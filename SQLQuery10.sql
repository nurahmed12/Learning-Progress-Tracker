--use mydatabase

select first_name, country
from customers;

select 
	first_name,
	country, 
	concat(first_name, '_', country) as name_country
from customers;

select
	first_name,
	country,
	upper(first_name) as upper_first_name,
	lower(country) as lower_country
from customers;

insert into customers
values
	('     Matt', '   SK   ', 322);

select * from customers;

select 
	first_name,
	country
from customers
where first_name != trim(first_name);

select 
	first_name,
	country
from customers
where country != trim(country);

select 
	first_name,
	country
from customers
where len(first_name) != len(trim(first_name));

select 
	first_name, 
	len(trim(first_name)) as actual_length_of_first_name,
	len(first_name) as false_length_of_first_name,
	country, 
	len(trim(country)) as actual_length_of_country,
	len(country) as false_length_of_country
from customers;

select 
	first_name, 
	len(first_name) as length_of_first_name,
	len(first_name) - len(trim(first_name)) flag_name,
	country, 
	len(country) as length_of_country,
	len(country) - len(trim(country)) flag_country
from customers;

select 
	'123-44-1214' as Phone,
	replace('123-44-1214', '-', '') as Clean_Phone;

select 
	'report.txt' as Old_format,
	replace('report.txt', '.txt', '.csv') as New_format;

select first_name, left(trim(first_name), 2) first_2_char
from customers;

select first_name, right(first_name, 2) first_2_char
from customers;

select 
	'Nodir pare' col1, 
	substring('Nodir pare', 2, 3) col2;

select 
	'Nodir pare' col1, 
	substring('Nodir pare', 3, (len('Nodir pare') + 1) - 3) col2;

select 
	3.516,
	round(3.516, 2) as round_1;

select 
	3.516,
	round(3.516, 1) as round_1;

select 
	-12 negative_number,
	abs(-12) positive_number,
	abs(10) neutral_number;


