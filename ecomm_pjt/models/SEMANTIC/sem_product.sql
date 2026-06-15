{{ config(
    materialized='view',
    schema='SEMANTIC'
) }}

select

    p.product_id,
    p.name,
    p.category,

    sum(f.quantity) as units_sold,

    sum(f.sales_amount) as revenue

from {{ ref('FACT_SALES') }} f

join {{ ref('dim_product') }} p
    on f.product_key = p.product_key

group by
    p.product_id,
    p.name,
    p.category