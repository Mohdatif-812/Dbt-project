{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    d.date_key,
    v.vendor_key,
    p.product_key,
    s.store_key,

    po.purchase_order_id,

    poi.quantity,
    poi.unit_price,

    poi.line_total,

    po.status

FROM {{ ref('stg_purchase_order_items') }} poi

INNER JOIN {{ ref('stg_purchase_order') }} po
    ON poi.purchase_order_id = po.purchase_order_id

LEFT JOIN {{ ref('dim_vendor') }} v
    ON po.vendor_id = v.vendor_id

LEFT JOIN {{ ref('dim_store') }} s
    ON po.store_id = s.store_id

LEFT JOIN {{ ref('dim_product') }} p
    ON poi.product_id = p.product_id

LEFT JOIN {{ ref('dim_date') }} d
    ON CAST(po.order_date AS DATE) = d.full_date