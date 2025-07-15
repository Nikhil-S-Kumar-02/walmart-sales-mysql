WITH monthly_sales AS (
    SELECT 
        branch,
        DATE_FORMAT(p_date, '%Y-%m') AS sale_month,
        SUM(total) AS monthly_sales
    FROM walmart_sales
    GROUP BY branch, sale_month
),
sales_lagged AS (
    SELECT 
        branch,
        sale_month,
        monthly_sales,
        LAG(monthly_sales) OVER (PARTITION BY branch ORDER BY sale_month) AS prev_month_sales
    FROM monthly_sales
),
growth_rates AS (
    SELECT 
        branch,
        sale_month,
        monthly_sales,
        prev_month_sales,
        ROUND(
            CASE 
                WHEN prev_month_sales IS NOT NULL AND prev_month_sales != 0 THEN
                    ((monthly_sales - prev_month_sales) / prev_month_sales) * 100
                ELSE NULL
            END,
            2
        ) AS growth_rate
    FROM sales_lagged
)
SELECT 
    branch,
    AVG(growth_rate) AS avg_growth_rate
FROM growth_rates
GROUP BY branch
ORDER BY avg_growth_rate DESC
LIMIT 1;
