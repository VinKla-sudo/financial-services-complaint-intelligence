WITH monthly_complaints AS (
    SELECT
        DATE_TRUNC('month', date_received)::DATE AS complaint_month,
        COUNT(*) AS total_complaints
    FROM public.complaints_2025
    GROUP BY 1
)

SELECT
    complaint_month,
    total_complaints,

    LAG(total_complaints) OVER (
        ORDER BY complaint_month
    ) AS previous_month_complaints,

    total_complaints -
    LAG(total_complaints) OVER (
        ORDER BY complaint_month
    ) AS complaint_difference,

    ROUND(
        (
            total_complaints - LAG(total_complaints) OVER (
                ORDER BY complaint_month
            )
        ) * 100.0 /
        NULLIF(
            LAG(total_complaints) OVER (
                ORDER BY complaint_month
            ), 0
        ), 2
    ) AS mom_growth_percentage

FROM monthly_complaints
ORDER BY complaint_month;