--Creating the Sales table
CREATE TABLE sales (
  sales_id NUMERIC (10),
  sales_rep VARCHAR(50),
  emails VARCHAR(255),
  brands VARCHAR(50),
  plant_cost INTEGER,
  unit_price INTEGER,
  quantity INTEGER,
  cost INTEGER,
  profit INTEGER,
  countries VARCHAR (50),
  region VARCHAR (50),
  months VARCHAR (50),  
  years VARCHAR (50),
  PRIMARY KEY (sales_id)
);



/*Question A1
Within the space of the last three years, what was the profit worth of the breweries,
inclusive of the anglophone and the francophone territories?*/

SELECT SUM(profit) AS Last_3_Years_Profit
FROM Sales
WHERE years IN ('2019','2018','2017');

/*
--Question A2
Compare the total profit between these two territories in order for the territory manager,
Mr. Stone made a strategic decision that will aid profit maximization in 2020.*/

SELECT 
CASE
    WHEN Countries IN ('Ghana','Nigeria') THEN 'Anglophone'
	WHEN Countries IN ('Togo','Senegal','Benin') THEN 'Francophone'
END AS Territory,
SUM (profit) AS Total_Profit
FROM Sales
GROUP BY Territory
ORDER BY Total_Profit DESC;

/*
Question A3
Compare the total profit between these two territories in order for the territory manager,
Mr. Stone made a strategic decision that will aid profit maximization in 2020.*/

SELECT countries, SUM(profit) AS TotalProfit
FROM Sales
WHERE years IN ('2019')
GROUP BY countries
ORDER BY totalprofit DESC
LIMIT 1;


--Question A4
--Help him find the year with the highest profit.
SELECT years, SUM(profit) AS TotalProfit
FROM Sales
GROUP BY years
ORDER BY totalprofit DESC
LIMIT 1;

--Question A5
--Which month in the three years was the least profit generated?
SELECT months, SUM(profit) AS TotalProfit
FROM Sales
WHERE years IN ('2019','2018','2017')
GROUP BY months
ORDER BY totalprofit ASC
LIMIT 1;

--Question A5

SELECT months, SUM(profit) AS TotalProfit
FROM Sales
WHERE years IN ('2019','2018','2017')
GROUP BY months
ORDER BY totalprofit ASC
LIMIT 1;

--Question A6
--What was the minimum profit in the month of December 2018?
SELECT MIN(profit) AS Minimum_Profit_In_December
FROM Sales
WHERE years IN ('2018') AND months IN ('December') ;


--Question A7
--7. Compare the profit in percentage for each of the month in 2019
SELECT months, ((SUM(profit) * 100)/(SELECT SUM(profit)
FROM sales
WHERE years IN ('2019'))) AS Percentage_Profit
FROM Sales
WHERE years IN ('2019')
GROUP BY months
ORDER BY Percentage_Profit DESC;

--Question A8
--Which particular brand generated the highest profit in Senegal?
SELECT brands, SUM(profit) AS totalprofit
FROM Sales
WHERE countries IN ('Senegal') 
GROUP BY brands
ORDER BY totalprofit DESC
LIMIT 1;

---Question B1
/*Within the last two years, the brand manager wants to know the top three brands
consumed in the francophone countries*/
SELECT brands, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE years IN ('2019','2018') AND countries IN ('Senegal', 'Benin','Togo')
GROUP BY brands
ORDER BY TotalQuantity DESC
LIMIT 3;

---Question B2
-- Find out the top two choice of consumer brands in Ghana
SELECT brands, SUM(quantity) AS TotalProfit
FROM Sales
WHERE countries IN ('Ghana')
GROUP BY brands
ORDER BY totalprofit DESC
LIMIT 2;

--Question B3
/*Find out the details of beers consumed in the past three years in the most oil reached
country in West Africa.*/
SELECT brands, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE countries IN ('Nigeria') AND brands NOT LIKE '%malt%'
AND years IN ('2019','2018','2017')
GROUP BY brands
ORDER BY TotalQuantity DESC;


--Question B4
/*Favorites malt brand in Anglophone region between 2018 and 2019*/

SELECT brands, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE countries IN ('Nigeria','Ghana') AND brands LIKE '%malt%'
AND years IN ('2019','2018')
GROUP BY brands
ORDER BY totalquantity DESC;

--Question B5
--Which brands sold the highest in 2019 in Nigeria?

SELECT brands, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE countries IN ('Nigeria')
AND years IN ('2019')
GROUP BY brands
ORDER BY totalquantity DESC
LIMIT 1;


--Question B6
--Favorites brand in South_South region in Nigeria

SELECT brands, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE countries IN ('Nigeria')
AND region IN ('southsouth')
GROUP BY brands
ORDER BY totalquantity DESC
LIMIT 1;

--Question B7
--Bear consumption in Nigeria

SELECT brands, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE countries IN ('Nigeria') AND brands NOT LIKE '%malt%'
GROUP BY brands
ORDER BY totalquantity DESC;

--Question B8
--Level of consumption of Budweiser in the regions in Nigeria
SELECT region, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE countries IN ('Nigeria') AND brands IN ('budweiser')
GROUP BY region
ORDER BY totalquantity DESC;

--Question B9
--Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
SELECT region, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE countries IN ('Nigeria') AND brands IN ('budweiser')
AND years IN ('2019')
GROUP BY region
ORDER BY totalquantity DESC;

--Question C1
--Country with the highest consumption of beer.
SELECT countries, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE brands NOT LIKE '%malt%'
GROUP BY countries
ORDER BY totalquantity DESC
LIMIT 1;

--Question C2
--Highest sales personnel of Budweiser in Senegal
SELECT sales_rep, SUM(quantity) AS TotalQuantity
FROM Sales
WHERE countries IN('Senegal') AND brands IN ('budweiser')
GROUP BY sales_rep
ORDER BY totalquantity DESC
LIMIT 1;


--Question C3
--Country with the highest profit of the fourth quarter in 2019
SELECT countries, SUM(profit) AS TotalProfit
FROM Sales
WHERE months IN('October','November','December')
AND years IN ('2019')
GROUP BY countries
ORDER BY totalprofit DESC
LIMIT 1;








