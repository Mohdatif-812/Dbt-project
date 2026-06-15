{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze', 'payments') }}

),

cleaned as (

    select

        payment_id,

        order_id,

        {{ clean_amount('amount') }}
            as amount,

        {{ standard_text('method') }}
            as method,

        {{ standard_text('status') }}
            as status,

        billing_address_line,

        {{ standard_text('billing_city') }}
            as billing_city,

        {{ standard_text('billing_state') }}
            as billing_state,

        billing_zip,

        {{ standard_text('billing_country') }}
            as billing_country,

        payment_date,

        current_timestamp() as etl_loaded_at

    from source

    where payment_id is not null

)

select *
from cleaned