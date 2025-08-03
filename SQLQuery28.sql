-- Trigger

-- Creating a table which will be used after trigger
create table sales.EmployeeLogs (
	LogID int identity (1, 1) primary key, -- identity (seed, increment), where seed = The first value, increment = Each new row will increase this value by 1, identity is used for auto increment
	EmployeeID int,
	LogMessage varchar(255),
	LogDate date
);

-- Creating a trigger 
create trigger trg_AfterInsertEmployee on Sales.Employees 
after insert
as
begin
	insert into Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
	select
		EmployeeID,
		'New Employee Added = ' + cast(EmployeeID as varchar),
		getdate()
	from inserted
end

-- Check current status and insert values to the Employees table
select * from sales.employees;

insert into sales.Employees 
values (7, 'Nur', 'Ahmed', 'Data Analysis', '2002-12-12', 'M', '1000000', 2);

-- Check the log table
select * from sales.EmployeeLogs;
 
 