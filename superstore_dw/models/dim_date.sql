WITH Dates AS (
SELECT date_trunc('day', d):: date as date
FROM generate_series( 
    '2017-01-01'::timestamp, 
    '2023-04-30'::timestamp,
    '1 day'::interval) d
) 
select
    {{dbt_utils.generate_surrogate_key(['date'])}} as sk_date,
    date,
    DATE_PART('day', date) as "day",
    DATE_PART('month', date) as "month",
    DATE_PART('year', date) as "year",
    TO_CHAR(date, 'Month') AS "month_name",
    TO_CHAR(date, 'Mon') AS "month_name_short",
    EXTRACT('week' from date) as "week_number",
    EXTRACT('dow' from date) as "day_of_week",
    TO_CHAR(date, 'Day') AS "day_of_week_name",
    EXTRACT(QUARTER from date) as "quarter",
    EXTRACT('dow' FROM date) IN (6,0) as "is_weekend"
from Dates