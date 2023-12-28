-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

--CREATE SALES TABLE
DROP TABLE IF EXISTS danny_dinner;
CREATE TABLE IF NOT EXISTS sales(
	customer_id varchar(1) not null,
	order_date date not null,
	product_id smallint not null
)


--INSERT VALUES INTO SALES TABLE
insert into 
sales(
customer_id, 
order_date, 
product_id
)

values
('A', '2021-01-01', 1),
('A', '2021-01-01', 2),
('A', '2021-01-07', 2),
('A', '2021-01-10', 3),
('A', '2021-01-11', 3),
('A', '2021-01-11', 3),
('B', '2021-01-01', 2),
('B', '2021-01-02', 2),
('B', '2021-01-04', 1),
('B', '2021-01-11', 1),
('B', '2021-02-01', 3),
('C', '2021-01-01', 3),
('C', '2021-01-01', 3),
('C', '2021-01-07', 3)

RETURNING *;


-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

--CREATE MENU TABLES
CREATE TABLE IF NOT EXISTS menu(
	
product_id INT NOT NULL , 
product_name VARCHAR NOT NULL , 
price INT NOT NULL

)

--INSERT VALUES INTO MENU TABLE
INSERT INT0 MENU(
product_id, product_name, price
)
VALUES
(1, 'Sushi', 10),
(2, 'Curry', 15),
(3, 'Ramen', 12)

RETURNING *;

-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
--CREATE MEMBERS TABLE
CREATE TABLE IF NOT EXISTS members(
	customer_id varchar,
	join_date date
)
--INSERT VALUES INTO MEMBERS TABLE
INSERT INTO 
members(
	customer_id,
	join_date
)
VALUES
('A', '2021-01-07'),
('B', '2021-01-09')
RETURNING *;


-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

--COMBINE TABLES
CREATE TABLE combined_table as
select * from sales
LEFT JOIN members using(customer_id)
LEFT JOIN menu using(product_id)
order by sales.customer_id


-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

--What is the total amount each customer spent at the restaurant?

select sum(price) from combined_table -- 174

-- How many days has each customer visited the restaurant?

select count(distinct(order_date)) FROM combined_table
where customer_id = 'A' --- A = 4 DAYS

select count (distinct(order_date)) from combined_table 
where customer_id = 'B' -- B = 5 days

select count (distinct(order_date)) from combined_table 
where customer_id = 'C' -- C = 2 days

--What was the first item from the menu purchased by each customer?

--Customer A 
select product_name, order_date from combined_table
where customer_id = 'A'
order by order_date asc
limit 1 -- Sushi

--Customer B
select product_name, order_date from combined_table
where customer_id = 'B'
order by order_date asc
limit 1 -- Curry

----Customer C
select product_name, order_date from combined_table
where customer_id = 'C'
order by order_date asc
limit 1 -- Ramen

--What is the most purchased item on the menu and how many times was it purchased by all customers?
select product_name, count(product_name) from combined_table
group by product_name
order by count(product_name) desc
limit 1 -- Ramen, 7 times.


--Which item was the most popular for each customer?

--Customer A 
select customer_id, product_name, count(product_name) from combined_table
where customer_id = 'A'
group by customer_id, product_name
order by count(product_name) desc
limit 1 -- Ramen
 
 
--Customer B

select customer_id, product_name, count(product_name) from combined_table
where customer_id = 'B'
group by customer_id, product_name
order by count(product_name) desc
limit 1 -- Curry

--Customer C

select customer_id, product_name, count(product_name) from combined_table
where customer_id = 'C'
group by customer_id, product_name
order by count(product_name) desc
limit 1 -- Ramen


--Which item was purchased first by the customer after they became a member?

--Customer A 
select customer_id, product_name, order_date, join_date from combined_table
where order_date > join_date and customer_id = 'A'
order by order_date asc
limit 1 -- Ramen


