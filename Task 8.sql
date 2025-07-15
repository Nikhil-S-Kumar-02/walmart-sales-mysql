WITH customer_dates AS (
    SELECT 
        customer_id,
        p_date,
        LEAD(p_date) OVER (PARTITION BY customer_id ORDER BY p_date) AS next_purchase_date
    FROM walmart_sales
),
repeat_customers AS (
    SELECT 
        customer_id,
        p_date,
        next_purchase_date,
        DATEDIFF(next_purchase_date, p_date) AS days_between
    FROM customer_dates
    WHERE next_purchase_date IS NOT NULL
      AND DATEDIFF(next_purchase_date, p_date) <= 30
)
SELECT DISTINCT customer_id
FROM repeat_customers;
