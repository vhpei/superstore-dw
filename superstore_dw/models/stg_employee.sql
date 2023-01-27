select
    e.employee_id,
    e.name as employee_name,
    r.region
from {{ source("norm", "t_employee") }} e
    join {{ source("norm", "t_region") }} r on e.region_id = r.region_id
