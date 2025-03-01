-- 1. Basic Overview of the Data --
-- Let's start by understanding the structure and basic statistics of the dataset. --
-- Check the first 10 rows of the dataset
SELECT TOP 10 *
FROM [Addidas Sales].[dbo].['Data Sales Adidas$'];


-- 2. Check for Missing Values --
-- Identify if there are any missing values in the dataset. --

-- Count missing values in each column
SELECT 
    COUNT(*) - COUNT([Retailer]) AS Missing_Retailer,
    COUNT(*) - COUNT([Retailer ID]) AS Missing_Retailer_ID,
    COUNT(*) - COUNT([Invoice Date]) AS Missing_Invoice_Date,
    COUNT(*) - COUNT([Region]) AS Missing_Region,
    COUNT(*) - COUNT([State]) AS Missing_State,
    COUNT(*) - COUNT([City]) AS Missing_City,
    COUNT(*) - COUNT([Product]) AS Missing_Product,
    COUNT(*) - COUNT([Price per Unit]) AS Missing_Price_per_Unit,
    COUNT(*) - COUNT([Units Sold]) AS Missing_Units_Sold,
    COUNT(*) - COUNT([Total Sales]) AS Missing_Total_Sales,
    COUNT(*) - COUNT([Operating Profit]) AS Missing_Operating_Profit,
    COUNT(*) - COUNT([Operating Margin]) AS Missing_Operating_Margin,
    COUNT(*) - COUNT([Sales Method]) AS Missing_Sales_Method
FROM [Addidas Sales].[dbo].['Data Sales Adidas$'];

-- 3. Basic Statistics --
-- Calculate basic statistics for numerical columns. --
-- Basic statistics for numerical columns
SELECT 
    AVG([Price per Unit]) AS Avg_Price_per_Unit,
    MIN([Price per Unit]) AS Min_Price_per_Unit,
    MAX([Price per Unit]) AS Max_Price_per_Unit,
    AVG([Units Sold]) AS Avg_Units_Sold,
    MIN([Units Sold]) AS Min_Units_Sold,
    MAX([Units Sold]) AS Max_Units_Sold,
    AVG([Total Sales]) AS Avg_Total_Sales,
    MIN([Total Sales]) AS Min_Total_Sales,
    MAX([Total Sales]) AS Max_Total_Sales,
    AVG([Operating Profit]) AS Avg_Operating_Profit,
    MIN([Operating Profit]) AS Min_Operating_Profit,
    MAX([Operating Profit]) AS Max_Operating_Profit,
    AVG([Operating Margin]) AS Avg_Operating_Margin,
    MIN([Operating Margin]) AS Min_Operating_Margin,
    MAX([Operating Margin]) AS Max_Operating_Margin
FROM [Addidas Sales].[dbo].['Data Sales Adidas$'];

-- 4. Temporal Analysis-- 
-- Analyze sales trends over time. --
-- Total sales by year
SELECT 
    YEAR([Invoice Date]) AS Sale_Year,
    SUM([Total Sales]) AS Total_Sales
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY YEAR([Invoice Date])
ORDER BY Sale_Year;

-- Total sales by month for a specific year (e.g., 2022)
SELECT 
    YEAR([Invoice Date]) AS Sale_Year,
    MONTH([Invoice Date]) AS Sale_Month,
    SUM([Total Sales]) AS Total_Sales
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2022
GROUP BY YEAR([Invoice Date]), MONTH([Invoice Date])
ORDER BY Sale_Year, Sale_Month;


-- 5. Geographic Analysis --
-- Analyze sales by region, state, and city. -

-- Total sales by region
SELECT 
    [Region],
    SUM([Total Sales]) AS Total_Sales
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY [Region]
ORDER BY Total_Sales DESC;

-- Total sales by state
SELECT 
    [State],
    SUM([Total Sales]) AS Total_Sales
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY [State]
ORDER BY Total_Sales DESC;

-- Total sales by city
SELECT 
    [City],
    SUM([Total Sales]) AS Total_Sales
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY [City]
ORDER BY Total_Sales DESC;

-- 6. Product Analysis--
-- Analyze sales by product.--

-- Total sales by product
SELECT 
    [Product],
    SUM([Total Sales]) AS Total_Sales
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY [Product]
ORDER BY Total_Sales DESC;

-- Average price per unit by product
SELECT 
    [Product],
    AVG([Price per Unit]) AS Avg_Price_per_Unit
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY [Product]
ORDER BY Avg_Price_per_Unit DESC;

-- 7. Retailer Analysis --
-- Analyze sales by retailer. ---- Total sales by retailer
SELECT 
    [Retailer],
    SUM([Total Sales]) AS Total_Sales
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY [Retailer]
ORDER BY Total_Sales DESC;

-- Total operating profit by retailer
SELECT 
    [Retailer],
    SUM([Operating Profit]) AS Total_Operating_Profit
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY [Retailer]
ORDER BY Total_Operating_Profit DESC;

-- Sales Method Analysis --
-- Analyze sales by sales method. --
-- Total sales by sales method
SELECT 
    [Sales Method],
    SUM([Total Sales]) AS Total_Sales
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY [Sales Method]
ORDER BY Total_Sales DESC;

-- Average operating margin by sales method
SELECT 
    [Sales Method],
    AVG([Operating Margin]) AS Avg_Operating_Margin
FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
GROUP BY [Sales Method]
ORDER BY Avg_Operating_Margin DESC;

-- 9. Outlier Detection --
-- dentify potential outliers in numerical columns. --
-- Outliers in Total Sales (beyond 3 standard deviations from the mean)
WITH stats AS (
    SELECT 
        AVG([Total Sales]) AS mean,
        STDEV([Total Sales]) AS stddev
    FROM [Addidas Sales].[dbo].['Data Sales Adidas$']
)
SELECT 
    *
FROM [Addidas Sales].[dbo].['Data Sales Adidas$'], stats
WHERE [Total Sales] < (mean - 3 * stddev) OR [Total Sales] > (mean + 3 * stddev);

-- 10. Correlation Analysis --
-- Check for correlations between numerical columns. --
-- Correlation between Units Sold and Total Sales
SELECT 
    (AVG([Units Sold] * [Total Sales]) - AVG([Units Sold]) * AVG([Total Sales])) / 
    (STDEV([Units Sold]) * STDEV([Total Sales])) AS Correlation_UnitsSold_TotalSales
FROM [Addidas Sales].[dbo].['Data Sales Adidas$'];