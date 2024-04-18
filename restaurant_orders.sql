use restaurant_db;

/*Objective 1 - Exploring the items table*/

-- view the menu_items table
select * 
from menu_items;

-- Number of items on the menu
select count(item_name) as number_of_items
from menu_items; 

-- Least and most expensive items on the menu
-- least expensive
select * 
from menu_items
order by price;

-- Most Expensive
select * 
from menu_items
order by price desc;

-- Number of Italian dishes on the menu
select count(*)
from menu_items
where category = "Italian";

-- Least and most expensive Italian dishes on the menu
-- least expensive
select * 
from menu_items
where category = "Italian"
order by price;

select * 
from menu_items
order by price;


-- most expensive
select * 
from menu_items
where category = "Italian"
order by price desc;

select * 
from menu_items
order by price desc;

-- Number of dishes in each category
select category,count(item_name) as number_of_dishes
from menu_items
group by category;

-- Average dish price within each category
select category, avg(price) as avg_dish_price
from menu_items
group by category;


/*Objective 2 - Exploring orders table */

-- view the order_details table
select *
from order_details;

-- date range of the table

select *
from order_details
order by order_date;

-- or

select min(order_date), max(order_date)
from order_details;

-- Number of orders made within this range

select count( distinct order_id)
from order_details;

-- number of items ordered within this date range

select count(*)
from order_details;

-- orders that had the most number of items

select order_id,count(item_id) as num_items 
from order_details
group by order_id
order by num_items desc;

-- orders that had more than 12 items

select count(*)
from
(select order_id,count(item_id) as num_items 
from order_details
group by order_id
having num_items>12 )as num_orders;

/*Objective 3- Analyze Customer behavior*/

-- join menu_items and order_details table 

select * 
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id;

-- least and most ordered items and their categories
-- least ordered
select item_name, category, count(order_details_id) as num_purchases
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
group by item_name, category
order by num_purchases;

-- most ordered 
select item_name, category, count(order_details_id) as num_purchases
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
group by item_name, category
order by num_purchases desc;

-- top 5 orders that spend the most money

select order_id, sum(price) as total_spend
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
group by order_id
order by total_spend desc
limit 5;


-- view the details of the highest spend orders

select category, count(item_id) as num_items
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
where order_id = 440
group by category;


-- view the details of top 5 highest spend orders

select order_id, category, count(item_id) as num_items
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
where order_id in (440, 2075, 1957, 330, 2675)
group by order_id, category;