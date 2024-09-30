-- Retrieve the total number of orders placedu\ 
 Select Count(order_id) from orders;
 
 
 
 -- Calculate the total revenue generated from pizza sales.
 SELECT 
    ROUND(SUM(order_details.quantity * pipizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pipizzas ON pipizzas.pizza_id = order_details.pizza_id;
    
--  Identify the highest-priced pizza.
SELECT 
    pipizza_types.name, pipizzas.price
FROM
    pipizza_types
        JOIN
    pipizzas ON pipizza_types.pizza_type_id = pipizzas.pizza_type_id
ORDER BY pipizzas.price DESC
LIMIT 1;


-- Identify the most common pizza size ordered.
 select quantity, count(order_details_id)
 from order_details group by quantity;
 
 
 -- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pipizzas.size, COUNT(order_details.order_details_id)
FROM
    pipizzas
        JOIN
    order_details ON pipizzas.pizza_id = order_details.pizza_id
GROUP BY pipizzas.size;


-- Join the necessary tables to find the total quantity of each pizza ordered.
SELECT 
    pipizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pipizza_types
        JOIN
    pipizzas ON pipizza_types.pizza_type_id = pipizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pipizzas.pizza_id
GROUP BY pipizza_types.name
ORDER BY quantity DESC
LIMIT 5;
 
 -- Join the necessary tables to find the total quantity of each pizza category ordered.
 SELECT 
    pipizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pipizza_types
        JOIN
    pipizzas ON pipizza_types.pizza_type_id = pipizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pipizzas.pizza_id
GROUP BY pipizza_types.category
ORDER BY quantity DESC;
 
 
 -- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time), COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name)
FROM
    pipizza_types
GROUP BY category;


-- Group the orders by date and calculate the average number of pizzas ordered per day. 
SELECT 
    ROUND(AVG(quantity), 0) AS Avg_orders_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
    
    
-- Determine the top 3 most ordered pizza types based on revenue. 
SELECT 
    pipizza_types.name,
    SUM(order_details.quantity * pipizzas.price) AS revenue
FROM
    pipizza_types
        JOIN
    pipizzas ON pipizzas.pizza_type_id = pipizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pipizzas.pizza_id
GROUP BY pipizza_types.name
ORDER BY revenue DESC
LIMIT 3;


-- Calculate the percentage contribution of each pizza type to total revenue.

-- Analyze the cumulative revenue generated over time.
select order_date, sum(revenue) over (order by order_date) as cum_revenue
from
(select orders.order_date,
sum(order_details.quantity * pipizzas.price) as revenue
from order_details join pipizzas
on order_details.pizza_id = pipizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

 
 