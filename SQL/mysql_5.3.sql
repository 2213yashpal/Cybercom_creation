CREATE TABLE Customers
(
	 CustomerID   INT PRIMARY KEY AUTO_INCREMENT
    ,CustomerName VARCHAR(100)
);
INSERT INTO Customers (CustomerName) VALUES
('Alice Johnson'),
('Bob Smith'),
('Charlie Brown'),
('Diana Williams'),
('Ella Jones'),
('Frank Garcia'),
('Grace Martinez'),
('Henry Rodriguez'),
('Isabel Wilson'),
('Jack Anderson');

CREATE TABLE Employees
(
	 EmployeeID    INT PRIMARY KEY AUTO_INCREMENT 
    ,EmployeeName  VARCHAR(100)
    ,Salary        DECIMAL(8,2)
);

INSERT INTO Employees (EmployeeName, Salary) VALUES
('John Smith', 50000.00),
('Emily Johnson', 55000.00),
('Michael Williams', 60000.00),
('Jessica Brown', 52000.00),
('William Jones', 58000.00),
('Olivia Garcia', 62000.00),
('David Martinez', 54000.00),
('Emma Rodriguez', 59000.00),
('Daniel Wilson', 63000.00),
('Sophia Anderson', 57000.00);

CREATE TABLE Country
(
	 CountryID    INT PRIMARY KEY AUTO_INCREMENT 
    ,CountryName varchar(50)
);

INSERT INTO Country (CountryName) VALUES
('USA'),
('Canada'),
('UK'),
('Germany'),
('France'),
('Australia'),
('Japan'),
('Brazil'),
('India'),
('China');

CREATE TABLE Orders
(
	 OrderID      INT PRIMARY KEY AUTO_INCREMENT
    ,CustomerID   INT
    ,ProductName  VARCHAR(50)
    ,Price        DECIMAL(6,2)
    ,EmployeeID   INT
    ,CountryID    INT
    ,FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    ,FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    ,FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);
INSERT INTO Orders (CustomerID, ProductName, Price, EmployeeID, CountryID) VALUES
(1, 'Laptop', 999.99, 1, 1),
(3, 'Phone', 799.99, 2, 3),
(3, 'Headphones', 49.99, 3, 3),
(4, 'Tablet', 299.99, 4, 5),
(5, 'Smartwatch', 199.99, 5, 5),
(6, 'Camera', 399.99, 6, 6),
(7, 'Speaker', 149.99, 7, 7),
(8, 'Monitor', 349.99, 8, 8),
(9, 'Keyboard', 79.99, 9, 9),
(10, 'Mouse', 29.99, 10, 10),
(1, 'Printer', 199.99, 1, 1),
(2, 'Earphones', 29.99, 2, 1),
(2, 'Smartwatch', 299.99, 3, 3),
(4, 'Tablet', 399.99, 4, 4),
(4, 'Camera', 499.99, 5, 2),
(6, 'Headphones', 69.99, 6, 6),
(7, 'Speaker', 99.99, 7, 7),
(8, 'Laptop', 899.99, 8, 2),
(9, 'Monitor', 249.99, 9, 9),
(10, 'Keyboard', 59.99, 10, 10);


-- 1.Write a SQL query to retrieve the names and salaries of all employees who have a 
-- salary greater than the average salary of all employees.
SELECT EmployeeName FROM Employees 
WHERE Salary > (SELECT AVG(Salary)FROM Employees);

-- 2.Write a SQL query to retrieve the names and total revenue generated by all
 -- customers in the "orders" table, sorted by revenue in descending order.
 SELECT C.CustomerName,SUM(O.Price) AS total_revenue FROM Customers C
 INNER JOIN Orders O ON O.CustomerID = C.CustomerID
 GROUP BY C.CustomerID 
 ORDER BY total_revenue DESC;
 
 -- 3.Write a SQL query to retrieve the names and total revenue generated by all customers in the "orders" table, 
--  sorted by revenue in descending order, where the total revenue is greater than $10,000.
 SELECT C.CustomerName,SUM(O.Price) AS total_revenue FROM Customers C
 INNER JOIN Orders O ON O.CustomerID = C.CustomerID
 GROUP BY C.CustomerID 
 HAVING total_revenue > 1000
 ORDER BY total_revenue DESC;
 
