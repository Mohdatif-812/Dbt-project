{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'warehouses') }}

),

cleaned as (

    select
        warehouse_id,
        {{ standard_text('warehouse_name') }} as warehouse_name,
        {{ standard_text('city') }} as city,
        {{ standard_text('state') }} as state,
        created_date,
        modified_date,
        current_timestamp() as etl_loaded_at
    from source
    where warehouse_id is not null

)

select *
from cleaned
{{ latest_record('warehouse_id', 'modified_date') }}