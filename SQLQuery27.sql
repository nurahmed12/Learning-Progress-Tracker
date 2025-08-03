-- Parameters

-- For German Customers find the total number of Customers and the average score
create procedure GetCustomerSummaryGermany as
begin
	select
		count(*) TotalCustomers,
		avg(score) AvgScore
	from sales.customers
	where country = 'Germany'
end

exec GetCustomerSummaryGermany

drop procedure GetCustomerSummaryGermany

-- Instead of writing the same query for different Stored Procedures
create /* or alter if same named table already exists*/ procedure GetCustomerSummary @Country nvarchar(50) -- The @Country is the parameter here
as
begin
	select
		count(*) TotalCustomers,
		avg(score) AvgScore
	from sales.customers
	where country = @Country
end

-- Execute the Stored Procedure
exec GetCustomerSummary @Country = 'USA'

-- Assigning a default value

-- Total Customers from Germany: 2
-- Average Score from Germany: 425
-- Using Variable
alter procedure GetCustomerSummary @Country nvarchar(50) = 'USA' 
as
begin
	begin try -- For trying to catch an Error

		declare @TotalCustomers int, @AvgScore float; -- Variables

		-- =========================
		-- Prepare & Cleanup Data
		-- =========================

		if exists(select 1 from sales.Customers where score is null and Country = @Country)
			begin
				print('Updating NULL Scores to 0');
				update sales.customers
				set score = 0
				where score is null and country = @Country;
			end
		else
			begin
				print('No NULL Scores found');
			end;

		-- =====================
		-- Generating Reports
		-- ===================== 
		-- Calculate Total Customers and Average Score for specific Country
		select
			@TotalCustomers = count(*), -- No aliases are allowed
			@AvgScore = avg(score) -- No aliases are allowed
		from sales.customers
		where country = @Country;

		print 'Total Customers from ' + @Country + ':' + cast(@TotalCustomers as nvarchar);
		print 'Average Score from ' + @Country + ':' + cast(@AvgScore as nvarchar);

		-- =============================================
		-- Find the total no of Orders and Total Sales
		-- =============================================
		-- Calculate Total Number of Orders and Total Sales for specific Country
		select
			count(orderid) TotalOrders,
			sum(sales) TotalSales
		from sales.orders o
		join sales.customers c
		on c.CustomerID = o.CustomerID
		where c.Country = @Country;

	end try
	begin catch 
		-- ===============
		-- Errors Handling
		-- ===============
		print('An Error Occured');
		print('Error Message: ' + error_message());
		print('Error Number: ' + cast(error_number() as nvarchar));
		print('Error Line: ' + cast(error_line() as nvarchar));
		print('Error Procedure: ' + error_procedure());
	end catch
end
 
-- select * from sales.customers

exec GetCustomerSummary
exec GetCustomerSummary @Country = 'Germany'




