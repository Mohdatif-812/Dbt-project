{{ config(materialized='view') }}

select

    event_id,
    payment_id,
    {{ standard_text('event_type') }} as event_type,
    {{ clean_amount('amount') }} as amount,
    timestamp,
    gateway_response_json,
    current_timestamp() as etl_loaded_at

from {{ source('bronze','payment_events') }}

where event_id is not null