-- Find number of distinct films rented each month

-- Use DISTINCT
SELECT 
    LEFT(r.rental_date, 7) as Month, 
    COUNT(r.rental_id) as "Total Rentals", 
    COUNT(DISTINCT i.film_id) as "Unique Films",
    COUNT(r.rental_id) / COUNT(DISTINCT i.film_id) as "Rentals / Film"
FROM rental r, inventory i
WHERE r.inventory_id = i.inventory_id
GROUP BY 1
ORDER BY 2 DESC
;