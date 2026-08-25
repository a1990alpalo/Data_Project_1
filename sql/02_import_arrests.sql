SELECT COUNT(*) AS row_count
FROM arrests;

--import the cleaned NYPD arrest dataset.
--This path is specific to my local windows environment 

-- Import the cleaned NYPD arrest dataset using psql.
-- Run from the repository root while connected to nypd_crime_db.
-- This is a psql meta-command and will not run in the VS Code query editor.

\copy arrests FROM 'C:/Users/A1990/Data_Project_1/data/processed/nypd_arrests_clean.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',', NULL '', ENCODING 'UTF8')