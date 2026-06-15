{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    ROW_NUMBER() OVER(
        ORDER BY STORE_ID
    ) AS STORE_KEY,

    STORE_ID,
    STORE_NAME,
    CITY,
    STATE,
    CREATED_DATE,
    MODIFIED_DATE

FROM {{ ref('stg_stores') }}