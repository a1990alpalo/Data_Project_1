-- Create indexes for commonly searched and grouped columns.
-- Run while connected to the nypd_crime_db database.
--
-- PostgreSQL already created an index for arrest_key because it is
-- the table's primary key.


-- Speed up searches and summaries by arrest date.
CREATE INDEX IF NOT EXISTS idx_arrests_arrest_date
ON arrests (arrest_date);


-- Speed up searches and summaries by borough.
CREATE INDEX IF NOT EXISTS idx_arrests_borough
ON arrests (borough);


-- Speed up searches involving offense type.
CREATE INDEX IF NOT EXISTS idx_arrests_offense_type
ON arrests (offense_type);


-- Speed up searches involving offense level.
CREATE INDEX IF NOT EXISTS idx_arrests_offense_level
ON arrests (offense_level);


-- Speed up geographical queries using latitude and longitude.
CREATE INDEX IF NOT EXISTS idx_arrests_coordinates
ON arrests (latitude, longitude);


-- Update PostgreSQL's table statistics after creating the indexes.
ANALYZE arrests;


-- Verify the indexes attached to the arrests table.
SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'arrests'
ORDER BY indexname;