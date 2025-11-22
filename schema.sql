
-- =====================================================
-- PROJECT: E-Commerce Sales Performance Analysis
-- Description: Analyze sales data to identify trends,
--              top products, and regional performance
-- Skills Demonstrated: Complex SQL, Joins, Subqueries,
--                      CTEs, Window Functions, Aggregations
-- =====================================================

-- Create Database Schema ---

CREATE DATABASE ECommerceSalesDB;
GO

USE ECommerceSalesDB;
GO

-- Create Tables ---

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50),
    Region VARCHAR(50),
    JoinDate DATE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    Cost DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATE,
    ShippingDate DATE,
    Status VARCHAR(20)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    Discount DECIMAL(5,2)
);

-- Drop Tables -- 
--DROP TABLE Customers;
--GO
--DROP TABLE Products;
--GO
--DROP TABLE Orders;
--GO
--DROP TABLE OrderDetails;
--GO