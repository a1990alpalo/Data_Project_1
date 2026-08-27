-- Prepare geographically valid NYPD arrest records for mapping.
-- Run the SELECT queries while connected to nypd_crime_db.


-- 1. Count records containing valid NYC coordinates.
SELECT
    COUNT(*) AS valid_map_records
FROM arrests
WHERE latitude BETWEEN 40.45 AND 41.00
  AND longitude BETWEEN -74.30 AND -73.65;


-- 2. Preview geographically valid arrest records.
SELECT
    arrest_key,
    arrest_date,
    borough,
    offense_type,
    offense_level,
    age_group,
    gender,
    race,
    latitude,
    longitude
FROM arrests
WHERE latitude BETWEEN 40.45 AND 41.00
  AND longitude BETWEEN -74.30 AND -73.65
ORDER BY arrest_date, arrest_key
LIMIT 10;


-- 3. Count geographically valid arrests by borough.
SELECT
    borough,
    COUNT(*) AS total_arrests
FROM arrests
WHERE latitude BETWEEN 40.45 AND 41.00
  AND longitude BETWEEN -74.30 AND -73.65
GROUP BY borough
ORDER BY total_arrests DESC;


/*
Export the mapping dataset with psql.

Run this command from the repository root while connected to
nypd_crime_db. It will not run in the VS Code query editor.

\copy (SELECT arrest_key, arrest_date, borough, offense_type, offense_level, age_group, gender, race, latitude, longitude FROM arrests WHERE latitude BETWEEN 40.45 AND 41.00 AND longitude BETWEEN -74.30 AND -73.65 ORDER BY arrest_date, arrest_key) TO 'data/processed/nypd_arrests_map.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8')
*/