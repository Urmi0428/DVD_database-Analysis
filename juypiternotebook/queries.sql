/*first query- */
SELECT co.country,  DATE(p.payment_date) as date, SUM(p.amount) as total_revenue FROM Customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY co.country,DATE(p.payment_date)
order by DATE(p.payment_date);

/*second query- */
SELECT f.film_id, f.title, c.name, f.description FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id;

/*third query- */
SELECT co.country, COUNT(c.customer_id) as No_of_Customer, SUM (p.amount) as Revenue_from_country FROM Customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY co.country;

/*fourth query- */
SELECT a.actor_id, CONCAT(a.first_name,' ',a.Last_name) as actor, SUM(p.amount) as amount From actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON f.film_id = fa.film_id
JOIN inventory i ON i.film_id  = f.film_id 
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY a.actor_id
ORDER BY SUM(p.amount) DESC;



