
select r.customer_id, c.first_name, c.last_name, r.rental_date, 
row_number() over (partition by r.customer_id order by rental_date)
from rental r
join customer c on r.customer_id = c.customer_id 


with cte_5 as
(select r.customer_id, c.first_name, c.last_name, r.rental_date, f2.film_id
from rental r
join customer c on r.customer_id = c.customer_id 
join inventory i2 on i2.inventory_id = r.inventory_id 
join film f2 on f2.film_id = i2.film_id 
where f2.special_features @> array ['{Behind the Scenes}'])
select customer_id, count(film_id)
from cte_5
group by customer_id

create materialized view lesson5 as
with cte_5 as
(select r.customer_id, c.first_name, c.last_name, r.rental_date, f2.film_id
from rental r
join customer c on r.customer_id = c.customer_id 
join inventory i2 on i2.inventory_id = r.inventory_id 
join film f2 on f2.film_id = i2.film_id 
where f2.special_features @> array ['{Behind the Scenes}'])
select customer_id, count(film_id)
from cte_5
group by customer_id
with no data; 

refresh materialized view lesson5 

with cte_5 as
(select r.customer_id, c.first_name, c.last_name, r.rental_date, f2.film_id
from rental r
join customer c on r.customer_id = c.customer_id 
join inventory i2 on i2.inventory_id = r.inventory_id 
join film f2 on f2.film_id = i2.film_id 
where 'Behind the Scenes' = any(special_features))
select customer_id, count(film_id)
from cte_5
group by customer_id

with cte_5 as
(select r.customer_id, c.first_name, c.last_name, r.rental_date, f2.film_id
from rental r
join customer c on r.customer_id = c.customer_id 
join inventory i2 on i2.inventory_id = r.inventory_id 
join film f2 on f2.film_id = i2.film_id 
where f2.special_features :: text ilike '%Behind the Scenes%')
select customer_id, count(film_id)
from cte_5
group by customer_id

Лабораторная работа
--1. Рассчитайте совокупный доход всех магзиной на каждую дату
select cast(payment_date as date) as date, sum (amount) as income
from payment 
group by date
order by date 

--Преобразовала ДАТА-Время в Дату, чтобы потом по ней сгруппировать 
select cast(payment_date as date) as date
from payment 

--2.
select*
from payment p2 

select*
from category c2 

select*
from rental r2 

select*
from film f2 

select c2.category_id, c2."name", count(f.rental_rate) as count_rate 
from category c2 
join film_category fc on c2.category_id = fc.category_id 
join film f on f.film_id = fc.film_id 
group by c2.name, c2.category_id
order by count_rate
where category_id = 12 or category_id = 15

