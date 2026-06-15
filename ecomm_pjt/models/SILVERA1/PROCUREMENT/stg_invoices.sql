{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze','invoices') }}

),

cleaned as (

    select

        invoice_id,

        purchase_order_id,

        invoice_date,

        {{ clean_amount('amount_due') }}
            as amount_due,

        {{ standard_text('status') }}
            as status,

        current_timestamp() as etl_loaded_at

    from source

    where invoice_id is not null

)

select *
from cleaned