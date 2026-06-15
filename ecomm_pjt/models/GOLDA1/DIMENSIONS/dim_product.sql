{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    ROW_NUMBER() OVER(
        ORDER BY PRODUCT_ID
    ) AS PRODUCT_KEY,

    PRODUCT_ID,
    NAME,
    CATEGORY,
    PRICE,
    CREATED_DATE,
    MODIFIED_DATE

FROM {{ ref('stg_products') }}