-- Best Practices

-- Always check the execution plan to confirm performance improvements when optimizing your query (Data Engineer)

-- ==================================
-- Rule 1: Select only what you need
-- ==================================

-- Bad Practice:
SELECT 
	* 
FROM Sales.Customers;

-- Good Practice:
SELECT 
	CustomerID, Score  -- Choose only what you need
FROM Sales.Customers; 
-- =================================================
-- Rule 2: Avoid unnecessary DISTINCT & ORDER BY
-- =================================================

-- DISTINCT & ORDER BY filters are expensive and consumes a lot of resources when performed on large tables

-- Bad Practice:
SELECT DISTINCT
	FirstName 
FROM Sales.Customers
ORDER BY FirstName;

-- Good Practice:
SELECT 
	FirstName 
FROM Sales.Customers;

-- =================================================
-- Rule 3: For exploration purpose, Limit Rows
-- =================================================

-- If you need a quick peak about all the data or some specific columns, then use TOP or BOTTOM (TOP together with ORDER BY ... DESC) to see some values, instead of the entire table

-- Bad Practice:
SELECT 
	* 
FROM Sales.Customers;

-- Good Practice:
SELECT TOP 10
	* 
FROM Sales.Customers;

-- ================================================================================
-- Rule 4: Create Non-Clustered Index on frequently used Columns in WHERE clause
-- ================================================================================

SELECT 
	* 
FROM Sales.Orders
WHERE OrderStatus = 'Delivered';

CREATE NONCLUSTERED INDEX idx_Orders_OrderStatus ON Sales.Orders (OrderStatus);

-- =============================================================
-- Rule 5: Avoid applying functions to columns in WHERE clauses
-- =============================================================

-- If we apply any function in the WHERE clause, any Index that has been created for the search will not work 

-- Bad Practice:
SELECT 
	* 
FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered';

SELECT 
	* 
FROM Sales.Customers
WHERE SUBSTRING(FirstName, 1, 1) = 'A';

SELECT 
	* 
FROM Sales.Orders
WHERE YEAR(OrderDate) = 2025;

-- Good Practice:
SELECT 
	* 
FROM Sales.Orders
WHERE OrderStatus = 'Delivered';

SELECT 
	* 
FROM Sales.Customers
WHERE FirstName LIKE 'A%';

SELECT 
	* 
FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31';

-- ==========================================================================
-- Rule 6: Avoid leading wildcards (LIKE '%...') as they prevent index usage
-- ==========================================================================

-- Bad Practice:
SELECT 
	* 
FROM Sales.Customers
WHERE FirstName LIKE '%Ava%';

-- Good Practice:
SELECT 
	* 
FROM Sales.Customers
WHERE FirstName LIKE 'Ava%';

-- =======================================
-- Rule 7: Use IN instead of multiple OR
-- =======================================

-- Bad Practice:
SELECT 
	* 
FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3;

-- Good Practice:
SELECT 
	* 
FROM Sales.Orders
WHERE CustomerID IN (1, 2, 3);

-- =====================================================================
-- Rule 8: Understand the speed of JOINs & use INNER JOIN when possible
-- =====================================================================

-- Best Performance:

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID;

-- Slightly Slower Performance:

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
RIGHT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID;

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID;

-- Worst Performance:

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
FULL JOIN Sales.Orders o		-- Or FULL OUTER JOIN
ON c.CustomerID = o.CustomerID;

-- ===============================================================================
-- Rule 9: Use Explicit Join (ANSI Join) Instead of Implicit Join (non-ANSI Join)
-- ===============================================================================

-- Bad Practice:
SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID;

-- Good Practice:
SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID;

-- ==============================================================
-- Rule 10: Make sure to Index the columns used in the ON clause
-- ==============================================================

-- Without Indexes the Query might scan the entire table

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID;

CREATE NONCLUSTERED INDEX idx_Customers_CustomerID ON Sales.Customers (CustomerID);
CREATE NONCLUSTERED INDEX idx_Orders_CustomerID ON Sales.Orders (CustomerID);

-- ============================================
-- Rule 11: Filter Before Joining (Big Tables)
-- ============================================

-- Same Performance for all the following

-- Filter After Join (WHERE) {( For Small & Medium Size Tables) (Easy to Understand)}

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered';

-- Filter During Join (ON)

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
AND o.OrderStatus = 'Delivered';

-- Filter Before Join (SubQuery) {( For Large Table Best Practice is to Filter Before Join)}

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN (SELECT OrderID, CustomerID FROM Sales.Orders WHERE OrderStatus = 'Delivered') o	-- A CTE could be a better Alternative
ON c.CustomerID = o.CustomerID;

-- ===============================================
-- Rule 12: Aggregate Before Joining (Big Tables)
-- ===============================================

-- Grouping and Joining ( Best Practice for Small-Medium Tables)

SELECT 
	c.CustomerID,
	c.FirstName,
	COUNT(o.OrderID) AS OrderCount
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName;

-- Pre-Aggregated Subquery ( Best Practice for Big Tables )

SELECT 
	c.CustomerID,
	c.FirstName,
	o.OrderCount
FROM Sales.Customers c
INNER JOIN (
	SELECT 
		CustomerID, 
		COUNT(OrderID) AS OrderCount
	FROM Sales.Orders
	GROUP BY CustomerID
) o
ON c.CustomerID = o.CustomerID;

-- Correlated Subquery ( Bad Performance )

SELECT 
	c.CustomerID,
	c.FirstName,
	(
		SELECT 
			COUNT(OrderID) AS OrderCount
		FROM Sales.Orders o
		WHERE o.CustomerID = c.CustomerID
	) AS OrderCount
FROM Sales.Customers c;

-- ==========================================
-- Rule 13: Use Union Instead of OR in Joins
-- ==========================================

