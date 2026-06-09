WITH raw_airports AS (
    SELECT
        *
    FROM
       {{ source('airstats', 'airports') }}
)

SELECT 
    id as airport_id,
    ident as airport_ident, 
    type as airport_type, 
    name as airport_name, 
    latitude_deg as airport_lat ,
    longitude_deg as airport_long,
    continent ,
    iso_country ,
    iso_region 
FROM raw_airports