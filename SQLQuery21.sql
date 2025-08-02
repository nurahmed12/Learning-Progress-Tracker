--View 2

if object_id('Sales.V_Monthly_Summary', 'V') is not null
	drop view Sales.V_Monthly_Summary;
go
create view Sales.V_Monthly_Summary as --Specifying the Schema name
(
		select
		DATETRUNC(month, orderdate) OrderMonth,
		sum(sales) TotalSales,
		count(orderid) TotalOrders,
		sum(quantity) TotalQuantities 
	from sales.orders
	group by DATETRUNC(month, OrderDate)
)