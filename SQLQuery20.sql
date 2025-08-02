--View 1

create view V_Monthly_Summary as
(
		select
		DATETRUNC(month, orderdate) OrderMonth,
		sum(sales) TotalSales,
		count(orderid) TotalOrders,
		sum(quantity) TotalQuantities
	from sales.orders
	group by DATETRUNC(month, OrderDate)
)