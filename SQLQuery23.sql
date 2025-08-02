-- CTAS Table

if OBJECT_ID('Sales.Order_Details_Secured_USA_Table', 'U') is not null -- U stands for User Defined Table
	drop table Sales.Order_Details_Secured_USA_Table;
go
select
	o.OrderID,
	o.OrderDate,
	p.Product,
	p.Category,
	coalesce(c.FirstName, '') + ' ' + coalesce(c.LastName, '') CustomerName,
	c.Country CustomerCountry,
	coalesce(e.FirstName, '') + ' ' + coalesce(e.LastName, '') SalesPersonName,
	e.Department SalesDepartment,
	o.Sales,
	o.Quantity

into sales.Order_Details_Secured_USA_Table -- New Table 

from sales.orders o
left join sales.Products p
on p.ProductID = o.ProductID
left join sales.Customers c
on c.CustomerID = o.CustomerID
left join sales.Employees e
on e.EmployeeID = o.SalesPersonID
where c.Country <> 'USA'


select * from sales.Order_Details_Secured_USA_Table
-- drop table sales.Order_Details_Secured_USA_Table
