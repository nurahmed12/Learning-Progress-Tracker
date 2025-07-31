--Information Schema that contains Meta Data about the database
select * from information_schema.COLUMNS;
select distinct table_name from information_schema.COLUMNS;

--Scalar SubQuery
select 
	avg(sales) AvgSales
from sales.orders

--Row SubQuery
select
	customerid
from sales.orders

--Table SubQuery
select
	*
from sales.orders

/* Find the products that have a price higher than the average price of all products */
select 
	productid,
	sales
from sales.orders
where sales > 
(
	select
		avg(sales)
	from sales.orders
)

select 
	*
from
(
	select
		productid,
		sales,
		avg(sales) over() AvgSales
	from sales.orders
)t
where sales > AvgSales

--Rank the customers based on their total amount of sales
select *,
	rank() over(order by TotalSales desc) Ranking
from
(
select
	customerid,
	sum(sales) TotalSales
from sales.orders
group by customerid
)t

--Show the product ids, product names, prices, and the total number of orders
--Main Query
select
	productid,
	product,
	price,
	--Sub Query (only scalar subquery is allowed)
	(select count(*) from sales.orders) TotalOrders
from sales.products

--Show all customer details and find the total orders of each customer
select 
	c.*,
	o.TotalOrders
from sales.customers c 
left join (
	select 
		customerid,
		count(*) TotalOrders
	from sales.orders
	group by customerid) o
on c.customerid = o.customerid

--Find the products that have a price higher than the average price of all products
select * from sales.products
where price > 
(select 
	avg(price) AveragePrice 
from sales.products)

--Show the details of orders made by customers in Germany
select *
from sales.orders
where customerid in
(
select customerid
from sales.customers
where country = 'Germany'
)

--Find female employees whose salaries are greater than the salaries of any male employees
select 
	employeeid,
	firstname,
	gender,
	salary
from sales.employees
where gender = 'F' and salary > any
(
select 
	salary
from sales.employees
where gender = 'M'
)

select 
	employeeid,
	firstname,
	gender,
	salary
from sales.employees
where gender = 'M' and salary > all
(
select 
	salary
from sales.employees
where gender = 'F'
)

--Correlated SubQuery
--Show all customer details and find the total orders of each customer
select
	*,
	(select count(*) from sales.orders o where o.customerid = c.customerid) TotalOrders
from sales.customers c

--Show the details of orders made by customers in Germany
select
*
from sales.orders o
where exists (
		select 1
		from sales.customers c
		where c.country = 'Germany'
		and c.customerid = o.customerid)



