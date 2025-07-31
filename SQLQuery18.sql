--CTE (Common Table Expression)

--CTE
with cte_total_sales as
(
	select 
		CustomerID,
		sum(sales) TotalSales 
	from sales.orders
	group by customerid --Standalone CTE
--Order By cannot be used inside CTE
)
, cte_last_order as
(
	select
		customerid,
		max(orderdate) LastOrder 
	from sales.orders
	group by customerid --Multiple CTE
)
, cte_customer_rank as
(
	select
		customerid,
		totalsales,
		rank() over(order by totalsales desc) CustomerRank
	from cte_total_sales --Nested CTE
)
, cte_customer_segments as
(
	select
		customerid,
		totalsales,
		case when totalsales > 100 then 'High'
			 when totalsales > 80 then 'Medium'
			 else 'Low'
		end CustomerSegments
	from cte_total_sales --Nested CTE
)

--select * from cte_customer_segments

--Step1: Find the total Sales per Customer
--Step2: Find the last order date for each customer
--Step3: Rank Customers based on Total Sales per Customer
--Step4: Segment customers based on their total sales

--Main Query
select
	c.customerid,
	c.firstname,
	c.lastname,
	cts.TotalSales,
	clo.LastOrder,
	ccr.CustomerRank,
	ccs.CustomerSegments
from sales.customers c
left join cte_total_sales cts
on cts.customerid = c.customerid
left join cte_last_order clo
on clo.CustomerID = c.CustomerID
left join cte_customer_rank ccr
on ccr.CustomerID = c.CustomerID
left join cte_customer_segments ccs
on ccs.CustomerID = c.CustomerID






