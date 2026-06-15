{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze','purchase_order_items') }}

),

cleaned as (

    select

        purchase_order_item_id,

        purchase_order_id,

        product_id,

        {{ negative_to_zero('quantity') }}
            as quantity,

        {{ clean_amount('unit_price') }}
            as unit_price,

        {{ clean_amount('line_total') }}
            as line_total,

        current_timestamp() as etl_loaded_at

    from source

    where purchase_order_item_id is not null

)

select *
from cleaned