/*
Project: Financial Services Complaint Intelligence
File: 05_company_analysis.sql

Analysis: Company-level complaint distribution
Purpose: Identify companies with the highest
number of submitted complaints in 2025.
*/

WITH company_complaints AS (
    SELECT
        company,
        COUNT(*) AS complaint_count
    FROM public.complaints_2025
    GROUP BY company
)

SELECT
    company,
    complaint_count,

    ROUND(
        complaint_count * 100.0 /
        SUM(complaint_count) OVER (),
        2
    ) AS complaint_share_percentage,

    RANK() OVER (
        ORDER BY complaint_count DESC
    ) AS company_rank

FROM company_complaints

ORDER BY complaint_count DESC
LIMIT 20;



/*
Analysis: Company concentration by product cohort
Purpose: Identify the top 10 companies separately
for credit reporting and other financial products.
*/

WITH company_cohorts AS (

    SELECT
        CASE
            WHEN product = 'Credit reporting or other personal consumer reports'
            THEN 'Credit Reporting'
            ELSE 'Other Products'
        END AS product_cohort,

        company,
        COUNT(*) AS complaint_count

    FROM public.complaints_2025

    GROUP BY 1, 2
),

company_rankings AS (

    SELECT
        product_cohort,
        company,
        complaint_count,

        ROUND(
            complaint_count * 100.0 /
            SUM(complaint_count) OVER (
                PARTITION BY product_cohort
            ),
            2
        ) AS cohort_share_percentage,

        RANK() OVER (
            PARTITION BY product_cohort
            ORDER BY complaint_count DESC
        ) AS company_rank

    FROM company_cohorts
)

SELECT *
FROM company_rankings
WHERE company_rank <= 10
ORDER BY product_cohort, company_rank;