-- Active: 1666860366437@@127.0.0.1@3306@sakila

Use sakila;

SELECT COUNT(*) FROM film
    left join film_category on film_category.film_id = film.film_id
    left join category on category.category_id = film_category.category_id
    where category.name = 'Music';


SELECT staff.email, address.address, address.address2, city.city, country.country FROM staff
    left join address on address.address_id = staff.address_id
    left join city on city.city_id = address.city_id
    left join country on country.country_id = city.country_id
    where ((staff.first_name = 'MIKE') and (staff.last_name = 'HILLYER'));


SELECT film_text.description from film_text
    left join film on film.film_id = film_text.film_id
    left join film_actor on film_actor.film_id = film.film_id
    left join actor on actor.actor_id = film_actor.actor_id
    where (actor.first_name = 'CARMEN') and (actor.last_name = 'HUNT')