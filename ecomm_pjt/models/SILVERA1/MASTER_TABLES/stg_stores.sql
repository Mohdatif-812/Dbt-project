{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'stores') }}

),

cleaned as (

    select
        store_id,
        {{ standard_text('store_name') }} as store_name,
        {{ standard_text('city') }} as city,
        {{ standard_text('state') }} as state,
        created_date,
        modified_date,
        current_timestamp() as etl_loaded_at
    from source
    where store_id is not null

)

select *
from cleaned
{{ latest_record('store_id', 'modified_date') }}