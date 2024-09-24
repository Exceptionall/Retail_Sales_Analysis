SELECT * FROM retailsalesanalysis.`sql - retail sales analysis_utf`
LIMIT 10;

SELECT * FROM retailsalesanalysis.`sql - retail sales analysis_utf`
LIMIT 10;


SELECT 
    COUNT(*) 
FROM retailsalesanalysis.`sql - retail sales analysis_utf`;

-- Data cleaning
SELECT * 
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
WHERE ï»¿transactions_id IS NULL;

SELECT * 
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
WHERE sale_date IS NULL;

SELECT * 
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
WHERE sale_time IS NULL;

SELECT * 
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
WHERE 
    ï»¿transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
   
    -- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retailsalesanalysis.`sql - retail sales analysis_utf`;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retailsalesanalysis.`sql - retail sales analysis_utf`;

SELECT DISTINCT category FROM retailsalesanalysis.`sql - retail sales analysis_utf`;

-- Data Analysis & Business Key Problems & Answers
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05   
    
SELECT * 
FROM retailsalesanalysis.`sql - retail sales analysis_utf` 
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
WHERE 
    category = 'Clothing'
    AND 
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND
    quantiy >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retailsalesanalysis.`sql - retail sales analysis_utf`
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT year, month, avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retailsalesanalysis.`sql - retail sales analysis_utf`
    GROUP BY year, month
) AS t1
WHERE avg_sale = (
    SELECT MAX(avg_sale)
    FROM (
        SELECT 
            EXTRACT(YEAR FROM sale_date) AS year,
            EXTRACT(MONTH FROM sale_date) AS month,
            AVG(total_sale) AS avg_sale
        FROM retailsalesanalysis.`sql - retail sales analysis_utf`
        GROUP BY year, month
    ) AS t2
    WHERE t1.year = t2.year
);


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retailsalesanalysis.`sql - retail sales analysis_utf`
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;



    
    
    








