# NYPD Arrest Data Analysis

## Project Overview

This project analyzes the NYPD Arrest Data (Year to Date) dataset for January 1 through July 2, 2024. The dataset contains individual arrest records, demographic categories, offense classifications, precinct information, and geographic coordinates.

The project uses Python for data cleaning and visualization and PostgreSQL for database creation, validation, exploratory analysis, indexing, and geographic-data export.

This is a descriptive analysis. It identifies patterns within the arrest records but does not attempt to explain why those patterns occurred. Arrest counts should not be interpreted as crime rates or as measurements of criminal behavior within a population.

## Research Questions

The analysis addresses the following questions:

1. What are the most common offenses by age group?
2. What are the most common offenses by gender?
3. How are arrest records distributed across racial categories?
4. How are arrests distributed geographically across New York City?
5. Which offenses appear most frequently within each borough?

## Dataset

* **Source:** NYPD Arrest Data (Year to Date)
* **Date range:** January 1–July 2, 2024
* **Imported records:** 63,621
* **Unique arrest keys:** 63,621
* **Map-ready records:** 63,619
* **Database:** PostgreSQL
* **Database name:** `nypd_crime_db`
* **Primary table:** `arrests`

The cleaned dataset contains 19 columns, including:

* Arrest key and arrest date
* Offense type and offense level
* Borough and precinct
* Age group, gender, and race
* Latitude and longitude
* Georeferenced point data

## Project Workflow

The project follows an end-to-end data-analysis workflow:

1. Load the original NYPD CSV dataset with pandas.
2. Clean and standardize the arrest records.
3. Export a reproducible cleaned CSV file.
4. Create and populate a PostgreSQL database.
5. Validate the imported database records.
6. Write exploratory SQL queries.
7. Create indexes for common database searches.
8. Query PostgreSQL from Python.
9. Generate an interactive Folium map.
10. Export the completed map as an HTML file.

## Data Preparation

The primary notebook, `NYPD_arrest_analysis.ipynb`, performs the following tasks:

* Converts the original column names to `snake_case`
* Strips unnecessary whitespace from text values
* Replaces blank and null-like values with missing values
* Converts arrest dates to pandas datetime values
* Converts latitude and longitude to numeric values
* Removes records missing required analytical categories
* Checks for complete duplicate rows
* Checks for duplicate arrest keys
* Creates reusable plotting functions
* Exports the cleaned dataset for PostgreSQL

The cleaned dataset is exported locally to:

```text
data/processed/nypd_arrests_clean.csv
```

Processed CSV files are excluded from Git because they can be reproduced by running the notebook.

## Key Findings

### Arrest Records by Age Group

The `25–44` group accounts for the largest share of arrest records.

| Age group | Arrest records | Percentage |
| --------- | -------------: | ---------: |
| 25–44     |         37,254 |      58.6% |
| 45–64     |         12,315 |      19.4% |
| 18–24     |         10,684 |      16.8% |
| Under 18  |          2,327 |       3.7% |
| 65+       |          1,041 |       1.6% |

Robbery was the most common offense among records for individuals under 18. Assault 3 & Related Offenses was the most common offense for the remaining age groups.

### Arrest Records by Gender

| Gender code | Arrest records | Percentage |
| ----------- | -------------: | ---------: |
| M           |         52,432 |      82.4% |
| F           |         11,189 |      17.6% |

Assault 3 & Related Offenses was the most common offense recorded for both gender categories.

### Geographic Distribution

The geographic analysis uses latitude and longitude to map arrest records across New York City.

Records were filtered to the following expected coordinate boundaries:

```text
Latitude:  40.45 to 41.00
Longitude: -74.30 to -73.65
```

This geographic filter retained 63,619 of the 63,621 imported records.

| Borough code | Borough       | Map-ready records |
| ------------ | ------------- | ----------------: |
| K            | Brooklyn      |            17,402 |
| M            | Manhattan     |            15,322 |
| B            | Bronx         |            14,221 |
| Q            | Queens        |            13,782 |
| S            | Staten Island |             2,892 |

Brooklyn contained the largest number of map-ready arrest records, while Staten Island contained the smallest number.

Assault 3 & Related Offenses was the most common offense in Manhattan, the Bronx, Brooklyn, and Queens. Vehicle & Traffic Laws was the most common offense in Staten Island.

These totals represent arrest records and should not be interpreted as borough crime rates.

## PostgreSQL Workflow

The `sql` directory contains the complete database workflow:

