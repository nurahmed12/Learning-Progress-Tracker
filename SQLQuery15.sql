--Rank the orders based on their sales from highest to lowest
select
	orderid,
	productid,
	sales,
	row_number() over(order by sales desc) Rank,
	rank() over(order by sales desc) SalesRank,
	dense_rank() over(order by sales desc) SalesRank2
from sales.orders;

select
	orderid,
	productid,
	sales
from sales.orders;

--Find the top highest sales for each product
select * from
(
select
	orderid,
	productid,
	sales,
	row_number() over(partition by productid order by sales desc) SalesRank
from sales.orders
)t
where SalesRank = 1;

--Find the lowest 2 customers based on their total sales
select * from 
(
select
	customerid,
	sum(sales) TotalSales,
	row_number() over(order by sum(sales)) RankCustomers
from sales.orders
group by customerid
)t
where RankCustomers <= 2;

--Assign unique IDs to the rows of the 'Orders Archive' table
select 
	row_number() over(order by orderid, orderdate) UniqueID,
	*
from sales.ordersarchive;

--Identify duplicate rows in the table 'Orders Archive'
--and return a clean result without any duplicates
select * from
(
select
row_number() over(partition by orderid order by creationtime desc) RN,
*
from sales.ordersarchive
)t
where rn != 1;

--NTILE (Bucket size = (no of rows / no of buckets)
select
	orderid,
	sales,
	ntile(1) over(order by sales desc) OneBucket,
	ntile(2) over(order by sales desc) TwoBucket,
	ntile(3) over(order by sales desc) ThreeBucket,
	ntile(4) over(order by sales desc) FourBucket
from sales.orders;

--Segment all orders into 3 categories: high, medium, and low sales
select
	*,
	case when buckets = 1 then 'High'
		 when buckets = 2 then 'Medium'
		 else 'Low'
	end SalesSegmentations
from
(
select
	orderid,
	sales,
	ntile(3) over(order by sales desc) Buckets
from sales.orders
)t

--In order to export the data, devide the orders into 2 groups
select
	ntile(4) over(order by orderid) Buckets,
	*
from sales.orders

--Find the products that fall within the highest 40% of the prices
select
	*,
	concat(DistRank * 100, '%') DistRankPercentage
from
(
select
	product,
	price,
	cume_dist() over(order by price desc) DistRank /*I’m doing better than X% of the group if asc*/
from sales.products
)t
where DistRank <= 0.4

select
	*,
	concat(PercentRank * 100, '%') PercentRankPercentage
from
(
select
	product,
	price,
	percent_rank() over(order by price desc) PercentRank /*I’m doing better than X% of the group if asc*/
from sales.products
)t
where PercentRank <= 0.4



