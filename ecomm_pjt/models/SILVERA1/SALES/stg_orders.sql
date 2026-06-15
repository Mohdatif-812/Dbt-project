{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'orders') }}

),

cleaned as (

    select

        order_id,

        customer_id,

        store_id,

        order_date,

        {{ clean_amount('total_amount') }}
            as total_amount,

        {{ standard_text('status') }}
            as status,

        created_date,

        modified_date,

        current_timestamp() as etl_loaded_at

    from source

    where order_id is not null

)

select *
from cleaned

{{ latest_record(
    'order_id',
    'modified_date'
) }}