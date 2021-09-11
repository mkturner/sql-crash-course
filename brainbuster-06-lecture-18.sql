-- determine which Store has produced the most Revenue

-- inventory has store_id
-- payment has amount
-- rental has common fields (rental_id, invemtory_id), that can be used to link them

SELECT
    i.store_id as "Store ID", sum(p.amount) as Revenue 
FROM 
    payment p, inventory i, rental r
WHERE
    p.rental_id = r.rental_id
    AND 
    i.inventory_id = r.inventory_id
GROUP BY 1
ORDER BY 2 DESC
;