WITH raw_credits AS (
    SELECT * FROM {{ source('netflix', 'credits') }}
)

SELECT
    person_id,
    id AS production_id,
    name AS person_name,
    character AS person_character,
    role AS person_role
FROM
    raw_credits