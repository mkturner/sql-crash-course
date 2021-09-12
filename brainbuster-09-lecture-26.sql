-- How much revenue has one store made from PG-13 and R-Rated films?

-- Use HAVING, IN

SELECT 
    SUM(p.amount) as 'Revenue', 
    f.rating as 'Rating', 
    i.store_id as 'Store'
FROM film f, payment p, inventory i, rental r
WHERE
    f.film_id = i.film_id
    AND
    i.inventory_id = r.inventory_id
    AND 
    r.rental_id = p.rental_id
    AND
    -- limit results to only the first store 
    i.store_id = 1
    AND
    -- limit further to only films RATED R or PG-13
    -- but also from store 1
    f.rating IN('R', 'PG-13')
-- Group by rating to see Revenue for both 'R' and 'PG-13'
GROUP BY 2
ORDER BY 1 DESC
;