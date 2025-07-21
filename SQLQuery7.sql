/*select * from customers

update customers
set score = 0, country = 'USA'
where id = 9

insert into customers
(id, first_name, country, score)
values
(10, 'Rika', 'Bangladesh', null),
(11, 'Nur', 'Bangladesh', null)

update customers
set score = 0
where score is null

delete from customers
where id > 6

select * from persons

truncate table persons -- Alternative is DELETE FROM customers, but prefer the TRUNCATE cs it is faster

select * from customers where country = 'bangladesh'

select * from customers where country <> 'Germany' -- or we can use !=

select * from customers where score >= 0

select * from customers where score <= 100*/

select * from customers

/*insert into customers
values
	('Nur', 'Bangladesh', 344),
	('Ana', 'Spain', 234),
	('Lisa', 'SK', 456),
	('Chris', 'UK', 463),
	('Robert', 'USA', 775),
	('Sabila', 'Bangladesh', 673)

EXEC sp_rename 'customers', 'customers_old';

CREATE TABLE customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100),
    country VARCHAR(100),
    score INT
);

INSERT INTO customers (first_name, country, score)
SELECT first_name, country, score FROM customers_old;

DBCC CHECKIDENT ('customers', RESEED, 6);

drop table customers_old*/

select * from customers
where country = 'bangladesh' and score >500

select * from customers
where country = 'bangladesh' or country = 'sk'

select * from customers where not score > 500

select * from customers 
where score between 300 and 500

select * from customers 
where country in ('bangladesh','sk')

select * from customers 
where country not in ('bangladesh','sk')

select * from customers
where first_name like 'A%'

select * from customers 
where country like '%h'

select * from customers
where country like '%a%'

select * from customers
where country like '__n%'

select * from customers
where first_name like 'n__'

select * from customers
where first_name like '__r'

select * from customers
where first_name like '__b___'

insert into customers
	(first_name, country, score)
values
	('Caca', 'Bangladesh', null),
	('Juby', 'Italy', null)

select * from customers
where score is not null

select * from customers
select * from orders

select * from customers as A
inner join orders as B on A.id = B.customer_id

select A.id, A.first_name, B.order_id, B.sales from customers as A
inner join orders as B on A.id = B.customer_id

select A.id, A.first_name, B.order_id, B.sales from
customers as A left join orders as B
on A.id = B.customer_id

insert into orders (order_id, customer_id, order_date, sales)
values (1005, 20, '2025-07-19', 30)

select B.order_id, A.id as customer_id, A.first_name, B.sales from
customers as A right join orders as B
on A.id = B.customer_id

select A.id, A.first_name, B.order_id, B.sales from
customers as A full join orders as B
on A.id = B.customer_id

select * from customers as A
left join orders as B
on A.id = B.customer_id
where B.customer_id is null

select * from customers as A
right join orders as B
on A.id = B.customer_id
where A.id is null

select * from customers A
full join orders B
on A.id = B.customer_id
where A.id is null or B.customer_id is null

select * from customers A
full join orders B
on A.id = B.customer_id
where A.id is not null and B.customer_id is not null -- Alternative of Inner Join

select * from customers A
left join orders B
on A.id = B.customer_id
where B.customer_id is not null -- A better alternative

select * from customers A
cross join orders B


