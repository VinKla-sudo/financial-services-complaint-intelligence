/*
Project: Financial Services Complaint Intelligence
File: 07_response_analysis.sql

Analysis: Company response and timeliness
Purpose: Understand response patterns across
the 2025 complaint dataset.
*/

SELECT
    timely_response,
    company_response_to_consumer,
    COUNT(*) AS complaint_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS complaint_share_percentage
FROM public.complaints_2025
GROUP BY
    timely_response,
    company_response_to_consumer
ORDER BY complaint_count DESC;





/*
Analysis: Timely response by product cohort
Purpose: Compare response timeliness between
credit reporting and other financial products.
*/

WITH complaint_cohorts AS (
    SELECT
        CASE
            WHEN product =
                'Credit reporting or other personal consumer reports'
            THEN 'Credit Reporting'
            ELSE 'Other Products'
        END AS product_cohort,
        timely_response
    FROM public.complaints_2025
)

SELECT
    product_cohort,
    timely_response,
    COUNT(*) AS complaint_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (
            PARTITION BY product_cohort
        ),
        2
    ) AS cohort_percentage
FROM complaint_cohorts
GROUP BY
    product_cohort,
    timely_response
ORDER BY
    product_cohort,
    timely_response DESC;




/*
Analysis: Company-level response timeliness
Purpose: Identify companies with the highest
untimely response rates.
*/

SELECT
    company,
    COUNT(*) AS total_complaints,
    COUNT(*) FILTER (
        WHERE timely_response = 'Yes'
    ) AS timely_responses,
    COUNT(*) FILTER (
        WHERE timely_response = 'No'
    ) AS untimely_responses,
    ROUND(
        COUNT(*) FILTER (
            WHERE timely_response = 'No'
        ) * 100.0 / COUNT(*),
        2
    ) AS untimely_response_percentage
FROM public.complaints_2025
GROUP BY company
HAVING COUNT(*) >= 1000
ORDER BY untimely_response_percentage DESC,
         total_complaints DESC
LIMIT 20;





/*
Analysis: Untimely responses by product
Purpose: Identify products contributing the
largest number of untimely responses.
*/

SELECT
    product,
    COUNT(*) AS total_complaints,
    COUNT(*) FILTER (
        WHERE timely_response = 'No'
    ) AS untimely_responses,
    ROUND(
        COUNT(*) FILTER (
            WHERE timely_response = 'No'
        ) * 100.0 / COUNT(*),
        2
    ) AS untimely_response_percentage,
    ROUND(
        COUNT(*) FILTER (
            WHERE timely_response = 'No'
        ) * 100.0 /
        SUM(
            COUNT(*) FILTER (
                WHERE timely_response = 'No'
            )
        ) OVER (),
        2
    ) AS share_of_all_untimely_responses
FROM public.complaints_2025
GROUP BY product
ORDER BY untimely_responses DESC;


/*
Analysis: Response timeliness validation
Purpose: Reconcile total records and response
categories across the dataset.
*/

SELECT
    COUNT(*) AS total_records,

    COUNT(*) FILTER (
        WHERE timely_response = 'Yes'
    ) AS timely_records,

    COUNT(*) FILTER (
        WHERE timely_response = 'No'
    ) AS untimely_records,

    COUNT(*) FILTER (
        WHERE timely_response IS NULL
    ) AS missing_timeliness,

    COUNT(*) FILTER (
        WHERE company_response_to_consumer IS NULL
    ) AS missing_response_type

FROM public.complaints_2025;