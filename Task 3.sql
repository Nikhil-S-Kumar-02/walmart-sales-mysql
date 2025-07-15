WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(total) AS total_spent
    FROM walmart_sales
    GROUP BY customer_id
),
segmented_customers AS (
    SELECT 
        customer_id,
        total_spent,
        NTILE(4) OVER (ORDER BY total_spent DESC) AS spending_quartile
    FROM customer_spending
)
SELECT 
    customer_id,
    total_spent,
    CASE 
        WHEN spending_quartile = 1 THEN 'High'
        WHEN spending_quartile IN (2, 3) THEN 'Medium'
        WHEN spending_quartile = 4 THEN 'Low'
    END AS spending_tier
FROM segmented_customers;
