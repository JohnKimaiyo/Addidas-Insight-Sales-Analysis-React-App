SELECT TOP (1000) [CustomerName]
      ,[CustomerNumber]
      ,[InvoiceDate]
      ,[CustomerLocation]
      ,[CustomerState]
      ,[CustomerCity]
      ,[Product]
      ,[PriceperUnit]
      ,[UnitsSold]
      ,[TotalSales]
      ,[SalesMethod]
  FROM [adidas].[dbo].[adidas$]

  --Check the Structure of the Table --
  SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH, 
    IS_NULLABLE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'adidas$';


	-- Check for Missing Values --
	SELECT 
    SUM(CASE WHEN CustomerName IS NULL THEN 1 ELSE 0 END) AS Missing_CustomerName,
    SUM(CASE WHEN CustomerNumber IS NULL THEN 1 ELSE 0 END) AS Missing_CustomerNumber,
    SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) AS Missing_InvoiceDate,
    SUM(CASE WHEN CustomerLocation IS NULL THEN 1 ELSE 0 END) AS Missing_CustomerLocation,
    SUM(CASE WHEN CustomerState IS NULL THEN 1 ELSE 0 END) AS Missing_CustomerState,
    SUM(CASE WHEN CustomerCity IS NULL THEN 1 ELSE 0 END) AS Missing_CustomerCity,
    SUM(CASE WHEN Product IS NULL THEN 1 ELSE 0 END) AS Missing_Product,
    SUM(CASE WHEN PriceperUnit IS NULL THEN 1 ELSE 0 END) AS Missing_PriceperUnit,
    SUM(CASE WHEN UnitsSold IS NULL THEN 1 ELSE 0 END) AS Missing_UnitsSold,
    SUM(CASE WHEN TotalSales IS NULL THEN 1 ELSE 0 END) AS Missing_TotalSales,
    SUM(CASE WHEN SalesMethod IS NULL THEN 1 ELSE 0 END) AS Missing_SalesMethod
FROM 
    [adidas].[dbo].[adidas$];

	-- Check for Duplicates --
SELECT 
    CustomerName, 
    CustomerNumber, 
    InvoiceDate, 
    CustomerLocation, 
    CustomerState, 
    CustomerCity, 
    Product, 
    PriceperUnit, 
    UnitsSold, 
    TotalSales, 
    SalesMethod, 
    COUNT(*) AS DuplicateCount
FROM 
    [adidas].[dbo].[adidas$]
GROUP BY 
    CustomerName, 
    CustomerNumber, 
    InvoiceDate, 
    CustomerLocation, 
    CustomerState, 
    CustomerCity, 
    Product, 
    PriceperUnit, 
    UnitsSold, 
    TotalSales, 
    SalesMethod
HAVING 
    COUNT(*) > 1;

	--  Basic Statistics for Numeric Columns --
	SELECT 
    MIN(PriceperUnit) AS Min_PriceperUnit,
    MAX(PriceperUnit) AS Max_PriceperUnit,
    AVG(PriceperUnit) AS Avg_PriceperUnit,
    MIN(UnitsSold) AS Min_UnitsSold,
    MAX(UnitsSold) AS Max_UnitsSold,
    AVG(UnitsSold) AS Avg_UnitsSold,
    MIN(TotalSales) AS Min_TotalSales,
    MAX(TotalSales) AS Max_TotalSales,
    AVG(TotalSales) AS Avg_TotalSales
FROM 
    [adidas].[dbo].[adidas$];

	-- Count of Unique Values for Categorical Columns -- 
	SELECT 
    COUNT(DISTINCT CustomerName) AS Unique_CustomerNames,
    COUNT(DISTINCT CustomerNumber) AS Unique_CustomerNumbers,
    COUNT(DISTINCT CustomerLocation) AS Unique_CustomerLocations,
    COUNT(DISTINCT CustomerState) AS Unique_CustomerStates,
    COUNT(DISTINCT CustomerCity) AS Unique_CustomerCities,
    COUNT(DISTINCT Product) AS Unique_Products,
    COUNT(DISTINCT SalesMethod) AS Unique_SalesMethods
FROM 
    [adidas].[dbo].[adidas$];  


	--Total Sales by Product --
	SELECT 
    Product, 
    SUM(TotalSales) AS Total_Sales
FROM 
    [adidas].[dbo].[adidas$]
GROUP BY 
    Product
ORDER BY 
    Total_Sales DESC;

	-- Total Sales by Sales Method --
	SELECT 
    SalesMethod, 
    SUM(TotalSales) AS Total_Sales
FROM 
    [adidas].[dbo].[adidas$]
GROUP BY 
    SalesMethod
ORDER BY 
    Total_Sales DESC;

	-- Total Sales by State -
	SELECT 
    CustomerState, 
    SUM(TotalSales) AS Total_Sales
FROM 
    [adidas].[dbo].[adidas$]
GROUP BY 
    CustomerState
ORDER BY 
    Total_Sales DESC;   


	--  Total Sales Over Time (Monthly) --
	SELECT 
    FORMAT(InvoiceDate, 'yyyy-MM') AS Month, 
    SUM(TotalSales) AS Total_Sales
FROM 
    [adidas].[dbo].[adidas$]
GROUP BY 
    FORMAT(InvoiceDate, 'yyyy-MM')
ORDER BY 
    Month;

;

--  Average Price per Unit by Product --
SELECT 
    Product, 
    AVG(PriceperUnit) AS Avg_PriceperUnit
FROM 
    [adidas].[dbo].[adidas$]
GROUP BY 
    Product
ORDER BY 
    Avg_PriceperUnit DESC;
