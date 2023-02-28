with fact as(
    select
    o.order_id, 
    da.sk_date as sk_order_date,
    da2.sk_date as sk_shipped_date,
    dc.sk_customer,
    geo.sk_geography,
    emp.sk_employee,
    CASE
    WHEN now()::date < sh.ship_date and now()::date > o.order_date THEN 'Ordered'
    WHEN now()::date > sh.ship_date THEN 'Shipped'
    END AS order_status,
    CASE
    WHEN now()::date < sh.ship_date and now()::date > o.order_date THEN sh.ship_date - now()::date
    ELSE '0'
    END AS time_to_ship_days,
    shmo.ship_mode
    
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
join {{ source("norm", "t_ship_mode") }} shmo on shmo.ship_mode_id = sh.ship_mode_id
),
order_line as (
    select o.order_id, count(ol.order_id) as nr_of_order_lines, sum(ol.quantity) as quantity, sum(ol.sales) as sales, sum(ol.profit) as profit
    from {{ source("norm", "t_order") }} o
    join {{ source("norm", "t_order_line") }} ol on ol.order_id = o.order_id
    group by o.order_id
),
factual as(
    select f.*, ol.nr_of_order_lines, ol.quantity, ol.sales, ol.profit
    from fact f
    join order_line ol on ol.order_id = f.order_id
)
select *, now() as created_at
from factual
