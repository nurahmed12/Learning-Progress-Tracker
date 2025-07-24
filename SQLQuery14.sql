--Case Statement

/*
Create report showing total sales for each of the following categories:
High (sales over 50), Medium (sales 21-50), and low (sales 20 or less)
Sort the categories from highest sales to lowest
*/
select 
	SalesCategory,
	sum(sales) TotalSales
from (
	select 
		orderid,
		sales,
		case
			when sales >50 then 'High'
			when sales > 20 then 'Medium'
			else 'Low'
		end SalesCategory
	from sales.orders
)t
group by SalesCategory
order by TotalSales desc;

--Retrive employee details with gender displayed as full text
select 
	employeeid,
	firstname,
	lastname,
	gender,
	case
		when gender = 'M' then 'Male'
		when gender = 'F' then 'Female'
		else 'Unspecified'
	end GenderFull,
	department,
	salary
from sales.employees;

--Retrive customers details with abbreviated country code
select distinct country from sales.customers;

select
	customerid,
	firstname,
	lastname,
	country,
	case
		when country = 'Germany' then 'DE'
		when country = 'USA' then 'US'
		else 'n/a'
	end CountryShortForm
from sales.customers;

--Quick format (only for a single column and equla operation)
select
	customerid,
	firstname,
	lastname,
	country,
	case country --Only one column name can be used
		when 'Germany' then 'DE'
		when 'USA' then 'US'
		else 'n/a'
	end CountryNameShorthand
from sales.customers;

/*
Find the average scores of customers and treat NULLs as 0
Additionally provide details such CustomerID and LastName
*/
select
	CustomerID,
	LastName,
	case
		when score is null then 0
		else score
	end Score,
	avg(case
		when score is null then 0
		else score
	end) over() AverageScore
from sales.customers;

/*
Count how many times each customer has made an order with sales 
greater than 30
*/
select 
	--orderid,
	customerid,
	--sales,
	sum(case
			when sales > 30 then 1
			else 0
		end /*SalesFlag*/) CountOfOrdersExceedingSales30,
	count(*) TotalOrders
from sales.orders
group by customerid;

select 
	--orderid,
	customerid,
	--sales,
	count(case
			when sales > 30 then sales
			else NULL
		end /*SalesFlag*/) CountOfOrdersExceedingSales30,
	count(*) TotalOrders
from sales.orders
group by customerid;

select
	--customerid,
	count(*) TotalNumOrders,
	sum(sales) TotalSales,
	avg(sales) AverageSales,
	max(sales) HighestSales,
	min(sales) LowestSales
from sales.orders
--group by customerid;

select * from sales.orders order by sales;

--Window Functions

--Find the total sales across all orders
select
	--sales,
	sum(sales) TotalSales
from sales.orders;

--Find the total sales for each product
select 
	productid,
	sum(sales) TotalSales
from sales.orders
group by productid;

--Find the total sales for each product
--additionally provide details such as order id and order date
select 
	orderid,
	orderdate,
	productid,
	sum(sales) TotalSales
from sales.orders
group by 
	orderid,
	orderdate,
	productid;

--Partition By
select 
	orderid,
	orderdate,
	productid,
	orderstatus,
	sales,
	sum(sales) over(partition by productid) TotalSalesByProducts,
	sum(sales) over(partition by productid, orderstatus) TotalSalesByProductsAndOrderStatus,
	sum(sales) over() TotalSales
from sales.orders;

--Order By

--Rank each order based on their sales from highest to lowest
--Additionally provide details such as order id, order date
select
	orderid,
	orderdate,
	sales,
	rank() over(order by sales desc) RankedBasedOnSales
from sales.orders;

--Frame Clause

select
	orderid,
	orderdate,
	orderstatus,
	sales,
	sum(sales) over(partition by orderstatus order by orderdate
		rows between current row and 2 following) TotalSales1,
	sum(sales) over(partition by orderstatus order by orderdate
		rows between 2 preceding and current row) TotalSales2,
	sum(sales) over(partition by orderstatus order by orderdate
		rows 2 preceding) TotalSales3, /*Same as before, but shortcut, can only be applied to proceding*/
	sum(sales) over(partition by orderstatus order by orderdate
		rows unbounded preceding) TotalSales4, /*rows between unbounded preceding and current row*/
	sum(sales) over(partition by orderstatus order by orderdate) TotalSales5 --Default frame is rows between unbounded preceding and current row
	--Order By always uses Frame
from sales.orders;
--Window functions cannot be used in Where clause, Group by
--Nested Widow function is not allowed
--Window functions will be executed after the Where clause

--Find the total sales for each order status, only for 
--two products 101 and 102

select
	productid,
	orderid,
	orderdate,
	orderstatus,
	sales,
	sum(sales) over(partition by orderstatus) TotalSales
from sales.orders
where productid in (101,102);

--Window function can be used together with group by
--in same query, only if same columns are used

--Rank the customers based on their total sales
select
	customerid,
	sum(sales) TotalSales,
	rank() over(order by sum(sales) desc) RankCustomers
from sales.orders
group by customerid;

--Find the total number of scores for the customers
--additionally provide all customers details
select *,
	count(*) over() TotalCustomers,
	count(score) over() TotalScores,
	count(country) over() TotalCountries,
	count(lastname) over() TotalLastnames
from sales.customers;
