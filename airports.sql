/*
Airports Exercise
 
Data source: https://ourairports.com/data/
Data dictionary: https://ourairports.com/help/data-dictionary.html
 
In this exercise we analyse the countries, airports and airports_frequencies table
These have  matching columns:
* airports.ident matches airport_frequencies.airport_ident
* countries.code matches airports.iso_country
*/
 
-- Show 10 sample rows of the airports table
SELECT  TOP 10 * FROM   countries c
WHERE c.continent = 'EU';

 
-- Show 10 sample rows of the airports table
SELECT  TOP 10 * FROM   airports a
WHERE a.elevation_ft >1000;
 
-- Show 10 sample rows of the airports_frequencies table
SELECT  TOP 10 * FROM airport_frequencies af
where af.fequency_mhz between 120 and 130
order by af.fequency_mhz asc;
 
-- These are the more interesting columns of the airports table  that we use in this exercise
SELECT TOP 10
    a.ident
    , a.iata_code
    , a.name
    , a.[type]
    , a.latitude_deg
    , a.longitude_deg
    , a.elevation_ft
    , a.iso_country
FROM airports a;
 
-- How many airports are in the airports table?
SELECT COUNT(*) as NumberOfAirport FROM airports a;
 select COUNT(*) as [Number of Airport] from airports


--are there airport with the same name?
 SELECT a.name, COUNT(*) AS NumberOfAirports
 FROM airports a
 GROUP BY a.name
 HAVING COUNT(*)>1
 ORDER BY NumberOfAirports DESC;


 
-- How many frequencies are in the airport_frequencies table?
 
-- How many airports of each type?
SELECT COUNT(*) as NumberOfAirport, a.TYPE
FROM airports a 
GROUP BY a.[type]
order by 1 DESC


 
-- Is the airport.ident column unique? i.e. there are no duplicate values
 
/*
Do a data quality check on the airports_frequencies table
Are there any orphan rows (frequencies without a matching airports)?
You can do this is several ways: LEFT JOIN, NOT IN, NOT EXISTS,...
*/
-- left join approach
 
-- NOT EXISTS approach  
 
-- NOT IN approach  
 
/*
1. List airports.  Show the following columns: ident, iata_code, name, latitude_deg, longitude_deg
2. Filter to those airports
  (a) of large_airports type
  (b) in the United Kingdom or France (iso_country  GB, FR)
  [advanced - in Europe i.e., country.continent = 'EU']
  (c) that have a latitude between 49 and 54 degrees
3. Order from the most northern airports to most southern airports
*/

SELECT
  a.ident
  ,a.iata_code
  ,a.name
  ,a.latitude_deg
  ,a.longitude_deg
  ,a.[type]
  ,a.iso_country
FROM
  airports a

  LEFT JOIN countries c ON a.iso_country = c.code

WHERE a.type = 'large_airport'
  AND ( c.continent = 'EU' OR c.continent IS null )

/*
AND a.latitude_deg BETWEEN 49 AND 54
ORDER BY a.latitude_deg DESC
*/

 
 
/*
List the iso_country of the 5 countries with the most airports
List in order of number of airports (highest first)
*/
 
 
/*
How many airports are in those 5 countries (with the most airports)?
Use three different approaches: temp table, CTE, subquery
*/
 
-- Write the temp table approach below here
 
 
-- Write the CTE approach below here
 
-- Write the subquery approach below here
 
/*
List those large airports (if any) without a frequency
*/
 
 
/*
List airports (if any) that have missing (NULL) values for *both* latitude or longitude.
*/
 
/*
List airports (if any) that have missing (NULL) values for *either* latitude or longitude  but not both.
This may indicate some sort of data quality issue.
*/