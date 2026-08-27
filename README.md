# NYPD Arrest Data Analysis

## Project Overview

This project analyzes the NYPD Arrest Data (Year to Date) dataset for January 1 through July 2, 2024. The dataset contains individual arrest records, demographic categories, offense classifications, precinct information, and geographic coordinates.

The project uses Python for data cleaning and visualization and PostgreSQL for database creation, validation, exploratory analysis, indexing, and geographic-data export.

The analysis is descriptive. It identifies patterns in the arrest records but does not attempt to explain why those patterns occurred. Arrest counts should not be interpreted as crime rates or as a measure of criminal behavior within a population.

## Research Questions

The analysis addresses the following questions:

1. What are the most common offenses by age group?
2. What are the most common offenses by gender?
3. How are arrest records distributed across racial categories?
4. How are arrests distributed geographically across New York City?
5. Which offenses appear most frequently within each borough?

## Dataset

- **Source:** NYPD Arrest Data (Year to Date)
- **Date range:** January 1–July 2, 2024
- **Imported records:** 63,621
- **Unique arrest keys:** 63,621
- **Map-ready records:** 63,619
- **Database:** PostgreSQL
- **Database name:** `nypd_crime_db`
- **Primary table:** `arrests`

The cleaned dataset contains 19 columns, including:

- Arrest key and date
- Offense type and level
- Borough and precinct
- Age group, gender, and race
- Latitude and longitude
- Georeferenced point data

## Data Preparation

The primary notebook standardizes the original column names, converts dates and geographic coordinates to appropriate data types, handles blank values, and removes records missing required analytical categories.

The cleaned dataset is exported locally to:

```text
data/processed/nypd_arrests_clean.csv
```

Processed CSV files are excluded from Git because they can be reproduced from the notebook.

## Key Findings

### Arrest records by age group

The `25–44` group accounts for the largest share of arrest records.

| Age group | Arrest records | Percentage |
|---|---:|---:|
| 25–44 | 37,254 | 58.6% |
| 45–64 | 12,315 | 19.4% |
| 18–24 | 10,684 | 16.8% |
| Under 18 | 2,327 | 3.7% |
| 65+ | 1,041 | 1.6% |

Robbery was the most common offense among records for individuals under 18. Assault 3 & Related Offenses was the most common offense for the other age groups.

### Arrest records by gender

| Gender code | Arrest records | Percentage |
|---|---:|---:|
| M | 52,432 | 82.4% |
| F | 11,189 | 17.6% |

Assault 3 & Related Offenses was the most common offense recorded for both gender categories.

### Geographic distribution

The geographic analysis uses latitude and longitude to map arrest records across New York City. Records were filtered to the following expected NYC coordinate boundaries:

```text
Latitude:  40.45 to 41.00
Longitude: -74.30 to -73.65
```

This filter retained 63,619 of the 63,621 imported records.

| Borough code | Borough | Map-ready records |
|---|---|---:|
| K | Brooklyn | 17,402 |
| M | Manhattan | 15,322 |
| B | Bronx | 14,221 |
| Q | Queens | 13,782 |
| S | Staten Island | 2,892 |

The original geographic analysis divided New York City into approximately one-mile sections and displayed the most common offense within each area through an interactive map.

Assault 3 & Related Offenses was the most common offense in Manhattan, the Bronx, Brooklyn, and Queens. Vehicle & Traffic Laws was the most common offense in Staten Island.

## PostgreSQL Workflow

The `sql` directory contains the complete database workflow:

| Script | Purpose |
|---|---|
| `00_create_database.sql` | Creates `nypd_crime_db` |
| `01_create_arrests_table.sql` | Creates the 19-column `arrests` table |
| `02_import_arrests.sql` | Imports the cleaned CSV using psql `\copy` |
| `03_validate_import.sql` | Validates row counts, unique keys, dates, and null values |
| `04_exploratory_queries.sql` | Analyzes boroughs, offenses, age groups, gender, race, months, and precincts |
| `05_create_indexes.sql` | Creates indexes for common searches and geographic filtering |
| `06_export_map_data.sql` | Filters and exports map-ready arrest records |

## Database Indexes

PostgreSQL contains six indexes on the `arrests` table:

- Primary-key index on `arrest_key`
- Arrest-date index
- Borough index
- Offense-type index
- Offense-level index
- Composite latitude and longitude index

These indexes improve searches, filtering, grouping, and geographic-data preparation.

## PostgreSQL Mapping Workflow

`NYPD_postgresql_mapping.ipynb` connects directly to the local PostgreSQL database using SQLAlchemy and psycopg2. The PostgreSQL password is requested at runtime with `getpass()` and is never stored in the notebook or committed to Git.

The mapping query:

- Filters records to the expected NYC coordinate range
- Groups nearby records into geographic bins
- Counts arrest records within each bin
- Uses a window function to identify the most common offense
- Returns 63,619 geographically valid arrest records

Folium then creates an interactive Leaflet map containing:

- An arrest-record density heat layer
- Geographic-bin markers
- Hover totals
- Clickable offense-detail popups
- Interactive layer controls

The completed map is saved to:

```text
outputs/maps/nypd_postgresql_arrest_map.html

## Technologies

- Python
- pandas
- Matplotlib
- SciPy
- Folium and Leaflet
- Jupyter Notebook
- PostgreSQL
- SQLAlchemy
- psycopg2
- psql
- Git and GitHub
- Visual Studio Code

## Repository Structure

```text
Data_Project_1/
├── Data_Project_1/
│   └── NYPD_Arrest_Data__Year_to_Date__20240702.csv
├── data/
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


Save `README.md`, then run:

```bash
git status --short

## Summary

The project demonstrates an end-to-end data-analysis workflow: cleaning raw NYPD data, validating the results, loading the cleaned dataset into PostgreSQL, writing analytical SQL queries, creating database indexes, and exporting geographically valid records for mapping.

The strongest descriptive pattern is the concentration of arrest records in the `25–44` age group. The dataset also contains substantially more records coded as male than female. Geographically, Brooklyn has the largest number of map-ready arrest records, while Staten Island has the smallest.

These findings describe the records in this dataset and should not be interpreted as explanations of criminal behavior or comparisons of crime risk among demographic groups.