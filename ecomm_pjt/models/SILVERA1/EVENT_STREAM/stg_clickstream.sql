{{ config(materialized='view') }}

select

    event_id,
    user_id,
    session_id,
    page_url,
    {{ standard_text('event_type') }} as event_type,
    timestamp,
    user_agent,
    ip_address,
    referrer,
    current_timestamp() as etl_loaded_at

from {{ source('bronze','clickstream') }}

where event_id is not null