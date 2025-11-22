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