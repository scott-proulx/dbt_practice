-- Use an admin role
USE ROLE ACCOUNTADMIN;

-- Create the `transform` role
CREATE ROLE IF NOT EXISTS transform;
GRANT ROLE TRANSFORM TO ROLE ACCOUNTADMIN;

-- Create the default warehouse if necessary
CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH;
GRANT OPERATE ON WAREHOUSE COMPUTE_WH TO ROLE TRANSFORM;

-- Create the `dbt` user and assign to role
CREATE USER IF NOT EXISTS dbt
  PASSWORD='dbtPassword123'
  LOGIN_NAME='dbt'
  MUST_CHANGE_PASSWORD=FALSE
  DEFAULT_WAREHOUSE='COMPUTE_WH'
  DEFAULT_ROLE='transform'
  DEFAULT_NAMESPACE='AIRBNB.RAW'
  COMMENT='DBT user used for data transformation';
GRANT ROLE transform to USER dbt;

-- Create our database and schemas
CREATE DATABASE IF NOT EXISTS NETFLIX;
CREATE SCHEMA IF NOT EXISTS NETFLIX.RAW;

-- Set up permissions to role `transform`
GRANT ALL ON WAREHOUSE COMPUTE_WH TO ROLE transform; 
GRANT ALL ON DATABASE NETFLIX to ROLE transform;
GRANT ALL ON ALL SCHEMAS IN DATABASE NETFLIX to ROLE transform;
GRANT ALL ON FUTURE SCHEMAS IN DATABASE NETFLIX to ROLE transform;
GRANT ALL ON ALL TABLES IN SCHEMA NETFLIX.RAW to ROLE transform;
GRANT ALL ON FUTURE TABLES IN SCHEMA NETFLIX.RAW to ROLE transform;

-- Set up the defaults
USE WAREHOUSE COMPUTE_WH;
USE DATABASE NETFLIX;
USE SCHEMA RAW;

-- Create our two tables and import data later
CREATE OR REPLACE TABLE raw_credits
                    (person_id integer,
                     id string,
                     name string,
                     character string,
                     role string);                 

CREATE OR REPLACE TABLE raw_titles
                    (id string,
                     title string,
                     type string,
                     release_year integer,
                     age_certification string,
                     runtime integer,
                     genres string,
                     production_countries string,
                     seasons integer,
                     imdb_id string,
                     imdb_score double,
                     imdb_votes integer);