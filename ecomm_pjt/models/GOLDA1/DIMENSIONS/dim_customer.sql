{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    ROW_NUMBER() OVER(
        ORDER BY CUSTOMER_ID
    ) AS CUSTOMER_KEY,

    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE,
    ADDRESS,
    IS_ACTIVE,
    CREATED_DATE,
    MODIFIED_DATE

FROM {{ ref('stg_customers') }}