with geography as(
select
    {{dbt_utils.generate_surrogate_key(['c.city','s.state','r.region'])}} as sk_geography,
    c.city, 
    s.state, 
    r.region, 
    cc.country
from {{ source("norm", "t_city") }} c 
join {{ source("norm", "t_state") }} s on c.state_id = s.state_id
join {{ source("norm", "t_region") }} r on c.region_id = r.region_id
join {{ source("norm", "t_country") }} cc on c.country_id = cc.country_id
)
select*, now() as created_at
from geography