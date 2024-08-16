-- BÀI 1
SELECT 
  SUM(CASE WHEN device_type = 'LAPTOP' THEN 1 ELSE 0 END) AS LAPTOP_VIEWS, 
  SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS MOBILE_VIEWS 
FROM viewership;
-- BÀI 2
select x,y,z,
case 
when x<0 and y<0 and z<0 then 'No'
when x=y and y=z then 'Yes'
when (x+y)>z and x+z>y and z+y>x  then 'Yes'
else 'No' end as 'triangle'
from Triangle
-- BÀI 3
SELECT
  ROUND(100.0 *SUM(CASE WHEN call_category IS NULL OR call_category = 'n/a' THEN 1
    ELSE 0
     END)/COUNT(*), 1) AS kpl_calls
FROM callers
-- BÀI 4
select name
from Customer
where coalesce(referee_id,'') != 2
-- BÀI 5
SELECT
    survived,
    sum(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
    sum(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
    sum(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM TITANIC
GROUP BY SURVIVED
