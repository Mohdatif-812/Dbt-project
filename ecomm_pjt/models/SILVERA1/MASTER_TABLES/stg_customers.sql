{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'customers') }}

),

cleaned as (

    select
        customer_id,
        {{ standard_text('first_name') }} as first_name,
        {{ standard_text('last_name') }} as last_name,
        {{ clean_email('email') }} as email,
        {{ clean_phone('phone') }} as phone,
        {{ clean_address('address') }} as address,
        created_date,
        modified_date,
        is_active,
        record_type,
        current_timestamp() as etl_loaded_at
    from source
    where customer_id is not null

)

select *
from cleaned
{{ latest_record('customer_id', 'modified_date') }}