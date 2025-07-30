/*
Analyze the month-over-month (MOM) (Time Series Analysis) performance
by finding the percentage change in sales between 
the current and previous month
*/
select
	*,
	CurrentMonthSales - PreviousMonthSales MoM_Change,
	concat(coalesce(round(cast((CurrentMonthSales - PreviousMonthSales) as float) / PreviousMonthSales * 100, 1), 0), '%') [MoM Change in Percentage]
from
(
select
	month(orderdate) OrderMonth,
	sum(sales) CurrentMonthSales,
	lag(sum(sales)) over(order by month(orderdate)) PreviousMonthSales
from sales.orders
group by month(orderdate)
)t

--Analyze customer loyalty by ranking customers
--based on the average number of days between orders
select 
	customerid,
	avg(daysuntilnextorder) AvgDays,
	rank() over(order by coalesce(avg(daysuntilnextorder), 9999)) RankAvg
from
(
select
	orderid,
	customerid,
	orderdate CurrentOrder,
	lead(orderdate) over(partition by customerid order by orderdate) NextOrder,
	datediff(day, orderdate, lead(orderdate) over(partition by customerid order by orderdate)) DaysUntilNextOrder
from sales.orders
)t
group by customerid;

--Find the lowest and highest sales for each product
select
	orderid,
	productid,
	sales,
	first_value(sales) over(partition by productid order by sales) LowestSales,
	last_value(sales) over(partition by productid order by sales rows between current row and unbounded following) HighestSales,
	first_value(sales) over(partition by productid order by sales desc) HighestSalesNinjaTechnique,
	min(sales) over(partition by productid) LowestSalesUsingMin,
	max(sales) over(partition by productid) LowestSalesUsingMax
from sales.orders



