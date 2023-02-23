{% snapshot sp_fact_order %}

{{
    config(
        target_schema='snapshots',
        unique_key='order_id',
        strategy='check',
        check_cols=['sk_order_date', 'sk_shipped_date', 'sk_customer', 'sk_geography', 'sk_employee', 'order_status', 'ship_mode', 'nr_of_order_lines', 'quantity', 'time_to_ship_days', 'sales', 'profit']
    )
}}

select
    *
from {{ ref('fact_order') }}

{% endsnapshot %}