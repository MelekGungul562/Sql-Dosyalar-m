SELECT *
FROM FLO;
--2
SELECT COUNT(DISTINCT master_id) AS ToplamFarkliMusteri
FROM FLO;
--3
SELECT
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS ToplamCiro,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS ToplamAlisverisAdedi
FROM FLO;
--4
SELECT
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) / SUM(order_num_total_ever_online + order_num_total_ever_offline) AS AlisverisBasinaOrtalamaCiro
FROM FLO;

--5
SELECT
    last_order_channel,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS KanalToplamCiro,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS KanalToplamAlisverisAdedi
FROM FLO
GROUP BY last_order_channel;
-- SQL Server / Azure SQL için (Genel olarak kullanılan)
--6
SELECT
    YEAR(first_order_date) AS IlkAlisverisYili,
    COUNT(master_id) AS MusteriSayisi
FROM FLO
GROUP BY YEAR(first_order_date)
ORDER BY IlkAlisverisYili;
--7
SELECT
    last_order_channel,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) / SUM(order_num_total_ever_online + order_num_total_ever_offline) AS AlisverisBasinaOrtalamaCiro
FROM FLO
GROUP BY last_order_channel;
--8
SELECT
    SUM(customer_value_total_ever_online) AS ToplamOnlineCiro,
    SUM(customer_value_total_ever_offline) AS ToplamOfflineCiro
FROM FLO;
--9
SELECT
    master_id,
    order_channel
FROM FLO;
--10
SELECT *
FROM FLO
WHERE order_channel <> 'Offline';
--11
SELECT *
FROM FLO
WHERE order_channel <> 'Offline'
  AND customer_value_total_ever_online > 1000;

--12**
SELECT
    SUM(customer_value_total_ever_online) AS ToplamOnlineCiro_MobileKanal,
    SUM(customer_value_total_ever_offline) AS ToplamOfflineCiro_MobileKanal
FROM FLO
WHERE order_channel = 'Mobile';
--13**
SELECT *
FROM FLO
WHERE interested_in_categories_12 LIKE '%SPOR%';
--14
SELECT *
FROM FLO
WHERE customer_value_total_ever_offline BETWEEN 0 AND 10000;
--15
SELECT
    interested_in_categories_12,
    order_channel,
    SUM(order_num_total_ever_online) AS ToplamOnlineSiparisAdedi
FROM FLO
GROUP BY interested_in_categories_12, order_channel
ORDER BY ToplamOnlineSiparisAdedi DESC;

--16
SELECT
    last_order_channel,
    interested_in_categories_12,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS ToplamAlisverisAdedi
FROM FLO
GROUP BY last_order_channel, interested_in_categories_12
ORDER BY ToplamAlisverisAdedi DESC;
--17
SELECT TOP 50  
    master_id,
    (order_num_total_ever_online + order_num_total_ever_offline) AS ToplamAlisveris
FROM FLO
ORDER BY ToplamAlisveris DESC;
--18
SELECT
    YEAR(first_order_date) AS IlkAlisverisYili,
    COUNT(master_id) AS MusteriSayisi
FROM FLO
GROUP BY YEAR(first_order_date)
ORDER BY IlkAlisverisYili;
--19
SELECT
    COUNT(master_id) AS LastOrderDate2020MusteriAdedi
FROM FLO
WHERE YEAR(last_order_date) = 2020;
--20
SELECT
    *,  -- Tüm kolonları getir
    order_channel AS Aktifspor_OrderChannel  -- order_channel kolonunu tekrar yeni isimle ekle
FROM FLO
WHERE interested_in_categories_12 = '[AKTIFSPOR]';
--21
SELECT
    *, -- Tüm kolonları getir
    order_channel AS Aktifspor_IcindeGecen_OrderChannel -- order_channel kolonunu tekrar yeni isimle ekle
FROM FLO
WHERE interested_in_categories_12 LIKE '%AKTIFSPOR%';
--22
SELECT
    YEAR(first_order_date) AS IlkAlisverisYili,
    MONTH(first_order_date) AS IlkAlisverisAyi,
    COUNT(master_id) AS YeniMusteriSayisi
FROM FLO
WHERE YEAR(first_order_date) BETWEEN 2018 AND 2019
GROUP BY YEAR(first_order_date), MONTH(first_order_date)
ORDER BY IlkAlisverisYili, IlkAlisverisAyi;
--23
SELECT *
FROM FLO
WHERE (order_channel = 'Mobile' OR order_channel = 'Desktop')
  AND interested_in_categories_12 NOT LIKE '%AKTIFSPOR%';
--24
SELECT *
FROM FLO
WHERE order_channel IN ('Mobile', 'Desktop');

--25
SELECT TOP 1
    YEAR(last_order_date_online) AS Yil,
    MONTH(last_order_date_online) AS Ay,
    SUM(order_num_total_ever_online) AS ToplamOnlineAlisverisAdedi,
    SUM(customer_value_total_ever_online) AS ToplamOnlineCiro
FROM FLO
GROUP BY YEAR(last_order_date_online), MONTH(last_order_date_online)
ORDER BY ToplamOnlineAlisverisAdedi DESC;