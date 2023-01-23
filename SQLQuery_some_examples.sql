-- 1. Product Sales
-- You need to create a report on whether customers who purchased the product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' buy the product below or not.

-- 1. 'Polk Audio - 50 W Woofer - Black' -- (other_product)

-- To generate this report, you are required to use the appropriate SQL Server Built-in functions or expressions as well as basic SQL knowledge.

select distinct c.customer_id, c.first_name, c.last_name,
	case when c.customer_id in (
				select c.customer_id
				from product.product p, sale.order_item oi, sale.orders o, sale.customer c
				where p.product_id = oi.product_id
					and
					oi.order_id = o.order_id
					and
					o.customer_id = c.customer_id
					and
					product_name = 'Polk Audio - 50 W Woofer - Black' )
	then 'yes' else 'no' end other_product
from product.product p, sale.order_item oi, sale.orders o, sale.customer c
where p.product_id = oi.product_id
	and
	oi.order_id = o.order_id
	and
	o.customer_id = c.customer_id
	and
	product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
order by customer_id

--2. Conversion Rate
--Below you see a table of the actions of customers visiting the website by clicking on two different types of advertisements given by an E-Commerce company. 
--Write a query to return the conversion rate for each Advertisement type.

-- a.    Create above table (Actions) and insert values,

CREATE TABLE ECommerce (
	Visitor_ID INT IDENTITY (1, 1) PRIMARY KEY,	
	Adv_Type VARCHAR (255) NOT NULL,	
	Action1 VARCHAR (255) NOT NULL);
INSERT INTO ECommerce (Adv_Type, Action1)VALUES
('A', 'Left'),('A', 'Order'),
('B', 'Left'),('A', 'Order'),
('A', 'Review'),('A', 'Left'),
('B', 'Left'),('B', 'Order'),
('B', 'Review'),('A', 'Review');

select * from ECommerce

-- b.Retrieve count of total Actions and Orders for each Advertisement Type,

create view t1 as 
select  Visitor_ID,
	case when Action1 = 'Order' then 'Order' else 'Action' end order_case
from ECommerce

select e.Adv_Type, t1.order_case, count(t1.order_case) total
from ECommerce e, t1
where e.Visitor_ID = t1.Visitor_ID
group by e.Adv_Type, t1.order_case
order by Adv_Type

--drop view t1

-- c.Calculate Orders (Conversion) rates for each Advertisement Type by dividing by total count of actions casting as float by multiplying by 1.0.







