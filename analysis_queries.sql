-- =====================================================
-- ADVANCED SQL ANALYSIS QUERIES
-- These queries demonstrate: Joins, Subqueries, CTEs,
-- Window Functions, Aggregations, Case Statements
-- =====================================================

USE ECommerceSalesDB;
GO

-- =====================================================
-- QUERY 1: Monthly Sales Trend with Growth Rate
-- Skills: CTE, Window Function (LAG), Aggregation
-- =====================================================
WITH MonthlySales AS (
    SELECT 
        FORMAT(o.OrderDate, 'yyyy-MM') AS Month,
        COUNT(DISTINCT o.OrderID) AS TotalOrders,
        SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)) AS Revenue
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.Status = 'Delivered'
    GROUP BY FORMAT(o.OrderDate, 'yyyy-MM')
)
SELECT 
    Month,
    TotalOrders,
    ROUND(Revenue, 2) AS Revenue,
    LAG(Revenue) OVER (ORDER BY Month) AS PreviousMonth,
    ROUND(
        ((Revenue - LAG(Revenue) OVER (ORDER BY Month)) / 
        LAG(Revenue) OVER (ORDER BY Month)) * 100, 2
    ) AS GrowthPercent
FROM MonthlySales
ORDER BY Month;
GO

-- =====================================================
-- QUERY 2: Top 5 Products by Revenue with Profit Margin
-- Skills: Multiple Joins, Subquery, TOP, Calculations
-- =====================================================
SELECT TOP 5
    p.ProductName,
    p.Category,
    SUM(od.Quantity) AS UnitsSold,
    ROUND(SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)), 2) AS TotalRevenue,
    ROUND(SUM(od.Quantity * (p.UnitPrice - p.Cost) * (1 - od.Discount)), 2) AS TotalProfit,
    ROUND(
        (SUM(od.Quantity * (p.UnitPrice - p.Cost)) / 
        SUM(od.Quantity * p.UnitPrice)) * 100, 2
    ) AS ProfitMarginPercent
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.Status = 'Delivered'
GROUP BY p.ProductID, p.ProductName, p.Category
ORDER BY TotalRevenue DESC;
GO

-- =====================================================
-- QUERY 3: Regional Performance Analysis
-- Skills: Multiple Joins, CASE Statement, Grouping
-- =====================================================
SELECT 
    c.Region,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    ROUND(SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)), 2) AS TotalRevenue,
    ROUND(AVG(od.Quantity * p.UnitPrice * (1 - od.Discount)), 2) AS AvgOrderValue,
    CASE 
        WHEN SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)) > 300000 THEN 'High'
        WHEN SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)) > 150000 THEN 'Medium'
        ELSE 'Low'
    END AS PerformanceTier
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.Status = 'Delivered'
GROUP BY c.Region
ORDER BY TotalRevenue DESC;
GO

-- =====================================================
-- QUERY 4: Customer Segmentation (RFM Analysis)
-- Skills: CTE, Multiple Aggregations, NTILE Window
-- =====================================================
WITH CustomerMetrics AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        c.Region,
        DATEDIFF(DAY, MAX(o.OrderDate), GETDATE()) AS DaysSinceLastOrder,
        COUNT(DISTINCT o.OrderID) AS OrderFrequency,
        SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)) AS TotalSpent
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.Status = 'Delivered'
    GROUP BY c.CustomerID, c.CustomerName, c.Region
)
SELECT 
    CustomerID,
    CustomerName,
    Region,
    DaysSinceLastOrder AS Recency,
    OrderFrequency AS Frequency,
    ROUND(TotalSpent, 2) AS Monetary,
    CASE 
        WHEN OrderFrequency >= 3 AND TotalSpent > 100000 THEN 'VIP'
        WHEN OrderFrequency >= 2 AND TotalSpent > 50000 THEN 'Loyal'
        WHEN DaysSinceLastOrder > 90 THEN 'At Risk'
        ELSE 'Regular'
    END AS CustomerSegment
FROM CustomerMetrics
ORDER BY TotalSpent DESC;
GO

