--use SalesDB

select * from Sales.Customers;

select * from Sales.Employees;

select * from Sales.Orders;

select * from Sales.OrderArchive;

select * from Sales.Products;

select 
	o.OrderID, o.Sales, 
	c.FirstName as CustomerFirstName, c.LastName as CustomeLastName, 
	p.Product as ProductName, p.Price,
	e.FirstName as EmployeeFirstName, e.LastName as EmployeeLastName
from Sales.Orders o
left join Sales.Customers c
on o.CustomerID = c.CustomerID
left join Sales.Products p
on o.ProductID = p.ProductID
left join Sales.Employees e
on o.SalesPersonID = e.EmployeeID


