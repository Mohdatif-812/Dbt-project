{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'returns') }}

),

cleaned as (

    select

        return_id,

        order_id,

        {{ standard_text('return_reason') }}
            as return_reason,

        return_date,

        {{ standard_text('status') }}
            as status,

        return_items_json,

        current_timestamp() as etl_loaded_at

    from source

    where return_id is not null

)

select *
from cleaned