select * from customer_shopping_behavior

select gender, SUM(purchase_amount) as revenue
from customer_shopping_behavior
group by gender

select customer_id, purchase_amount
from customer_shopping_behavior
where discount_applied='Yes' and purchase_amount>(select AVG(purchase_amount) from customer_shopping_behavior)

select item_purchased, ROUND(AVG(review_rating::numeric),1) as average_product_rating
from customer_shopping_behavior
group by item_purchased
order by avg(review_rating) desc
limit 5;

select shipping_type, round(avg(purchase_amount))
from customer_shopping_behavior
where shipping_type in ('Standard','Express')
group by shipping_type

select subscription_status,
count(customer_id) as total_customers,
round(avg(purchase_amount)) as avg_spend,
round(sum(purchase_amount)) as total_revenue
from customer_shopping_behavior
group by subscription_status
order by total_revenue, avg_spend desc;

select item_purchased,
round(100*sum(case when discount_applied='Yes' then 1 else 0 end)/count(*)) as discount_rate
from customer_shopping_behavior
group by item_purchased
order by discount_rate desc
limit 5;

with customer_type as(
select customer_id, previous_purchases,
case
	when previous_purchases=1 then 'New'
	when previous_purchases between 2 and 10 then 'Returning'
	else 'Loyal'
	end as customer_loyalty
from customer_shopping_behavior)
select customer_loyalty, count(*) as number_of_customers
from customer_type
group by customer_loyalty

select subscription_status,
count(customer_id) as repeat_buyers
from customer_shopping_behavior
where previous_purchases>5
group by subscription_status

select age_group,
sum(purchase_amount) as total_revenue
from customer_shopping_behavior
group by age_group
order by total_revenue desc;





