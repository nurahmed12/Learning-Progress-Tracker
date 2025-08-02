--Deleting a View
--drop view V_Monthly_Summary
--drop view Sales.V_Monthly_Summary

-- Provide view that combines details from orders, products, customers, and employees
if OBJECT_ID('Sales.V_Order_Details', 'V') is not null -- V stands for View
	drop view Sales.V_Order_Details;
go
create view Sales.V_Order_Details as
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
)

