-- Calculate the total revenue generated from pizza sales.
SELECT 
   round(SUM(order_details.quantity * pizzas.price),2)
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;