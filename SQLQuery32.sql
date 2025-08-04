-- Filtered Index

-- Filtered indexes cannot be created on Clustered Index
-- Filtered indexes cannot be created on ColumnStore Index

select * from sales.customers
where country = 'USA';

create nonclustered index idx_Customers_Country -- We can also use Unique keyword to make it unique
on sales.customers (Country)
where country = 'USA'; -- Filtered 










