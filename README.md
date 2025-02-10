# Pizza-Sales-Analysis

# Project overview
**Title**: pizza sales analysis

**Leve**l: Beginner

**Database**: pizza	

# Dashboard link: 
https://app.powerbi.com/links/uPAnL-8gAk?ctid=51302999-bb18-4fba-98bf-3a7ab3f07f13&pbi_source=linkShare

# Objectives:
  Identify Best-Selling Pizzas – Determine which pizza types, sizes, and toppings generate the highest sales.
 Analyze Sales Trends – Understand peak sales hours, seasonal demand, and customer preferences.
  Optimize Pricing & Promotions – Assess the impact of discounts, combo deals, and pricing strategies on revenue.
  Improve Inventory Management – Reduce waste and ensure availability of high-demand ingredients.
  Enhance Customer Experience – Use insights to improve delivery times, menu offerings, and marketing strategies.
Project structure

### 1.Database Setup

•	**Database Creation**: The project starts by creating named `pizza`.

•	**Table Creation**: A table named `pizza_sales` is created to store the players data. The table structure includes
Columns for pizza_id, pizza_id, pizza_name_id, quantity, order_date, order_time, unit_price, total_price, pizza_size, pizza_category, pizza_ingredients, pizza_name.



```sql
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

```

## Data analysis and Exploration


SELECT * FROM pizza_sales;
# Total Revenue:
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;
Link: ![Image](https://github.com/user-attachments/assets/f77f1048-47ae-4f35-b6df-69f3a1793f86)

# Average Order Values:
SELECT SUM(total_price) / count(Distinct order_id) as Average_order_values FROM pizza_sales;

Link: ![Image](https://github.com/user-attachments/assets/edc44400-d09a-419c-8a89-8c755e6b93e3)

# Total Pizza Sold:
SELECT SUM(quantity) as Total_pizza_sold from pizza_sales;
Link: ![Image](https://github.com/user-attachments/assets/590b611f-517c-4af9-b0f8-57d04bb608c5)

# Total Orders:
SELECT COUNT(Distinct order_id) as Total_orders FROM pizza_sales;
Link: ![Image](https://github.com/user-attachments/assets/ba7119b4-5d3a-452b-bcf6-7167f0b464c7)

# Average Pizza Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS 
Avg_pizzas_per_order FROM pizza_sales;
Link: ![Image](https://github.com/user-attachments/assets/ca3949b1-0ae8-4362-be74-e98643beb0a0)


--# HourlyTrend For Total Pizzas Sold
SELECT DATEPART(HOUR, order_time) as order_hour, sum(quantity) as Total_pizza_sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR,order_time);
Link: ![Image](https://github.com/user-attachments/assets/4a16e1d0-b8b9-4495-856f-3766ff48fa31)

--# weeklyTrend For Total Order
SELECT DATEPART(ISO_WEEK, order_date) AS week_number, year(order_date) AS order_year,
COUNT(DISTINCT order_id) as Total_orders from pizza_sales
Group by DATEPART(ISO_WEEK, order_date), year(order_date)
order by DATEPART(ISO_WEEK, order_date), year(order_date);
link: ![Image](https://github.com/user-attachments/assets/57d7c88c-ebe0-4d87-83fe-c517fbc6e504)

#  Pizza Category Total Sales And Percentages
SELECT pizza_category, SUM(total_price) as Total_sales, SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1)
AS PTC from pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;
Link: ![Image](https://github.com/user-attachments/assets/c03d6882-4b11-4deb-91df-f2a65d2de084)








# Pizza Size Total Sales And Percentages

SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales,
CAST(SUM(total_price) * 100/ (SELECT SUM(total_price) FROM pizza_sales
WHERE DATEPART(quarter, order_date)= 1) AS DECIMAL(10,2)) AS PCT FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1 
GROUP BY pizza_size
ORDER BY PCT DESC;
Link: ![Image](https://github.com/user-attachments/assets/83e6a184-7dd3-4b3d-9ee6-90db03607ac0)




# Total Revenue Of Pizzas

SELECT TOP 5 pizza_name, sum(total_price) as Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_name ASC;
Link: ![Image](https://github.com/user-attachments/assets/f72101e4-a490-47db-bed5-1ed74e5e5719)


# Total Pizzas Sold
SELECT TOP 5 pizza_name, sum(quantity) as Total_pizzas_sold
FROM pizza_sales
WHERE MONTH(order_date) = 8
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC;
Link: ![Image](https://github.com/user-attachments/assets/fc6bcbc1-5019-43e5-9c1f-aa66c5ab90f5)


# Visualization
## Pizza Sales Dashboard Report 1
snapshot1:![Image](https://github.com/user-attachments/assets/1857010a-25ac-4d57-8d1c-672e62e2a000)
## Pizza Sales Dashboard Report 2

## snapshot2:![Image](https://github.com/user-attachments/assets/ca307663-0bd3-4eb8-bdff-c8abe876aaa6)

Publishing To Power BI
Link: ![Image](https://github.com/user-attachments/assets/26e01dcb-c203-47c6-ae87-e0e9cbeb1e0a)

A card visual was used to represent count of Total Revenue.

Link: ![Image](https://github.com/user-attachments/assets/ad9f50fd-01ee-4e0b-8377-0d1f14ac8f54)

 
A card visual was used to represent the count of Total Pizza Sold.
 Link: ![Image](https://github.com/user-attachments/assets/a9e09c39-efa3-4e27-8eb5-f479bb010b62)

A card visual was used to represent count of Total orders.
Link: ![Image](https://github.com/user-attachments/assets/cf7ada1c-5113-4530-993a-badaf0acb5c3)
 Creating a new column following DAX expression was write.
**Order Day**:
         Order Day = UPPER(LEFT(pizza_sales[Day Name],3))
**Order Month**:
         Order Month = UPPER(LEFT(pizza_sales[Month Name],3))

         
 
Following DAX expression was written to find Total Revenue.
          Total Revenue = SUM(pizza_sales[total_price])

Following DAX expression was written to find Total Orders.
             Total Orders = DISTINCTCOUNT(pizza_sales[order_id])
Following DAX expression was written to find Total Pizza Sold.
            Total Pizza Sold = SUM(pizza_sales[quantity])

# Conclusion
Pizza sales analysis reveals that pepperoni and large-sized pizzas are the top sellers, with peak sales during dinner hours and weekends. Combo deals and discounts boost revenue, while seasonal trends affect demand. Optimizing inventory, improving delivery efficiency, and offering loyalty programs can enhance sales and customer satisfaction.

**How to use**:

1.**clone the Repository**: Clone this project repository from GitHub.

2.**Set Up the Database**: Run the SQL scripts provided in the database_setup.sql file to create and populate the database.

3.**Run the Queries**: Use the SQL queries provided in the analysis_queries.sql file to perform your analysis.

4.**Explore and Modify**:Feel free to modify the queries to explore different aspect of the dataset or answer
Additional business questions
