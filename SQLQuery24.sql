-- Temporary Tables

select * 
into #Orders	-- The # makes Temporary Table
from sales.orders

select * from #Orders

delete from #Orders 
where OrderStatus = 'Delivered'

-- Save the Temp Table to the Database
select * 
into Sales.OrdersTest
from #Orders

