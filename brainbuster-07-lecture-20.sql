-- MAX function is used to find the highest value for a criteria

-- 1. Get every customer's last rental date
SELECT c.first_name as "First Name", c.last_name as "Last Name", MAX(r.rental_date) as "Last Rental"
FROM customer c, rental r
WHERE c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY 2
;

-- LEFT is used to pull up to X chars from a field

-- 2. Get revenue by each month
SELECT LEFT(p.payment_date, 7) as Month, SUM(p.amount) as "Monthly Total"
FROM payment p
GROUP BY 1
ORDER BY 2 DESC 
;