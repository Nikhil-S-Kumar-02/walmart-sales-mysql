SELECT 
    DATE_FORMAT(p_date, '%Y-%m') AS sale_month,
    gender,
    SUM(total) AS total_sales
FROM walmart_sales
GROUP BY sale_month, gender
ORDER BY sale_month, gender;