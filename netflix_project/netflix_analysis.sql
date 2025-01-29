CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);


-- Business Problems and Solutions


-- 1. Count the Number of Movies vs TV Shows

SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1;


-- 2. Find the Most Common Rating for Movies and TV Shows


SELECT
	type,
	rating
FROM
	(SELECT type,rating,count(*),rank() over (partition by type order by count(*) desc) 
	AS ranking from netflix group by 1 ,2)
AS t1 where ranking=1;


-- 3. List All Movies Released in a Specific Year (e.g., 2020)


SELECT * FROM netflix
where 
	type='Movie'
	and 
	release_year=2020;


-- 4. Find the Top 5 Countries with the Most Content on Netflix


SELECT
	UNNEST (STRING_TO_ARRAY(country,',')) as new_country ,
	COUNT(*) as total_Content 
FROM netflix 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- 5. Identify the Longest Movie


SELECT * FROM netflix 
where 
	type='Movie' 
	and
	duration=(select Max(duration) from netflix);


-- 6. Find Content Added in the Last 5 Years


SELECT * from netflix
where 
	TO_DATE(date_added,'Month DD,yyyy')>=CURRENT_DATE - INTERVAL '5 YEARS';


-- 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'


SELECT * FROM netflix
where 
	director ilike '%Rajiv Chilaka%';


-- 8. List All TV Shows with More Than 5 Seasons


SELECT * FROM netflix
where 
	type='TV Show' 
	and 
	split_part(duration,' ',1)::numeric >5;


9. Count the Number of Content Items in Each Genre


SELECT
	UNNEST(string_to_array(listed_in,',')) as Genre,
	count(show_id)
from netflix
group by 1


-- 10.Find each year and the average numbers of content release in India on netflix.
-- return top 5 year with highest avg content release!


SELECT
	extract(year from to_Date(date_added,'Month DD,YYYY')) as year,
	count(*) as yearly_content,
	Round(count(*)::numeric/(select count(*) from netflix where country='India')::numeric*100,2) as avg_content
FROM netflix
where country='India'
GROUP BY 1 
ORDER BY avg_content desc limit 5;


-- 11. List All Movies that are Documentaries


Select * from netflix
where listed_in ilike '%Documentaries%';


12. Find All Content Without a Director


SELECT * FROM netflix 
where 
director is null;


-- 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years


SELECT * 
FROM netflix
WHERE casts iLIKE '%Salman Khan%'
  AND 
release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;


14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India


SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;