-- 4.Write a SQL query to retrieve the names and total revenue generated by all customers in the "orders" table, 
-- sorted by revenue in descending order,where the total revenue is greater 
-- than the average revenue generated by all customers.
 SELECT C.CustomerName,SUM(O.Price) AS total_revenue FROM Customers C
 INNER JOIN Orders O ON O.CustomerID = C.CustomerID
 GROUP BY C.CustomerID 
 HAVING total_revenue > (SELECT 
							AVG(TotalRevenue)FROM 
							(SELECT SUM(Price) AS TotalRevenue FROM Orders GROUP BY CustomerID)AS TOTAL
						)
 ORDER BY total_revenue DESC;
 
--  5.Write a SQL query to retrieve the names and total revenue generated by all customers in the "orders" table, 
--  sorted by revenue in descending order, where the total revenue is greater than the average revenue generated by 
--  all customers, and the customer is from the "USA" or "Canada".
 SELECT C.CustomerName,SUM(O.Price) AS total_revenue FROM Customers C
 INNER JOIN Orders O ON O.CustomerID = C.CustomerID
 INNER JOIN Country CO ON CO.CountryID = O.CountryID
 WHERE CO.CountryName = 'USA' OR CO.CountryName = 'Canada'
 GROUP BY C.CustomerID 
 HAVING total_revenue > (SELECT 
							AVG(TotalRevenue)FROM 
							(SELECT SUM(Price) AS TotalRevenue FROM Orders GROUP BY CustomerID)AS TOTAL
						);
	
-- 6.Write a SQL query to retrieve the names of all employees who have made sales greater than $50,000 in the "orders" table

SELECT E.EmployeeName  FROM Employees E 
INNER JOIN Orders O ON O.EmployeeID = E.EmployeeID
GROUP BY E.EmployeeName  
HAVING SUM(O.Price) > 50000;


-- 7.Write a SQL query to retrieve the names of all employees who have made sales greater than the average sales 
-- of all employees in the "orders" table, sorted by sales in descending order.
SELECT  E.EmployeeName,SUM(O.Price) AS total_revenue FROM Employees E 
INNER JOIN Orders O ON O.EmployeeID = E.EmployeeID
GROUP BY E.EmployeeName
HAVING total_revenue > (SELECT 
							AVG(TotalRevenue)FROM 
							(SELECT SUM(Price) AS TotalRevenue FROM Orders GROUP BY EmployeeID)AS TOTAL
						)
 ORDER BY total_revenue DESC;
 
 
--  8.Write a SQL query to retrieve the names and total revenue generated by all customers in the "orders" table, 
--  sorted by revenue in descending order,where the customer is from the "USA" and the revenue is greater than $5,000.
 SELECT C.CustomerName,SUM(O.Price) AS total_revenue FROM Customers C
 INNER JOIN Orders O ON O.CustomerID = C.CustomerID
 INNER JOIN Country CO ON CO.CountryID = O.CountryID
 WHERE CO.CountryName = 'USA' OR CO.CountryName = 'Canada'
 GROUP BY C.CustomerID 
 HAVING total_revenue > 5000
 ORDER BY total_revenue DESC;
 
 
--  9.Write a SQL query to retrieve the names and total revenue generated by all customers
--  in the "orders" table, sorted by revenue in descending order, where the customer is from the "USA" and the 
--  revenue is greater than the average revenue generated by all customers from the "USA".
 SELECT C.CustomerName,SUM(O.Price) AS total_revenue FROM Customers C
 INNER JOIN Orders O ON O.CustomerID = C.CustomerID
 INNER JOIN Country CO ON CO.CountryID = O.CountryID
 WHERE CO.CountryName = 'USA'
 GROUP BY C.CustomerID 
 HAVING total_revenue > (SELECT 
							AVG(TotalRevenue)FROM 
							(SELECT SUM(Price) AS TotalRevenue FROM Orders GROUP BY CustomerID)AS TOTAL
						)
ORDER BY total_revenue DESC;


-- 10.Write a SQL query to retrieve the names and total revenue generated by all customers in the "orders" table,
-- sorted by revenue in descending order, where the customer is from the "USA" and the revenue is greater 
-- than the average revenue generated by all customers, and the customer has made at least 2 orders.
 SELECT C.CustomerName,SUM(O.Price) AS total_revenue FROM Customers C
 INNER JOIN Orders O ON O.CustomerID = C.CustomerID
 INNER JOIN Country CO ON CO.CountryID = O.CountryID
 WHERE CO.CountryName = 'USA' 
 GROUP BY C.CustomerID 
 HAVING COUNT(o.OrderID) >= 2 AND total_revenue > (SELECT 
							AVG(TotalRevenue)FROM 
							(SELECT SUM(Price) AS TotalRevenue FROM Orders GROUP BY CustomerID)AS TOTAL
						)
 ORDER BY total_revenue DESC;