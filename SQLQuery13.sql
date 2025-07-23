--Find the average scores of the customers
select
	customerid,
	score,
	coalesce(score, 0) Score2,
	avg(score) over() Average,
	avg(coalesce(score,0)) over() Average1
from sales.customers;

/*
Display the full name of customers in a single field
by merging their first and last names, and add 10 bonus
points to each customer's score.
*/
select 
	customerid,
	firstname,
	lastname,
	firstname + ' ' + coalesce(lastname, '') fullname,
	score,
	10 + isnull(score, 0) new_score --coalesce is better
from sales.customers;

select
	a.year,
	a.type, 
	a.orders,
	b.sales
from table1 a
join table2 b
on a.year = b.year
and isnull(a.type, '') = isnull(b.type, '');

/*
Sort the customers from lowest to highest scores, with
nulls appearing last
*/
select
	customerid,
	score
	--coalesce(score, 1231231)
from sales.customers
order by case when score is null then 1 else 0 end --coalesce(score, 1231231);

--Find the sales price for each order by dividing sales by quantity
select
	orderid,
	sales,
	quantity,
	sales / nullif(quantity, 0) Price --if quantity = 0 return null
from sales.orders;

--Identify the customers who have no scores
select *
from sales.customers
where score is null;

--List all customers who have scores
select *
from sales.customers 
where score is not null;

--list all details for customers who have not placed any orders
--Left Anti Join
select 
c.*,
o.orderid
from sales.Customers c
left join sales.orders o
on c.customerid = o.customerid
where o.customerid is null;

with orders as (
select 1 ID, 'A' Category union
select 2, null union
select 3, '' union
select 4, ' '
)
select *,
	datalength(category) CategoryLen --Or use the len()
from orders;

with orders as (
select 1 ID, 'A' Category union
select 2, null union
select 3, '' union
select 4, '    '
)
select *,
	datalength(category) CategoryLenBefore,
	trim(category) Policy,
	datalength(trim(category)) CategoryLenAfter
from orders;


