-- Active: 1666860366437@@127.0.0.1@3306@sakila

use sakila;

select category.name, rental_duration from category
    left join film_category on film_category.category_id = category.category_id
    left join film on film.film_id = film_category.film_id
    ORDER BY film.rental_duration DESC;