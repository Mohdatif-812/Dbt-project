{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'vendors') }}

),

cleaned as (

    select
        vendor_id,
        {{ standard_text('vendor_name') }} as vendor_name,
        {{ clean_email('contact_email') }} as contact_email,
        {{ clean_phone('phone') }} as phone,
        {{ clean_address('address') }} as address,
        created_date,
        modified_date,
        current_timestamp() as etl_loaded_at
    from source
    where vendor_id is not null

)

select *
from cleaned
{{ latest_record('vendor_id', 'modified_date') }}