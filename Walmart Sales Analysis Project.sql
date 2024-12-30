-- Query to fetch all records from the WalmartSalesData table
SELECT *
FROM Protfolio_Project..[WalmartSalesData.csv];

-- Customer Insights --

-- 1. Customer Demographics
SELECT SUM(total) AS Total_sales, Gender
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Gender
ORDER BY Gender;

SELECT DISTINCT Customer_type, AVG(Rating) AS Average_Rating
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Customer_type
ORDER BY Customer_type;

SELECT DISTINCT Customer_type, AVG(gross_margin_percentage) AS Average_gross_margin_percentage
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Customer_type
ORDER BY Average_gross_margin_percentage DESC;

-- 2. Customer Preferences
SELECT Gender, Product_line, SUM(Quantity) AS Total_quantity_sold
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Gender, Product_line
ORDER BY Gender, Total_quantity_sold DESC;

SELECT Customer_type, Product_line, SUM(Quantity) AS Total_quantity_sold
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Customer_type, Product_line
ORDER BY Customer_type, Total_quantity_sold DESC;

-- Sales Performance --

-- 3. Branch & City Analysis
-- Total sales before tax per branch
SELECT Branch, 
    SUM(Unit_price * Quantity) AS Total_sales_before_tax
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch
ORDER BY Total_sales_before_tax;

-- Total sales after tax per branch
SELECT Branch, SUM(Total) AS Total_income_after_tax
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch
ORDER BY Total_income_after_tax;

-- Total tax per branch
SELECT Branch, SUM(Tax_5) AS Total_tax
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch
ORDER BY Total_tax DESC;

-- Total gross income per branch
SELECT Branch, 
    SUM(gross_income) AS Total_gross_income
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch
ORDER BY Total_gross_income DESC;

-- Product line contribution to gross income per branch
SELECT Branch, Product_line, 
    SUM(gross_income) AS Total_gross_income
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch, Product_line
ORDER BY Branch, Total_gross_income DESC;

-- Total customers per branch
SELECT Branch, 
    COUNT(Invoice_ID) AS Total_customers_per_branch
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch
ORDER BY Branch, Total_customers_per_branch DESC;

-- Total quantity sold per branch
SELECT Branch, 
    SUM(Quantity) AS Total_quantity_sold_per_branch
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch
ORDER BY Total_quantity_sold_per_branch DESC;

-- Revenue by branch and city
SELECT City, Branch, 
    SUM(Total) AS Total_revenue
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY City, Branch
ORDER BY Total_revenue DESC;

-- Branch performance by customer type in each city
SELECT City, Branch, Customer_type,
    SUM(Total) AS Total_revenue
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY City, Branch, Customer_type
ORDER BY Customer_type, Total_revenue DESC;

-- Correlation between customer ratings and branch performance
SELECT Branch, 
    AVG(Rating) AS Average_rating, 
    SUM(gross_income) AS Total_gross_income
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch
ORDER BY Average_rating DESC;

-- Product line revenue contribution
SELECT Product_line, SUM(gross_income) AS TotalIncomePerProduct
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Product_line
ORDER BY TotalIncomePerProduct DESC;

-- Average gross margin percentage per product line
SELECT Product_line, AVG(gross_margin_percentage) AS AvgMarginPercentagePerProduct
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Product_line
ORDER BY AvgMarginPercentagePerProduct DESC;

-- Time-based Analysis --

-- Hour of the day with most sales
SELECT DATEPART(HOUR, Time) AS Hour_of_Day, 
    SUM(Total) AS Total_Sales
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY DATEPART(HOUR, Time)
ORDER BY Total_Sales DESC;

-- Day of the week profitability
SELECT DATENAME(WEEKDAY, Date) AS Day_of_Week, 
    SUM(Total) AS Total_Sales
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY DATENAME(WEEKDAY, Date)
ORDER BY Total_Sales DESC;

-- Sales and customer ratings over the month
SELECT DAY(Date) AS Day_of_Month, 
    SUM(Total) AS Total_Sales, 
    AVG(Rating) AS Average_Rating
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY DAY(Date)
ORDER BY Day_of_Month;

-- Payment Analysis --

-- Popular payment methods per branch
SELECT Branch, Payment, COUNT(Payment) AS MostPopularPaymentMethod
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch, Payment
ORDER BY MostPopularPaymentMethod DESC;

-- Payment method analysis by rating and transaction size
SELECT AVG(Rating) AS AverageRating, Payment, 
    COUNT(Payment) AS MostPopularPaymentMethod, 
    AVG(Total) AS AverageTransactionSize
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Payment
ORDER BY AverageRating DESC;

-- Cost and Profitability --

-- Branch and product line with highest profit margins
SELECT Branch, Product_line, 
    AVG(gross_margin_percentage) AS AverageProfitMargin
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch, Product_line
ORDER BY AverageProfitMargin DESC;

-- Average profit per transaction by city
SELECT City, 
    AVG(gross_income) AS AverageGrossIncome
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY City
ORDER BY AverageGrossIncome DESC;

-- Tax Contribution --

-- Total tax revenue per branch
SELECT Branch, 
    SUM(Tax_5) AS TotalTaxGeneratedPerBranch
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch
ORDER BY TotalTaxGeneratedPerBranch DESC;

-- Average tax paid per transaction by city
SELECT City, 
    AVG(Tax_5) AS AverageTaxPerTransaction
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY City
ORDER BY AverageTaxPerTransaction DESC;

-- Customer Experience --

-- Analyze customer ratings by branch
SELECT Branch, 
    AVG(Rating) AS AverageRating
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Branch
ORDER BY AverageRating DESC;

-- Analyze customer ratings by time of day
SELECT 
    CASE 
        WHEN CAST(Time AS TIME) BETWEEN '06:00:00' AND '12:00:00' THEN 'Morning'
        WHEN CAST(Time AS TIME) BETWEEN '12:01:00' AND '18:00:00' THEN 'Afternoon'
        WHEN CAST(Time AS TIME) BETWEEN '18:01:00' AND '23:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS TimeOfDay,
    AVG(Rating) AS AverageRating
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY 
    CASE 
        WHEN CAST(Time AS TIME) BETWEEN '06:00:00' AND '12:00:00' THEN 'Morning'
        WHEN CAST(Time AS TIME) BETWEEN '12:01:00' AND '18:00:00' THEN 'Afternoon'
        WHEN CAST(Time AS TIME) BETWEEN '18:01:00' AND '23:59:59' THEN 'Evening'
        ELSE 'Night'
    END
ORDER BY AverageRating DESC;

-- Ratings and gross income relationship
SELECT Rating, 
    AVG(gross_income) AS AverageProfit,
    COUNT(*) AS TransactionCount
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Rating
ORDER BY Rating DESC;

-- Seasonal Trends --

-- Monthly sales trends
SELECT DATEPART(YEAR, CAST(Date AS DATE)) AS Year,
    DATEPART(MONTH, CAST(Date AS DATE)) AS Month,
    SUM(Total) AS MonthlySales
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY DATEPART(YEAR, CAST(Date AS DATE)), DATEPART(MONTH, CAST(Date AS DATE))
ORDER BY Year, Month;

-- Annual sales by product line
SELECT Product_line, 
    DATEPART(YEAR, CAST(Date AS DATE)) AS Year,
    SUM(Total) AS AnnualSales
FROM Protfolio_Project..[WalmartSalesData.csv]
GROUP BY Product_line, DATEPART(YEAR, CAST(Date AS DATE))
