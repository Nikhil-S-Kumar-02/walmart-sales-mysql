WITH product_profits AS (
    SELECT
        branch,
        product_line,
        SUM(gross_income) AS total_profit
    FROM walmart_sales
    GROUP BY branch, product_line
),
ranked_profits AS (
    SELECT 
        branch,
        product_line,
        total_profit,
        ROW_NUMBER() OVER (PARTITION BY branch ORDER BY total_profit DESC) AS row_num
    FROM product_profits
)
SELECT 
    branch,
    product_line AS most_profitable_product_line,
    total_profit
FROM ranked_profits
WHERE row_num = 1;
