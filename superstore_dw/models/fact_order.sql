with fact as(
    select
    o.order_id, 
    da.sk_date as sk_order_date,
    da2.sk_date as sk_shipped_date,
    dc.sk_customer,
    geo.sk_geography,
    emp.sk_employee
    
from {{ source("norm", "t_order") }} o
join {{ source("dw", "dim_date") }} da on da.date = o.order_date
join {{ source("dw", "dim_customer") }} dc on dc.customer_id = o.customer_id
join {{ source("norm", "t_shipment") }} sh on sh.order_id = o.order_id
join {{ source("dw", "dim_date") }} da2 on da2.date = sh.ship_date
join {{ source("norm", "t_city") }} ci on ci.city_id = sh.city_id
join {{ source("norm", "t_state") }} s on s.state_id = ci.state_id
join {{ source("norm", "t_region") }} r on ci.region_id = r.region_id
join {{ source("norm", "t_country") }} cc on ci.country_id = cc.country_id
join {{ source("dw", "dim_geography") }} geo on geo.city = ci.city and geo.state = s.state and geo.region = r.region and geo.country = cc.country
join {{ source("norm", "t_employee") }} em on r.region_id = em.region_id
join {{ source("dw", "dim_employee") }} emp on emp.employee_id = em.employee_id
)
select *, now() as created_at
from fact