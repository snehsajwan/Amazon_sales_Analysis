select * from amazondata;
use  amazon;
select count(*) from amazondata; #No. of rows

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'amazondata'; #column name



-- -Q1-What is the count of distinct cities in the dataset?
SELECT count(distinct City)
FROM amazondata; #3 count of distinct cities

-- -Q2-For each branch, what is the corresponding city?
SELECT distinct Branch, City
FROM amazondata
order by 1; 

-- -Q3-What is the count of distinct product lines in the dataset?
SELECT count(distinct Product_line)
FROM amazondata; # 6 distinct product lines

-- -Q4-Which payment method occurs most frequently?
select Payment, count(Payment) as Paymnet_count
from amazondata
group by Payment
order by Paymnet_count desc
limit 1; #Ewallet occurs most frequently

-- -Q5Which product line has the highest sales?
SELECT product_line, SUM(Quantity) AS quantity_of__sales
FROM amazondata
GROUP BY product_line
ORDER BY 2 desc; 
#Electronic accessories has the highest sales.

-- -Q6-How much revenue is generated each month?
select month_name, sum(Total) as revenue
from amazondata
group by 1; #Jan month generated most revenue

-- -Q7-In which month did the cost of goods sold reach its peak?
select * from amazondata;
select month_name, sum(Cogs) as Cost_of_good_sold
from amazondata
group by 1; #Jan month cost of goods sold reach its peak

-- -Q8-Which product line generated the highest revenue?
select * from amazondata;
select Product_line, sum(Total) as revenue
from amazondata
group by 1
order by 2 desc; 
#Food and Beverages generated the highest revenue

-- -Q9-In which city was the highest revenue recorded?
select * from amazondata;
select City, sum(Total) as revenue
from amazondata
group by 1
order by 2 desc; # Naypyitaw city was the highest revenue recorded

select Gender, sum(Total) as revenue
from amazondata
group by 1
order by 2 desc;
#female are generating more revenue to amazon

-- -Q10-Which product line incurred the highest Value Added Tax?
select * from amazondata;
select Product_line,sum(VAT)
from amazondata
group by 1
order by 2 desc; 
#Food and beverages incurred the highest Value Added Tax

-- -Q11-For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
select * from amazondata;
SELECT 
	product_line,
	ROUND(AVG(Total),2) AS avg_sales,
	(CASE
		WHEN avg(Total) > (SELECT AVG(Total) FROM amazondata) THEN "Good"
        ELSE "Bad"
	END) AS Criteria
FROM amazondata
GROUP BY product_line
ORDER BY avg_sales;

-- -Q12-Identify the branch that exceeded the average number of products sold.
SELECT Branch, SUM(Quantity) AS qnty
FROM amazondata
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM amazondata);

-- -Q13-Which product line is most frequently associated with each gender?
select Gender,Product_line,count(Gender) as frequency
from amazondata
group by 1,2
order by 1,frequency desc;

-- -Q14-Calculate the average rating for each product line.
select Product_line,avg(Rating) from amazondata
group by 1 
order by 2 desc; #Food and beverages has the highest average rating

-- -Q15-Count the sales occurrences for each time of day on every weekday.
select day_name as weekday,
hour(Time) as hour_of_day,
count(*) as sales_occurences 
from amazondata
group by 1,2
order by sales_occurences desc;

-- -Q16-Identify the customer type contributing the highest revenue.
select Customer_type,sum(Total) as revenue
from amazondata
group by 1; # Member contributing highest revenue

-- -Q17-Determine the city with the highest VAT percentage.
select City,sum(VAT)/ sum(Total)* 100 as vat_percentage
from amazondata
group by 1
order by 2 desc; #Mandalay highest VAT percentage

-- -Q18-Identify the customer type with the highest VAT payments.
select Customer_type,sum(VAT) AS total_VAT
from amazondata
group by 1
order by 2 desc;
# Member highest VAT payment

-- -Q19-What is the count of distinct customer types in the dataset?
select count(distinct Customer_type) as distinct_customer_type
from amazondata;

-- -Q20-What is the count of distinct payment methods in the dataset?
select count(distinct Payment) as distinct_Payment
from amazondata;

-- -Q21-Which customer type occurs most frequently?
select Customer_type,count(Customer_type) as frequency
from amazondata
group by 1
order by 2 desc; #Member occurs most frequently

-- -Q22-Identify the customer type with the highest purchase frequency.
select * from amazondata;
select Customer_type,count(Customer_type) as frequency
from amazondata
group by 1
order by 2 desc; #Member with the highest purchase

-- -Q23-Determine the predominant gender among customers.
select Gender,count(Gender) as gender_count
from amazondata
group by 1
order by 2 desc;
# Female purchase most

-- -Q24-Examine the distribution of genders within each branch.
select Gender,Branch,count(*) as Gender_count
from amazondata
group by 1,2
order by Gender_count desc;
#Most Male are in A branch,female are in C branch followed by others

-- -Q25-Identify the time of day when customers provide the most ratings.
select * from amazondata;
select time_of_day,count(Rating) as frequency_rating
from amazondata
group by 1
order by 2 desc;
#Evening customers provide the most ratings

-- -Q26-Determine the time of day with the highest customer ratings for each branch.
select Branch,time_of_day,count(Rating) as frequency_rating
from amazondata
group by 1,2
order by 1 ;
#Each Branch A,B,C highest customer rating is in the Evening

-- -Q27-Identify the day of the week with the highest average ratings.
select day_name,avg(Rating) as avg_rating
from amazondata
group by 1
order by 2 desc ;
#MONDAY is the highest average rating

-- -Q28-Determine the day of the week with the highest average ratings for each branch.
with branch_high_rating as
(select Branch,day_name,avg(Rating) as avg_rating,
rank() over (partition by Branch order by avg(Rating) desc) as rank_num
from amazondata
group by 1,2)
select Branch,day_name,avg_rating
from branch_high_rating;
#branch-B ,day monday highest average ratings.

-- -INSIGHTS FROM THE AMAZON DB

# 1 Product Analysis

6 distinct product lines
-- -Female are most frequently buying from	Fashion accessories 
Female are not frequently buying from Health and beauty 

-- -Male are most frequently buying from Health and beauty	
Male are not frequently buying from Sports and travel 

-- -Product line Food and beverages were mostly purchased from Naypyitaw city,branch C
Product line Sports and travel were mostly purchased from Mandalay city,branch B
Product line Fashion accessories were mostly purchased from Yangon city,branch A
Product line Fashion accessories were mostly purchased from Naypyitaw city
Product line Electronic accessories were mostly purchased from Yangon city


 # 2 Sales Analysis

Food and beverages perforing best with heighest revenue= 56144.844000000005
Health and beauty needs to be improved ,they have the lowest revenue= 49193.739000000016

Electronic accessories has the highest no. of sales 971, followed by Food and beverages 952
lowest is Health and beauty	854
Naypyitaw city was the highest revenue record


# 3 customer analysis

Female are generating higher revenue to amazon	167882.92500000002 ,compare to male
Male are generating	155083.82400000014

Member contributing highest revenue and highest purchase
Evening customers provide the most ratings
