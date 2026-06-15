{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'products') }}

),

cleaned as (

    select
        product_id,
        {{ standard_text('name') }} as name,
        {{ standard_text('category') }} as category,
        {{ clean_amount('price') }} as price,
        created_date,
        modified_date,
        record_type,
        current_timestamp() as etl_loaded_at
    from source
    where product_id is not null

)

select *
from cleaned
{{ latest_record('product_id', 'modified_date') }}