{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    ROW_NUMBER() OVER(
        ORDER BY PARTNER_ID
    ) AS PARTNER_KEY,

    PARTNER_ID,
    PARTNER_NAME,
    API_ENDPOINT,
    CREATED_DATE,
    MODIFIED_DATE

FROM {{ ref('stg_delivery_partners') }}