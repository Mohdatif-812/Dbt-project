{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze','transfer_order_items') }}

),

cleaned as (

    select

        transfer_order_item_id,

        transfer_order_id,

        product_id,

        {{ negative_to_zero('quantity') }}
            as quantity,

        current_timestamp() as etl_loaded_at

    from source

    where transfer_order_item_id is not null

)

select *
from cleaned