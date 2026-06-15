{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze','purchase_orders') }}

),

cleaned as (

    select

        purchase_order_id,

        vendor_id,

        store_id,

        order_date,

        expected_delivery,

        {{ clean_amount('total_amount') }}
            as total_amount,

        {{ standard_text('status') }}
            as status,

        current_timestamp() as etl_loaded_at

    from source

    where purchase_order_id is not null

)

select *
from cleaned