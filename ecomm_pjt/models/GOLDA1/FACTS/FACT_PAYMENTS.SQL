{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    p.payment_id,

    p.order_id,

    o.customer_id,

    c.customer_key,

    p.amount,

    p.method,

    p.status,

    p.payment_date

FROM {{ ref('stg_payments') }} p

LEFT JOIN {{ ref('stg_orders') }} o
    ON p.order_id = o.order_id

LEFT JOIN {{ ref('dim_customer') }} c
    ON o.customer_id = c.customer_id