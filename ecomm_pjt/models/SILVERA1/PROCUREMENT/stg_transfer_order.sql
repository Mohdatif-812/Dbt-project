{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze','transfer_orders') }}

),

cleaned as (

    select

        transfer_order_id,

        from_location_id,

        to_location_id,

        transfer_date,

        {{ standard_text('status') }}
            as status,

        current_timestamp() as etl_loaded_at

    from source

    where transfer_order_id is not null

)

select *
from cleaned