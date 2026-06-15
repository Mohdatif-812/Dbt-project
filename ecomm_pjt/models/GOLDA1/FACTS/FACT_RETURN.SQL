{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    d.date_key,
    c.customer_key,

    r.return_id,
    r.order_id,

    r.return_reason,
    r.status as return_status,

    r.return_date

FROM {{ ref('stg_returns') }} r

LEFT JOIN {{ ref('stg_orders') }} o
    ON r.order_id = o.order_id

LEFT JOIN {{ ref('dim_customer') }} c
    ON o.customer_id = c.customer_id

LEFT JOIN {{ ref('dim_date') }} d
    ON CAST(r.return_date AS DATE) = d.full_date