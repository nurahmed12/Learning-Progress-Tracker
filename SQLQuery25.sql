-- Provide a view for EU sales team
-- that combines details from all tables
-- and excludes Data related to the USA
if OBJECT_ID('Sales.V_Order_Details_Secured_USA', 'V') is not null
	drop view Sales.V_Order_Details_Secured_USA;
go
create view Sales.V_Order_Details_Secured_USA as
(
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
	from sales.orders o
	left join sales.Products p
	on p.ProductID = o.ProductID
	left join sales.Customers c
	on c.CustomerID = o.CustomerID
	left join sales.Employees e
	on e.EmployeeID = o.SalesPersonID
	where c.Country <> 'USA'
)



