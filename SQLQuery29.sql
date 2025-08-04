-- Index

-- Create a new table for experiment
select *
into Sales.DBCustomers
from Sales.Customers;

select *
from Sales.Customers
where CustomerID = 1; -- Currently in Heap Index ( Searching the entire table to find the id)

-- Create a new Clustered Index for the table
create clustered index idx_DBCustomers_CustomerID
on Sales.DBCustomers (CustomerID);

-- Multiple Clustered indexes are not allowed
/*create clustered index idx_DBCustomers_FirstName
on Sales.DBCustomers (FirstName);*/ -- Will throw error

drop index idx_dbcustomers_customerid on sales.dbcustomers;


select *
from Sales.DBCustomers
where LastName = 'Brown';

-- Create a Non-Clustered Index for the table
create nonclustered index idx_DBCustomers_LastName
on sales.dbcustomers (lastname);

select *
from Sales.DBCustomers
where FirstName = 'Anna';

-- Multiple Non-Clustered indexes are allowed
create index idx_DBCustomers_FirstName -- If type of Index is not specified then the default (Non-Clustered) type will be used
on sales.dbcustomers (firstname);

-- Multiple Conditions
select * 
from Sales.Customers
where Country = 'USA' and Score > 500;

create index idx_DBCustomers_CountryScore
on Sales.DBCustomers (Country, Score); -- The search query order should be matched

select * 
from Sales.Customers
where Country = 'USA'; -- This still follows the previous indexing type as the left most prefix matches

select * 
from Sales.Customers
where Country = 'USA' and Score > 500; -- This however doesn't follow the previous indexing as a single condition because it is not the left most prefix that matches

-- ==================
-- ColumnStore Index
-- ==================

-- Deleting the existing Clustered index because only one can exist
drop index idx_DBCustomers_CS on sales.DBCustomers;

-- Clustered Columnstore
create clustered columnstore index idx_DBCustomers_CS
on Sales.DBCustomers;

-- Only one of any type Columnstore Index can be created for each table, so the following query will show error
-- Non-Clustered Columnstore
create nonclustered columnstore index idx_DBCustomers_CS_FirstName
on Sales.DBCustomers (FirstName);







