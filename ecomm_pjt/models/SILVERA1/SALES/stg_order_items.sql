{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'order_items') }}

),

cleaned as (

    select

        order_item_id,

        order_id,

        product_id,

        {{ negative_to_zero('quantity') }}
            as quantity,

        {{ clean_amount('price') }}
            as price,

        {{ clean_amount('subtotal') }}
            as subtotal,

        current_timestamp() as etl_loaded_at

    from source

    where order_item_id is not null

)

select *
from cleaned