{{ config(materialized='view') }}

select

    tracking_id,
    shipment_id,
    {{ standard_text('status') }} as status,
    {{ standard_text('location') }} as location,
    timestamp,
    notes,
    current_timestamp() as etl_loaded_at

from {{ source('bronze','delivery_tracking') }}

where tracking_id is not null