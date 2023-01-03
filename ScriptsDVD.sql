--"Hello World" of SQL - SELECT * GETS YOU ALL RECORDS FROM THE TABLE

select *
from actor;

-- Querey specific columns - SECLECT column_name,... FROM table_name

select first_name, last_name
from actor;

-- Change Query Order

select last_name, first_name
from actor;

select *
from film;

-- Filter rows - use the WHERE clause, always after from 

select *
from actor
where first_name = 'Nick';

--Using the LIKE operator

select *
from actor
where first_name like 'Nick';

-- Using the LIKE operator WITH %-% ACTS AS A WILd card - can be any number of characters (0-infinite)

select *
from actor where first_name like 'J%';

-- Using the LIKE operator with _-_ acts as a wild card for one and only one character

select *
from actor a where first_name like '_i_'; -- any record that has a first_name of 3 letters with the second letter being i

-- Using % and _ in the same pattern

select *
from actor a where first_name like '_i%';

-- using AND and OR in our WHERE clause
-- OR - only one thing needs to be true 

select *
from actor a 
where first_name like 'N%' or last_name like 'W%';

-- AND - where all conditions have to be true 

select *
from actor a 
where first_name like 'N%' and last_name like 'W%';

-- Comparing Operators in SQL:
-- Greater Than (>) - Less Than (<)
-- Greater Than or Equal to (>=) - Less Than or Equal to (<=)
-- Equal (=) - Not Equal (<>)

select *
from payment;

-- Query for all payments > $4

select customer_id, amount
from payment
where amount > '4';
-- where amount > 4; works the same because column type is numeric

-- Query for all payment that are not 7.99

select customer_id, amount
from payment
where amount <> 7.99;

-- Get all of the payments between $3 and $8 (inclusive)

select *
from payment
where amount >= 3 and amount <= 8;

-- BETWEEN/AND clause

select *
from payment
where amount between 3 and 8;

-- Order our rows of data by using the order by cluase (default ascending)

select *
from payment
where amount between 3 and 8
order by payment_date;

-- descending

select *
from payment
where amount between 3 and 8
order by amount desc;

-- Order by Strings - Alpha order 

select *
from actor
order by last_name;

-- SQL Aggregations => SUM(), AVG(), COUNT(), MIN(), MAX()
-- takes in a cloumn_name as an argumnet a returns a value
-- Get the sum of all the payments

select amount
from payment;

select sum(amount)
from payment;

-- get sum of all payments of more than $5

select sum(amount)
from payment
where amount > 5;

-- get average of all payments of more than $5
select avg(amount)
from payment
where amount > 5;

-- Count the amount of payments
select count(amount)
from payment
where amount > 5;

-- count all

select count(*)
from payment
where amount > 5;

-- get the min and max of payments

select min(amount)
from payment;

-- min with aliasing
select min(amount) as lowest_amount_paid
from payment;

-- max with aliasing

select max(amount) as highest_amount_paid
from payment;

-- calculate column based on 2 other columns 

select payment_id - rental_id as difference
from payment;

select payment_id, rental_id, payment_id - rental_id  as difference
from payment;

--select f.title, f.description, a.first_name, a.last_name
--from film f
--join film_actor fa
--on f.film_id = fa.film_id 
--join actor a
--on a.actor_id = fa.actor_id;
--
--SELECT film.title, film.description, actor.first_name, actor.last_name
--FROM film
--JOIN film_actor
--ON film.film_id = film_actor.film_id
--JOIN actor
--ON actor.actor_id = film_actor.actor_id;

-- Query the number of payments per amount

select caount(*)
from payment
where amount = 2.99

-- GROUP BY Clause - Used aggregations
select amount, count(*)
from payment
group by amount;

select amount, count(*), sum(amount), avg(amount)
from payment
group by amount;

-- using GROUP BY with everything from the select

select amount, customer_id, count(*)
from payment
group by amount, customer_id;

-- querey the payment tabnle to display the customer who spent the most

select customer_id, sum(amount)
from payment
group by customer_id 
order by sum(amount) desc;

select * from payment order by customer_id;

-- alias our aggregation column and iuse aliased name in order by 

select customer_id, sum(amount) as total_spent
from payment
group by customer_id 
order by total_spent desc;

-- Query the payment table to display customers who have spent the most , but have made at least 40 payments

select customer_id, sum(amount) as total_spent
from payment
group by customer_id
having count(*) >= 4
order by total_spent desc;

-- LIMIT and OFFSET clause
-- LIMIT - limits the num if rows that are returned

select *
from film
limit 10;

-- OFFSET - start rows after a certain amount using OFFSET

select *
from actor
offset 10;

-- OFFSET and LIMIT together
select *
from actor offset 10
limit 5;

-- Putting all of the clauses into one querey
-- display customers 11-20 wwho have spent the most in under 20 payments
-- and the customer_id has to be greater than 3

select customer_id, sum(amount), count(*)
from payment
where customer_id > 3
group by customer_id
having count(*) < 20
order by sum(amount)
offset 10
limit 10;

-- Syntax order (SELECT and FROM are the only mandatory keywords):
--select
--from
--join
--on
--where 
--group by 
--having
--order by 
--offset 
--limit


------------------------------------
-- WEEK 5 - DAY 1 - MONDAY QUESTIONS
------------------------------------

--	Question 1: How many actors are there with the last name ‘Wahlberg’?

select *
from actor
where last_name = 'Wahlberg';

-- Answer: 2 actors

-------------------------------------------------------------------------------------------------
--	Question 2: How many payments were made between $3.99 and $5.99?

select *
from payment
where amount between 3.99 and 5.99;

-- Answer: 5607 payments

-------------------------------------------------------------------------------------------------
--	Question 3: What films have exactly 7 copies? (search in inventory)

select film_id, COUNT(*) as copies
from inventory
group by film_id
having count(*) = 7;

-- Answer: 116 Different films with 7 copies

-------------------------------------------------------------------------------------------------
--	Question 4: How many customers have the first name ‘Willie’?

select *
from customer
where first_name = 'Willie';

-- Answer: 2 customers

-------------------------------------------------------------------------------------------------
--	Question 5: What store employee (get the id) sold the most rentals (use the rental table)?

select staff_id, COUNT(*) as most_rentals_sold
from rental
group by staff_id
order by most_rentals_sold desc
limit 1;
  
-- Answer: Mike Hillyer

-------------------------------------------------------------------------------------------------
--	Question 6: How many unique district names are there?

select district, COUNT(*) as unique_district_names
from address
group by district;

-- Answer: 378 Unique District Names

-------------------------------------------------------------------------------------------------
--	Question 7: What film has the most actors in it? (use film_actor table and get film_id)

select film_id, count(actor_id) as num_actors
from film_actor
group by film_id
order by num_actors desc
limit 1;

-- Answer: Lambs Cincinatti

-------------------------------------------------------------------------------------------------
--	Question 8: From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)

select count(*) as customers
from customer
where store_id = 1 and last_name like '%es';

-- Answer: 13 customers

-------------------------------------------------------------------------------------------------
--	Question 9: How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
-- with ids between 380 and 430? (use group by and having > 250)

select amount, count(*) as num_of_rentals
from payment
where customer_id between 380 and 430
group by amount
having count(*) > 250;

-- Answer: 3 payment amounts

-------------------------------------------------------------------------------------------------
--	Question 10: Within the film table, how many rating categories are there? And what rating has the most
-- movies total?

select rating, count(*) as most_movies_total
from film
group by rating
order by most_movies_total desc;

-- Answer: 5 rating categories, PG-13 has the most movies