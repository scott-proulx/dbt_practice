{{
    config(
        materialized = 'view'
        )
}}

WITH src_titles AS (
    SELECT * FROM {{ref('src_titles')}}
)

SELECT
    production_id,
    TRIM(production_title) AS production_title,
    production_type,
    release_year,
    NVL(age_certification, 'Not Rated') AS age_certification,
    runtime,
    CASE
        WHEN genres LIKE '%,%' THEN SUBSTRING(TRIM(SUBSTRING(TRIM(TRIM(genres, '[')), 1, CHARINDEX(',', TRIM(TRIM(genres, '[')))),','), 2, LEN(TRIM(SUBSTRING(TRIM(TRIM(genres, '[')), 1, CHARINDEX(',', TRIM(TRIM(genres, '[')))),',')) - 2)
        WHEN LEN(genres) <= 2 THEN 'N/A'
        ELSE SUBSTRING(TRIM(TRIM(TRIM(genres, ']'), '[')), 2, LEN(TRIM(TRIM(TRIM(genres, ']'), '['))) - 2)
    END AS main_genre,
    CASE
        WHEN production_countries LIKE '%,%' THEN SUBSTRING(TRIM(SUBSTRING(TRIM(TRIM(production_countries, '[')), 1, CHARINDEX(',', TRIM(TRIM(production_countries, '[')))),','), 2, LEN(TRIM(SUBSTRING(TRIM(TRIM(production_countries, '[')), 1, CHARINDEX(',', TRIM(TRIM(production_countries, '[')))),',')) - 2)
        WHEN LEN(production_countries) <= 2 THEN 'N/A'
        WHEN production_countries LIKE '%Lebanon%' THEN 'LB'
        ELSE SUBSTRING(TRIM(TRIM(TRIM(production_countries, ']'), '[')), 2, LEN(TRIM(TRIM(TRIM(production_countries, ']'), '['))) - 2)
    END AS main_country,
    NVL(number_of_seasons, 0) AS number_of_seasons,
    imdb_id,
    imdb_score,
    imdb_votes
FROM src_titles
WHERE imdb_id IS NOT NULL
AND imdb_score IS NOT NULL
AND imdb_votes IS NOT NULL