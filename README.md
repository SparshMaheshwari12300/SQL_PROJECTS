# SQL_PROJECTS
Contains all my SQL Projects
<hr/> 
1. PIZZA SALES:-

https://github.com/user-attachments/assets/79d62221-44a9-4d5d-8ed3-2562c7e20293

PROJECT OVERVIEW:-

This project provides an in-depth analysis of pizza sales for a fictitious pizza store using SQL queries. It demonstrates how to derive critical business insights from transactional data related to orders, pizzas, and their categories. The purpose of this project is to analyze key metrics such as total revenue, popular pizza types, order trends, and category-based revenue distribution, enabling data-driven decision-making to improve sales strategies.

Let us consider a Example:-

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category, name, revenue
from (
    select pizza_types.category, pizza_types.name,
           sum(order_details.quantity * pizzas.price) as revenue,
           rank() over (partition by pizza_types.category order by sum(order_details.quantity * pizzas.price) desc) as rn
    from pizza_types
    join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
    join order_details on order_details.pizza_id = pizzas.pizza_id
    group by pizza_types.category, pizza_types.name
) as ranked_sales
where rn <= 3;

This SQL query identifies the top 3 most ordered pizza types based on revenue within each pizza category. It uses window functions with rank() to partition the data by category, ordering by revenue in descending order. The query demonstrates efficient data grouping and ranking to derive valuable sales insights for category-wise pizza performance analysis.

CONCLUSION:-

This project showcases advanced SQL techniques applied to real-world business scenarios. It highlights the power of data-driven decision-making for sales analytics and offers a robust foundation for more complex
analytical solutions in the future. The queries presented can be extended to generate dashboards or reports, offering valuable insights for business growth.


<hr/> 
2. NETFLIX ANALYSIS:-

https://github.com/user-attachments/assets/4c3498b3-63fd-49cd-8526-b29caeff0f91

PROJECT OVERVIEW:-

This project analyzes Netflix content using PostgreSQL. The dataset includes movies and TV shows with attributes like title, director, cast, country, release year, duration, and more. The analysis covers various business insights, such as content distribution, most common ratings, top countries with the most content, and trends over the years. The goal is to derive meaningful insights from the dataset to understand Netflix's content trends better.

Let us consider a Example:-

-- Find the Most Common Rating for Movies and TV Shows

SELECT
    type,
    rating
FROM
    (SELECT type, rating, count(*), rank() OVER (PARTITION BY type ORDER BY count(*) DESC)
    AS ranking FROM netflix GROUP BY 1, 2)
AS t1 WHERE ranking = 1;

1.The query finds the most common rating for Movies and TV Shows.

2.It first groups the dataset by type (Movie/TV Show) and rating, counting occurrences.

3.The RANK() function assigns a ranking based on the highest count within each type.

4.The outer query filters for the most common rating (ranking = 1).

CONCLUSION:-

1.The Netflix dataset provides valuable insights into content distribution across different categories. The analysis highlights:

2.The number of Movies vs. TV Shows.

3.Most common ratings for content.

4.Top content-producing countries.

5.The longest movie and TV shows with more than 5 seasons.

6.Trends in content addition over the years.

This project helps in understanding Netflix's content strategy, identifying popular genres, and assessing the influence of directors and actors in different regions.

