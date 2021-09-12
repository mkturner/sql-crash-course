-- Introducing JOIN && LEFT JOIN

-- TASK 1
-- create temporary table: All active customers w/ phone number
-- active: customer table
-- phone number: address table
-- include all fields from customer table

SELECT c.*, a.phone
FROM customer c 
LEFT JOIN address a
ON c.address_id = a.address_id
WHERE c.active = 1
GROUP BY 1
