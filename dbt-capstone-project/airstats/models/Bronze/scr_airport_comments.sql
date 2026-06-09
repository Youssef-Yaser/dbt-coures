WITH raw_airport_comments AS (
    SELECT
        *
    FROM
       {{ source('airstats', 'airport_comments') }}
)

SELECT 
    id as comment_id,
    airport_ref as airport_id, 
    airport_ident  , 
    date as comment_timestamp ,
    member_nickname ,
    subject as comment_subject ,
    body as comment_body
FROM raw_airport_comments