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

/*fourth Query-Country vise revenue*/
SELECT co.country, COUNT(c.customer_id) as No_of_Customer, SUM (p.amount) as Revenue_from_country FROM Customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY co.country
ORDER BY co.country;

/*fifth-query Using Union- List of customers that haven't return the DVD*/
SELECT  CONCAT(first_name,' ', last_name) AS Fullname
FROM customer
UNION
(
    SELECT CONCAT(first_name,' ', last_name)AS Fullname
	FROM Customer C
	JOIN rental r ON r.customer_id = c.customer_id
    WHERE r.return_date IS NULL
)
Order by Fullname;

/*sixth quersy- running total payment by paymentdate -Window Function*/
SELECT CONCAT(c.first_name,' ',c.last_name)AS Customer,
CONCAT(s.first_name,' ',s.last_name)AS staff,TO_CHAR(p.payment_date, 'YYYY-MM-DD') AS Date,
p.amount,SUM(p.amount)
OVER( PARTITION BY TO_CHAR(p.payment_date, 'YYYY-MM-DD')
	 ORDER BY p.customer_id ASC) AS running_total
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
JOIN staff s ON s.staff_id = p.staff_id 
ORDER BY TO_CHAR(p.payment_date, 'YYYY-MM-DD') ASC;

/*Seventh query -Case*/
SELECT f.title, f.rental_duration,c.name,
       CASE
           WHEN f.rental_duration > 5 THEN 'Long Duration'
           WHEN f.rental_duration <= 5 THEN 'Short Duration'
           ELSE 'Unknown Duration'
       END AS duration_category
FROM film f 
JOIN film_category fi ON f.film_id = fi.film_id
JOIN category c ON c.category_id = fi.category_id;

/* eighth query - creating View of film and film category */
ALTER VIEW Filmview AS
SELECT f.film_id, f.title, c.name FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id;
SELECT * FROM Filmview

/*ninth query- Create function to search filmcount by category from query eight view */
CREATE FUNCTION countfilmfromcategory(categoryname text) 
RETURNS integer AS $$
DECLARE
    filmCount integer;
BEGIN
    SELECT COUNT(*) INTO filmCount
    FROM Filmview
    WHERE name = categoryName;
    
    RETURN filmCount;
END;
$$ LANGUAGE plpgsql;
SELECT countfilmfromcategory('Action') AS Actionmoviecount;

/*tenth query-The inner subquery calculates the average amount for each film then rank by avg amount*/
SELECT film_id,customer, amount,average_amount,
  RANK() OVER (ORDER BY average_amount DESC) AS rank
FROM
  (SELECT
    f.film_id,CONCAT(c.first_name,' ',c.last_name)AS customer,
    p.amount,
    AVG(p.amount) OVER (PARTITION BY f.film_id) AS average_amount
  FROM
    payment p
  JOIN rental r ON r.rental_id = p.rental_id
  JOIN customer c ON c.customer_id = r.customer_id
  JOIN inventory i ON i.inventory_id = r.inventory_id
  JOIN film f ON f.film_id = i.film_id) AS subquery
  ORDER BY film_id;





 








  
