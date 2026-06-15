{{ config(
    materialized='table',
    schema='GOLDA1'
) }}

SELECT

    ROW_NUMBER() OVER(
        ORDER BY WAREHOUSE_ID
    ) AS WAREHOUSE_KEY,

    WAREHOUSE_ID,
    WAREHOUSE_NAME,
    CITY,
    STATE,
    CREATED_DATE,
    MODIFIED_DATE

FROM {{ ref('stg_warehouses') }}