/* Question 1.
Query all columns for all American cities in the CITY table with 
populations larger than 100000. The CountryCode for America is USA.*/

SELECT *
FROM city
WHERE population > 100000 AND CountryCode = 'USA';

/* Question 2.
Query a count of the number of cities in CITY having a Population 
larger than .*/

SELECT count(population)
FROM city
WHERE population > 100000;

/* Question 3.
Query the total population of all cities in CITY where District 
is California. */

SELECT SUM(population)
FROM city
WHERE district = 'California';

/* Question 4.
Query the average population of all cities in CITY where 
District is California.*/

SELECT avg(population)
FROM city
WHERE district = 'California';

 /* Question 5.
Julia just finished conducting a coding contest, and she 
 needs your help assembling the leaderboard! Write a query to print the 
 respective hacker_id and name of hackers who achieved full scores for more 
 than one challenge. Order your output in descending order by the total number 
 of challenges in which the hacker earned a full score. If more than one hacker 
 received full scores in same number of challenges, then sort them by ascending hacker_id.*/

SELECT hackers.hacker_id, hackers.name
FROM hackers 
JOIN submissions 
ON
hackers.hacker_id = submissions.hacker_id
JOIN challenges
ON
challenges.challenge_id = submissions.challenge_id
JOIN difficulty 
ON
difficulty.difficulty_level = challenges.difficulty_level
WHERE submissions.score = difficulty.score
GROUP BY hackers.hacker_id, hackers.name
HAVING COUNT(*) > 1 
ORDER BY COUNT(*) DESC, hackers.hacker_id;

 /* Question 6.
 Query the list of CITY names from STATION that either do not start 
 with vowels or do not end with vowels. Your result cannot contain duplicates. */

SELECT DISTINCT City 
FROM Station 
WHERE LEFT(City, 1) NOT IN ('a', 'e', 'i', 'o', 'u')
    OR 
    RIGHT(City, 1) NOT IN ('a', 'e', 'i', 'o', 'u');

 /* Question 7.
 Query the list of CITY names from STATION that do not start with 
 vowels and do not end with vowels. Your result cannot contain duplicates. */

SELECT DISTINCT City 
FROM Station 
WHERE LEFT(City, 1) NOT IN ('a', 'e', 'i', 'o', 'u')
    AND 
    RIGHT(City, 1) NOT IN ('a', 'e', 'i', 'o', 'u');

 /* Question 8.
 Query the Name of any student in STUDENTS who scored higher 
 than  Marks. Order your output by the last three characters of each name. 
 If two or more students both have names ending in the same last 
 three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID. */

SELECT Name
FROM Students
WHERE Marks > 75
ORDER BY SUBSTRING(Name, -3), 
        ID ASC;

 /* Question 9.
 Write a query that prints a list of employee names 
 (i.e.: the name attribute) from the Employee table in alphabetical order. */

SELECT name 
FROM Employee 
ORDER BY name ASC;

 /* Question 10.
 Write a query that prints a list of employee names (i.e.: the name attribute) 
 for employees in Employee having a salary greater than  per month who have been employees 
 for less than  months. Sort your result by ascending employee_id. */

SELECT name 
FROM Employee 
WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC;

 /* Question 11.
 Query the sum of the populations for all Japanese cities in CITY. 
 The COUNTRYCODE for Japan is JPN. */

SELECT sum(population)
FROM City
WHERE Countrycode = 'JPN';

 /* Question 12.
 Query the difference between the maximum and minimum populations in CITY. */

SELECT max(population) - min(population)
FROM City;

/*  Question 13.
Samantha was tasked with calculating the average monthly salaries for 
 all employees in the EMPLOYEES table, but did not realize her keyboard's  key was 
 broken until after completing the calculation. She wants your help finding the 
 difference between her miscalculation (using salaries with any zeros removed), 
and the actual average salary.  Write a query calculating the amount of error 
(i.e.:  average monthly salaries), and round it up to the next integer.*/ 

SELECT CEIL(AVG(salary) - AVG(REPLACE(salary, '0','')))
FROM EMPLOYEES;

