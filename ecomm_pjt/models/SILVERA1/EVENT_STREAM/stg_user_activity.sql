{{ config(materialized='view') }}

select

    activity_id,
    user_id,
    {{ standard_text('action') }} as action,
    details,
    timestamp,
    {{ standard_text('device_type') }} as device_type,
    current_timestamp() as etl_loaded_at

from {{ source('bronze','user_activity') }}

where activity_id is not null