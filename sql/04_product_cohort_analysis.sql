/*
Analysis: Credit Reporting vs Other Products
Purpose: Compare monthly complaint trends across
the dominant credit reporting category and all
remaining financial products.
*/

WITH monthly_cohorts AS (
    SELECT
        DATE_TRUNC('month', date_received)::DATE AS complaint_month,

        CASE
            WHEN product = 'Credit reporting or other personal consumer reports'
            THEN 'Credit Reporting'
            ELSE 'Other Products'
        END AS product_cohort,

        COUNT(*) AS complaint_count

    FROM public.complaints_2025
    GROUP BY 1, 2
),

cohort_growth AS (
    SELECT
        complaint_month,
        product_cohort,
        complaint_count,

        LAG(complaint_count) OVER (
            PARTITION BY product_cohort
            ORDER BY complaint_month
        ) AS previous_month_count

    FROM monthly_cohorts
)

SELECT
    complaint_month,
    product_cohort,
    complaint_count,
    previous_month_count,

    complaint_count - previous_month_count AS complaint_difference,

    ROUND(
        (complaint_count - previous_month_count) * 100.0
        / NULLIF(previous_month_count, 0),
        2
    ) AS mom_growth_percentage

FROM cohort_growth
ORDER BY product_cohort, complaint_month;




SELECT
    product,

    COUNT(*) FILTER (
        WHERE EXTRACT(MONTH FROM date_received) = 1
    ) AS january_complaints,

    COUNT(*) FILTER (
        WHERE EXTRACT(MONTH FROM date_received) = 2
    ) AS february_complaints,

    COUNT(*) FILTER (
        WHERE EXTRACT(MONTH FROM date_received) = 1
    ) -
    COUNT(*) FILTER (
        WHERE EXTRACT(MONTH FROM date_received) = 2
    ) AS complaint_difference

FROM public.complaints_2025

GROUP BY product

ORDER BY complaint_difference DESC;



/*
Analysis: January vs February issue-level comparison
Purpose: Identify which complaint issues contributed
to the decline in money transfer and checking/savings.
*/

SELECT
    product,
    issue,

    COUNT(*) FILTER (
        WHERE EXTRACT(MONTH FROM date_received) = 1
    ) AS january_complaints,

    COUNT(*) FILTER (
        WHERE EXTRACT(MONTH FROM date_received) = 2
    ) AS february_complaints,

    COUNT(*) FILTER (
        WHERE EXTRACT(MONTH FROM date_received) = 1
    ) -
    COUNT(*) FILTER (
        WHERE EXTRACT(MONTH FROM date_received) = 2
    ) AS complaint_difference

FROM public.complaints_2025

WHERE product IN (
    'Money transfer, virtual currency, or money service',
    'Checking or savings account'
)

GROUP BY product, issue

ORDER BY complaint_difference DESC;