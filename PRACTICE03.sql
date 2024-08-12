-- BÀI 1
SELECT NAME 
FROM STUDENTS 
WHERE MARKS > 75
ORDER BY RIGHT(NAME, 3), ID ASC
-- BÀI 2
SELECT USER_ID, 
CONCAT(UPPER(LEFT(NAME,1)),LOWER(RIGHT(NAME,LENGTH(NAME)-1))) AS NAME
FROM USERS
ORDER BY USER_ID
-- BÀI 3
SELECT manufacturer, 
CONCAT( '$', ROUND(SUM(total_sales) / 1000000), ' million') AS sales 
FROM pharmacy_sales 
GROUP BY manufacturer 
ORDER BY SUM(total_sales) DESC, manufacturer;
-- BÀI 4
SELECT EXTRACT(MONTH FROM submit_date) AS MONTH_REVIEW,
  product_id,
  ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY 
EXTRACT(MONTH FROM submit_date), product_id
ORDER BY MONTH_REVIEW, product_id;
-- BÀI 5
SELECT sender_id,COUNT(message_id) AS count_messages
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = '8'
  AND EXTRACT(YEAR FROM sent_date) = '2022'
GROUP BY sender_id
ORDER BY count_messages DESC
LIMIT 2; 
-- BÀI 6
SELECT TWEET_ID FROM TWEETS
WHERE LENGTH(CONTENT)>15
-- BÀI 7
-- BÀI 8
select 
count(id) as number_of_employee
from employees
where extract(month from joining_date)between 1 and 7
and extract (year from joining_date)=2022
-- BÀI 9
SELECT
POSITION('a' IN FIRST_NAME) AS NAMEE
FROM WORKER
WHERE FIRST_NAME='Amitah'
-- BÀI 10
SELECT SUBSTRING (TITLE, LENGTH (WINERY)+2,4)
FROM WINEMAG_P2
WHERE COUNTRY='Macedonia'
