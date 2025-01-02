{{
	config(
		materialized = 'view'
		)
}}

WITH src_credits AS (
    SELECT * FROM {{ref('src_credits')}}
)

SELECT
    person_id,
    production_id,
    TRIM(person_name) AS person_name,
    TRIM(NVL(person_character,'N/A')) AS person_character,
    person_role
FROM src_credits