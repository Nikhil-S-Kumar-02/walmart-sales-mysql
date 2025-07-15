WITH product_line_stats AS (
    SELECT 
        product_line,
        AVG(total) AS avg_total,
        STDDEV(total) AS std_dev_total
    FROM walmart_sales
    GROUP BY product_line
),
anomalies AS (
    SELECT 
        ws.*,
        pls.avg_total,
        pls.std_dev_total
    FROM walmart_sales ws
    JOIN product_line_stats pls
        ON ws.product_line = pls.product_line
    WHERE ws.total > (pls.avg_total + pls.std_dev_total)
       OR ws.total < (pls.avg_total - pls.std_dev_total)
)
SELECT 
    invoice_id,
    product_line,
    total,
    avg_total,
    std_dev_total,
    ROUND(total - avg_total, 2) AS deviation
FROM anomalies
ORDER BY ABS(total - avg_total) DESC;
