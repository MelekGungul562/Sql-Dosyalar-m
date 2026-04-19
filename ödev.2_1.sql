-- 1. "Geciken Ürünler" ortalama kaç gün geciktiğini bulan sorguyu yazınız.

SELECT AVG(Gecikme)
FROM (
    SELECT 
        OrderID,
        RequiredDate,
        ShippedDate,
        DATEDIFF(DAY, RequiredDate, ShippedDate) AS Gecikme
    FROM Orders
    WHERE DATEDIFF(DAY, RequiredDate, ShippedDate) > 0
) AS Geciken;

--subquery olmadan
SELECT
    AVG(DATEDIFF(DAY, RequiredDate, ShippedDate)) AS Ortalama_Gecikme
FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ShippedDate) > 0

--2 "Erken Giden Ürünler"in ortalama kaç gün erken gittiğini bulunuz.
SELECT 
    AVG(Erken_Gonderim) AS Ortalama_Erken_Gonderim
FROM (
    SELECT 
        OrderID,
        RequiredDate,
        ShippedDate,
        DATEDIFF(DAY, RequiredDate, ShippedDate) AS Erken_Gonderim
    FROM Orders
    WHERE DATEDIFF(DAY, RequiredDate, ShippedDate) < 0
) AS subquery_0;

-- subquery_0 olmadan
SELECT 
    AVG(DATEDIFF(DAY, RequiredDate, ShippedDate)) AS Ortalama_Erken_Gonderim
FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ShippedDate) < 0;





-- 3. CustomerID bazında toplam gelir elde edildiğini gösteren tabloyu getiriniz.
SELECT Customer_ID, SUM(Price * Quantity) AS Monetary
FROM retail_II
GROUP BY Customer_ID;

-- 4. CustomerID bazında 2011.12.30 tarihine göre Recency değerlerini gösteren tabloyu oluşturacak sorguyu yazınız.
SELECT
    Customer_ID,
    -- Recency = Başvuru Tarihi - En Son Alışveriş Tarihi (Gün olarak fark)
    DATEDIFF(day, MAX(InvoiceDate), '2011-12-30') AS RecencyGun
FROM retail_II  -- Tablo adını SÜREKLİ KULLANDIĞINIZ doğru adla DÜZELTTİK
GROUP BY Customer_ID
ORDER BY RecencyGun ASC;

-- 4. CustomerID bazında 2011.12.30 tarihine göre Recency değerlerini gösteren tabloyu oluşturacak sorguyu yazınız.
SELECT
    Customer_ID,  -- Düzeltildi
    MAX(InvoiceDate) AS Last_Purchase_Date,
    DATEDIFF(DAY, MAX(InvoiceDate), '20111230') AS Recency
FROM retail_II  -- Düzeltildi
GROUP BY Customer_ID

-- 5. Ülke bazında en fazla satılan ürünlerin Toplam Cirosu nu gösteren tabloyu oluşturacak sorguyu yazınız.
SELECT
    Country,
    SUM(Quantity * Price) AS ToplamCiro  -- Ciro = Miktar x Birim Fiyat
FROM retail_II  -- Düzeltildi
GROUP BY Country
ORDER BY ToplamCiro DESC;

-- 5. Ülke bazında en fazla satılan ürünlerin Toplam Cirosu nu gösteren tabloyu oluşturacak sorguyu yazınız.

SELECT
    Country,
    SUM(Quantity * Price) AS ToplamCiro
FROM retail_II
GROUP BY Country
ORDER BY ToplamCiro DESC;

-- 5. Ülke bazında en fazla satılan ürünlerin Toplam Cirosu nu gösteren tabloyu oluşturacak sorguyu yazınız.
SELECT *
FROM
(
    SELECT
        Country,
        [Description],
        SUM(Quantity) AS Satis_Adet,
        SUM(Quantity * Price) AS Ciro,  -- Ciro hesaplaması eklendi
        -- Her ülkede en çok satılan ürünü Rank = 1 olarak işaretler
        ROW_NUMBER() OVER(PARTITION BY Country ORDER BY SUM(Quantity) DESC) AS Rank
    FROM retail_II  -- Düzeltildi: retail_2010_2011 yerine retail_II
    GROUP BY Country, [Description]
) AS A
WHERE Rank = 1;  -- Sadece Rank 1 olan (en çok satılan) ürünü getirir