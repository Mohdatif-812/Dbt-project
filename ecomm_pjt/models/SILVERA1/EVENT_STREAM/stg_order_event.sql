{{ config(materialized='view') }}

select

    event_id,
    order_id,
    {{ standard_text('old_status') }} as old_status,
    {{ standard_text('new_status') }} as new_status,
    timestamp,
    source,
    current_timestamp() as etl_loaded_at

from {{ source('bronze','order_events') }}

where event_id is not null