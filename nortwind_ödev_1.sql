SELECT TOP 10 *
FROM Customers;
--1
-- 26. Müşteriler ve sipariş detayları (INNER JOIN)
-- Sadece her iki tabloda da eşleşen (yani sipariş vermiş) müşterileri getirir.
SELECT
    C.CustomerID,
    C.CompanyName,
    O.OrderID,
    O.OrderDate
FROM Customers AS C
INNER JOIN Orders AS O
    ON C.CustomerID = O.CustomerID;
--2
-- 27. Müşteriler ve sipariş detayları (LEFT JOIN)
-- Soldaki (Customers) tablodaki TÜM müşterileri getirir. Siparişi olmayanların sipariş bilgileri NULL olur.
SELECT
    C.CustomerID,
    C.CompanyName,
    O.OrderID,
    O.OrderDate
FROM Customers AS C  -- Bu LEFT (sol) tablodur
LEFT JOIN Orders AS O
    ON C.CustomerID = O.CustomerID
ORDER BY C.CustomerID;
--3
-- 28. Müşteriler ve sipariş detayları (RIGHT JOIN)
-- Sağdaki (Orders) tablodaki TÜM siparişleri getirir. Siparişi veren müşteri bilgisi olmayanlar NULL olur.
SELECT
    C.CustomerID,
    C.CompanyName,
    O.OrderID,
    O.OrderDate
FROM Customers AS C
RIGHT JOIN Orders AS O  -- Bu RIGHT (sağ) tablodur
    ON C.CustomerID = O.CustomerID
ORDER BY O.OrderID;