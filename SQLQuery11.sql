--use salesdb

select 
	orderid,
	orderdate,
	shipdate,
	creationtime
from sales.orders;

select 
	orderid,
	creationtime,
	'2025-08-20' HardCoded,
	getdate() Today
from sales.orders;

update sales.orders
set creationtime = '2025-07-16 23:25:15.0000000'
where orderid = 10

select * from sales.orders where orderid = 10

select
	orderid,
	creationtime,
	year(creationtime) Year,
	month(creationtime) Month,
	day(creationtime) Day,
	--Date Part
	datepart(year, creationtime) Year_dp, --Int
	datepart(month, creationtime) Month_dp,
	datepart(day, creationtime) Day_dp, --Int
	datepart(hour, creationtime) Hour_dp,
	datepart(quarter, creationtime) Quarter_dp,
	datepart(week, creationtime) Week_dp,
	datepart(weekday, creationtime) Weekday_dp,
	--Date Name
	datename(month, creationtime) Month_nm,
	datename(weekday, creationtime) Weekday_nm,
	datename(day, creationtime) Day_nm, --String
	datename(year, creationtime) Year_nm, --String
	--Date Trunc (Reset part of date)
	datetrunc(minute, creationtime) Minute_dt,
	datetrunc(day, creationtime) Day_dt,
	datetrunc(year, creationtime) Year_dt
from sales.orders;

select 
	creationtime,
	count(*)
from sales.orders
group by creationtime;

select 
	datetrunc(month, creationtime) Creation,
	count(*) Total_orders
from sales.orders
group by datetrunc(month, creationtime);

select 
	orderid,
	creationtime,
	eomonth(creationtime) EOMONTH,
	cast(datetrunc(month, creationtime) as date) SOMONTH
from sales.orders;

--How many orders were placed each month?
select 
	month(orderdate),
	count(*) NoOfOrders
from sales.orders
group by month(orderdate); 

select 
	datename(month, orderdate) as OrderDate,
	count(*) NoOfOrders
from sales.orders
group by datename(month, orderdate); 
