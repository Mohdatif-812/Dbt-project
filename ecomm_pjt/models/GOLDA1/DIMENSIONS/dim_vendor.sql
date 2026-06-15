{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    ROW_NUMBER() OVER(
        ORDER BY VENDOR_ID
    ) AS VENDOR_KEY,

    VENDOR_ID,
    VENDOR_NAME,
    CONTACT_EMAIL,
    PHONE,
    ADDRESS,
    CREATED_DATE,
    MODIFIED_DATE

FROM {{ ref('stg_vendors') }}