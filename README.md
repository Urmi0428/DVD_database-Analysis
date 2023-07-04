# DVD_database-Analysis
Database_Project(DVD)
The purpose of this project is to analyse the DVD database and present the significant relationas and data to see the revenue and get some predictions for store.
ER Diagaram
![image](https://github.com/Urmi0428/DVD_database-Analysis/assets/122922168/35af4219-9942-492d-ac01-6d06cf9e8fb0)
Below is bunch of 10 queries for Analysis of particular area of the database.
<h2>1.List of comedy films that have more than two actors</h2>
```
SELECT f.title as Comedy_Film, COUNT(a.actor_id)as No_of_actor FROM film f
join film_actor fa ON fa.film_id = f.film_id
Join actor a on a.actor_id = fa.actor_id
join film_category fc ON fc.film_id = f.film_id
Join category c ON c.category_id = fc.category_id
Group by f.title,c.name
Having c.name ='Comedy' AND COUNT(a.actor_id)>2
```

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
