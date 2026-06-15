{{ config(
    materialized='view',
    schema='SEMANTIC'
) }}

select

    v.vendor_id,
    v.vendor_name,

    count(distinct f.purchase_order_id) as total_purchase_orders,

    sum(f.line_total) as total_spend,

    avg(f.line_total) as avg_purchase_amount

from {{ ref('FACT_PROCUREMENT') }} f

left join {{ ref('DIM_VENDOR') }} v
    on f.vendor_key = v.vendor_key

group by

    v.vendor_id,
    v.vendor_name