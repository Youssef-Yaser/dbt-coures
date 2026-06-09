{{ config(
    materialized = 'incremental',
    unique_key = 'comment_id'
    )
}}

WITH silver_airport_comments AS (
    SELECT * FROM  {{ ref('scr_airport_comments') }} 
) 

select 
    comment_id,
    airport_id, 
    airport_ident  , 
    comment_timestamp ,
    COALESCE(member_nickname, '__UNKNOWN__') AS member_nickname ,
    comment_subject ,
    comment_body
FROM silver_airport_comments
WHERE comment_body IS NOT NULL AND comment_body != ''

{%if is_incremental() %}
AND comment_id > (SELECT MAX(comment_id) FROM {{ this }})
{% endif %}