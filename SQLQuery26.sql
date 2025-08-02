-- Store Procedure

-- Step 1: Write a query
-- For US Customers find the total number of Customers and the Average Score
select
	count(*) TotalCustomers,
	avg(score) AvgScore
from sales.customers
where country = 'USA'

-- Step 2: Turning the Query into a Stored Procedure

create procedure GetCustomerSummaryUSA as
begin
	select
		count(*) TotalCustomers,
		avg(score) AvgScore
	from sales.customers
	where country = 'USA'
end

-- Step 3: Execute the Stored Procedure
exec GetCustomerSummaryUSA

drop procedure GetCustomerSummary




