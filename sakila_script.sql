use sakila;
SHOW TABLES;
-- PART I
-- 1. Get a list of all film tiles alphabetized by title.
SELECT * FROM film ORDER BY title;

-- 2. Find the description, release year, length, and ra�ng for the movie “KENTUCKIAN GIANT”.
SELECT DESCRIPTION, release_year, length, rating FROM film WHERE title = "KENTUCKIAN GIANT";

-- 3. Find the first name and last name of each employee (staff table). Your query should include the last name first, and then the first name.
SELECT last_name, first_name FROM staff;

-- 4. Repeat the query above, but this time, the results should include only one column with the format last name, first name. The output column should be named “name”
SELECT concat(last_name, ', ', first_name) AS NAME FROM staff;

-- 5. Get the number of customers. The output should be a single number. Name the column “num_customers”
SELECT count(*) as num_customers from customer;

-- 6. Get the number of customers who are active vs inactive in the system.
SELECT count(*) as active_customers FROM customer WHERE active = 'active';
SELECT count(*) as active_customers FROM customer WHERE active != 'active';

-- 7. Get the average amount a customer spends on a rental.
SELECT AVG(p.amount) as average_spent_per_rental FROM payment p;

-- 8. Get maximum amount any customer has spent on a rental.
SELECT max(p.amount) as maximum_spent_on_rental FROM payment p;

-- 9. Get a list of the actors. The results should include only one column with the format last name, first name. The column should be named “actor_name” The results should be sorted be sorted alphabetically by the last name (ascending).
SELECT concat(last_name, ", ", first_name) AS actor_name from actor ORDER BY last_name ASC;

-- 10. Repeat this query above, but the results should be in reverse order.
SELECT concat(last_name, ", ", first_name) AS actor_name from actor ORDER BY last_name DESC;

-- 11. Repeat the query again, this time get only actors whose last names start with ‘M’ or ‘V’. Order the results alphabetically by last name (ascending).
SELECT concat(last_name, ", ", first_name) AS actor_name from actor WHERE last_name LIKE "M%" or last_name LIKE "V%" ORDER BY last_name ASC;

-- 12. Repeat the query again, this time get only actors whose last names start with leters between‘M’ and ‘V’ inclusive. Order the results alphabetically by last name (ascending).
SELECT concat(last_name, ", ", first_name) AS actor_name from actor WHERE last_name >= "M%" AND last_name <= "V%" ORDER BY last_name ASC;

-- 13. Get a list of each customer ID and the number of rentals they have in their history. Name this column Number of Rentals.
SELECT customer_id, COUNT(rental_id) as number_of_rentals FROM rental GROUP BY customer_id ORDER BY customer_id;

-- PART II
-- 1. Get a list of category names and a count of movies that fall into that category. Name the category column “category” the count column “num_films”. Order the results alphabetically (ascending). Use the WHERE clause to join the tables.
SELECT c.name AS category, COUNT(f.film_id) AS num_films FROM category c, film_category fc, film f WHERE c.category_id = fc.category_id  AND fc.film_id = f.film_id GROUP BY c.name ORDER BY c.name ASC;

-- 2. Repeat the query above using a JOIN clause instead of the WHERE clause
SELECT c.name AS category, COUNT(f.film_id) AS num_films FROM category c JOIN film_category fc ON c.category_id = fc.category_id JOIN film f ON fc.film_id = f.film_id GROUP BY c.name ORDER BY c.name ASC;

-- 3. Get a list of country names and a count of the cities that are in that country. Name the count column “num_cities”. Order the results alphabetically (ascending). Use the WHERE clause to join the tables.
SELECT co.country AS country, count(ci.city_id) AS num_cities FROM country co, city ci WHERE co.country_id = ci.country_id GROUP BY co.country ORDER BY co.country ASC;

-- 4. Repeat the query above using a JOIN clause instead of the WHERE clause.
SELECT co.country AS country, count(ci.city_id) AS num_cities FROM country co JOIN city ci ON co.country_id = ci.country_id GROUP BY co.country ORDER BY co.country ASC;

-- 5. Get a list of each customer’s last name and first name and the number of rentals they have. Name the count column “num_rentals”. Order the result by the number of rentals in descending order. The highest number of rentals should be at the top. Sort any �es (same number of rentals) by last name (ascending). Use the WHERE clause to join the tables.
SELECT COUNT(*) AS active_customers FROM customer WHERE active = 1;

-- 6. Repeat the query above using a JOIN clause instead of the WHERE clause.
SELECT COUNT(*) AS active_customers FROM customer c JOIN store s ON c.store_id = s.store_id WHERE c.active = 1;

