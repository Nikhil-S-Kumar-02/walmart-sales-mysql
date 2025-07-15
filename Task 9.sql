SELECT 
    customer_id,
    SUM(total) AS total_spent
FROM walmart_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;