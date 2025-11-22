# E-Commerce Sales Performance Analysis

## Project Overview

**Objective:** Analyze e-commerce sales data to identify trends, optimize performance, and provide actionable business insights for decision-makers.

**Tools Used:** SQL Server, Microsoft Excel

**Dataset:** 4 relational tables with 25 customers, 15 products, 50 orders, and 100+ order details spanning January-June 2024.

---

## Business Questions Answered

1. **What are the monthly revenue trends and growth rates?**
2. **Which products generate the highest revenue and profit margins?**
3. **How do different regions perform in terms of sales?**
4. **Who are our most valuable customers (RFM Analysis)?**
5. **What is the impact of discounts on revenue?**
6. **What is the order fulfillment efficiency?**

---

## Database Schema

```
Customers (CustomerID, CustomerName, Email, City, Region, JoinDate)
    |
    ↓ 1:N
Orders (OrderID, CustomerID, OrderDate, ShippingDate, Status)
    |
    ↓ 1:N
OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Discount)
    |
    ↓ N:1
Products (ProductID, ProductName, Category, UnitPrice, Cost)
```

---

## Key Findings

### 1. Revenue Performance
- **Total Revenue:** ₹12,47,850 (6 months)
- **Average Order Value:** ₹31,196
- **Peak Month:** May 2024 with 15% month-over-month growth

### 2. Top Performing Products
| Rank | Product | Revenue | Profit Margin |
|------|---------|---------|---------------|
| 1 | Laptop Pro 15 | ₹5,62,500 | 26.7% |
| 2 | Standing Desk | ₹1,18,750 | 40.0% |
| 3 | Monitor 27inch | ₹1,76,000 | 36.4% |

### 3. Regional Analysis
| Region | Revenue | Performance Tier |
|--------|---------|------------------|
| North | ₹4,23,500 | High |
| South | ₹3,89,200 | High |
| West | ₹2,85,100 | Medium |
| East | ₹1,50,050 | Low |

### 4. Customer Segments
- **VIP Customers:** 3 (12%) - Generate 45% of revenue
- **Loyal Customers:** 5 (20%) - Repeat buyers
- **At Risk:** 4 (16%) - No purchase in 90+ days

---

## SQL Techniques Demonstrated

| Technique | Queries Used In |
|-----------|-----------------|
| Common Table Expressions (CTE) | #1, #4 |
| Window Functions (LAG, NTILE) | #1, #4 |
| Multiple JOINs (3-4 tables) | #2, #3, #4 |
| Subqueries | #7, #8 |
| CASE Statements | #3, #4, #5, #9 |
| Aggregations | All queries |
| Date Functions | #1, #6, #7 |

---

## Excel Dashboard Components

1. **Revenue Trend Line Chart** - Monthly performance
2. **Product Performance Bar Chart** - Top 5 products
3. **Regional Pie Chart** - Revenue distribution
4. **Customer Segment Donut Chart** - VIP/Loyal/Regular
5. **KPI Cards** - Total Revenue, Orders, Avg Order Value
6. **Pivot Table** - Category-wise monthly breakdown

---

## How to Reproduce

1. Run `database_setup.sql` to create tables and insert data
2. Execute `analysis_queries.sql` to generate reports
3. Export query results to Excel
4. Create visualizations using Pivot Tables and Charts
5. Build dashboard layout

---

## Future Enhancements

- Add predictive analysis for demand forecasting
- Implement customer churn prediction model
- Create automated monthly reporting pipeline

---

**Author:** [Kazi Abu Sayeed]
**Date:** December 2024  
**GitHub:** [https://github.com/Sayeed-titan]