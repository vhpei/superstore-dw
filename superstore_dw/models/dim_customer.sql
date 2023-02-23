with customers as(
select
    {{dbt_utils.generate_surrogate_key(['c.customer_id'])}} as sk_customer, 
    c.customer_id, 
    c.name as customer_name, 
    s.segment 
from {{ source("norm", "t_customer") }} c
    join {{ source("norm", "t_segment") }} s on c.segment_id = s.segment_id
)
select*, now() as created_at
from customers
