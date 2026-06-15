{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'shipments') }}

),

cleaned as (

    select

        shipment_id,

        order_id,

        delivery_partner_id,

        {{ standard_text('carrier') }}
            as carrier,

        tracking_number,

        shipped_date,

        estimated_delivery,

        tracking_events_json,

        current_timestamp() as etl_loaded_at

    from source

    where shipment_id is not null

)

select *
from cleaned