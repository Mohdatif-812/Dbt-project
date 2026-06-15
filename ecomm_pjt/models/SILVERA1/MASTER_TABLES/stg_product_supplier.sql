{{ config(materialized='view') }}

select
    product_id,
    vendor_id,
    lead_time_days,
    standard_cost,
    is_preferred,
    effective_date

from {{ source('bronze','product_supplier') }}