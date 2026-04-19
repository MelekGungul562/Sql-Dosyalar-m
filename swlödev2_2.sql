SELECT TOP (1000)
    [Invoice]
    , [StockCode]
    , [Description]
    , [Quantity]
    , [InvoiceDate]
    , [Price]
    , [Customer_ID] -- Sizin teyit ettiğiniz Customer_ID kullanıldı
    , [Country]
FROM [onlineretaildb].[dbo].[retail_II]  -- Tablo adı "retail_II" olarak DÜZELTİLDİ


-- DİKKAT: Bu sorgu sizin ortamınızda izin hatası verecektir!
CREATE TABLE RFM_OR (
    CustomerID VARCHAR(20),
    LastInvoiceDate DATETIME,
    FirstInvoiceDate DATETIME,
    Recency INT,
    Frequency INT,
    Monetary INT,
    Tenure INT,
    Basket_Size FLOAT,
    Recency_Scale INT,
    Frequency_Scale INT,
    Segment VARCHAR(50)
);
-- DİKKAT: Bu sorgu sizin ortamınızda izin hatası verecektir!
INSERT INTO RFM_OR (CustomerID)
SELECT DISTINCT Customer_ID
FROM retail_II;
-------------------
SELECT * FROM RFM_OR;
-- MUSTERI ID EKLENMESI
INSERT INTO RFM_OR (CustomerID)
SELECT DISTINCT Customer_ID FROM retail_2010_2011

-- MÜŞTERİLERİN SON SATIN ALMA TARİHLERİNİ ELDE ETME
UPDATE RFM_OR SET LastInvoiceDate =
(
    SELECT MAX(InvoiceDate)
    FROM retail_2010_2011 r
    WHERE r.Customer_ID = RFM_OR.CustomerID
);

SELECT * FROM RFM_OR
--------------------
-- RECENCY DEĞERİNİN DOLDURULMASI
UPDATE RFM_OR SET Recency = DATEDIFF(DAY, LastInvoiceDate, '20120101');

-- MUSTERİLERİN İLK SATIN ALMA TARİHLERİNİ ELDE ETME
UPDATE RFM_OR SET FirstInvoiceDate =
(
    SELECT MIN(InvoiceDate)
    FROM retail_2010_2011 r
    WHERE r.Customer_ID = RFM_OR.CustomerID
);

SELECT * FROM RFM_OR
------------------------------------------------------------------------------------------
-- MUSTERİLERİN İLK SATIN ALMA TARİHLERİNİ ELDE ETME
UPDATE RFM_OR SET FirstInvoiceDate =
(
    SELECT MIN(InvoiceDate)
    FROM retail_2010_2011 r
    WHERE r.Customer_ID = RFM_OR.CustomerID
);

-- TENURE DEĞERİNİN DOLDURULMASI
UPDATE RFM_OR SET Tenure = DATEDIFF(DAY, FirstInvoiceDate, '20120101');

SELECT * FROM RFM_OR

-- FREQUENCY DEĞERİNİN DOLDURULMASI
UPDATE RFM_OR SET Frequency =
(
    SELECT COUNT(DISTINCT Invoice)
    FROM retail_2010_2011 r
    WHERE r.Customer_ID = RFM_OR.CustomerID
)

SELECT * FROM RFM_OR

-- MONETARY DEĞERİNİN DOLDURULMASI
UPDATE RFM_OR SET Monetary =
(
    SELECT SUM(Quantity * Price)
    FROM retail_2010_2011 r
    WHERE r.Customer_ID = RFM_OR.CustomerID
)


-- BASKET SIZE DEĞERİNİN DOLDURULMASI
UPDATE RFM_OR SET Basket_Size = (Monetary / Frequency) FROM RFM_OR

----------------
-- SCALE HESAPLARI
UPDATE RFM_OR SET Frequency_Scale =
(
    SELECT rank_
    FROM
    (
        SELECT CustomerID, Frequency, NTILE(5) OVER(ORDER BY FREQUENCY) rank_
        FROM RFM_OR
    ) AS t
    WHERE CustomerID = RFM_OR.CustomerID
)
-----------------
-- SEGMENT İSİMLERİ
UPDATE RFM_OR SET Segment = 'Hibernating'
WHERE Recency_Scale LIKE '[1-2]' AND Frequency_Scale LIKE '[1-2]'

--
UPDATE RFM_OR SET Segment = 'At_Risk'
WHERE Recency_Scale LIKE '[1-2]' AND Frequency_Scale LIKE '[3-4]'


UPDATE RFM_OR SET Segment = 'Cant_Loose'
WHERE Recency_Scale LIKE '[1-2]' AND Frequency_Scale LIKE '[5]';

UPDATE RFM_OR SET Segment = 'About_to_Sleep'
WHERE Recency_Scale LIKE '[3]' AND Frequency_Scale LIKE '[1-2]';

UPDATE RFM_OR SET Segment = 'Need_Attention'
WHERE Recency_Scale LIKE '[3]' AND Frequency_Scale LIKE '[3]';

UPDATE RFM_OR SET Segment = 'Loyal_Customers'
WHERE Recency_Scale LIKE '[3-4]' AND Frequency_Scale LIKE '[4-5]';

UPDATE RFM_OR SET Segment = 'Promising'
WHERE Recency_Scale LIKE '[4]' AND Frequency_Scale LIKE '[1]';

UPDATE RFM_OR SET Segment = 'New_Customers'
WHERE Recency_Scale LIKE '[5]' AND Frequency_Scale LIKE '[1]';

UPDATE RFM_OR SET Segment = 'Potential_Loyalists'
WHERE Recency_Scale LIKE '[4-5]' AND Frequency_Scale LIKE '[2-3]';

UPDATE RFM_OR SET Segment = 'Champions'
WHERE Recency_Scale LIKE '[5]' AND Frequency_Scale LIKE '[4-5]';


SELECT Segment, Count(CustomerID)
FROM RFM_OR
WHERE Segment IS NOT NULL
GROUP BY Segment

SELECT * FROM RFM_OR




SELECT * FROM retail_2010_2011
SELECT * FROM RFM_OR

