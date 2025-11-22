
-- =====================================================
-- PROJECT: E-Commerce Sales Performance Analysis (DML)
-- Description: Analyze sales data to identify trends,
--              top products, and regional performance
-- Skills Demonstrated: Complex SQL, Joins, Subqueries,
--                      CTEs, Window Functions, Aggregations
-- =====================================================

-- Use Database  ---

USE ECommerceSalesDB;
GO

--==== Insert Data ====--
-- Customers 
INSERT INTO Customers VALUES
(1, 'Rahul Sharma', 'rahul@email.com', 'Mumbai', 'West', '2023-01-15'),
(2, 'Priya Singh', 'priya@email.com', 'Delhi', 'North', '2023-02-20'),
(3, 'Amit Patel', 'amit@email.com', 'Ahmedabad', 'West', '2023-01-10'),
(4, 'Sneha Gupta', 'sneha@email.com', 'Kolkata', 'East', '2023-03-05'),
(5, 'Vikram Reddy', 'vikram@email.com', 'Hyderabad', 'South', '2023-02-28'),
(6, 'Ananya Iyer', 'ananya@email.com', 'Chennai', 'South', '2023-04-12'),
(7, 'Rajesh Kumar', 'rajesh@email.com', 'Bangalore', 'South', '2023-01-22'),
(8, 'Meera Nair', 'meera@email.com', 'Kochi', 'South', '2023-05-08'),
(9, 'Arjun Mehta', 'arjun@email.com', 'Pune', 'West', '2023-03-18'),
(10, 'Divya Sharma', 'divya@email.com', 'Jaipur', 'North', '2023-06-01'),
(11, 'Karan Singh', 'karan@email.com', 'Lucknow', 'North', '2023-04-25'),
(12, 'Pooja Verma', 'pooja@email.com', 'Chandigarh', 'North', '2023-07-14'),
(13, 'Suresh Rao', 'suresh@email.com', 'Vizag', 'South', '2023-02-11'),
(14, 'Neha Kapoor', 'neha@email.com', 'Delhi', 'North', '2023-08-03'),
(15, 'Aditya Joshi', 'aditya@email.com', 'Mumbai', 'West', '2023-05-29'),
(16, 'Ritu Agarwal', 'ritu@email.com', 'Kolkata', 'East', '2023-09-17'),
(17, 'Manoj Tiwari', 'manoj@email.com', 'Patna', 'East', '2023-06-22'),
(18, 'Swati Mishra', 'swati@email.com', 'Bhopal', 'Central', '2023-10-05'),
(19, 'Deepak Negi', 'deepak@email.com', 'Dehradun', 'North', '2023-07-30'),
(20, 'Kavita Rani', 'kavita@email.com', 'Amritsar', 'North', '2023-11-12'),
(21, 'Rohit Saxena', 'rohit@email.com', 'Agra', 'North', '2023-08-19'),
(22, 'Anjali Das', 'anjali@email.com', 'Guwahati', 'East', '2023-12-01'),
(23, 'Vivek Chauhan', 'vivek@email.com', 'Shimla', 'North', '2023-09-08'),
(24, 'Sunita Pillai', 'sunita@email.com', 'Trivandrum', 'South', '2023-10-25'),
(25, 'Gaurav Malhotra', 'gaurav@email.com', 'Noida', 'North', '2024-01-03');
GO
-- View Data --
--SELECT * FROM Customers;
--GO

-- Products
INSERT INTO Products VALUES
(1, 'Laptop Pro 15', 'Electronics', 75000.00, 55000.00),
(2, 'Wireless Mouse', 'Electronics', 1500.00, 800.00),
(3, 'USB-C Hub', 'Electronics', 2500.00, 1200.00),
(4, 'Office Chair', 'Furniture', 12000.00, 7500.00),
(5, 'Standing Desk', 'Furniture', 25000.00, 15000.00),
(6, 'Monitor 27inch', 'Electronics', 22000.00, 14000.00),
(7, 'Keyboard Mechanical', 'Electronics', 5000.00, 2800.00),
(8, 'Webcam HD', 'Electronics', 3500.00, 1800.00),
(9, 'Desk Lamp LED', 'Furniture', 1800.00, 900.00),
(10, 'Notebook Set', 'Stationery', 500.00, 200.00),
(11, 'Pen Premium', 'Stationery', 350.00, 120.00),
(12, 'Headphones BT', 'Electronics', 8000.00, 4500.00),
(13, 'Mouse Pad XL', 'Electronics', 800.00, 300.00),
(14, 'Cable Organizer', 'Accessories', 600.00, 250.00),
(15, 'Laptop Stand', 'Accessories', 2200.00, 1100.00);
GO

--SELECT * FROM Products;
--GO