{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze','inventory_movements') }}

),

cleaned as (

    select

        movement_id,

        product_id,

        location_id,

        movement_date,

        {{ negative_to_zero('quantity') }}
            as quantity,

        {{ standard_text('movement_type') }}
            as movement_type,

        reference_id,

        notes,

        current_timestamp() as etl_loaded_at

    from source

    where movement_id is not null

)

select *
from cleaned