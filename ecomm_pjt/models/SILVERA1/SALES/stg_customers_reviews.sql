{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'customer_reviews') }}

),

cleaned as (

    select

        review_id,

        customer_id,

        product_id,

        order_id,

        rating,

        {{ standard_text('title') }}
            as title,

        comment,

        review_date,

        current_timestamp() as etl_loaded_at

    from source

    where review_id is not null

)

select *
from cleaned