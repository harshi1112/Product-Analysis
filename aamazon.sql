/*To get overview of dataset*/
SELECT * FROM amazonn_data limit 10; 

/* Category Analysis*/
SELECT DISTINCT (category_2) from amazonn_data;
/*To get the top 10 selling sub category of category_2*/
SELECT category_2 , count(*) as product_count from amazonn_data group by category_2 
order by product_count desc limit 10; 

/* To get the top 10 selling category*/
SELECT category , count(*) as product_count from amazonn_data group by category 
order by product_count desc limit 10; 

/* To get the top 5 highest rated product from each category of category_2*/
SELECT* FROM(SELECT product_name , rating , category_2, ROW_NUMBER() OVER (PARTITION BY category_2 ORDER BY rating desc) as top_rated_prdct
from amazonn_data) AS a where a.top_rated_prdct<=5;

/* 10 highest rated product from category*/
select product_name,category ,rating from amazonn_data order by rating desc limit 10;

/*Rating Analysis*/
SELECT  category_2,
avg(rating) as avg_rating,
min(rating) as min_rating,
max(rating) as max_rating
from amazonn_data group by category_2;

/* Top 10 category of category_2 with max rating count*/
SELECT category_2,max(rating_count)
 from amazonn_data group by category_2 order by max(rating_count)desc limit 10;

/*Discount Analysis*/
/*Product count within each discount*/
SELECT discount_percentage,
COUNT(*)as product_count
from amazonn_data group by discount_percentage order by discount_percentage desc;

/*Find Products with Discounts Higher than the Average Discount*/
SELECT product_name, discount_percentage
FROM amazonn_data
WHERE discount_percentage > (
    SELECT AVG(discount_percentage) FROM amazonn_data
);

/*Product with maximum discount percentage*/
SELECT
    product_name,
    category,
    discount_percentage
FROM amazonn_data
ORDER BY discount_percentage DESC
LIMIT 1;

/*Average discount percentage for each category*/
SELECT category, AVG(discount_percentage) AS avg_discount_percentage
FROM amazonn_data
GROUP BY category;

/*average rating and the count of products sold at each discount percentage*/
SELECT 
    discount_percentage,
    AVG(rating) AS avg_rating,
    COUNT(*) AS product_count
FROM amazonn_data
GROUP BY discount_percentage
ORDER BY discount_percentage;


/*Pricing Analysis*/
/*To find products within given price range*/
SELECT product_name, actual_price,discount_price
FROM amazonn_data
WHERE actual_price BETWEEN 100 AND 500;

/*To check the product with max price*/
SELECT product_name ,actual_price,discount_price from amazonn_data 
where actual_price in (SELECT MAX(actual_price) from amazonn_data);

SELECT AVG(actual_price),AVG(discount_price) from amazonn_data;
SELECT AVG(actual_price)-AVG(discount_price) from amazonn_data;

/* Customer Segmentation*/
SELECT 
    CASE
        WHEN rating >= 4.5 THEN 'Highly Satisfied'
        WHEN rating >= 3.5 AND rating < 4.5 THEN 'Satisfied'
        ELSE 'Unsatisfied'
    END AS customer_segment,
    COUNT(*) AS customer_count
FROM amazonn_data
GROUP BY customer_segment;




