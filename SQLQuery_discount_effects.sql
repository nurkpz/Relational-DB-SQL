-- Discount Effects
--Generate a report including product IDs and discount effects on whether the increase in the discount rate positively impacts the number of orders for the products.
--In this assignment, you are expected to generate a solution using SQL with a logical approach. 


with t1 as(
	select product_id, discount, sum(quantity) total_quantity
	from sale.order_item
	group by product_id, discount 
), t2 as(
	select *, 
		FIRST_VALUE(total_quantity) over(partition by product_id order by discount) first_quantity,
		LAST_VALUE(total_quantity) over(partition by product_id order by discount ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) last_quantity
	from t1
), t3 as(
	select distinct product_id, 
		1.0*(last_quantity - first_quantity) / first_quantity increase_value
	from t2
)
select product_id Product_id,
	case when increase_value >= 0.05 then 'Pozitive' 
		 when increase_value <= -0.05 then 'Negative'
		 else 'Neutral' end 'Discount Effect'
from t3




	