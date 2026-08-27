-- Explore the cleaned NYPD arrest dataset.
-- Run while connected to the nypd_crime_db database.


-- 1. Preview the first 10 arrest records.
SELECT *
FROM arrests
LIMIT 10;


-- 2. Count arrests by borough.
SELECT
    borough,
    COUNT(*) AS total_arrests
FROM arrests
GROUP BY borough
ORDER BY total_arrests DESC;


-- 3. Count arrests by offense level.
SELECT
    offense_level,
    COUNT(*) AS total_arrests
FROM arrests
GROUP BY offense_level
ORDER BY total_arrests DESC;


-- 4. Find the 10 most common offenses.
SELECT
    offense_type,
    COUNT(*) AS total_arrests
FROM arrests
GROUP BY offense_type
ORDER BY total_arrests DESC
LIMIT 10;


-- 5. Count arrests by age group.
SELECT
    age_group,
    COUNT(*) AS total_arrests
FROM arrests
GROUP BY age_group
ORDER BY total_arrests DESC;


-- 6. Count arrests by gender.
SELECT
    gender,
    COUNT(*) AS total_arrests
FROM arrests
GROUP BY gender
ORDER BY total_arrests DESC;


-- 7. Count arrests by race.
SELECT
    race,
    COUNT(*) AS total_arrests
FROM arrests
GROUP BY race
ORDER BY total_arrests DESC;


-- 8. Count arrests by month.
SELECT
    DATE_TRUNC('month', arrest_date)::DATE AS arrest_month,
    COUNT(*) AS total_arrests
FROM arrests
GROUP BY arrest_month
ORDER BY arrest_month;


-- 9. Find the 10 precincts with the most arrests.
SELECT
    arrest_precinct,
    COUNT(*) AS total_arrests
FROM arrests
GROUP BY arrest_precinct
ORDER BY total_arrests DESC
LIMIT 10;


-- 10. Find the most common offenses within each borough.
WITH borough_offense_counts AS (
    SELECT
        borough,
        offense_type,
        COUNT(*) AS total_arrests
    FROM arrests
    GROUP BY borough, offense_type
),
ranked_offenses AS (
    SELECT
        borough,
        offense_type,
        total_arrests,
        ROW_NUMBER() OVER (
            PARTITION BY borough
            ORDER BY total_arrests DESC
        ) AS offense_rank
    FROM borough_offense_counts
)
SELECT
    borough,
    offense_type,
    total_arrests
FROM ranked_offenses
WHERE offense_rank = 1
ORDER BY borough;

SELECT
    COUNT(*) AS number_of_tables
FROM information_schema.tables
WHERE table_schema = 'public';

-- 11. Find the five most common offenses within each age group.
WITH age_offense_counts AS (
    SELECT
        age_group,
        offense_type,
        COUNT(*) AS total_arrests
    FROM arrests
    GROUP BY age_group, offense_type
),
ranked_age_offenses AS (
    SELECT
        age_group,
        offense_type,
        total_arrests,
        ROW_NUMBER() OVER (
            PARTITION BY age_group
            ORDER BY total_arrests DESC, offense_type
        ) AS offense_rank
    FROM age_offense_counts
)
SELECT
    age_group,
    offense_type,
    total_arrests,
    offense_rank
FROM ranked_age_offenses
WHERE offense_rank <= 5
ORDER BY
    CASE age_group
        WHEN '<18' THEN 1
        WHEN '18-24' THEN 2
        WHEN '25-44' THEN 3
        WHEN '45-64' THEN 4
        WHEN '65+' THEN 5
        ELSE 6
    END,
    offense_rank;