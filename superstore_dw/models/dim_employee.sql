with employee as(
    select
    {{dbt_utils.generate_surrogate_key(['e.employee_id'])}} as sk_employee,
    e.employee_id,
    e.name as employee_name
from {{ source("norm", "t_employee") }} e
)
select *, now() as created_at
from employee