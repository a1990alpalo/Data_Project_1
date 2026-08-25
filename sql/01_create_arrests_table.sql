-- Create the table for the cleaned NYPD arrest data.

CREATE TABLE arrests (
    arrest_key BIGINT PRIMARY KEY,
    arrest_date DATE NOT NULL,
    pd_code SMALLINT,
    pd_description TEXT,
    key_code SMALLINT,
    offense_type TEXT NOT NULL,
    law_code VARCHAR(20),
    offense_level VARCHAR(20) NOT NULL,
    borough VARCHAR(20) NOT NULL,
    jurisdiction_code SMALLINT,
    arrest_precinct SMALLINT,
    age_group VARCHAR(20) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    race TEXT NOT NULL,
    x_coordinate INTEGER,
    y_coordinate INTEGER,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    georeferenced_column TEXT
);