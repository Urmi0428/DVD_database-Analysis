# DVD_database-Analysis
Database_Project(DVD)
The purpose of this project is to analyse the DVD database and present the significant relationas and data to see the revenue.
ER Diagaram
![image](https://github.com/Urmi0428/DVD_database-Analysis/assets/122922168/35af4219-9942-492d-ac01-6d06cf9e8fb0)
Below is bunch of 10 queries for Analysis of particular area of the database.


**1. List of comedy films that have more than two actors**

```
SELECT f.title as Comedy_Film, COUNT(a.actor_id)as No_of_actor FROM film f
join film_actor fa ON fa.film_id = f.film_id
Join actor a on a.actor_id = fa.actor_id
join film_category fc ON fc.film_id = f.film_id
Join category c ON c.category_id = fc.category_id
Group by f.title,c.name
Having c.name ='Comedy' AND COUNT(a.actor_id)>2;
```

**2. Data of customer Linda from Greece**

```
SELECT c.first_name, c.last_name, ci.city, co.country, p.amount,p.Payment_date
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN payment p ON p.customer_id = c.customer_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
WHERE co.country LIKE '%Greece%' AND c.first_name Like 'Linda';
```
**3. List of most rented film in descending orders with total and avg amount**

```
SELECT f.title, COUNT(r.rental_id) AS Rental_count, SUM(p.amount) AS Total_amount , AVG(p.amount) AS Avg_amount_per_rental,
STDDEV(p.amount) AS Standard_deviation FROM film f
JOIN film fi ON fi.film_id = f.film_id
JOIN inventory i ON i.film_id  = f.film_id 
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY f.title
ORDER BY  SUM(p.amount) desc ;
```
**4.Country vise revenue**

```
SELECT co.country, COUNT(c.customer_id) as No_of_Customer, SUM (p.amount) as Revenue_from_country FROM Customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY co.country;
```
**5. Using Union- List of customers that haven't return the DVD**

```
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
```
**6. running total payment by paymentdate -Window Function**

```
SELECT CONCAT(c.first_name,' ',c.last_name)AS Customer,
CONCAT(s.first_name,' ',s.last_name)AS staff,TO_CHAR(p.payment_date, 'YYYY-MM-DD') AS Date,
p.amount,SUM(p.amount)
OVER( PARTITION BY TO_CHAR(p.payment_date, 'YYYY-MM-DD')
	 ORDER BY p.customer_id ASC) AS running_total
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
JOIN staff s ON s.staff_id = p.staff_id 
ORDER BY TO_CHAR(p.payment_date, 'YYYY-MM-DD') ASC;
```
**7. List of films with rental duration using CASE**

```
SELECT f.title, f.rental_duration,c.name,
       CASE
           WHEN f.rental_duration > 5 THEN 'Long Duration'
           WHEN f.rental_duration <= 5 THEN 'Short Duration'
           ELSE 'Unknown Duration'
       END AS duration_category
FROM film f 
JOIN film_category fi ON f.film_id = fi.film_id
JOIN category c ON c.category_id = fi.category_id;
```

**7. creating View of film and film category**

```
CREATE VIEW FilmView AS
SELECT f.film_id, f.title, c.name as category FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id 
```
**9. Create function to search filmcount by category from query eight view**

```
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
SELECT countfilmfromcategory('Action');
```
- Run function to search filmcount by category 'Action'**
```
SELECT countfilmfromcategory('Action');
```
