create database if not exists sql_project_p1;
use sql_project_p1;

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

select * from retail_sales.turitorial_csv
limit 10; 

select count(*) from retail_sales.turitorial_csv;

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
      
-- Data Exploration

-- How many sales we have?

select count(*) as total_sale from retail_sales.turitorial_csv;

-- How many unique customer we have?

select count(distinct customer_id) as total_sale from retail_sales.turitorial_csv;

select count(distinct category) as total_sale from retail_sales.turitorial_csv;

-- Data Analysis & Business key problems & Answers

-- Q.1 Write a SQL query to retreieve all columns for sales made on '2022-11-05'

select * from retail_sales.turitorial_csv
where sale_date = '05-11-2022';

-- Q.2 Write a SQL query to retrieve all transaction where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT * 
FROM retail_sales.turitorial_csv
WHERE category = 'Clothing'
  AND quantiy > 2
  AND DATE_FORMAT(sale_date, '%m-%Y') = '11-2022';
  
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category. 

select category, 
       sum(total_sale) as total_sales,
       count(*) as total_order
from retail_sales.turitorial_csv
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),0) as age_of_customers
from retail_sales.turitorial_csv
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000. 

select transactions_id, total_sale
from retail_sales.turitorial_csv
where total_sale > '1000';

-- Q.6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category. 

select category, gender, count(transactions_id)
from retail_sales.turitorial_csv
group by category, gender
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year                          imp

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

-- Q.8 Write a SQL query to find the top 5 customers based on the highest tatal sales

select customer_id, sum(total_sale) as total_sales
from retail_sales.turitorial_csv
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category
-- distinct is use to find the unique customer

select category, count(distinct customer_id) as unique_customers
from retail_sales.turitorial_csv
group by 1;

-- Q.10 Write a SQL query to create each shift and number of orders (example Morning <=12, Afternon Between 12 & 17, Evening > 17)

select *,
     case
         when hour(sale_time) < 12 then 'Morning'
         when hour(sale_time) between 12 and 17 then 'Afternoon'
         else 'Evening'
	end as shift
from retail_sales.turitorial_csv

-- End of project
