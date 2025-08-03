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

