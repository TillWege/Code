-- Active: 1666860366437@@127.0.0.1@3306@sakila

Use sakila;

-- Aufgaben: 

SELECT film.title, rental.rental_date, country.country FROM customer
    INNER JOIN rental on rental.customer_id = customer.customer_id
    INNER JOIN inventory on inventory.inventory_id = rental.inventory_id
    INNER JOIN film on film.film_id = inventory.film_id
    INNER JOIN address on address.address_id = customer.address_id
    INNER JOIN city on city.city_id = address.city_id
    INNER JOIN country on country.country_id = city.country_id
    WHERE (rental_date LIKE "2005-05-28%") and (country.country = 'Canada');


SELECT film.title, rental_date FROM film
    INNER JOIN inventory on inventory.film_id = film.film_id
    INNER JOIN rental on rental.inventory_id = inventory.inventory_id
    INNER JOIN film_actor on film_actor.film_id = film.film_id
    INNER JOIN actor on actor.actor_id = film_actor.actor_id
    where (rental_date like "2005-05-29%") and (actor.first_name = 'UMA') and (actor.last_name = 'WOOD');

SELECT address.address, address.address2, address.district, city.city, country.country FROM customer
    INNER JOIN rental on rental.customer_id = customer.customer_id
    INNER JOIN inventory on inventory.inventory_id = rental.inventory_id
    INNER JOIN film on film.film_id = inventory.film_id
    INNER JOIN address on address.address_id = customer.address_id
    INNER JOIN city on city.city_id = address.city_id
    INNER JOIN country on country.country_id = city.country_id
    where (film.title = 'APACHE DIVINE');

SELECT address.address, address.address2, address.district, city.city, country.country FROM customer
    INNER JOIN address on address.address_id = customer.address_id
    INNER JOIN city on city.city_id = address.city_id
    INNER JOIN country on country.country_id = city.country_id
    WHERE customer.active = 0;

-- Random Stuff:

SELECT * FROM customer where address_id in 
    (select DISTINCT address_id from address where city_id in 
    (select DISTINCT city_id from city where country_id in 
    (select DISTINCT country_id from country where country.country = 'Canada')));

SELECT * FROM customer 
    left join address on customer.address_id = address.address_id
    left join city on city.city_id = address.city_id
    left join country on country.country_id = city.country_id
    where country.country = 'Canada';