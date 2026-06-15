{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze','receipts') }}

),

cleaned as (

    select

        receipt_id,

        purchase_order_id,

        warehouse_id,

        receipt_date,

        {{ negative_to_zero('quantity_received') }}
            as quantity_received,

        {{ standard_text('quality_status') }}
            as quality_status,

        current_timestamp() as etl_loaded_at

    from source

    where receipt_id is not null

)

select *
from cleaned