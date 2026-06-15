{{ config(materialized='view') }}

with source as (

    select *
    from {{ source('bronze','vendor_scorecard') }}

),

cleaned as (

    select

        vendor_id,

        scorecard_month,

        on_time_delivery_rate,

        defect_rate,

        avg_lead_time_days,

        {{ clean_amount('total_spend') }}
            as total_spend,

        rating,

        current_timestamp() as etl_loaded_at

    from source

    where vendor_id is not null

)

select *
from cleaned