SELECT COUNT(*)
FROM public.complaints_2025;



SELECT COUNT(*) AS duplicate_ids
FROM (
    SELECT complaint_id
    FROM public.complaints_2025
    GROUP BY complaint_id
    HAVING COUNT(*) > 1
) d;



SELECT
    COUNT(*) FILTER (WHERE product IS NULL) AS missing_product,
    COUNT(*) FILTER (WHERE issue IS NULL) AS missing_issue,
    COUNT(*) FILTER (WHERE company IS NULL) AS missing_company,
    COUNT(*) FILTER (WHERE state IS NULL) AS missing_state
FROM public.complaints_2025;

ALTER TABLE public.complaints_2025
ADD CONSTRAINT pk_complaints_2025
PRIMARY KEY (complaint_id);

SELECT
    constraint_name,
    constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'complaints_2025'
  AND constraint_type = 'PRIMARY KEY';

select
	date_trunc('month',date_received):: DATE as complaint_month,
	COUNT(*) as total_complaints
from public.complaints_2025
group by 1
order by 1;

SELECT
    date_received,
    DATE_TRUNC('month', date_received) AS month_timestamp,
    DATE_TRUNC('month', date_received)::DATE AS month_date
FROM public.complaints_2025
LIMIT 10;


with monthly_complaints as(
	select
		date_trunc('month', date_received):: date as complaint_month,
		count(*) as total_complaints
	from public.complaints_2025
	group by 1
	
)

select complaint_month, total_complaints,
lag(total_complaints) over (
	order by complaint_month) as previous_month_complaints
	
from monthly_complaints
order by complaint_month;





























