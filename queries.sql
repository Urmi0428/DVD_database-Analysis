/*first query- Since most people watch comdey now a days with many actors List Comdey films that have more than two actors*/
SELECT f.title as Comedy_Film, COUNT(a.actor_id)as No_of_actor FROM film f
join film_actor fa ON fa.film_id = f.film_id
Join actor a on a.actor_id = fa.actor_id
join film_category fc ON fc.film_id = f.film_id
Join category c ON c.category_id = fc.category_id
Group by f.title,c.name
Having c.name ='Comedy' AND COUNT(a.actor_id)>2

/*second query- customer name Linda called for issue in her payment so pull up the data of her past rentals*/
SELECT c.first_name, c.last_name, ci.city, co.country, p.amount,p.Payment_date
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN payment p ON p.customer_id = c.customer_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
WHERE co.country LIKE '%Greece%' AND c.first_name Like 'Linda';

/*Third query List of most rented film in descending orders with */
SELECT f.title, COUNT(r.rental_id) AS Rental_count, SUM(p.amount) AS Total_amount , AVG(p.amount) AS Avg_amount_per_rental,
STDDEV(p.amount) AS Standard_deviation FROM film f
JOIN film fi ON fi.film_id = f.film_id
JOIN inventory i ON i.film_id  = f.film_id 
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY f.title
ORDER BY  SUM(p.amount) desc ;

/*Country vise revenue*/
SELECT co.country, COUNT(c.customer_id) as No_of_Customer, SUM (p.amount) as Revenue_from_country FROM Customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY co.country

/**/






 







  
