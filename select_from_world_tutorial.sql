-- SELECT from WORLD Tutorial


-- 1.
-- Read the notes about this table. Observe the result of running a simple SQL command.


SELECT name, continent, population FROM world
;



-- 2.
-- How to use WHERE to filter records. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.


SELECT name FROM world
  WHERE population>200000000
;


-- 3.
-- Give the name and the per capita GDP for those countries with a population of at least 200 million.

-- HELP:How to calculate per capita GDP

SELECT name, gdp/population FROM world
  WHERE population > 200000000
;


-- 4.
-- Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.


SELECT name, population/1000000 FROM world
  WHERE continent='South America'
;


-- 5.
-- Show the name and population for France, Germany, Italy

SELECT name, population FROM world
  WHERE name IN ('France','Germany','Italy')
;


-- 6.
-- Show the countries which have a name that includes the word 'United'

SELECT name FROM world
  WHERE name LIKE '%United%'
;


-- 7.
-- Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.

-- Show the countries that are big by area or big by population. Show name, population and area.


SELECT name,population,area
  FROM world
  WHERE area>3000000
  OR population>250000000
;



-- 8.
-- Exclusive OR. Show the countries that are big by area or big by population but not both. Show name, population and area.

-- Australia has a big area but a small population, it should be included.
-- Indonesia has a big population but a small area, it should be included.
-- China has a big population and big area, it should be excluded.
-- United Kingdom has a small population and a small area, it should be excluded.



SELECT name, population,area
  FROM world
  WHERE
  (population>250000000 OR area>3000000)
  AND NOT(population>250000000 AND area>3000000)
;



-- 9.
-- Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.

-- For South America show population in millions and GDP in billions to 2 decimal places.
-- Millions and billions
-- Divide by 1000000 (6 zeros) for millions. Divide by 1000000000 (9 zeros) for billions.


SELECT name, ROUND(population/1000000,2),
             ROUND(gdp/1000000000,2)
  FROM world
 WHERE continent='South America'
;



-- 10.
-- Show the per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

-- Show per-capita GDP for the trillion dollar countries to the nearest $1000.


SELECT name, ROUND(gdp/population,-3)
  FROM world
  WHERE
  gdp>1000000000000
;


-- 11.
-- The CASE statement shown is used to substitute North America for Caribbean in the third column.

-- Show the name - but substitute Australasia for Oceania - for countries beginning with N.


SELECT name, CASE WHEN continent='Oceania' THEN 'Australasia'
                  ELSE continent END
  FROM world
 WHERE name LIKE 'N%'
;


-- 12.
-- Show the name and the continent - but substitute Eurasia for Europe and Asia; substitute America - for each country in North America or South America or Caribbean. Show countries beginning with A or B


SELECT name, CASE WHEN continent IN ('Europe','Asia') THEN 'Eurasia'
                  WHEN continent IN ('North America','South America','Caribbean') THEN 'America'
                  ELSE continent END
  FROM world
 WHERE name BETWEEN 'A' AND 'C'
;



-- 13.
-- Put the continents right...

-- Oceania becomes Australasia
-- Countries in Eurasia and Turkey go to Europe/Asia
-- Caribbean islands starting with 'B' go to North America, other Caribbean islands go to South America
-- Order by country name in ascending order
-- Show the name, the original continent and the new continent of all countries.

SELECT name,continent,
  CASE WHEN continent = 'Eurasia' OR name='Turkey' THEN 'Europe/Asia'
       WHEN continent IN ('Oceania') THEN 'Australasia'
       WHEN continent = 'Caribbean' AND name LIKE 'B%' THEN 'North America'
       WHEN continent = 'Caribbean' THEN 'South America'
       ELSE continent END
  FROM world
ORDER BY name
;

-- 14.
-- The capital of Sweden is Stockholm. Both words start with the letter 'S'.

-- Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
-- You can use the function LEFT to isolate the first character.
-- You can use <> as the NOT EQUALS operator.

SELECT name, capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1) 
AND 
name <> capital
;

15. 
-- Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.

-- Find the country that has all the vowels and no spaces in its name.

-- You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
-- The query shown misses countries like Bahamas and Belarus because they contain at least one 'a'

SELECT name
FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
AND name NOT LIKE '% %';






