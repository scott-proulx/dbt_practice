WITH raw_titles AS (
    SELECT * FROM {{ source('netflix', 'titles') }}
)

SELECT
    id AS production_id,
    title AS production_title,
    type AS production_type,
    release_year,
    age_certification,
    runtime,
    genres,
    production_countries,
    seasons AS number_of_seasons,
    imdb_id,
    imdb_score,
    imdb_votes
FROM
    raw_titles