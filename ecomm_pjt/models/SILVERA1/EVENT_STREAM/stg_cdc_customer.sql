{{ config(materialized='view') }}

select

    cdc_event_id,
    {{ standard_text('entity') }} as entity,
    entity_id,
    {{ standard_text('change_type') }} as change_type,
    timestamp,
    payload_json,
    current_timestamp() as etl_loaded_at

from {{ source('bronze','cdc_customer') }}

where cdc_event_id is not null