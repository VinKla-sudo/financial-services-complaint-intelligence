/*
Project: Financial Services Complaint Intelligence
File: 03_product_analysis.sql

Analysis 1: Product-wise complaint distribution
Purpose: Calculate complaint volumes and percentage
contribution for each financial product.
*/

WITH product_counts AS (
    SELECT
        product,
        COUNT(*) AS complaint_count
    FROM public.complaints_2025
    GROUP BY product
)

SELECT
    product,
    complaint_count,

    ROUND(
        complaint_count * 100.0 /
        SUM(complaint_count) OVER (),
        2
    ) AS complaint_share_percentage

FROM product_counts
ORDER BY complaint_count DESC;