
-- Determine the distribution of orders by hour of the day.
use project;
show tables;
select * from orders;
select hour(order_time) ,count(order_id) from orders group by  hour(order_time);