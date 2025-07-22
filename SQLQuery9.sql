--use SalesDB

select FirstName as f_name, LastName as l_name
from Sales.Customers

union

select firstname, lastname
from sales.employees;

select * from sales.customers;
select * from sales.employees;

select firstname, lastname
from sales.employees

union

select FirstName, LastName
from Sales.Customers;

select FirstName as f_name, LastName as l_name
from Sales.Customers

union all

select firstname, lastname
from sales.employees;

select firstname as f_name, lastname as l_name
from sales.employees

except

select FirstName, LastName
from Sales.Customers;

select firstname as f_name, lastname as l_name
from sales.employees

intersect

select firstname, lastname
from sales.customers;

select * from sales.orders;
select * from sales.ordersarchive;

select 
       'Orders' as SourceTable
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.orders

union

select 
       'OrdersArchive' as SourceTable
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.ordersarchive;

select 
       'Orders' as SourceTable
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.orders

union

select 
       'OrdersArchive' as SourceTable
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.ordersarchive
order by OrderID;


