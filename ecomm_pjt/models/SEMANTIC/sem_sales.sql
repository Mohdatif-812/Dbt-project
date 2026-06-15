{{ config(
    materialized='view',
    schema='SEMANTIC'
) }}

select

    f.order_id,

    d.full_date,

    c.customer_id,
    c.first_name,
    c.last_name,

    p.product_id,
    p.name as product_name,
    p.category,

    s.store_name,

    f.quantity,
    f.sales_amount,

    (f.quantity * f.sales_amount) as revenue

from {{ ref('FACT_SALES') }} f

left join {{ ref('dim_customer') }} c
    on f.customer_key = c.customer_key

left join {{ ref('dim_product') }} p
    on f.product_key = p.product_key

left join {{ ref('dim_store') }} s
    on f.store_key = s.store_key

left join {{ ref('dim_date') }} d
    on f.date_key = d.date_key