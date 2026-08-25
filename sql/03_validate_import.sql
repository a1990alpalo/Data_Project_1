-- Validate the NYPD arrest-data import.

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT arrest_key) AS unique_arrest_keys,
    MIN(arrest_date) AS earliest_date,
    MAX(arrest_date) AS latest_date
FROM arrests;


SELECT
    COUNT(*) FILTER (
        WHERE pd_code IS NULL
    ) AS pd_code_nulls,

    COUNT(*) FILTER (
        WHERE pd_description IS NULL
    ) AS pd_description_nulls,

    COUNT(*) FILTER (
        WHERE key_code IS NULL
    ) AS key_code_nulls,

    COUNT(*) FILTER (
        WHERE law_code IS NULL
    ) AS law_code_nulls,

    COUNT(*) FILTER (
        WHERE latitude IS NULL
    ) AS latitude_nulls,

    COUNT(*) FILTER (
        WHERE longitude IS NULL
    ) AS longitude_nulls
FROM arrests;