-- BÀI 1
SELECT COUNT(DISTINCT COMPANY_ID) AS DUPLICATE
FROM (SELECT COMPANY_ID, TITLE, DESCRIPTION, COUNT(JOB_ID) AS JOB_COUNT
FROM JOB_LISTINGS
GROUP BY COMPANY_ID, TITLE, DESCRIPTION) AS JOB_COUNT_HEHE
WHERE JOB_COUNT>1
-- BÀI 2 (giá trị thì ghi đúng chính tả, đúng định dạng viết hoa, viết thường giùm)
WITH CTE1 AS (
    SELECT CATEGORY, PRODUCT, 
        SUM(SPEND) AS TOTAL_SPEND
    FROM 
        PRODUCT_SPEND
    WHERE 
        EXTRACT(YEAR FROM TRANSACTION_DATE) = 2022
        AND CATEGORY = 'appliance'
    GROUP BY CATEGORY, PRODUCT
    ORDER BY TOTAL_SPEND DESC
    LIMIT 2
), 
CTE2 AS (
    SELECT CATEGORY, PRODUCT, 
        SUM(SPEND) AS TOTAL_SPEND
    FROM PRODUCT_SPEND
    WHERE 
        EXTRACT(YEAR FROM TRANSACTION_DATE) = 2022
        AND CATEGORY = 'electronics'
    GROUP BY CATEGORY, PRODUCT
    ORDER BY TOTAL_SPEND DESC
    LIMIT 2
)

SELECT * FROM CTE1
UNION ALL
SELECT * FROM CTE2;
-- BÀI 3
SELECT COUNT(DISTINCT POLICY_HOLDER_ID) AS policy_holder_count
FROM CALLERS
WHERE POLICY_HOLDER_ID IN (
    SELECT POLICY_HOLDER_ID
    FROM CALLERS
    GROUP BY POLICY_HOLDER_ID
    HAVING COUNT(POLICY_HOLDER_ID) >= 3
);
-- BÀI 4 (BÀI NÀY GIẢI RỒI)
SELECT PAGES.PAGE_ID
FROM PAGES
LEFT JOIN PAGE_LIKES
ON PAGES.PAGE_ID=PAGE_LIKES.PAGE_ID
WHERE PAGE_LIKES.PAGE_ID IS NULL
-- BÀI 5 
WITH CTE1 AS (
    SELECT DISTINCT USER_ID
    FROM USER_ACTIONS
    WHERE EXTRACT(MONTH FROM EVENT_DATE) < 7
), 
CTE2 AS (
    SELECT DISTINCT USER_ID
    FROM USER_ACTIONS
    WHERE EXTRACT(MONTH FROM EVENT_DATE) = 7
)
SELECT 7 AS mth, 
    COUNT(DISTINCT CTE1.USER_ID) AS monthly_active_users
FROM CTE1
JOIN CTE2 ON CTE1.USER_ID = CTE2.USER_ID;
-- BÀI 6
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month
    , country
    , COUNT(*) AS trans_count
    , SUM(IF(state = 'approved', 1, 0)) AS approved_count
    , SUM(amount) AS trans_total_amount
    , SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM Transactions
GROUP BY month, country
-- BÀI 7
SELECT product_id, year as first_year, quantity,price
FROM Sales
WHERE (product_id,year) in (
SELECT product_id,MIN(year)
FROM Sales
GROUP BY product_id
)
-- BÀI 8
/* Nhóm customer_id từ bảng CUSTOMER, đặt điều kiện là count distinct product_key của CUSTOMER = số product_key trong bảng PRODUCT)*/
SELECT CUSTOMER_ID 
FROM CUSTOMER
GROUP BY CUSTOMER_ID
HAVING COUNT(DISTINCT PRODUCT_KEY)=(SELECT COUNT(PRODUCT_KEY) FROM PRODUCT)
-- BÀI 9
/* DK1: SALARY <30K; DK2: manager_id not in employee_id (select)*/
SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE SALARY <30000
AND MANAGER_ID NOT IN  (SELECT EMPLOYEE_ID FROM EMPLOYEES)
ORDER BY EMPLOYEE_ID
-- BÀI 10 (trùng VỚI BÀI 1)
SELECT COUNT(DISTINCT COMPANY_ID) AS DUPLICATE
FROM (SELECT COMPANY_ID, TITLE, DESCRIPTION, COUNT(JOB_ID) AS JOB_COUNT
FROM JOB_LISTINGS
GROUP BY COMPANY_ID, TITLE, DESCRIPTION) AS JOB_COUNT_HEHE
WHERE JOB_COUNT>1
-- BÀI 11
(
    SELECT USERS.NAME AS RESULTS
    FROM MOVIERATING
    INNER JOIN USERS ON USERS.USER_ID = MOVIERATING.USER_ID
    GROUP BY USERS.USER_ID
    ORDER BY COUNT(*) DESC, USERS.NAME ASC
    LIMIT 1
) 
UNION  ALL
(
    SELECT RESULTS 
    FROM 
    (
        SELECT TITLE AS RESULTS, AVG(MOVIERATING.RATING) AS AVG_RATING
        FROM MOVIERATING
        INNER JOIN MOVIES ON MOVIERATING.MOVIE_ID = MOVIES.MOVIE_ID
        WHERE MONTH(MOVIERATING.CREATED_AT) = 2 AND YEAR(CREATED_AT)=2020
        GROUP BY MOVIES.MOVIE_ID
    ) RATING_GROUP
    ORDER BY AVG_RATING DESC, RESULTS ASC
    LIMIT 1
);
-- BÀI 12
WITH CTE AS(
SELECT requester_id , accepter_id
FROM RequestAccepted
UNION ALL
SELECT accepter_id , requester_id
FROM RequestAccepted
)
SELECT requester_id id, count(accepter_id) num
FROM CTE
group by 1
ORDER BY 2 DESC
LIMIT 1