-- =====================================================
-- QUERY 5: Product Category Performance by Month
-- Skills: PIVOT concept, Aggregation, Formatting
-- =====================================================
SELECT 
    FORMAT(o.OrderDate, 'yyyy-MM') AS Month,
    SUM(CASE WHEN p.Category = 'Electronics' 
        THEN od.Quantity * p.UnitPrice * (1 - od.Discount) ELSE 0 END) AS Electronics,
    SUM(CASE WHEN p.Category = 'Furniture' 
        THEN od.Quantity * p.UnitPrice * (1 - od.Discount) ELSE 0 END) AS Furniture,
    SUM(CASE WHEN p.Category = 'Stationery' 
        THEN od.Quantity * p.UnitPrice * (1 - od.Discount) ELSE 0 END) AS Stationery,
    SUM(CASE WHEN p.Category = 'Accessories' 
        THEN od.Quantity * p.UnitPrice * (1 - od.Discount) ELSE 0 END) AS Accessories
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.Status = 'Delivered'
GROUP BY FORMAT(o.OrderDate, 'yyyy-MM')
ORDER BY Month;
GO

-- =====================================================
-- QUERY 6: Order Fulfillment Analysis
-- Skills: DATEDIFF, Subquery, AVG, Status Analysis
-- =====================================================
SELECT 
    Status,
    COUNT(*) AS OrderCount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Orders), 2) AS Percentage,
    AVG(CASE 
        WHEN ShippingDate IS NOT NULL 
        THEN DATEDIFF(DAY, OrderDate, ShippingDate) 
    END) AS AvgFulfillmentDays
FROM Orders
GROUP BY Status
ORDER BY OrderCount DESC;
GO

-- =====================================================
-- QUERY 7: Year-over-Year Comparison (Subquery)
-- Skills: Subquery, Date Functions, Comparison
-- =====================================================
SELECT 
    'Current Period' AS Period,
    COUNT(DISTINCT o.OrderID) AS Orders,
    ROUND(SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)), 2) AS Revenue,
    ROUND(SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)) / 
        (SELECT SUM(od2.Quantity * p2.UnitPrice * (1 - od2.Discount))
         FROM Orders o2
         JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
         JOIN Products p2 ON od2.ProductID = p2.ProductID
         WHERE o2.Status = 'Delivered') * 100, 2) AS RevenueSharePercent
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.Status = 'Delivered'
    AND o.OrderDate >= DATEADD(MONTH, -18, GETDATE());
	GO

	-- =====================================================
-- QUERY 8: Repeat Customer Analysis
-- Skills: HAVING, COUNT, Subquery in SELECT
-- =====================================================
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.Region,
    COUNT(o.OrderID) AS TotalOrders,
    MIN(o.OrderDate) AS FirstOrder,
    MAX(o.OrderDate) AS LastOrder,
    DATEDIFF(DAY, MIN(o.OrderDate), MAX(o.OrderDate)) AS CustomerLifespanDays
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Status = 'Delivered'
GROUP BY c.CustomerID, c.CustomerName, c.Region
HAVING COUNT(o.OrderID) > 1
ORDER BY TotalOrders DESC;
GO

-- =====================================================
-- QUERY 9: Discount Impact Analysis
-- Skills: CASE, Grouping, Business Logic
-- =====================================================
SELECT 
    CASE 
        WHEN od.Discount = 0 THEN 'No Discount'
        WHEN od.Discount <= 0.05 THEN '1-5%'
        WHEN od.Discount <= 0.10 THEN '6-10%'
        WHEN od.Discount <= 0.15 THEN '11-15%'
        ELSE '16%+'
    END AS DiscountBracket,
    COUNT(DISTINCT od.OrderID) AS Orders,
    SUM(od.Quantity) AS UnitsSold,
    ROUND(SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)), 2) AS ActualRevenue,
    ROUND(SUM(od.Quantity * p.UnitPrice * od.Discount), 2) AS DiscountGiven
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.Status = 'Delivered'
GROUP BY 
    CASE 
        WHEN od.Discount = 0 THEN 'No Discount'
        WHEN od.Discount <= 0.05 THEN '1-5%'
        WHEN od.Discount <= 0.10 THEN '6-10%'
        WHEN od.Discount <= 0.15 THEN '11-15%'
        ELSE '16%+'
    END
ORDER BY ActualRevenue DESC;
GO