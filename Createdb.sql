create database amazon;
use  amazon;
CREATE TABLE amazon_data (
    invoice_id VARCHAR(30) PRIMARY KEY,
    branch VARCHAR(5),
    city VARCHAR(30),
    customer_type VARCHAR(30),
    gender VARCHAR(10),
    product_line VARCHAR(100),
    unit_price DECIMAL(10, 2),
    quantity INT,
    VAT FLOAT(6, 4),
    total DECIMAL(10, 2),
    date DATE,
    time TIME,
    payment_method varchar(100),
    cogs DECIMAL(10, 2),
    gross_margin_percentage FLOAT(11, 9),
    gross_income DECIMAL(10, 2),
    rating FLOAT(2, 1)
);
-- -Feature Engineering=
-- -Creating a new column
alter table amazondata add column time_of_day varchar(30);
alter table amazondata add column day_name varchar(30);
alter table amazondata add column month_name varchar(30);


select Time,
(case
    when hour(Time) >=0 and hour(Time) <12 then 'Morning'
    when hour(Time) < 16 then 'Afternoon'
	else 'Evening'
    end) as time_of_day
    from amazondata;
 
 update amazondata set time_of_day = (case
    when hour(Time) >=0 and hour(Time) <12 then 'Morning'
    when hour(Time) < 16 then 'Afternoon'
	else 'Evening'
    end);


update amazondata
set `Date` = str_to_date(`Date`, '%d-%m-%Y');
 
update amazondata
set day_name = upper(substring(DAYNAME(`Date`),1,3)); 

update amazondata
set month_name = upper(substring(MONTHNAME(`Date`),1,3));


ALTER TABLE amazondata
CHANGE COLUMN `Tax_5%` `VAT` FLOAT;

