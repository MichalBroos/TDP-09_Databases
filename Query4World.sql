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
# careful, cannot have DISTINCT followed by count because that will just use the count as being distinct and give you a result including duplicates so need to first eliminate duplicates with SELECT DISTINCT and then COUNT them
# including duplicates
SELECT
    COUNT(city.`Name`) AS no_of_cities_in_China
FROM
    city
        JOIN
    country ON city.CountryCode = country.`Code`
WHERE
    country.`Name` = 'China';
# my extension to find the cities with duplicate entries
SELECT
    city.`Name`, COUNT(city.`Name`) AS occurrence
FROM
    city
        JOIN
    country ON city.CountryCode = country.`Code`
WHERE
    country.`Name` = 'China'
GROUP BY city.`NAME`
HAVING occurrence > 1;
# excluding duplicates (first exclude duplicates in the nested query, then count the unique occurrences)
SELECT
    COUNT(no_duplicates.no_of_cities_in_China)
FROM
    (SELECT DISTINCT
        city.`Name` AS no_of_cities_in_China
    FROM
        city
            JOIN
        country ON city.CountryCode = country.`Code`
    WHERE
        country.`Name` = 'China') AS no_duplicates;

# 8. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
SELECT
    `Name`, Population
FROM
    country
WHERE
    Population IS NOT NULL AND Population > 0
ORDER BY Population
LIMIT 1;

# 9. Using aggregate functions, return the number of countries the database contains.
SELECT
    COUNT(`Code`) AS no_of_countries
FROM
    country;

# 10. What are the top ten largest countries by area?
SELECT
    `Name`, SurfaceArea
FROM
    country
ORDER BY SurfaceArea DESC
LIMIT 10;

# 11. List the five largest cities by population in Japan.
SELECT
    city.`Name`, city.Population
FROM
    city
        JOIN
    country ON city.CountryCode = country.`Code`
WHERE
    country.`Name` = 'Japan'
ORDER BY city.Population DESC
LIMIT 5;

# 12. List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
SELECT
    `Name`, `Code`, HeadOfState
FROM
    country
WHERE
    HeadOfState LIKE '%th II';
# double check only 1 head ends with th 'II'
SELECT DISTINCT
    HeadOfState
FROM
    country
WHERE
    HeadOfState LIKE '%th II';

# 13. List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT
    `Name`, Population / SurfaceArea AS pop_to_area_ratio
FROM
    country
HAVING
    pop_to_area_ratio > 0
ORDER BY pop_to_area_ratio
LIMIT 10;

# 14. List every unique world language.
SELECT DISTINCT
    `Language`
FROM
    countrylanguage
ORDER BY `Language`;

# 15. List the names and GNP of the world's top 10 richest countries.
SELECT
    `Name`, GNP
FROM
    country
ORDER BY GNP DESC
LIMIT 10;

# 16. List the names of, and number of languages spoken by, the top ten most multilingual countries.

# 17. List every country where over 50% of its population can speak German.
# 18. Which country has the worst life expectancy? Discard zero or null values.

# 19. List the top three most common government forms.
SELECT
    GovernmentForm, COUNT(`Code`) AS no_of_countries
FROM
    country
GROUP BY GovernmentForm
ORDER BY no_of_countries DESC
LIMIT 3;
# 20.How many countries have gained independence since records began?