-- 7. Get a list of each customer’s last name and first name and the amount of money they have spent on rentals. Name the sum column “total_spent”. Order the result by the amount in descending order. The highest amount of money spent should be at the top. Sort any �es (amount of money spent) by last name (ascending). Use the JOIN clause for this query.
SELECT p.customer_id, AVG(p.amount) AS average_spent_per_rental FROM payment p GROUP BY p.customer_id;

-- 8. Get the number of actors in each film. Order the results (ascending) by the film title and name the column with the actor count “num_actors”.
SELECT f.title, COUNT(fa.actor_id) AS num_actors FROM film f JOIN film_actor fa ON f.film_id = fa.film_id GROUP BY f.title ORDER BY f.title ASC;

-- 9. Get the number of films each manager holds. Use only the manager staff id to iden�fy the manager. Name the column with the number of films “num_films”.
SELECT CONCAT(last_name, ', ', first_name) AS actor_name FROM actor ORDER BY last_name ASC;

-- 10. Get the number of customers per manager. Use only the manager staff id to iden�fy the manager. Name the column with the number of films “num_customers”. Order by store id (ascending).
SELECT s.manager_staff_id AS manager_id, COUNT(c.customer_id) AS num_customers FROM store s JOIN customer c ON s.store_id = c.store_id GROUP BY s.manager_staff_id ORDER BY s.store_id ASC;

-- 11. Get the title and film category of each film. Order the results by category name. Rename the “name” column so it says “category”. This query will involve joining three tables using the JOIN syntax.
SELECT f.title, c.name AS category FROM film f JOIN film_category fc ON f.film_id = fc.film_id JOIN category c ON fc.category_id = c.category_id ORDER BY c.name ASC;

-- 12. Get a list of each customer’s first and last name (individually, not concatenated) and their full address including city and country. Order the results by the customer’s last name. This will involve joining four tables using the JOIN syntax.
SELECT c.first_name, c.last_name, a.address, a.address2, ci.city, co.country FROM customer c JOIN address a ON c.address_id = a.address_id JOIN city ci ON a.city_id = ci.city_id JOIN country co ON ci.country_id = co.country_id ORDER BY c.last_name ASC;

-- 13. SELECT c.first_name, c.last_name, a.address, a.address2, ci.city, co.country
SELECT c.first_name, c.last_name, a.address, a.address2, ci.city, co.country FROM customer c JOIN address a ON c.address_id = a.address_id JOIN city ci ON a.city_id = ci.city_id JOIN country co ON ci.country_id = co.country_id WHERE c.active = 0 AND co.country = 'China' ORDER BY c.last_name ASC;

-- 14. Get a list of the titles of every film each customer has rented. Order the results by customer last name (ascending) and title (ascending).
SELECT c.last_name, c.first_name, f.title FROM rental r JOIN customer c ON r.customer_id = c.customer_id JOIN inventory i ON r.inventory_id = i.inventory_id JOIN film f ON i.film_id = f.film_id ORDER BY c.last_name ASC, f.title ASC;

-- 15. Repeat the query above, but this time, include the category of each �tle in the results. Name the category column “category”. Order the results by the same columns (name and title).
SELECT c.last_name, c.first_name, f.title, cat.name AS category FROM rental r JOIN customer c ON r.customer_id = c.customer_id JOIN inventory i ON r.inventory_id = i.inventory_id JOIN film f ON i.film_id = f.film_id JOIN film_category fc ON f.film_id = fc.film_id JOIN category cat ON fc.category_id = cat.category_id ORDER BY c.last_name ASC, f.title ASC;

-- 16. Get a list of each customer that includes their first and last name, the number of rentals (num_rentals) they have had and the total amount (total_spent) of money they have spent on rentals. Order the results by last name (ascending).
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS num_rentals, COALESCE(SUM(p.amount), 0) AS total_spent FROM customer c LEFT JOIN rental r ON c.customer_id = r.customer_id LEFT JOIN payment p ON r.rental_id = p.rental_id GROUP BY c.customer_id, c.first_name, c.last_name ORDER BY c.last_name ASC;

-- 17. Repeat the query above, but this time add the customer’s country to the output. The order of the columns should be last_name, first_name, country, num_rentals, total_spent. Order rows by last name (ascending)
SELECT c.last_name, c.first_name, co.country, COUNT(r.rental_id) AS num_rentals, COALESCE(SUM(p.amount), 0) AS total_spent FROM customer c JOIN address a ON c.address_id = a.address_id JOIN city ci ON a.city_id = ci.city_id JOIN country co ON ci.country_id = co.country_id LEFT JOIN rental r ON c.customer_id = r.customer_id LEFT JOIN payment p ON r.rental_id = p.rental_id GROUP BY c.customer_id, c.last_name, c.first_name, co.country ORDER BY c.last_name ASC;
