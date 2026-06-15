{{ config(
    materialized='view',
    schema='SEMANTIC'
) }}

select

    c.customer_id,
    c.first_name,
    c.last_name,

    count(distinct f.order_id) as total_orders,

    sum(f.sales_amount) as total_sales,

    avg(f.sales_amount) as avg_order_value

from {{ ref('FACT_SALES') }} f

join {{ ref('dim_customer') }} c
    on f.customer_key = c.customer_key

group by
    c.customer_id,
    c.first_name,
    c.last_name