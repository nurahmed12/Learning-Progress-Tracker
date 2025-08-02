--Find the running total of sales of each month
with cte_monthly_summary as (
	select
		DATETRUNC(month, orderdate) OrderMonth,
		sum(sales) TotalSales,
		count(orderid) TotalOrders,
		sum(quantity) TotalQuantities
	from sales.orders
	group by DATETRUNC(month, OrderDate)
)
select
	OrderMonth,
	TotalSales,
	sum(totalsales) over (order by ordermonth) RunningTotal
from cte_monthly_summary

--Using View
select
	OrderMonth,
	TotalSales,
	sum(totalsales) over (order by ordermonth) RunningTotal
from v_monthly_summary

select *
from Sales.V_Order_Details_Secured_USA 
