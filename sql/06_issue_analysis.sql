/*
Project: Financial Services Complaint Intelligence
File: 06_issue_analysis.sql

Analysis: Most common complaint issues
Purpose: Identify the issues generating the
highest number of complaints in 2025.
*/

SELECT
    issue,
    COUNT(*) AS complaint_count,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS complaint_share_percentage

FROM public.complaints_2025

GROUP BY issue

ORDER BY complaint_count DESC

LIMIT 20;