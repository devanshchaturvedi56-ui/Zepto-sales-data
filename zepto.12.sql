alter table zepto_v1
add column sku_id int primary key  AUTO_INCREMENT  not null;
rename TABLE `copy of zepto_v1`TO zepto_v1;
-- count of rows 
select count(*) as total_rows  from zepto_v1;
-- null values 
select * from zepto_v1
where name is null
or 
ï»¿Category is null
or 
name is null 
or 
mrp is null 
or 
discountPercent is null 
or  
availableQuantity is null 
or 
discountedSellingPrice is null 
or 
weightInGms is null 
or
outOfStock is null 
or 
quantity is null; 
SELECT DISTINCT ï»¿Category
FROM zepto_v1;
alter table zepto_v1 
rename column ï»¿Category to category;

-- different product categories 

 select distinct category 
 from zepto_v1 
 order by category;

-- product in stock vs out of stock 
SELECT outOfStock, COUNT(name) as total_product
FROM zepto_v1
GROUP BY outOfStock;

-- product names present multiple times 
select name ,count(sku_id)as "number ofskus"
from zepto_v1
group by name 
having count(sku_id) >1
order by count(sku_id)desc;

-- data cleaning 

-- products with price = 0 
select * from zepto_v1
where mrp = 0 or discountedSellingPrice=0;

delete FROM zepto_v1 
WHERE mrp = 0;

-- convert paise to repees 
update zepto_v1 
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;
select mrp , discountedSellingPrice from zepto_v1;


-- Q1. find the top 10 best- value product based on the discount percentage 

select distinct name ,mrp , discountPercent
from zepto_v1 
order by discountPercent desc
limit 10;

-- Q2. what are the product with high mrp but out of stock 
select  name, mrp ,outOfStock from zepto_v1
where outOfStock = 'true'
 order by mrp desc
 limit 1;
--  Q3 calculate estimated revenue for each category 
select category ,sum(discountedSellingPrice *availableQuantity)  as total_revinue 
from zepto_v1
group by category
order by total_revinue;

-- Q4. find all product where mrp is greater than 500 and discount is less then 10%
select distinct name  ,mrp ,discountPercent
from zepto_v1
where mrp >500 
and 
discountPercent < 10;

-- Q5 identify the top 5 categories offering the highest average discount percentage .

select category ,round(avg(discountPercent),2)as avg_discount 
from zepto_v1
group by category
order by avg_discount desc
limit 5;

-- Q6. find the price per gram for products above 100g and sort _by best value .

SELECT DISTINCT
    name,
    weightInGms,
    discountedSellingPrice,
    ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM
    zepto_v1
WHERE
    weightInGms > 100
ORDER BY price_per_gram;