--Customer B
select customer_id, product_name, order_date, join_date from combined_table
where order_date > join_date and customer_id = 'B'
order by order_date asc
limit 1 -- Sushi

--Customer C
select customer_id, product_name, order_date, join_date from combined_table
where order_date > join_date and customer_id = 'C'
order by order_date asc
limit 1 -- No value for Customer C


-- Which item was purchased just before the customer became a member?

--Customer A 
select customer_id, product_name, order_date, join_date from combined_table
where order_date < join_date and customer_id = 'A'
order by order_date asc
limit 1 -- Sushi

--Customer B
select customer_id, product_name, order_date, join_date from combined_table
where order_date < join_date and customer_id = 'B'
order by order_date asc
limit 1 -- Curry

--Customer C
select customer_id, product_name, order_date, join_date from combined_table
where order_date < join_date and customer_id = 'C'
order by order_date asc
limit 1 -- No value for Customer C



--What is the total items and amount spent for each member before they became a member?

--Customer A
select  distinct customer_id, count(distinct product_name), sum(price) 
from combined_table 
where customer_id = 'A'
group by customer_id -- 3 Items and 76 dollars

--Customer B
select  distinct customer_id, count(distinct product_name), sum(price) 
from combined_table 
where customer_id = 'B'
group by customer_id -- 3 Items and 62 dollars

--Customer C
select  distinct customer_id, count(distinct product_name), sum(price) 
from combined_table 
where customer_id = 'C'
group by customer_id -- 1 Item and 36 dollars


-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier 
-- how many points would each customer have?

--Customer A
SELECT
    customer_id,
    product_name,
    price,
	
SUM(    
	CASE
        WHEN product_name = 'Ramen' THEN price * 10
        WHEN product_name = 'Curry' THEN price * 10
        WHEN product_name = 'Sushi' THEN price * 20
        ELSE price 
    END 
	)AS calculated_price
FROM
    combined_table
WHERE customer_id = 'A'
GROUP BY customer_id, product_name,price
ORDER BY
    customer_id; -- 860 points

--Customer B
SELECT
    customer_id,
    product_name,
    price,
	
SUM(    
	CASE
        WHEN product_name = 'Ramen' THEN price * 10
        WHEN product_name = 'Curry' THEN price * 10
        WHEN product_name = 'Sushi' THEN price * 20
        ELSE price 
    END 
	)AS calculated_price
FROM
    combined_table
WHERE customer_id = 'B'
GROUP BY customer_id, product_name,price
ORDER BY
    customer_id; -- 820 points


--Customer C
SELECT
    customer_id,
    product_name,
    price,
	
SUM(    
	CASE
        WHEN product_name = 'Ramen' THEN price * 10
        WHEN product_name = 'Curry' THEN price * 10
        WHEN product_name = 'Sushi' THEN price * 20
        ELSE price 
    END 
	)AS calculated_price
FROM
    combined_table
WHERE customer_id = 'C'
GROUP BY customer_id, product_name,price
ORDER BY
    customer_id; -- 360 points
	
-- In the first week after a customer joins the program (including their join date) 
--they earn 2x points on all items, not just sushi - 
--how many points do customer A and B have at the end of January?

--Customer A
select customer_id, product_name, 
	sum(
		case
			when product_name = 'Ramen' OR 
		         product_name = 'Curry' OR 
		         product_name = 'Sushi' 
		         then price * 20
			else price
		end
	)
	as calculated_price
from combined_table
where customer_id = 'A' and join_date > order_date
group by customer_id, product_name
order by customer_id -- 500 points


--customer B
select customer_id, product_name, 
	sum(
		case
			when product_name = 'Ramen' OR 
		         product_name = 'Curry' OR 
		         product_name = 'Sushi' 
		         then price * 20
			else price
		end
	)
	as calculated_price
from combined_table
where customer_id = 'B' and join_date > order_date
group by customer_id, product_name
order by customer_id -- 800 Points

select * from combined_table














