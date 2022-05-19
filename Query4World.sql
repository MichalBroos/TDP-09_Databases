USE world;

# 1. Using COUNT, get the number of cities in the USA.
SELECT 
    COUNT(city.ID)
FROM
    city
        JOIN
    country ON city.CountryCode = country.`Code`
WHERE
    country.`Name` = 'United States';

# 2. Find out the population and life expectancy for people in Argentina.
SELECT 
    `Name`, Population, LifeExpectancy
FROM
    country
WHERE
    `Name` = 'Argentina';

# 3. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT
    `Name`, LifeExpectancy
FROM
    country
WHERE
    LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy DESC
LIMIT 1;

# 4. Using JOIN ... ON, find the capital city of Spain.
SELECT 
    city.`Name`
FROM
    city
        JOIN
    country ON city.id = country.Capital
WHERE
    country.`Name` = 'Spain';

# 5. Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT DISTINCT
	`Language`
FROM
	country
		JOIN
	countrylanguage ON country.`Code` = CountryCode
WHERE
	Region = 'Southeast Asia';

# 6. Using a single query, list 25 cities around the world that start with the letter F.
SELECT 
    `Name`
FROM
    city
WHERE
    `Name` LIKE 'F%'
LIMIT 25;

# 7. Using COUNT and JOIN ... ON, get the number of cities in China.

/*

8.	Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
9.	Using aggregate functions, return the number of countries the database contains.
10.	What are the top ten largest countries by area?
11.	List the five largest cities by population in Japan.
12.	List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
13.	List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
14.	List every unique world language.
15.	List the names and GNP of the world's top 10 richest countries.
16.	List the names of, and number of languages spoken by, the top ten most multilingual countries.
17.	List every country where over 50% of its population can speak German.
18.	Which country has the worst life expectancy? Discard zero or null values.
19.	List the top three most common government forms.
20.	How many countries have gained independence since records began?
*/