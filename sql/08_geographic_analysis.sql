/*
Project: Financial Services Complaint Intelligence
File: 08_geographic_analysis.sql

Analysis: State-level complaint distribution
Purpose: Identify geographic concentration
of consumer complaints in 2025.
*/

SELECT
    state,
    COUNT(*) AS complaint_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS complaint_share_percentage
FROM public.complaints_2025
WHERE state IS NOT NULL
GROUP BY state
ORDER BY complaint_count DESC;



/*
Analysis: Monthly complaint trends by state
Purpose: Compare monthly complaint patterns
across the five highest-volume states.
*/

SELECT
    DATE_TRUNC('month', date_received)::DATE
        AS complaint_month,
    state,
    COUNT(*) AS complaint_count
FROM public.complaints_2025
WHERE state IN ('FL', 'TX', 'CA', 'GA', 'NY')
GROUP BY
    DATE_TRUNC('month', date_received)::DATE,
    state
ORDER BY
    complaint_month,
    state;




/*
Analysis: Product distribution by state
Purpose: Compare complaint product composition
across the five highest-volume states.
*/

SELECT
    state,
    product,
    COUNT(*) AS complaint_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (
            PARTITION BY state
        ),
        2
    ) AS state_product_share
FROM public.complaints_2025
WHERE state IN ('FL', 'TX', 'CA', 'GA', 'NY')
GROUP BY
    state,
    product
ORDER BY
    state,
    complaint_count DESC;





/*
Analysis: Top complaint issues by state
Purpose: Identify the most common complaint
issues across the five highest-volume states.
*/

WITH state_issue_counts AS (
    SELECT
        state,
        issue,
        COUNT(*) AS complaint_count,
        ROW_NUMBER() OVER (
            PARTITION BY state
            ORDER BY COUNT(*) DESC
        ) AS issue_rank
    FROM public.complaints_2025
    WHERE state IN ('FL', 'TX', 'CA', 'GA', 'NY')
    GROUP BY
        state,
        issue
)

SELECT
    state,
    issue,
    complaint_count,
    issue_rank
FROM state_issue_counts
WHERE issue_rank <= 5
ORDER BY
    state,
    issue_rank;