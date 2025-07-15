WITH product_totals AS (
    SELECT 
        customer_type,
        product_line,
        SUM(total) AS total_sales
    FROM walmart_sales
    GROUP BY customer_type, product_line
),
ranked_products AS (
    SELECT 
        customer_type,
        product_line,
        total_sales,
        ROW_NUMBER() OVER (PARTITION BY customer_type ORDER BY total_sales DESC) AS row_num
    FROM product_totals
)
SELECT 
    customer_type,
    product_line AS most_preferred_product_line,
    total_sales
FROM ranked_products
WHERE row_num = 1;