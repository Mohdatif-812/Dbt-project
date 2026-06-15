{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    d.date_key,
    c.customer_key,
    p.product_key,
    s.store_key,

    o.order_id,
    oi.order_item_id,

    o.order_date,

    oi.quantity,
    oi.price as unit_price,

    oi.subtotal as sales_amount,

    o.status as order_status

FROM {{ ref('stg_order_items') }} oi

INNER JOIN {{ ref('stg_orders') }} o
    ON oi.order_id = o.order_id

LEFT JOIN {{ ref('dim_customer') }} c
    ON o.customer_id = c.customer_id

LEFT JOIN {{ ref('dim_product') }} p
    ON oi.product_id = p.product_id

LEFT JOIN {{ ref('dim_store') }} s
    ON o.store_id = s.store_id

LEFT JOIN {{ ref('dim_date') }} d
    ON CAST(o.order_date AS DATE) = d.full_date