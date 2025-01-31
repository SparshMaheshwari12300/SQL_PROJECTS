-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name, sum(order_details.quantity*pizzas.price) as revenue
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
    group by pizza_types.name order by revenue desc limit 3;