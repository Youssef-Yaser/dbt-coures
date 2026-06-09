WITH silver_airports AS (
    SELECT * FROM  {{ ref('scr_airports') }} AS a
)


SELECT * FROM silver_airports