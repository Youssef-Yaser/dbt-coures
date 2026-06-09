SELECT
*
FROM {{ ref('scd_silver_airports') }}
WHERE AIRPORT_IDENT = '01CN'
ORDER BY dbt_valid_from