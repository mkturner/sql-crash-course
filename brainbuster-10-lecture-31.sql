-- Introducing JOIN && LEFT JOIN

-- TASK 1
-- create temporary table: All active customers w/ phone number
-- active: customer table
-- phone number: address table
-- include all fields from customer table

SELECT c.*, a.phone
FROM customer c 
JOIN address a
ON c.address_id = a.address_id
WHERE c.active = 1
GROUP BY 1
;



-- TASK 2
-- All reward customers, w/ rentals >= 30
-- list customer_id, number of rentals, last rental date
SELECT 
    r.customer_id as 'Customer ID',
    COUNT(r.rental_id) as '# Rentals',
    MAX(rental_date) as 'Last Rental Date'
FROM rental r
GROUP BY 1
ORDER BY 2
HAVING COUNT(r.rental_id) >= 30
;



-- BRAINBUSTER #1
-- determine list of reward users who are also active
-- list their customer_id, email, and first_name

SELECT 
    active_users.customer_id, 
    active_users.email, 
    active_users.first_name
FROM (
    SELECT c.*
    FROM customer c 
    JOIN address a
    ON c.address_id = a.address_id
    WHERE c.active = 1
) as active_users
JOIN (
    SELECT 
        r.customer_id as cust_id,
        COUNT(r.rental_id) as '# Rentals',
        MAX(rental_date) as 'Last Rental Date'
    FROM rental r
    GROUP BY 1
    HAVING COUNT(r.rental_id) >= 30
) as reward_users
ON active_users.customer_id = reward_users.cust_id
GROUP BY 1
;



-- BRAINBUSTER #2
--  ALL reward users
-- list customer_id, email, phone

SELECT
  reward.customer_id,
  c.email,
  active.phone
FROM
-- determine reward customers w/ 30+ rentals
  (
    SELECT
      r.customer_id,
      COUNT(r.rental_id) as num_rentals,
      MAX(rental_date)
    FROM
      rental r
    GROUP BY 1
    HAVING COUNT(r.rental_id) >= 30
  ) AS reward
--   JOIN on customers table for contact info
--   If you join active here, you will exclude 'non-active' users
--   and we want them. Non-actives will be included, but will not
--   have a phone number (NULL) as that info was only included from
--   active table.
  JOIN customer c ON reward.customer_id = c.customer_id
--   Keep all reward user's info but determine which ones are active.
  LEFT JOIN (
    SELECT
      c.customer_id,
      c.email,
      a.phone
    FROM
      customer c
      JOIN address a ON c.address_id = a.address_id
    WHERE c.active = 1
    GROUP BY 1
  ) AS active ON active.customer_id = reward.customer_id
GROUP BY 1
;