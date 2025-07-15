SELECT 
    DAYNAME(p_date) AS day_of_week,
    SUM(total) AS total_sales
FROM walmart_sales
GROUP BY day_of_week
ORDER BY total_sales DESC;