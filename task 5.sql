WITH payment_counts AS (
    SELECT 
        city,
        payment,
        COUNT(*) AS payment_count
    FROM walmart_sales
    GROUP BY city, payment
),
ranked_payments AS (
    SELECT 
        city,
        payment,
        payment_count,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY payment_count DESC) AS row_num
    FROM payment_counts
)
SELECT 
    city,
    payment AS most_popular_payment_method,
    payment_count
FROM ranked_payments
WHERE row_num = 1;