-- Bad Practice:

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
OR c.CustomerID = o.SalesPersonID;

-- Best Practice:

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
UNION
SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.SalesPersonID;

-- ==================================================
-- Rule 14: Check for Nested Loops and Use SQL HINTS
-- ==================================================

-- Check Execution Plan Whether any Nested Loop exists

-- Bad Practice:

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID;

-- Good Practice for Having Big Table & Small Table:

SELECT 
	c.FirstName,
	o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
OPTION (HASH JOIN);

-- ===========================================================================
-- Rule 15: Use UNION ALL instead of using UNION if duplicates are acceptable
-- ===========================================================================

-- SQL requires more time to execute UNION than UNION ALL

-- Bad Practice:

SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive;

-- Good Practice:

SELECT CustomerID FROM Sales.Orders
UNION ALL
SELECT CustomerID FROM Sales.OrdersArchive;

-- ==========================================================================================
-- Rule 16: Use UNION ALL + DISTINCT instead of using UNION if duplicates are not acceptable
-- ==========================================================================================

-- Bad Practice:

SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive;

-- Best Practice: (Only for Large Tables)

SELECT DISTINCT CustomerID 
FROM (
	SELECT CustomerID FROM Sales.Orders
	UNION ALL
	SELECT CustomerID FROM Sales.OrdersArchive
) AS CombineData;

-- ===============================================================
-- Rule 17: Use Columnstore Index for Aggregations on Large Table
-- ===============================================================

SELECT 
	CustomerID,
	COUNT(OrderID) AS OrderCount
FROM Sales.Orders
GROUP BY CustomerID;

CREATE CLUSTERED COLUMNSTORE INDEX idx_Orders_Columnstore ON Sales.Orders;

-- ====================================================================
-- Rule 18: Pre-Aggregate Data and store it in new Table for Reporting
-- ====================================================================

SELECT 
	MONTH(OrderDate) OrderMonth,
	SUM(Sales) TotalSales
INTO Sales.SalesSummary
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

SELECT 
	OrderMonth,
	TotalSales
FROM Sales.SalesSummary;

-- ==================================================================
-- Rule 19: Use JOIN if the performance equals to EXISTS over others
-- ==================================================================

-- JOIN ( Best Practice: If the Performance equals to EXISTS)

SELECT 
	o.OrderID,
	o.Sales
FROM Sales.Orders o
INNER JOIN Sales.Customers c
ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

-- EXISTS ( Best Practice: Use it for Large Tables)

SELECT 
	o.OrderID,
	o.Sales
FROM Sales.Orders o
WHERE EXISTS ( 
	SELECT 1
	FROM Sales.Customers c
	WHERE o.CustomerID = c.CustomerID
	AND c.Country = 'USA'
);

-- IN ( Bad Practice )

SELECT 
	o.OrderID,
	o.Sales
FROM Sales.Orders o
WHERE o.CustomerID IN( 
	SELECT 
		CustomerID
	FROM Sales.Customers
	WHERE Country = 'USA'
);

-- =============================================
-- Rule 20: Avoid Redundant Logic in Your Query
-- =============================================

-- Bad Practice:

SELECT 
	EmployeeID, 
	FirstName,
	'Above Average' Status
FROM Sales.Employees
WHERE Salary > (SELECT AVG(Salary) FROM Sales.Employees)
UNION ALL
SELECT 
	EmployeeID, 
	FirstName,
	'Below Average' Status
FROM Sales.Employees
WHERE Salary < (SELECT AVG(Salary) FROM Sales.Employees);

-- Good Practice:

SELECT 
	EmployeeID, 
	FirstName,
	CASE
		WHEN Salary > AVG(Salary) OVER() THEN 'Above Average'
		WHEN Salary < AVG(Salary) OVER() THEN 'Below Average'
		ELSE 'Average'
	END AS Status
FROM Sales.Employees;

-- ==================================
-- Rule 21: Create Table Efficiently
-- ==================================

-- Avoid Data Types VARCHAR & TEXT (Worst than VARCHAR)

-- Avoid (MAX) and try to reduce the Size of the VARCHAR

-- Use Proper Data Types for each Column

-- Use NOT NULL constraint where applicable

-- Ensure all your tables have a Clustered Primary Key

-- Create a Non-Clustered index for foreign keys that are used frequently

-- Bad Practice:

CREATE TABLE CustomersInfo1 (
	CustomerID INT,
	FristName VARCHAR(MAX),
	LastName TEXT,
	Country VARCHAR(255),
	TotalPurchases FLOAT,
	Score VARCHAR(255),
	BirthDate VARCHAR(255),
	EmployeeID INT,
	CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
		REFERENCES Sales.Employees(EmployeeID)
);

-- Good Practice:

CREATE TABLE CustomersInfo2 (
	CustomerID INT PRIMARY KEY CLUSTERED, -- By default it is also CLUSTERED
	FristName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Country VARCHAR(50) NOT NULL,
	TotalPurchases FLOAT,
	Score INT,
	BirthDate DATE,
	EmployeeID INT,
	CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
		REFERENCES Sales.Employees(EmployeeID)
);

CREATE NONCLUSTERED INDEX idx_Good_Customers_EmployeeID
ON CustomersInfo(EmployeeID);

-- =================================
-- Rule 22: Indexing Best Practices
-- =================================

-- Avoid Over Indexing because too many indexes going to slow down Insert, Update, Delete operations and will confuse the Execution Plan for right indexes and the performance of the system will drop

-- Drop Unused Indexes

-- Update Statistics (Weekly)

-- Reorganize & Rebuild Indexes (Weekly)

-- ==============================================================================
-- Rule 23: Use Partition Tables for large tables (Facts) to improve performance
-- ==============================================================================



