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
