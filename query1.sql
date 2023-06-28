SELECT a.actor_id,CONCAT(a.first_name,' ', a.last_name) as Actor,fi.title as Film,COUNT(CONCAT(c.first_name,' ', c.last_name)) as No_of_Customer, COUNT(a.actor_id) as No_of_Actors_In_Film  FROM actor a
JOIN film_actor f ON f.actor_id = a.actor_id
JOIN film fi ON fi.film_id = f.film_id
JOIN inventory i ON i.film_id  = f.film_id 
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id
GROUP BY a.actor_id, c.first_name,c.last_name,fi.title
HAVING c.first_name LIKE '%r%' AND c.last_name LIKE '%h%' AND COUNT(a.actor_id) >1
ORDER BY CONCAT(a.first_name,' ', a.last_name);

SELECT * 
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN payment p ON p.customer_id = c.customer_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
WHERE co.country LIKE '%ee%'



SELECT l.language_id, l.name AS language_name, f.film_id, f.title
FROM language l
RIGHT OUTER JOIN film f ON l.language_id = f.language_id;



SELECT
  r.rental_id,MAX(CASE WHEN a.actor_id = 1 THEN a.first_name END) AS actor1_first_name
  FROM
  actor a
  JOIN film_actor f ON f.actor_id = a.actor_id
  JOIN inventory i ON i.film_id = f.film_id
  JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY
  r.rental_id;
  
