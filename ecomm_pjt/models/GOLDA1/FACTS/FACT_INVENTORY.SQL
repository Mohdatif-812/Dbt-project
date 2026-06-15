{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    d.date_key,
    p.product_key,
    w.warehouse_key,

    i.movement_id,

    i.quantity,
    i.movement_type,

    i.movement_date

FROM {{ ref('stg_inventory_movement') }} i

LEFT JOIN {{ ref('dim_product') }} p
    ON i.product_id = p.product_id

LEFT JOIN {{ ref('dim_warehouse') }} w
    ON i.location_id = w.warehouse_id

LEFT JOIN {{ ref('dim_date') }} d
    ON CAST(i.movement_date AS DATE) = d.full_date