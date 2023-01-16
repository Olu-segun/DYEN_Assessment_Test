--SECTION A--
--PROFIT ANALYSIS--

/*1. Within the space of the last three years, what was the profit worth of the breweries,
inclusive of the anglophone and the francophone territories?*/

SELECT SUM(profit) AS sum_profit
FROM breweries;


/*2. Compare the total profit between these two territories in order for the territory manager,
Mr. Stone made a strategic decision that will aid profit maximization in 2020.*/

SELECT DISTINCT 
CASE
	WHEN countries IN ('Nigeria' , 'Ghana') THEN  'Anglophone'
	ELSE 'Francophone'
	END AS territories,
	SUM(profit) AS Sum_profit
FROM breweries
GROUP BY 1
ORDER BY 2 DESC;


--3. Country that generated the highest profit in 2019--

SELECT countries, SUM(profit) AS Sum_profit
FROM breweries
WHERE years= 2019
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


--4. Help him find the year with the highest profit.--

SELECT years, SUM(profit) AS Sum_profit
FROM breweries
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--5. Which month in the three years was the least profit generated?--

SELECT years, months, SUM(profit) AS Sum_profit
FROM breweries
GROUP BY 1,2
ORDER BY 3
LIMIT 1;

--6. What was the minimum profit in the month of December 2018?--

SELECT months, MIN(profit) AS Min_profit
FROM breweries
WHERE years= 2018
AND months = 'December'
GROUP BY 1
ORDER BY 2;

--7. Compare the profit in percentage for each of the month in 2019--

	
SELECT months, round(SUM(profit*1.0)/(SELECT SUM(profit)
FROM breweries
WHERE years= 2019)*100.0,2) AA
FROM breweries
where years = 2019					 
GROUP BY 1;


--8. Which particular brand generated the highest profit in Senegal?--

SELECT brands, SUM(profit)
FROM breweries
WHERE countries = 'Senegal'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--Session B--
--BRAND ANALYSIS--

/*1. Within the last two years, the brand manager wants to know the top three brands
consumed in the francophone countries*/


SELECT brands,SUM(profit), SUM(quantity)
FROM breweries
WHERE countries IN ('Senegal', 'Togo', 'Benin')
AND years IN (2018,2019)
GROUP BY 1
ORDER BY 3 DESC
LIMIT 3;

--2. Find out the top two choice of consumer brands in Ghana--

SELECT brands, SUM(quantity) AS Top_Choice
FROM breweries
WHERE countries = 'Ghana'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 2;

/*3. Find out the details of beers consumed in the past three years in the most oil reached
country in West Africa.*/


SELECT DISTINCT brands, unit_price,SUM(quantity) AS quantity, SUM(profit) AS profit, SUM(costs) AS costs 
FROM breweries
WHERE countries ='Nigeria'
AND brands NOT LIKE '%malt%'
GROUP BY 1,2
ORDER BY 3;

--4. Favorites malt brand in Anglophone region between 2018 and 2019--

SELECT brands, SUM(quantity)
FROM breweries
WHERE countries IN ('Nigeria', 'Ghana')
AND brands LIKE '%malt%'
AND years BETWEEN 2018 AND 2019
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--5. Which brand sold the highest in 2019 in Nigeria?--

SELECT brands, SUM(quantity)
FROM breweries
WHERE countries='Nigeria'
AND years=2019
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--6. Favorite brand in South_South region in Nigeria--

SELECT brands, SUM(quantity)
FROM breweries
WHERE region='southsouth'
AND countries='Nigeria'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--7. Beer consumption in Nigeria--
SELECT  brands, SUM(quantity) AS quantity
FROM breweries
WHERE countries='Nigeria'
AND brands NOT LIKE '%malt%'
GROUP BY 1
ORDER BY 2;



--8. Level of consumption of Budweiser in the regions in Nigeria--
--Total brands consumption in Nigeria --
SELECT SUM(quantity) FROM breweries 
WHERE countries = 'Nigeria';

-- Ratio of budweiser in total quantities in Nigeria --
SELECT SUM(quantity) FROM breweries 
WHERE brands = 'budweiser' 
AND countries = 'Nigeria';


--Level of consumption of Budweiser in the regions in Nigeria--
SELECT brands, ROUND ((
SELECT SUM(quantity) FROM breweries 
WHERE brands = 'budweiser' 
AND countries = 'Nigeria') * 1.0 / (
SELECT SUM(quantity) FROM breweries 
WHERE countries = 'Nigeria'),2) * 100 AS perc_ratio
FROM breweries
WHERE countries = 'Nigeria' 
AND brands = 'budweiser'
GROUP BY 1;


-- 9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)--
SELECT brands, ROUND ((
SELECT SUM(quantity) FROM breweries 
WHERE brands = 'budweiser' 
AND years = 2019
AND countries = 'Nigeria') * 1.0 / (
SELECT SUM(quantity) FROM breweries 
WHERE countries = 'Nigeria'
AND years = 2019
),2) * 100 AS perc_ratio
FROM breweries
WHERE countries = 'Nigeria' 
AND brands = 'budweiser'
AND years = 2019
GROUP BY 1;

--Session C--
--COUNTRIES ANALYSIS--
--1. Country with the highest consumption of beer--
SELECT countries, SUM(quantity)
FROM breweries
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--2. Highest sales personnel of Budweiser in Senegal--

SELECT sales_rep, SUM(quantity) AS sales_quantity
FROM breweries
WHERE brands='budweiser'
AND countries = 'Senegal'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


--3. Country with the highest profit of the fourth quarter in 2019--

SELECT countries, SUM(profit) AS profit
FROM breweries
WHERE months IN ('October','November', 'December')
AND years=2019
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
