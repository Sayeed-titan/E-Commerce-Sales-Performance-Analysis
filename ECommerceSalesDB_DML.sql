
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

INSERT INTO Orders VALUES
(1001, 1, '2024-01-05', '2024-01-08', 'Delivered'),
(1002, 2, '2024-01-07', '2024-01-10', 'Delivered'),
(1003, 3, '2024-01-10', '2024-01-14', 'Delivered'),
(1004, 5, '2024-01-12', '2024-01-15', 'Delivered'),
(1005, 7, '2024-01-15', '2024-01-18', 'Delivered'),
(1006, 4, '2024-01-18', '2024-01-22', 'Delivered'),
(1007, 8, '2024-01-20', '2024-01-24', 'Delivered'),
(1008, 10, '2024-01-25', '2024-01-28', 'Delivered'),
(1009, 6, '2024-02-01', '2024-02-04', 'Delivered'),
(1010, 9, '2024-02-05', '2024-02-08', 'Delivered'),
(1011, 11, '2024-02-08', '2024-02-12', 'Delivered'),
(1012, 12, '2024-02-12', '2024-02-15', 'Delivered'),
(1013, 1, '2024-02-15', '2024-02-18', 'Delivered'),
(1014, 14, '2024-02-18', '2024-02-22', 'Delivered'),
(1015, 15, '2024-02-22', '2024-02-25', 'Delivered'),
(1016, 3, '2024-02-25', '2024-02-28', 'Delivered'),
(1017, 16, '2024-03-01', '2024-03-04', 'Delivered'),
(1018, 17, '2024-03-05', '2024-03-08', 'Delivered'),
(1019, 18, '2024-03-08', '2024-03-12', 'Delivered'),
(1020, 2, '2024-03-12', '2024-03-15', 'Delivered'),
(1021, 19, '2024-03-15', '2024-03-18', 'Delivered'),
(1022, 20, '2024-03-18', '2024-03-22', 'Delivered'),
(1023, 21, '2024-03-22', '2024-03-25', 'Delivered'),
(1024, 5, '2024-03-25', '2024-03-28', 'Delivered'),
(1025, 22, '2024-04-01', '2024-04-04', 'Delivered'),
(1026, 23, '2024-04-05', '2024-04-08', 'Delivered'),
(1027, 7, '2024-04-08', '2024-04-12', 'Delivered'),
(1028, 24, '2024-04-12', '2024-04-15', 'Delivered'),
(1029, 25, '2024-04-15', '2024-04-18', 'Delivered'),
(1030, 13, '2024-04-18', '2024-04-22', 'Delivered'),
(1031, 1, '2024-05-01', '2024-05-04', 'Delivered'),
(1032, 4, '2024-05-05', '2024-05-08', 'Delivered'),
(1033, 8, '2024-05-08', '2024-05-12', 'Delivered'),
(1034, 10, '2024-05-12', '2024-05-15', 'Delivered'),
(1035, 6, '2024-05-15', '2024-05-18', 'Delivered'),
(1036, 9, '2024-05-18', '2024-05-22', 'Delivered'),
(1037, 11, '2024-05-22', '2024-05-25', 'Delivered'),
(1038, 14, '2024-05-25', '2024-05-28', 'Delivered'),
(1039, 2, '2024-06-01', '2024-06-04', 'Delivered'),
(1040, 15, '2024-06-05', '2024-06-08', 'Delivered'),
(1041, 3, '2024-06-08', NULL, 'Shipped'),
(1042, 16, '2024-06-10', NULL, 'Shipped'),
(1043, 19, '2024-06-12', NULL, 'Processing'),
(1044, 20, '2024-06-14', NULL, 'Processing'),
(1045, 7, '2024-06-15', NULL, 'Processing'),
(1046, 21, '2024-06-16', NULL, 'Pending'),
(1047, 22, '2024-06-17', NULL, 'Pending'),
(1048, 5, '2024-06-18', NULL, 'Pending'),
(1049, 13, '2024-06-19', NULL, 'Pending'),
(1050, 25, '2024-06-20', NULL, 'Pending');
GO

--SELECT * FROM Orders;
--GO