| Script                        | Purpose                                                                      |
| ----------------------------- | ---------------------------------------------------------------------------- |
| `00_create_database.sql`      | Creates the `nypd_crime_db` database                                         |
| `01_create_arrests_table.sql` | Creates the 19-column `arrests` table                                        |
| `02_import_arrests.sql`       | Imports the cleaned CSV using the psql `\copy` command                       |
| `03_validate_import.sql`      | Validates row counts, unique keys, dates, and null values                    |
| `04_exploratory_queries.sql`  | Analyzes boroughs, offenses, age groups, gender, race, months, and precincts |
| `05_create_indexes.sql`       | Creates indexes for common searches and geographic filtering                 |
| `06_export_map_data.sql`      | Filters and exports map-ready arrest records                                 |

The PostgreSQL validation confirmed:

* 63,621 imported records
* 63,621 unique arrest keys
* Earliest arrest date of January 1, 2024
* Latest arrest date of July 2, 2024
* No missing latitude or longitude values

## Database Indexes

PostgreSQL contains six indexes on the `arrests` table:

* Primary-key index on `arrest_key`
* Arrest-date index
* Borough index
* Offense-type index
* Offense-level index
* Composite latitude-and-longitude index

These indexes improve filtering, grouping, geographic-data preparation, and frequently used analytical queries.

## PostgreSQL Mapping Workflow

`NYPD_postgresql_mapping.ipynb` connects directly to the local PostgreSQL database using SQLAlchemy and psycopg2.

The PostgreSQL password is requested at runtime with `getpass()` and is never stored in the notebook or committed to GitHub.

The mapping query:

* Filters records to the expected New York City coordinate range
* Groups nearby records into geographic bins
* Counts arrest records within each geographic bin
* Uses a SQL window function to identify the most common offense
* Returns 63,619 geographically valid arrest records

Folium then creates an interactive Leaflet map containing:

* An arrest-record density heat layer
* Geographic-bin markers
* Hover totals
* Clickable offense-detail popups
* Interactive layer controls

The generated map is saved at:

```text
outputs/maps/nypd_postgresql_arrest_map.html
```

The HTML file is committed to the repository and will be published as an interactive webpage using GitHub Pages.

## Technologies

* Python
* pandas
* NumPy
* Matplotlib
* SciPy
* Folium
* Leaflet
* Jupyter Notebook
* PostgreSQL
* SQLAlchemy
* psycopg2
* psql
* Git
* GitHub
* Visual Studio Code

## Repository Structure

```text
Data_Project_1/
├── Data_Project_1/
│   └── NYPD_Arrest_Data__Year_to_Date__20240702.csv
├── data/
│   ├── boundaries/
│   │   └── nyc_borough_boundaries.geojson
│   └── processed/
├── outputs/
│   └── maps/
│       └── nypd_postgresql_arrest_map.html
├── sql/
│   ├── 00_create_database.sql
│   ├── 01_create_arrests_table.sql
│   ├── 02_import_arrests.sql
│   ├── 03_validate_import.sql
│   ├── 04_exploratory_queries.sql
│   ├── 05_create_indexes.sql
│   └── 06_export_map_data.sql
├── NYPD_arrest_analysis.ipynb
├── NYPD_postgresql_mapping.ipynb
├── NYPD_Crime_Project.pptx
├── Project_1_Proposal.pdf
├── README.md
└── requirements.txt
```

## Running the Project

Install the required Python packages:

```bash
python -m pip install -r requirements.txt
```

Run `NYPD_arrest_analysis.ipynb` first to clean the original dataset and create the processed CSV file.

Next, run the SQL scripts in numerical order to create, populate, validate, analyze, and index the PostgreSQL database.

Finally, run `NYPD_postgresql_mapping.ipynb` to query PostgreSQL and generate the interactive map.

## Limitations

* The dataset covers only January 1 through July 2, 2024.
* The analysis describes arrest records rather than confirmed crimes or convictions.
* Differences between groups or boroughs may reflect population, policing, reporting, or other factors not measured by this dataset.
* Raw arrest totals are not adjusted for borough population.
* The analysis should not be used to infer individual criminal behavior.

## Summary

This project demonstrates an end-to-end data-analysis workflow: cleaning raw NYPD data, validating the results, loading the cleaned dataset into PostgreSQL, writing analytical SQL queries, creating database indexes, and generating an interactive geographic visualization.

The strongest descriptive pattern is the concentration of arrest records in the `25–44` age group. The dataset also contains substantially more records coded as male than female. Geographically, Brooklyn has the largest number of map-ready arrest records, while Staten Island has the smallest.
