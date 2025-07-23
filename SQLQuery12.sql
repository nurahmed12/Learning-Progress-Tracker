--use salesdb

--Show all orders that were placed during the month of February
select *, datename(month, creationtime) order_month
from sales.orders
where datename(month, creationtime) = 'February';

select * from sales.orders
where month(orderdate) = 2;

select * from sales.orders
where datepart(month, orderdate) = 2;

--Format

select
	orderid,
	creationtime,
	format(creationtime, 'd') Day,
	format(creationtime, 'dd') Day,
	format(creationtime, 'ddd') Day,
	format(creationtime, 'dddd') Day
from sales.orders;

select
	orderid,
	creationtime,
	format(creationtime, 'M') Month,
	format(creationtime, 'MM') Month,
	format(creationtime, 'MMM') Month,
	format(creationtime, 'MMMM') Month
from sales.orders;

select
	orderid,
	creationtime,
	format(creationtime, 'MM-dd-yyyy') USA_Date,
	format(creationtime, 'yyyy-MM-dd') INT_Date,
	format(creationtime, 'dd-mm-yyyy') UK_Date,
	format(creationtime, 'MMM-dd-yyyy') USA_Date,
	format(creationtime, 'yyyy-MM-ddd') INT_Date,
	format(creationtime, 'dddd-MMMM-yyyy') UK_Date,
	format(creationtime, 'dddd-MMMM-yy') UK_Date
from sales.orders;

--Day Wed Jan Q1 2025 12:34:56 PM
select
	orderid,
	creationtime,
	'Day ' + format(creationtime, 'ddd MMM') + ' Q' + datename(quarter, creationtime)+ ' ' + format(creationtime, 'yyyy hh:mm:ss tt') CustomFormat
from sales.orders;

select
	datepart(month, orderdate),
	count(*)
from sales.orders
group by datepart(month, orderdate);

select
	format(orderdate, 'MMM yy') OrderDate,
	count(*)
from sales.orders
group by format(orderdate, 'MMM yy');

--Convert
select 
	convert(int, '123') as [String to INT Conversion],
	convert(date, '2025-08-20') as [String to Date Conversion],
	convert(date, creationtime) as [Datetime to Date Conversion]
from sales.orders;

select 
	convert(date, creationtime) as [Datetime to Date Conversion],
	convert(varchar, creationtime, 32) as [USA std. Style:32],
	convert(varchar, creationtime, 34) as [EU std. Style:34],
	convert(varchar, creationtime, 112) as [Plain std. Style:112]
from sales.orders;

--Cast
select 
	cast('123' as int) [String to INT],
	cast(213 as varchar) [INT to String],
	cast('2025-08-12' as date) [String to Date],
	cast('2025-08-12' as datetime2) [String to Datetime],
	creationtime,
	cast(creationtime as date) [Datetime as Date]
from sales.orders;

--Date Add
select
	orderid,
	orderdate,
	dateadd(month, -4, orderdate) [4 months before],
	dateadd(month, 4, orderdate) [4 months later],
	dateadd(day, -2, orderdate) [2 days before],
	dateadd(month, 2, (dateadd(year, 5, orderdate))) [5 years and extra 2 months later]
from sales.orders;

--Date Diff
select 
	employeeid,
	birthdate,
	datediff(year, birthdate, getdate()) Age
from sales.employees;

select 
	orderid,
	orderdate,
	shipdate,
	datediff(day, orderdate, shipdate) [Total waiting time]
from sales.orders;

select
	month(orderdate) [Order Month],
	avg(datediff(day, orderdate, shipdate)) [Average waiting time]
from sales.orders
group by month(orderdate);

select (datediff(month, '2002-12-12', getdate()))/12 Age;  --Calculate Age

--Find the number of days between each order and the previous order
select 
	orderid,
	orderdate CurrentOrderDate,
	lag(orderdate) over (order by orderdate) PreviousOrderDate,
	datediff(day, lag(orderdate) over (order by orderdate), orderdate) [Interval between orders]
from sales.orders;

--Is Date
select 
	isdate(getdate()),
	isdate(123),
	isdate('1222'),
	isdate('2025'),
	isdate(2025),
	isdate(2025-12-12),
	isdate('2025-12-12'),
	isdate('12-12-2002');

select
	--cast(orderdate as date) OrderDate,
	orderdate,
	isdate(orderdate) Date_or_not,
	(case when isdate(orderdate) = 1 
		then cast(orderdate as date)
		else '9999-01-01'
		end) NewOrderDate
from 
(
	select '2025-08-20' as OrderDate union
	select '2025-08-21' union
	select '2025-08-23' union
	select '2025-08'
)t
where isdate(orderdate) = 0;



