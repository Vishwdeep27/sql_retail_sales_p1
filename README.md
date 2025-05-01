# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis
**Level**: Beginner
**Database**: p1_retail_db

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named p1_retail_db.
- **Table Creation**: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

create database if not exists sql_project_p1;
use sql_project_p1;

```sql
drop table if exists retail_sales;
create table retail_sales (
	transactions_id int primary key,	
    sale_date date,
    sale_time time,
    customer_id	int,
    gender	varchar(50),
    age	int,
    category varchar(15),	
    quantiy	int,
    price_per_unit	float,
    cogs float,
    total_sale float
);
```
### 2. Data Exploration & Cleaning

```sql
select count(*) as total_sale from retail_sales.turitorial_csv;
select count(distinct customer_id) as total_sale from retail_sales.turitorial_csv;
select count(distinct category) as total_sale from retail_sales.turitorial_csv;

select * from retail_sales.turitorial_csv
where transactions_id is null
	  or
      sale_date is null
      or
      sale_time is null
      or 
      gender is null
      or 
      category is null
      or 
      quantiy is null
      or
      cogs is null
      or
      total_sale is null;
```
### 3. Data Analysis & Findings

The following SQL quaries were developed to answer specific business question:

1. **Write a SQL query to retreieve all columns for sales made on '2022-11-05'**
```sql
select * from retail_sales.turitorial_csv
where sale_date = '05-11-2022';
```

2. **Write a SQL query to retrieve all transaction where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022**
```sql
SELECT * 
FROM retail_sales.turitorial_csv
WHERE category = 'Clothing'
  AND quantiy > 2
  AND DATE_FORMAT(sale_date, '%m-%Y') = '11-2022';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**
```sql
select category, 
       sum(total_sale) as total_sales,
       count(*) as total_order
from retail_sales.turitorial_csv
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```sql
select round(avg(age),0) as age_of_customers
from retail_sales.turitorial_csv
where category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**
```sql
select transactions_id, total_sale
from retail_sales.turitorial_csv
where total_sale > '1000';
```

6. **Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.**
```sql
select category, gender, count(transactions_id)
from retail_sales.turitorial_csv
group by category, gender
order by 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**                          
```sql
select 
       sale_year,
       sale_month,
       avg_monthly_sales,
       ranks
from (
SELECT 
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    AVG(total_sale) AS avg_monthly_sales,
    rank() over(partition by YEAR(sale_date) order by AVG(total_sale) desc) as ranks
FROM retail_sales.turitorial_csv 
GROUP BY 1,2 
) as t1
where ranks = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest tatal sales**
```sql
select customer_id, sum(total_sale) as total_sales
from retail_sales.turitorial_csv
group by 1
order by 2 desc
limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category**
```sql
select category, count(distinct customer_id) as unique_customers
from retail_sales.turitorial_csv
group by 1;
```

10. **Write a SQL query to create each shift and number of orders (example Morning <=12, Afternon Between 12 & 17, Evening > 17)**
```sql
select *,
     case
         when hour(sale_time) < 12 then 'Morning'
         when hour(sale_time) between 12 and 17 then 'Afternoon'
         else 'Evening'
	end as shift
from retail_sales.turitorial_csv;
```
### Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
