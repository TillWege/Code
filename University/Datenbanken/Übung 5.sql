-- Active: 1666860366437@@127.0.0.1@3306@sakila

Use sakila;

SELECT * FROM sakila.category where sakila.category.name is NULL;

SELECT COUNT(*) FROM sakila.film 
    INNER JOIN sakila.film_category on film.film_id = sakila.film_category.film_id
    INNER JOIN sakila.category on sakila.category.category_id = sakila.film_category.category_id
    WHERE sakila.category.name = 'Music';

SELECT sakila.film.title, sakila.actor.first_name, sakila.actor.last_name  FROM sakila.film 
    INNER JOIN sakila.film_category on film.film_id = sakila.film_category.film_id
    INNER JOIN sakila.category on sakila.category.category_id = sakila.film_category.category_id
    INNER JOIN sakila.film_actor on sakila.film_actor.film_id = sakila.film.film_id
    INNER JOIN sakila.actor on sakila.actor.actor_id = sakila.film_actor.actor_id
    WHERE sakila.category.name = 'Drama';

SELECT sakila.actor.first_name, sakila.actor.last_name FROM sakila.actor WHERE 
    (EXISTS (select * FROM sakila.actor 
                    INNER JOIN sakila.film_actor on sakila.film_actor.actor_id = sakila.actor.actor_id
                    INNER JOIN sakila.film_category on sakila.film_category.film_id = sakila.film_actor.film_id
                    INNER JOIN sakila.category on sakila.category.category_id = sakila.film_category.category_id
                    WHERE sakila.category.name = "Drama"
                )
    AND
    EXISTS (select * FROM sakila.actor 
                INNER JOIN sakila.film_actor on sakila.film_actor.actor_id = sakila.actor.actor_id
                INNER JOIN sakila.film_category on sakila.film_category.film_id = sakila.film_actor.film_id
                INNER JOIN sakila.category on sakila.category.category_id = sakila.film_category.category_id
                WHERE sakila.category.name = "Musik"
            ))