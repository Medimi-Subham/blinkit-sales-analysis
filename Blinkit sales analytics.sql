SELECT COUNT(*) AS TotalRecords
FROM blinkit_sales;

SELECT TOP 100 *
FROM blinkit_sales;

SELECT
SUM(CASE WHEN Item_Weight IS NULL THEN 1 ELSE 0 END) AS MissingWeight,
SUM(CASE WHEN Outlet_Size IS NULL THEN 1 ELSE 0 END) AS MissingOutletSize
FROM blinkit_sales;

SELECT DISTINCT Item_Fat_Content
FROM blinkit_sales;

UPDATE blinkit_sales
SET Item_Fat_Content='Low Fat'
WHERE Item_Fat_Content IN ('LF','low fat');

UPDATE blinkit_sales
SET Item_Fat_Content='Regular'
WHERE Item_Fat_Content='reg';

SELECT DISTINCT Item_Fat_Content
FROM blinkit_sales;

UPDATE blinkit_sales
SET Item_Weight =
(
SELECT AVG(Item_Weight)
FROM blinkit_sales
)
WHERE Item_Weight IS NULL;

UPDATE blinkit_sales
SET Outlet_Size='Medium'
WHERE Outlet_Size IS NULL;

SELECT COUNT(*)
FROM blinkit_sales
WHERE Item_Visibility=0;

UPDATE blinkit_sales
SET Item_Visibility=
(
SELECT AVG(Item_Visibility)
FROM blinkit_sales
WHERE Item_Visibility > 0
)
WHERE Item_Visibility=0;

SELECT
SUM(Item_Outlet_Sales) AS TotalSales
FROM blinkit_sales;

SELECT
AVG(Item_Outlet_Sales) AS AvgSales
FROM blinkit_sales;

SELECT
COUNT(DISTINCT Item_Identifier) AS TotalProducts
FROM blinkit_sales;

SELECT
AVG(Item_MRP) AS AvgPrice
FROM blinkit_sales;

SELECT
Item_Type,
SUM(Item_Outlet_Sales) AS Sales
FROM blinkit_sales
GROUP BY Item_Type
ORDER BY Sales DESC;

SELECT TOP 10
Item_Type,
SUM(Item_Outlet_Sales) AS Sales
FROM blinkit_sales
GROUP BY Item_Type
ORDER BY Sales DESC;

SELECT
Item_Fat_Content,
SUM(Item_Outlet_Sales) AS Sales
FROM blinkit_sales
GROUP BY Item_Fat_Content;

SELECT
Item_Fat_Content,
AVG(Item_Outlet_Sales) AS AvgSales
FROM blinkit_sales
GROUP BY Item_Fat_Content;

SELECT
Outlet_Type,
SUM(Item_Outlet_Sales) AS Sales
FROM blinkit_sales
GROUP BY Outlet_Type
ORDER BY Sales DESC;

SELECT
Outlet_Size,
SUM(Item_Outlet_Sales) AS Sales
FROM blinkit_sales
GROUP BY Outlet_Size
ORDER BY Sales DESC;

SELECT
Outlet_Location_Type,
SUM(Item_Outlet_Sales) AS Sales
FROM blinkit_sales
GROUP BY Outlet_Location_Type
ORDER BY Sales DESC;

SELECT
Outlet_Identifier,
YEAR(GETDATE()) - Outlet_Establishment_Year AS OutletAge
FROM blinkit_sales
GROUP BY Outlet_Identifier,Outlet_Establishment_Year;

SELECT
Outlet_Establishment_Year,
SUM(Item_Outlet_Sales) AS Sales
FROM blinkit_sales
GROUP BY Outlet_Establishment_Year
ORDER BY Sales DESC;

SELECT
Item_Type,
AVG(Item_MRP) AS AvgMRP
FROM blinkit_sales
GROUP BY Item_Type
ORDER BY AvgMRP DESC;

SELECT TOP 20
Item_Identifier,
SUM(Item_Outlet_Sales) AS Sales
FROM blinkit_sales
GROUP BY Item_Identifier
ORDER BY Sales DESC;

SELECT
Item_Type,
MAX(Item_MRP) AS HighestPrice
FROM blinkit_sales
GROUP BY Item_Type
ORDER BY HighestPrice DESC;

SELECT
AVG(Item_Visibility) AS AvgVisibility,
AVG(Item_Outlet_Sales) AS AvgSales
FROM blinkit_sales;

SELECT TOP 20
Item_Identifier,
Item_Visibility
FROM blinkit_sales
ORDER BY Item_Visibility DESC;

SELECT TOP 1
Outlet_Identifier,
SUM(Item_Outlet_Sales) AS Sales
FROM blinkit_sales
GROUP BY Outlet_Identifier
ORDER BY Sales DESC;

SELECT
Outlet_Type,
SUM(Item_Outlet_Sales) AS Sales,
ROUND(
SUM(Item_Outlet_Sales)*100.0/
(SUM(SUM(Item_Outlet_Sales)) OVER()),
2
) AS SalesPercentage
FROM blinkit_sales
GROUP BY Outlet_Type;

GO
CREATE VIEW vw_SalesSummary AS
SELECT
Outlet_Type,
Outlet_Size,
Outlet_Location_Type,
Item_Type,
Item_Fat_Content,
SUM(Item_Outlet_Sales) AS TotalSales
FROM blinkit_sales
GROUP BY
Outlet_Type,
Outlet_Size,
Outlet_Location_Type,
Item_Type,
Item_Fat_Content;
GO

GO
CREATE VIEW vw_OutletPerformance AS
SELECT
Outlet_Identifier,
Outlet_Type,
Outlet_Size,
SUM(Item_Outlet_Sales) AS TotalSales
FROM blinkit_sales
GROUP BY
Outlet_Identifier,
Outlet_Type,
Outlet_Size;
GO

select *
from blinkit_sales;