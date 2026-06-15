{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    d.date_key,
    s.store_key,
    dp.partner_key,

    sh.shipment_id,
    sh.order_id,

    sh.carrier,
    sh.tracking_number,

    sh.shipped_date,
    sh.estimated_delivery

FROM {{ ref('stg_shipment') }} sh

LEFT JOIN {{ ref('stg_orders') }} o
    ON sh.order_id = o.order_id

LEFT JOIN {{ ref('dim_store') }} s
    ON o.store_id = s.store_id

LEFT JOIN {{ ref('dim_delivery_partner') }} dp
    ON sh.delivery_partner_id = dp.partner_id

LEFT JOIN {{ ref('dim_date') }} d
    ON CAST(sh.shipped_date AS DATE) = d.full_date