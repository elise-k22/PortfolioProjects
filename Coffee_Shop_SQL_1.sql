SELECT TOP (1000) [transaction_id]
      ,[transaction_date]
      ,[transaction_time]
      ,[transaction_qty]
      ,[store_id]
      ,[store_location]
      ,[product_id]
      ,[unit_price]
      ,[product_category]
      ,[product_type]
      ,[product_detail]
  FROM [Portfolio].[dbo].[coffee_shop_sales]


-- Which product produces the most sales?

SELECT product_type, SUM(transaction_qty * unit_price) as total_sales
FROM coffee_shop_sales
GROUP BY product_type
ORDER BY total_sales DESC;


-- Calculate the sales per day for sales trend visualization

SELECT transaction_date, SUM(transaction_qty * unit_price) as sales_per_day
FROM coffee_shop_sales
GROUP BY transaction_date
ORDER BY transaction_date ASC;


-- Which products are sold the most and the least often?

SELECT COUNT(product_type) as quantity_sold, product_type
FROM coffee_shop_sales
GROUP BY product_type
ORDER BY quantity_sold DESC;


-- Which dates of the week tend to be busiest? Find the days of the week by numerical date and add column to do further exploration.

Select transaction_date, DATENAME(Weekday, transaction_date) AS week_day 
From coffee_shop_sales

ALTER TABLE coffee_shop_sales
Add day_of_week NVARCHAR(255);

Update coffee_shop_sales
SET day_of_week = DATENAME(Weekday, transaction_date)

WITH coffee_cte AS
(SELECT day_of_week, SUM(transaction_qty * unit_price) as sales_per_day
FROM coffee_shop_sales
GROUP BY day_of_week
)
SELECT day_of_week, sales_per_day
FROM coffee_cte
ORDER BY sales_per_day DESC


-- Which shop does the best in sales?

SELECT store_id, SUM(transaction_qty * unit_price) as total_sales
FROM coffee_shop_sales
GROUP BY store_id
ORDER BY total_sales DESC;