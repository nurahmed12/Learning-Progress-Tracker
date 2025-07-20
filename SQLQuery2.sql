-- select * from customers order by score desc 

--select * from customers order by country asc, score desc

/*select country, sum(score) as Total 
from customers group by country*/

/*select country as Desh, avg(score) as Average,
count(id) as Occurance,
sum(score) as Total
from customers group by country 
order by country desc*/

/*select distinct country
from customers where score > 500*/

/*select country, sum(score) as total
from customers where score > 400
group by country having sum(score) > 800*/

/*select country, avg(score) as average_score
from customers
where score != 0 group by country 
having avg(score) > 430*/

/*select top 3 *
from customers*/

/*select top 3 first_name, score from customers
order by score desc*/

/*select top 2 first_name, score from customers
order by score asc*/

/*select top 2 * from orders
order by order_date desc*/

/*select * from customers;

select * from orders;*/

/*select 123 as static_number

select 'Nur' as static_string*/

select id, first_name, 
'New Customer' as customer_type
from customers where id < 4