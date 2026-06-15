{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'delivery_partners') }}

),

cleaned as (

    select
        partner_id,
        {{ standard_text('partner_name') }} as partner_name,
        {{ standard_text('api_endpoint') }} as api_endpoint,
        created_date,
        modified_date,
        current_timestamp() as etl_loaded_at
    from source
    where partner_id is not null

)

select *
from cleaned
{{ latest_record('partner_id', 'modified_date') }}