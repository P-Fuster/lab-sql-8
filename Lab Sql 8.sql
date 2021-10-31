-- Lab Sql 8
-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select title, length, rank() over (order by length desc) 
	from film
	where length != 0 and length <> " ";
	
-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
select title, length, rating, dense_rank() over (partition by rating order by length desc) as 'Rank'
	from film
	where length != 0 and length <> " ";
	
-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query
select f.category_id as ID, c.name as Genre, count(f.category_id) as 'Number of movies per Genre' from film_category f
	join category c on c.category_id = f.category_id
	group by f.category_id;
	
-- 4. Which actor has appeared in the most films?
select a.actor_id as ID, a.first_name, a.last_name, count(film_id) as 'Number of films in', rank() over(order by count(film_id) desc) as 'Rank', dense_rank() over(order by count(film_id) desc) as 'Dense Rank'
	from actor a
	join film_actor f on a.actor_id = f.actor_id
	group by a.actor_id;
	
-- 5. Most active customer (the customer that has rented the most number of films)
select c.customer_id, c.first_name, c.last_name, count(rental_id) as 'Number of rentals per customer', rank() over(order by count(rental_id) desc) as 'Rank'
	from customer c
	join rental r on c.customer_id = r.customer_id
	group by c.customer_id;
	










