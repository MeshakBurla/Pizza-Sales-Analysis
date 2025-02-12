CREATE DATABASE Pizza;

USE Pizza;

CREATE TABLE pizza_sales(
pizza_id INT,
order_id INT,
pizza_name_id varchar(80),
quantity int,
order_date DATE,
order_time TIME NOT NULL,
unit_price DECIMAL(10,2),
total_price decimal(10,2),
pizza_size NVARCHAR(80),
pizza_category NVARCHAR(80),
pizza_ingredients TEXT,
pizza_name NVARCHAR(80)
);


select * from pizza_sales;

SELECT sum(total_price) AS Total_Revenue FROM pizza_sales;

select sum(total_price) / count(Distinct order_id) as Average_order_values from pizza_sales;

select sum(quantity) as Total_pizza_sold from pizza_sales;

select count(Distinct order_id) as Total_orders from pizza_sales;

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
Avg_pizzas_per_order FROM pizza_sales;

--HourlyTrend For Total Pizzas Sold
SELECT DATEPART(HOUR, order_time) as order_hour, sum(quantity) as Total_pizza_sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR,order_time);

--weeklyTrend For Total Order

SELECT DATEPART(ISO_WEEK, order_date) AS week_number, year(order_date) AS order_year,
COUNT(DISTINCT order_id) as Total_orders from pizza_sales
Group by DATEPART(ISO_WEEK, order_date), year(order_date)
order by DATEPART(ISO_WEEK, order_date), year(order_date);

SELECT pizza_category, SUM(total_price) as Total_sales, SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1)
AS PTC from pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales,
CAST(SUM(total_price) * 100/ (SELECT SUM(total_price) FROM pizza_sales
WHERE DATEPART(quarter, order_date)= 1) AS DECIMAL(10,2)) AS PCT FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1 
GROUP BY pizza_size
ORDER BY PCT DESC;

SELECT TOP 5 pizza_name, sum(total_price) as Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_name ASC;

SELECT TOP 5 pizza_name, sum(quantity) as Total_pizzas_sold
FROM pizza_sales
WHERE MONTH(order_date) = 8
GROUP BY pizza_name
ORDER BY SUM(quantity) asc;



