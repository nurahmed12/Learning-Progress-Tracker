create table persons (
	id int not null,
	person_name varchar(50) not null,
	birth_date date,
	phone varchar(15) not null,
	constraint pk_persons primary key(id)
)

select * from persons

alter table persons
add email varchar(50) not null

alter table persons
drop column phone

drop table persons
 
insert into customers 
(id, first_name, country, score)
values 
(6, 'Anna', 'USA', null),
(7, 'Sam', null, 100)

select * from customers

insert into customers 
values 
(8, 'Sam', 'Germany', 100)

insert into customers (id, first_name, country)
values 
(9, 'Andreas', 'UK')

insert into persons 
(id, person_name, birth_date, phone)
select id, 
first_name,
null,
'Unknown'
from customers

update customers
set score = 0
where id = 6