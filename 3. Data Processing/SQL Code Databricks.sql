select * 
from `datascience`.`case_study`.`bright_coffee_shop_new`;

--Running the entire table
SELECT *
FROM `datascience`.`case_study`.`bright_coffee_shop_new`;

--Checking date range
SELECT MIN(transaction_date) AS Earliest_date,
       MAX(transaction_date) AS Latest_date
FROM `datascience`.`case_study`.`bright_coffee_shop_new`;

--Checking the different store locations
SELECT DISTINCT store_location
FROM `datascience`.`case_study`.`bright_coffee_shop_new`;

-- Checking product type sold at our stores
SELECT DISTINCT product_type
FROM `datascience`.`case_study`.`bright_coffee_shop_new`;

--Checking product detail
SELECT DISTINCT product_detail
FROM `datascience`.`case_study`.`bright_coffee_shop_new`;

SELECT
COUNT(*) AS number_of_rows,
      COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores
 FROM `datascience`.`case_study`.`bright_coffee_shop_new`;

 -- Number of sales per store
 SELECT DISTINCT store_location,
      COUNT(DISTINCT transaction_id ) AS number_of_sales_per_store
 FROM `datascience`.`case_study`.`bright_coffee_shop_new`
 GROUP BY STORE_LOCATION;

---Checking for NULLS in various columns
SELECT *
FROM `datascience`.`case_study`.`bright_coffee_shop_new`
WHERE unit_price IS NULL
OR transaction_qty IS NULL
OR transaction_date IS NULL;

--Checking lowest and highest unit price
SELECT MIN (unit_price) AS Lowest_price,
       MAX (unit_price) AS Highest_price
FROM `datascience`.`case_study`.`bright_coffee_shop_new`;

--Extracting the day name and month name
SELECT transaction_date,
       DAYNAME(transaction_date) AS Day_name,
       MONTHNAME(transaction_date) AS Month_name
FROM `datascience`.`case_study`.`bright_coffee_shop_new`;

--Calculating the revenue(unit_price * transaction_qty)
SELECT unit_price,
       transaction_qty,
       unit_price*transaction_qty AS revenue
FROM `datascience`.`case_study`.`bright_coffee_shop_new`; 

---Combining functions to get a clean and enhanced data set
SELECT transaction_id,
       transaction_date,
       transaction_time,
       transaction_qty,
       store_id,
       store_location,
       product_id,
       unit_price,
       product_category,
       product_type,
       product_detail,
      
--Adding columns to enhance the table for better insights
       DAYNAME(transaction_date) AS Day_name,
       MONTHNAME(transaction_date) AS Month_name,
       DAYOFMONTH(transaction_date) AS Day_of_month,

--Calculating the revenue
     -- unit_price,
     -- transaction_qty. When I add these two lines of code, I will have duplicated columns
      
      unit_price*transaction_qty AS revenue,

---Case statement
case
WHEN DAYNAME(transaction_date) IN ('Sun', 'Sat') THEN 'Weekend'
     ELSE 'Weekday'
END AS Day_classification,

---Case statement (Time bucket)(Extracting time)
case
WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') BETWEEN '17:00:00' AND '21:59:59' THEN 'Evening'
     ELSE 'Night'
END AS Time_classification,

--Spend bucket
case
WHEN (transaction_qty*unit_price) <14 THEN 'Low spender'
WHEN  (transaction_qty*unit_price) BETWEEN '13'AND '23' THEN 'Medium spender'
     ELSE 'Big spender'
END AS Spend_bucket
FROM `datascience`.`case_study`.`bright_coffee_shop_new`;
