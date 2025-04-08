DROP DATABASE IF EXISTS world;

CREATE DATABASE world;

USE world;

\. C:/Users/ari_l/Documents/world.sql

-- 1. The Continent, Country Name, District, City Name and City Population of for all cities with a population of over 3 million people. 
		-- Sort the results by Continent, Country Name, District and City Name.

SELECT country.continent "Continent", country.name "Country Name", city.district "City Ditrict", city.name "City Name", city.population "City Population"
FROM country
JOIN city ON country.code = city.countrycode
WHERE city.population > 3000000
ORDER BY country.continent ASC, country.name ASC, city.district ASC, city.name ASC;


-- 2. The Country Name, Language percentage, and population for all countries where English is the official language. 
		-- Sort the results by ascending Country Name, descending percentage .

SELECT country.name "Country Name", countrylanguage.percentage "Percentage", country.population "Total Population"
FROM country
JOIN countrylanguage ON countrylanguage.countrycode = country.code
WHERE countrylanguage.language = 'English' AND countrylanguage.isofficial = 'T'
ORDER BY country.name ASC, countrylanguage.percentage DESC;


-- 3. The Life Expectancy, Country Population, Country Name, Head of State and Official Language of countries with more than 100 million people. 
		-- Sort the results by Life Expectancy, Population.
		-- ***only returns countries WITH an official language AND over 100m people***

SELECT country.lifeexpectancy "Life Expectancy", country.population "Population", country.name "Country Name", country.headofstate "Head of State", countrylanguage.language "Official Language" 
FROM country
JOIN countrylanguage ON countrycode = country.code
WHERE country.population > 100000000 AND countrylanguage.isofficial = 'T'
ORDER BY country.lifeexpectancy DESC, country.population DESC;

		-- ***returns all countries with over 100m people and their official language, inlcuding those without an official language***

SELECT 
	country.lifeexpectancy "Life Expectancy", 
	country.population "Population", 
	country.name "Country Name", 
	country.headofstate "Head of State",
    COALESCE(countrylanguage.language, 'No Official Language') "Official Language"
FROM country
LEFT JOIN countrylanguage 
    ON country.code = countrylanguage.countrycode 
    AND countrylanguage.isofficial = 'T'  -- Only official languages
WHERE country.population > 100000000
ORDER BY country.lifeexpectancy DESC, country.population DESC;


-- 4. The Country Name and Capital City Name of countries with surface area greater than 2 million.

SELECT country.name "Country Name", city.name "Capital City"
FROM country 
JOIN city ON city.countrycode = country.code
WHERE country.surfacearea > 2000000 AND country.capital = city.ID;


-- 5. The Country Name, Independence Year, Capital City Name, Language, Language Percentage, with Independence Year > 1991. 
		-- Sort the results by country name ascending and language percentage Descending.

SELECT country.name "Country Name", country.indepyear "Independence Year", city.name "Capital City", countrylanguage.language "Language", countrylanguage.percentage "Language Percent"
FROM country
JOIN city ON city.countrycode = country.code
JOIN countrylanguage ON countrylanguage.countrycode = country.code
WHERE country.indepyear > 1991 AND country.capital = city.ID
ORDER BY country.name ASC, countrylanguage.percentage DESC;


-- 6. Write the UPDATE statement to change the US Head of State to the name of the current President or your name.

	-- Write a select statement to show the Head of State in the database for the USA (Show the result set)
	-- first have to find naming convention of USA in database and confirm rows affected
	
	SELECT name, headofstate
	FROM country
	WHERE name IN ('USA', 'United States', 'America', 'United States of America');

	+---------------+----------------+
	| name          | headofstate    |
	+---------------+----------------+
	| United States | George W. Bush |
	+---------------+----------------+

	SELECT name, headofstate 
	FROM country 
	WHERE headofstate = 'george w. bush';

	+--------------------------------------+----------------+
	| name                                 | headofstate    |
	+--------------------------------------+----------------+
	| American Samoa                       | George W. Bush |
	| Guam                                 | George W. Bush |
	| Northern Mariana Islands             | George W. Bush |
	| Puerto Rico                          | George W. Bush |
	| United States                        | George W. Bush |
	| Virgin Islands, U.S.                 | George W. Bush |
	| United States Minor Outlying Islands | George W. Bush |
	+--------------------------------------+----------------+

	-- Write the update statement using the same where clause from (a)
	
	START TRANSACTION;

	UPDATE country 
	SET headofstate = 'Donald J. Trump'
	WHERE headofstate = 'George W. Bush';

	COMMIT;

	-- Re-run the select from (6.1) to show your update
	
	SELECT name, headofstate
	FROM country
	WHERE name IN ('USA', 'United States', 'America', 'United States of America');

	+---------------+-----------------+
	| name          | headofstate     |
	+---------------+-----------------+
	| United States | Donald J. Trump |
	+---------------+-----------------+

	SELECT name, headofstate 
	FROM country 
	WHERE headofstate = 'george w. bush';

	MariaDB [world]> SELECT name, headofstate
		-> FROM country
		-> WHERE headofstate = 'george w. bush';
	Empty set (0.001 sec)


	SELECT name, headofstate 
	FROM country 
	WHERE headofstate = 'donald j. trump'; 

	+--------------------------------------+-----------------+
	| name                                 | headofstate     |
	+--------------------------------------+-----------------+
	| American Samoa                       | Donald J. Trump |
	| Guam                                 | Donald J. Trump |
	| Northern Mariana Islands             | Donald J. Trump |
	| Puerto Rico                          | Donald J. Trump |
	| United States                        | Donald J. Trump |
	| Virgin Islands, U.S.                 | Donald J. Trump |
	| United States Minor Outlying Islands | Donald J. Trump |
	+--------------------------------------+-----------------+