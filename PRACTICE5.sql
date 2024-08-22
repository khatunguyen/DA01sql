-- Bài 1 --
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) --floor: hàm làm tròn xuống; ceiling: làm tròn lên --
FROM CITY JOIN COUNTRY 
ON CITY.CountryCode = COUNTRY.Code 
GROUP BY COUNTRY.Continent;
-- Bài 2 
SELECT (ROUND(COUNT(texts.email_id)::DECIMAL
    /COUNT(DISTINCT emails.email_id),2)) AS activation
FROM emails
LEFT JOIN texts
ON emails.email_id = texts.email_id
AND signup_action='Confirmed'
-- Bài 3
SELECT 
  age.age_bucket, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'send')/
    SUM(activities.time_spent),2) AS send_percent, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'open')/
    SUM(activities.time_spent),2) AS open_percent
FROM activities
INNER JOIN age_breakdown AS age 
  ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket;
-- BÀI 4
SELECT CUSTOMER_ID
FROM customer_contracts
INNER JOIN PRODUCTS
ON customer_contracts.PRODUCT_ID=PRODUCTS.PRODUCT_ID
GROUP BY CUSTOMER_ID
HAVING COUNT(DISTINCT products.product_category) = 3;
-- BÀI 5 
SELECT E1.Employee_id, E1.name, COUNT(E2.EMPLOYEE_ID) AS reports_count, round(avg(E2.age)) AS average_age
FROM EMPLOYEES as E1
INNER JOIN EMPLOYEES AS E2
ON E1.Employee_id= E2.reports_to
GROUP BY E1.EMPLOYEE_ID
ORDER BY E1.EMPLOYEE_ID
-- BÀI 6