/* Question 14.
We define an employee's total earnings to be their monthly  worked, 
and the maximum total earnings to be the maximum total earnings for any employee 
in the Employee table. Write a query to find the maximum total earnings for all 
employees as well as the total number of employees who have maximum total earnings. 
Then print these values as  space-separated integers. */ 

SELECT months * salary AS earnings, count(*)
FROM Employee 
GROUP BY earnings
ORDER BY earnings DESC
LIMIT 1;

 /* Question 15.
 Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of  decimal places.
The sum of all values in LONG_W rounded to a scale of  decimal places.*/

SELECT ROUND(sum(lat_N), 2), ROUND(sum(long_w), 2)
FROM station;

/* Question 16.
Query the sum of Northern Latitudes (LAT_N) from STATION 
having values greater than  and less than . Truncate your answer to  decimal places.*/

SELECT ROUND(sum(lat_n), 4)
FROM station
WHERE lat_n > 38.7880 
      AND lat_n < 137.2345;

/* Question 17.
Query the greatest value of the Northern Latitudes (LAT_N) from 
STATION that is less than . Truncate your answer to  decimal places.*/

SELECT round(max(lat_n), 4)
FROM station
WHERE lat_n < 137.2345;

/* Question 18.
Query the Western Longitude (LONG_W) for the largest Northern Latitude
 (LAT_N) in STATION that is less than . Round your answer to  decimal places.*/

SELECT round(long_w, 4) 
FROM station 
WHERE lat_n = (SELECT max(lat_n) 
               FROM station 
               WHERE lat_n < 137.2345 );
 
/* Question 19.
Query the smallest Northern Latitude (LAT_N) from STATION that is 
greater than . Round your answer to  decimal places.*/

SELECT ROUND(min(lat_n), 4)
FROM station
WHERE lat_n > 38.7780;

/* Question 20.
Query the Western Longitude (LONG_W)where the smallest Northern 
Latitude (LAT_N) in STATION is greater than . Round your answer to  decimal places.*/

SELECT ROUND(long_w, 4)
FROM station
WHERE lat_n = (SELECT min(lat_n)
               FROM station
               WHERE lat_n > 38.7780
              );

/* Question 21. 
Consider  and  to be two points on a 2D plane.

 happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.*/

SELECT ROUND(ABS(max(lat_n) + max(long_w)) - ABS(min(lat_n) + min(long_w)), 4) AS ManhattanDistance
FROM   station;

/* Question 22.
Consider  and  to be two points on a 2D plane where  are the respective minimum 
and maximum values of Northern Latitude (LAT_N) and  are the respective minimum 
and maximum values of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points  and  and format your answer to display
  decimal digits.*/

SELECT ROUND(sqrt(((max(lat_n)-min(lat_n))*(max(lat_n)-min(lat_n)))+
             ((max(long_w)-min(long_w))*(max(long_w)-min(long_w)))),4)
FROM station;

/* Question 23. A median is defined as a number separating the higher half of a data
 set from the lower half. Query the median of the Northern Latitudes (LAT_N) 
 from STATION and round your answer to  decimal places.*/

-- (Oracle)
SELECT ROUND(median(lat_n), 4)
FROM STATION;

/* Question 24.
Query the average population for all cities in CITY, rounded down to the nearest 
integer.*/

SELECT FLOOR(avg(population))
FROM city;

/* Question 25.
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically
 and displayed underneath its corresponding Occupation. The output column headers 
 should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.*/

WITH CTE AS( SELECT 
          CASE WHEN occupation='Doctor' THEN name END AS doctor , 
          CASE WHEN occupation='professor' THEN name END AS Professor , 
          CASE WHEN occupation='singer' THEN name END AS singer, 
          CASE WHEN occupation='actor' THEN name END AS actor, ROW_NUMBER() over (PARTITION BY occupation ORDER BY name) AS r 
          FROM occupations) 
SELECT min(doctor), min(professor), min(singer), min(actor) 
FROM CTE GROUP BY r;