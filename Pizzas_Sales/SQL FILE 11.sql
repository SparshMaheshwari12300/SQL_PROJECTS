-- Calculate the percentage contribution of each pizza type to total revenue.
-- SELECT 
--     pizzas.pizza_type_id, sum(order_details.quantity*pizzas.price) as revenue
-- FROM
--     pizzas
--         JOIN
--     order_details ON order_details.pizza_id = pizzas.pizza_id
--     group by pizzas.pizza_type_id;
--     

SELECT 
    pizza_types.category, sum(order_details.quantity*pizzas.price)/(SELECT 
   round(SUM(order_details.quantity * pizzas.price),2)
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id)*100 as revenue
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
    group by pizza_types.category order by revenue desc;