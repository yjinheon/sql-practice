- [참조 및 고려사항](#참조-및-고려사항)
  - [고려사항](#고려사항)
- [Basic SQL Programming](#basic-sql-programming)
  - [Data Manipulation](#data-manipulation)
    - [Select](#select)
    - [From 절](#from-절)
    - [Where 절](#where-절)
      - [BETWEEN](#between)
      - [IN](#in)
      - [IS NULL](#is-null)
      - [LIKE](#like)
      - [이스케이핑 문제](#이스케이핑-문제)
      - [ANY](#any)
      - [ALL](#all)
      - [EXISTS](#exists)
    - [Group by](#group-by)
    - [Join](#join)
    - [CASE WHEN](#case-when)
    - [Subquery](#subquery)
      - [Where 절의 Subquery](#where-절의-subquery)
      - [FROM 절의 Subquery(Inline View)](#from-절의-subqueryinline-view)
      - [SELECT 절의 Subquery(Scala Subquery)](#select-절의-subqueryscala-subquery)
      - [블로그에 안넣은 서브쿼리](#블로그에-안넣은-서브쿼리)
    - [Correleated Subqurery (연관서브쿼리)](#correleated-subqurery-연관서브쿼리)
    - [Case When](#case-when-1)
      - [Case When 용법](#case-when-용법)
    - [RANK](#rank)
  - [Data Definition](#data-definition)
    - [테이블 데이터 다루기](#테이블-데이터-다루기)
  - [Table](#table)
  - [View](#view)
    - [Constraints](#constraints)
  - [Data Manipulation_in practice](#data-manipulation_in-practice)
- [Preporecessing](#preporecessing)
  - [SQL 문자열 처리](#sql-문자열-처리)
    - [문자열 분해 (split_part,split)](#문자열-분해-split_partsplit)
    - [문자열 연결(concat,||)](#문자열-연결concat)
  - [SQL 날짜와 타임스탬프](#sql-날짜와-타임스탬프)
    - [현재 날짜와 타임스탬프](#현재-날짜와-타임스탬프)
    - [지정한 값의 시각데이터 추출(CAST)](#지정한-값의-시각데이터-추출cast)
  - [SQL unsorted trick](#sql-unsorted-trick)
  - [Data Reading & Writing](#data-reading--writing)
  - [데이터 추출(Sampling)](#데이터-추출sampling)
  - [데이터 집약(Data)](#데이터-집약data)
- [Unsorted 문서](#unsorted-문서)
  - [MySQL Locations](#mysql-locations)
  - [Add mysql to your PATH](#add-mysql-to-your-path)
  - [Login](#login)
  - [Show Users](#show-users)
  - [Create User](#create-user)
  - [Grant All Priveleges On All Databases](#grant-all-priveleges-on-all-databases)
  - [Show Grants](#show-grants)
  - [Remove Grants](#remove-grants)
  - [Delete User](#delete-user)
  - [Exit](#exit)
  - [Show Databases](#show-databases)
  - [Create Database](#create-database)
  - [Delete Database](#delete-database)
  - [Select Database](#select-database)
  - [Create Table](#create-table)
  - [Delete / Drop Table](#delete--drop-table)
  - [Show Tables](#show-tables)
  - [Insert Row / Record](#insert-row--record)
  - [Insert Multiple Rows](#insert-multiple-rows)
  - [Select](#select-1)
  - [Where Clause](#where-clause)
  - [Delete Row](#delete-row)
  - [Update Row](#update-row)
  - [Add New Column](#add-new-column)
  - [Modify Column](#modify-column)
  - [Order By (Sort)](#order-by-sort)
  - [Concatenate Columns](#concatenate-columns)
  - [Select Distinct Rows](#select-distinct-rows)
  - [Between (Select Range)](#between-select-range)
  - [Like (Searching)](#like-searching)
  - [Not Like](#not-like)
  - [IN](#in-1)
  - [Create & Remove Index](#create--remove-index)
  - [New Table With Foreign Key (Posts)](#new-table-with-foreign-key-posts)
  - [Add Data to Posts Table](#add-data-to-posts-table)
  - [INNER JOIN](#inner-join)
  - [New Table With 2 Foriegn Keys](#new-table-with-2-foriegn-keys)
  - [Add Data to Comments Table](#add-data-to-comments-table)
  - [Left Join](#left-join)
  - [Join Multiple Tables](#join-multiple-tables)
  - [Aggregate Functions](#aggregate-functions)
  - [Group By](#group-by-1)

# 참조 및 고려사항

- [제타위키](https://zetawiki.com/wiki/MySQL)
- [mysql tutorial](https://www.mysqltutorial.org/mysql-join/)
- 데이터 전처리 대전
- 코드잇 SQL

##  고려사항

- **데이터 분석을 위한 SQL 레시피 분해해서 정리**
- reference
	+ mysql cheat sheet pdf
	+ 데이터 전처리 대전
	+ 코드잇 SQL

- Preprocessing.md 랑 겹치는 부분이 많다
- 전처리


# Basic SQL Programming

## Data Manipulation

- tutorial + codeit

### Select

db : sqltutoral_classicmodels

- **칼럼조회**

```sql
select customernumber
from classicmodels.customers;
```

- **집계함수**

```sql
select sum(amonut), count(customernumber)
from classicmodels.payments;
```

- **모든 결과 조회**


```sql
select * from classicmodels.customers;
```

- **alias**

```sql
select count(productcode) as n_products
from classicmodels.products;

```

- **중복제거**

```sql

SELECT distinct ordernumber
from classicmodels.orderdetails;

```

### From 절

- 테이블 명을 지정해주는 부분

```sql
use database_name;

select * 
from table1;

```


### Where 절

조건절

#### BETWEEN

- 특정 칼럼의 값이 시작점, 끝점인 데이터만 출력

```sql
select *
from ordersdetails
where priceeach between 30 and 50;
```

#### IN

- or 연산자

```sql
select customernumber
from customers
where country in ('USA','CANADA')

```

#### IS NULL

- null 데이터 출력

```sql
SELECT * FROM copang_main.member where ADDRESS is NULL;

SELECT * FROM copang_main.member where address is NOT NULL;

SELECT * FROM copang_main.member where
address is NULL
OR height IS NULL
OR weight IS NULL; # 세 컬럼중 하나라도 null이 있는 로우만 조회


SELECT # coalesce
    coalesce(height,'####'), # null이 아닌 값은 그대로 반환, null일 경우 입력한 값 반환
    coalesce(weight,'----'),
    coalesce(address,'@@@@')
FROM copang_main.`member`;

```

**NULL 변환함수**

1. coalesce : 첫번째로 null이 아닌 값을 반환

2. ifnull : 첫번째 인자가 null인 경우 두번째 인자, 아닐 경우 해당 값 표현

3. if(a1,a2,a3) : ifelse 처럼 사용가능


#### LIKE

- 문자열 매칭하기

```sql
SELECT * FROM main.`member` WHERE address like '서울%'; # address가 서울로 시작하는 row 조회

SELECT * FROM main.`member` WHERE address like '%고양시%'; # 고양시라는 단어 앞뒤로 임의의 길이를 가진 문자열 조건
```


#### 이스케이핑 문제


- 어떤 문자가 그것에 부여된 특정한 의미,기능으로 해석되는 것이 아니라 단순한 문자 하나도 해석되게끔 하는 것을 `이스케이핑`이라 한다.
- ' 이스케이핑 -> select * from copang_main.test where sentence like '%\'%'
- _ 이스케이핑 -> select * from copang_main.test where sentence like '%\_%'
- " 이스케이핑 -> select * from copang_main.test where sentence like '%\"\"%'
- 대문자 제외 소문자 찾기 select * from copang_main.test where sentence like binary '%g%'

#### ANY

- **ANY는 나올 수 있는 모든 조건에 OR 연산을 수행한것과 동일한 결과 반환**
- 수량이 10개인 제품 전부 반환

```sql
SELECT ProductName
FROM Products
WHERE ProductID = ANY
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity = 10);
```

- 수량이 1000개 초과인 제품 전부 반환

```sql
SELECT ProductName
FROM Products
WHERE ProductID = ANY
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity > 1000);
```

#### ALL

- 조건을 모두 만족하는 행을 반환

```sql
SELECT ProductName
FROM Products
WHERE ProductID = ALL
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity = 10);
```

#### EXISTS

- EXISTS는 행의 존재 여부를 확인하여 True/False 값을 반환

```sql
SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products 
WHERE Products.SupplierID = Suppliers.supplierID AND Price = 22);
```

### Group by

### Join

### CASE WHEN

```sql
SELECT 
case when country in ('USA','CANADA') then 'North America'
else 'Others' End as region,
count(customernumber) as N_CUSTOMERS
from classicmodels.customers
group by 1; -- select의 첫번째 칼럼으로 그루핑

```


### Subquery

---

**_Concept_**


- **서브쿼리** : 서브쿼리는 하나의 SQL쿼리 안에 포함된 다른 SQL쿼리를 말한다.

---

- **서브쿼리 사용상황**
    - 가장 기본적으로 알려지지 않은 조건을 사용해서 조회해야할 때
    - DB에 접근하는 속도를 향상시킬 때 

- **사용시 주의점**
    - 항상 괄호로 감싸서 사용할 것
    - 서브쿼리의 결과가 2건 이상이라면(다중행) **반드시** 비교연산자와 함께 사용한다, 
    - 서브쿼리 내에서는 order by 사용 못함( order by는 쿼리에서 하나만 사용)
    - 서브쿼리는 메인쿼리의 컬럼을 모두 사용할 수 있지만, 메인쿼리는 서브쿼리의 컬럼을 사용할 수 없다.
    - 질의 결과에 서브쿼리 컬럼을 표시해야 한다면 조인 방식으로 변환하거나 함수, 스칼라 서브쿼리 등을 사용해야 한다.

- **종류**
  + 단일 행 서브쿼리 : 특정 행을 반환. 이 행을 조건절도도 사용가능
    * ex) 평균값알아내는 서브쿼리를 통해 평균값 이상의 그룹을 출력
  * 다중행 서브쿼리 : 결과가 2건이상 반환되는 서브쿼리. 반드시 비교연산자와 함께 사용. Where 절에 괄호로 들어간다.
    - IN(서브쿼리) : 서브쿼리의 결과에 존재하는 값과 동일한 조건의미
    - ALL(서브쿼리) : 모든 값을 만족하는 조건
    - ANY(서브쿼리) : 비교연산자에 ">" 를 썼다면 ANY가 어떤 하나라도 맞는지 조건이기 때문에
                         결과중에 가장 작은값보다 크면 만족한다.
    - EXIST(서브쿼리) :  서브쿼리의 결과를 만족하는 값이 존재하는지 여부 확인. 존재유무만 확인하기에 1건만 찾으면 더 이상검색안함
  * 다중 컬럼 서브쿼리 : 서브쿼리 결과로 **여러 개의 컬럼이 반환**되어 메인쿼리 조건과 동시에 비교되는 것.
  ```sql
  -- 다둥컬럼 서브퉈리 예시

  select ord_num, agent_code, ord_date, ord_amount
  from orders
  where(agent_code, ord_amount) IN
  (SELECT agent_code, MIN(ord_amount)
  FROM orders 
  GROUP BY agent_code);  

  ```


#### Where 절의 Subquery

- 비교연산자 IN 사용
```sql
# 특정 행 반환
SELECT 
    employee_id, first_name, last_name
FROM
    employees
WHERE
    department_id IN (SELECT 
            department_id
        FROM
            departments
        WHERE
            location_id = "찾는 아이디")
ORDER BY first_name , last_name;

```

- MAX나 MIN 사용

```sql

# where 절에서 서브쿼리로 정의한 조건을 select 절에 쓸 수 있다.

SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary = (SELECT 
            MAX(salary)
        FROM
            employees)
ORDER BY first_name , last_name;

```

- AVG로 조건걸기


```sql

SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);    


```

- 서브쿼리 조건문처럼 사용하기

```sql
SELECT *
  FROM tutorial.sf_crime_incidents_2014_01
 WHERE Date = (SELECT MIN(date)
                 FROM tutorial.sf_crime_incidents_2014_01
              )
```



#### FROM 절의 Subquery(Inline View)

- SQL이 실행될 때만 동적으로 생성되는 Inline view 




```sql
SELECT A.item_name, subquery1.total_amt
FROM suppliers A,
     (SELECT supplier_id, SUM(B.amount) AS total_amt
      FROM orders B
      GROUP BY supplier_id) subquery1
WHERE subquery1.supplier_id = A.supplier_id;
```


```sql
SELECT 
    MAX(items), 
    MIN(items), 
    FLOOR(AVG(items))
FROM
    (SELECT 
        orderNumber, COUNT(orderNumber) AS items
    FROM
        orderdetails
    GROUP BY orderNumber) AS lineitems;
```


- 파생테이블은 반드시 alias를 가진다,

```sql
select
    substring(address,1,2) as region,
    count(*) as review_count
from review as r left outer join member as m
on r.mem_id = m.id
group by substring(address,1,2)
having region is not null
    and region != '안드'

select avg(review_count),
       max(review_count),
       min(review_count)
from
(select
    substring(address,1,2) as region,
    count(*) as review_count
from review as r left outer join member as m
on r.mem_id = m.id
group by substring(address,1,2)
having region is not null
    and region != '안드') as review_count_summary #서브쿼리로 탄생한 파생테이블은 반드시 alias를 가져야 한다
```


-- Join과 서브쿼리 같이 사용하기

```sql
SELECT *
  FROM tutorial.sf_crime_incidents_2014_01 incidents
  JOIN ( SELECT date
           FROM tutorial.sf_crime_incidents_2014_01
          ORDER BY date
          LIMIT 5
       ) sub
    ON incidents.date = sub.date

```

#### SELECT 절의 Subquery(Scala Subquery)

- SELECT 절 안에 SELECT가 있을 경우 Scala 서브쿼리라 부르며 기본적으로 한 행만 리턴한다.

```sql
SELECT PLAYER, HEIGHT , (SELECT AVG(HEIGHT)
                         FROM PLAYER X
                         WHERE X.TEAM_ID = P.TEAM_ID)
FROM PLAYER_P

```

- 기본적으로 outer join이 적용되어 있다.
- 쿼리 수행 횟수를 최소화하기 위해서 입력값과 출력값을 내부 캐시에 저장한다.
- 대용량 데이터를 처리할 경우 속도가 느려질 수 있다.

```sql

SELECT A.PKID
    , A.TITLE
    , NVL(B.NAME, '탈퇴한 회원'), B.NAME
    , (SELECT COUNT(*) FROM REPLY WHERE P_PKID = B.PKID) AS COUNT1
FROM BOARD B LEFT OUTER JOIN MEMBER M
    ON B.MEM_NO = M.PKID

```

#### 블로그에 안넣은 서브쿼리

- 어떤 블로그에서 가져옴

```sql
 
3. 다중 컬럼 서브쿼리
- 서브쿼리 결과로 여러 개의 컬럼이 반환되어 메인쿼리 조건과 동시에 비교되는 것.
SELECT TEAM_ID 팀코드, PLAYER_NAME 선수명, POSITION 포지션, BACK_NO 백넘버, HEIGHT 키
FROM PLAYER
WHERE (TEAM_ID, HEIGHT) IN (SELECT TEAM_ID, MIN(HEIGHT)
                            FROM PLAYER
                            GROUP BY TEAM_ID)
ORDER BY TEAM_ID, PLAYER_NAME;
// 소속팀별 키가 가장 작은 사람들의 정보를 출력.
// 같은 팀에서 여러명의 선수가 반환될 수 있음. 키가 같은 경우.
 
4. 연관 서브쿼리 (Correlated Subquery)
SELECT T.TEAM_NAME 팀명, M.PLAYER_NAME 선수명, M.POSITION 포지션, M.BACK_NO 백넘버, M.HEIGHT 키
FROM PLAYER M , TEAM T
WHERE M.TEAM_ID = T.TEAM_ID
AND M.HEIGHT < (SELECT AVG(S.HEIGHT)
                FROM PLAYER S
                WHERE S.TEAM_ID = M.TEAM_ID
                AND S.HEIGHT IS NOT NULL
                GROUP BY S.TEAM_ID)
ORDER BY 선수명;
// 선수 자신이 속한 팀의 평균키보다 작은 선수들의 정보를 출력하는 SQL문
 
SELECT STARDIUM_ID ID, STARDIUM_NAME 경기장명
FROM STARDIUM A
WHERE EXISTS (SELECT 1
              FROM SCHEDULE X
              WHERE X.STARDIUM_ID = A.STARDIUM_ID
              AND X.SCHE_DATE BETWEEN '20120501' AND '20120502')
// 20120501 과 20120502 사이의 날짜에 경기가 있는 경기장 조회
 
5-1 SELECT 절에 서브쿼리 (=스칼라쿼리 : 한 행 한 컬럼만 반환하는 쿼리)
 
SELECT PLAYER_NAME 선수명, HEIGHT 키, ROUND( (SELECT AVG(HEIGHT)
                                             FROM PLAYER X
                                             WHERE X.TEAM_ID = P.TEAM_ID),3) 팀평균키
FROM PLAYER P
 
5-2 FROM 절에 서브쿼리
SELECT T.TEAM_NAME 팀명, P.PLAYER_NAME 선수명, P.BACK_NO 백넘버
FROM (SELECT TEAM_ID, PLAYER_NAME, BACK_NO
      FROM PLAYER
      WHERE POSITION = 'MF') P,
      TEAM T
WHERE P.TEAM_ID = T.TEAM_ID
ORDER BY 선수명;
// 서브쿼리의 결과가 마치 동적으로 생성된 테이블처럼 사용
// 서브쿼리의 컬럼은 메인에서 사용할 수 없다. 하지만 이건 인라인뷰이기 때문에 사용가능
 
** TOP-N 쿼리
인라인 뷰에서는 ORDER BY절이 불가하다. 따라서 인라인 뷰에서 먼저 정렬하고 정렬된 결과에서 일부데이터를 추출하는 것이 TOP-N쿼리
TOP-N 쿼리를 수행하기 위해서는 ROWNUM이라는 연산자를 통해 건수를 제약할 수 있다.
 
SELECT PLAYER_NAME 선수명, POSITION 포지션, BACK_NO 백넘버, HEIGHT ㅣ
FROM (SELECT PLAYER_NAME, POSITION, BACK_NO, HEIGHT
      FROM PLAYER
      WHERE HEIGHT IS NOT NULL
      ORDER BY HEIGHT DESC)
WHERE ROWNUM <= 5;
// 인라인 뷰에서 선수의 키를 내림차순으로 정렬한 후 메인쿼리에서 ROWNUM을 통해 5명만 추출.
// 즉, 키가 큰순서로 상위 5명 뽑음
 
5-3 HAVING 절에 서브쿼리
SELECT P.TEAM_ID 팀코드, T.TEAM_NAME 팀명, AVG(P.HEIGHT) 평균키
FROM PLAYER P , TEAM T
WHERE P.TEAM_ID, T.TEAM_ID
GROUP BY P.TEAM_ID, T.TEAM_NAME
HAVING AVG(P.HEIGHT) < (SELECT AVG(HEIGHT)
                        FROM PLAYER
                        WHERE TEAM_ID = 'K02');
 
5-4 UPDATE SET 절 서브쿼리
UPDATE TEAM A
SET A.E_TEAM_NAME = (SELECT X.STARDIUM_NAME
                     FROM STARDIUM X
                     WHERE X.STARDIUM_ID = A.STARDIUM_ID);
 
5-5 INSERT VALUES 절에 서브쿼리
INSERT INTO PLAYER(PLAYER_ID, PLAYER_NAME, TEAM_ID)
VALUES( (SELECT TO_CAHR(MAX(TO_NUMBER(PLAYER_ID))+1) FROM PLAYER), '홍길동','K06');
 
6. 뷰
테이블은 실제 데이터를 가지고 있는 반면, 뷰는 실제 데이터가 없음
테이블 구조가 변경되어도 뷰를 사용하는 응용프로그램은 변경하지 않아도 됨.
 
CREATE VIEW V_PLAYER_TEAM AS
SELECT P.PLAYER_NAME ,P.POSITION, P.BACK_NO, P.TEAM_ID, T.TEAM_NAME
FROM PLAYER P , TEAM T
WHERE P.TEAM_ID = T.TEAM_ID;

```

**ref**

- [연관서브쿼리](https://www.w3resource.com/sql/subqueries/multiple-row-column-subqueries.php)

### Correleated Subqurery (연관서브쿼리)


---

**_Concept_**


- **연관 서브쿼리** : 

---

### Case When

- 기본적으로 파생변수(컬럼)를 생성하는데 사용한다.
- 파생변수이기 때문에 Select절 에 들어간다.


#### Case When 용법

```sql
SELECT player_name,
       weight,
       CASE WHEN weight > 250 THEN 'over 250'
            WHEN weight > 200 THEN '201-250'
            WHEN weight > 175 THEN '176-200'
            ELSE '175 or under' END AS weight_group
  FROM benn.college_football_players
```

- order by에 사용힐 컬럼 생성

```sql
SELECT CustomerName, City, Country
FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END);
```

```sql
SELECT animal_id, name,
case 
    when sex_upon_intake like "Intact%" then "O"
    else "X" 
end as "중성화"
from animal_ins
order by animal_id
```

**ref**
- https://www.w3schools.com/sql/sql_case.asp


### RANK

https://satisfactoryplace.tistory.com/193


<<<<<<< HEAD
## Data Definition

- `ALTER`는 DB구조를 변경하는데 쓴다.
- `TRUNCATE`는 데이터를 삭제하는데 쓴다.
- `DROP`은 테이블 자체를 삭제한다.

### 테이블 데이터 다루기


- 테이블 생성

```sql
CREATE TABLE t ( id INT PRIMARY KEY,
                 name VARCHAR NOT NULL, 
                 price INT DEFAULT 0);

```

- 테이블 삭제

```sql
DROP TABLE t;

```

- 새 컬럼 추가

```sql
ALTER TABLE t ADD COLUMN;

```

- 새 제약조건 추가

```sql
ALTER TABLE t ADD CONSTRAINT;

```

- 제약조건 삭제

```sql
ALTER TABLE t DROP CONSTRAINT;

```

- 테이블명 변경

```sql
ALTER TABLE t RENAME to t2;

```

- 컬럼명 변경

```sql

ALTER table t1 RENAME c1 to c2;

```

- 테이블 데이터 삭제

테이블 구조는 남기고 데이터를 전부 날린다.

```sql

TRUNCATE TABLE t;

```
=======
## Table
>>>>>>> 2392348623ab026ecc187a8b50d9619895c682ae

## View


### Constraints


## Data Manipulation_in practice

# Preporecessing

## SQL 문자열 처리

### 문자열 분해 (split_part,split)

### 문자열 연결(concat,||)

## SQL 날짜와 타임스탬프

### 현재 날짜와 타임스탬프

### 지정한 값의 시각데이터 추출(CAST)

## SQL unsorted trick

## Data Reading & Writing

- amazon redshift

## 데이터 추출(Sampling)

## 데이터 집약(Data)

- Better Way 집약파트
- 전처리 대전 집약

# Unsorted 문서

- mysql cheatsheat

## MySQL Locations
* Mac             */usr/local/mysql/bin*
* Windows         */Program Files/MySQL/MySQL _version_/bin*
* Xampp           */xampp/mysql/bin*

## Add mysql to your PATH

```bash
# Current Session
export PATH=${PATH}:/usr/local/mysql/bin
# Permanantly
echo 'export PATH="/usr/local/mysql/bin:$PATH"' >> ~/.bash_profile
```

On Windows - https://www.qualitestgroup.com/resources/knowledge-center/how-to-guide/add-mysql-path-windows/

## Login

```bash
mysql -u root -p
```

## Show Users

```sql
SELECT User, Host FROM mysql.user;
```

## Create User

```sql
CREATE USER 'someuser'@'localhost' IDENTIFIED BY 'somepassword';
```

## Grant All Priveleges On All Databases

```sql
GRANT ALL PRIVILEGES ON * . * TO 'someuser'@'localhost';
FLUSH PRIVILEGES;
```

## Show Grants

```sql
SHOW GRANTS FOR 'someuser'@'localhost';
```

## Remove Grants

```sql
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'someuser'@'localhost';
```

## Delete User

```sql
DROP USER 'someuser'@'localhost';
```

## Exit

```sql
exit;
```

## Show Databases

```sql
SHOW DATABASES
```

## Create Database

```sql
CREATE DATABASE acme;
```

## Delete Database

```sql
DROP DATABASE acme;
```

## Select Database

```sql
USE acme;
```

## Create Table

```sql
CREATE TABLE users(
id INT AUTO_INCREMENT,
   first_name VARCHAR(100),
   last_name VARCHAR(100),
   email VARCHAR(50),
   password VARCHAR(20),
   location VARCHAR(100),
   dept VARCHAR(100),
   is_admin TINYINT(1),
   register_date DATETIME,
   PRIMARY KEY(id)
);
```

## Delete / Drop Table

```sql
DROP TABLE tablename;
```

## Show Tables

```sql
SHOW TABLES;
```

## Insert Row / Record

```sql
INSERT INTO users (first_name, last_name, email, password, location, dept, is_admin, register_date) values ('Brad', 'Traversy', 'brad@gmail.com', '123456','Massachusetts', 'development', 1, now());
```

## Insert Multiple Rows

```sql
INSERT INTO users (first_name, last_name, email, password, location, dept,  is_admin, register_date) values ('Fred', 'Smith', 'fred@gmail.com', '123456', 'New York', 'design', 0, now()), ('Sara', 'Watson', 'sara@gmail.com', '123456', 'New York', 'design', 0, now()),('Will', 'Jackson', 'will@yahoo.com', '123456', 'Rhode Island', 'development', 1, now()),('Paula', 'Johnson', 'paula@yahoo.com', '123456', 'Massachusetts', 'sales', 0, now()),('Tom', 'Spears', 'tom@yahoo.com', '123456', 'Massachusetts', 'sales', 0, now());
```

## Select

```sql
SELECT * FROM users;
SELECT first_name, last_name FROM users;
```

## Where Clause

```sql
SELECT * FROM users WHERE location='Massachusetts';
SELECT * FROM users WHERE location='Massachusetts' AND dept='sales';
SELECT * FROM users WHERE is_admin = 1;
SELECT * FROM users WHERE is_admin > 0;
```

## Delete Row

```sql
DELETE FROM users WHERE id = 6;
```

## Update Row

```sql
UPDATE users SET email = 'freddy@gmail.com' WHERE id = 2;

```

## Add New Column

```sql
ALTER TABLE users ADD age VARCHAR(3);
```

## Modify Column

```sql
ALTER TABLE users MODIFY COLUMN age INT(3);
```

## Order By (Sort)

```sql
SELECT * FROM users ORDER BY last_name ASC;
SELECT * FROM users ORDER BY last_name DESC;
```

## Concatenate Columns

```sql
SELECT CONCAT(first_name, ' ', last_name) AS 'Name', dept FROM users;

```

## Select Distinct Rows

```sql
SELECT DISTINCT location FROM users;

```

## Between (Select Range)

```sql
SELECT * FROM users WHERE age BETWEEN 20 AND 25;
```

## Like (Searching)

```sql
SELECT * FROM users WHERE dept LIKE 'd%';
SELECT * FROM users WHERE dept LIKE 'dev%';
SELECT * FROM users WHERE dept LIKE '%t';
SELECT * FROM users WHERE dept LIKE '%e%';
```

## Not Like

```sql
SELECT * FROM users WHERE dept NOT LIKE 'd%';
```

## IN

```sql
SELECT * FROM users WHERE dept IN ('design', 'sales');
```

## Create & Remove Index

```sql
CREATE INDEX LIndex On users(location);
DROP INDEX LIndex ON users;
```

## New Table With Foreign Key (Posts)

```sql
CREATE TABLE posts(
id INT AUTO_INCREMENT,
   user_id INT,
   title VARCHAR(100),
   body TEXT,
   publish_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(id),
   FOREIGN KEY (user_id) REFERENCES users(id)
);
```

## Add Data to Posts Table

```sql
INSERT INTO posts(user_id, title, body) VALUES (1, 'Post One', 'This is post one'),(3, 'Post Two', 'This is post two'),(1, 'Post Three', 'This is post three'),(2, 'Post Four', 'This is post four'),(5, 'Post Five', 'This is post five'),(4, 'Post Six', 'This is post six'),(2, 'Post Seven', 'This is post seven'),(1, 'Post Eight', 'This is post eight'),(3, 'Post Nine', 'This is post none'),(4, 'Post Ten', 'This is post ten');
```

## INNER JOIN

```sql
SELECT
  users.first_name,
  users.last_name,
  posts.title,
  posts.publish_date
FROM users
INNER JOIN posts
ON users.id = posts.user_id
ORDER BY posts.title;
```

## New Table With 2 Foriegn Keys

```sql
CREATE TABLE comments(
    id INT AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    body TEXT,
    publish_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) references users(id),
    FOREIGN KEY(post_id) references posts(id)
);
```

## Add Data to Comments Table

```sql
INSERT INTO comments(post_id, user_id, body) VALUES (1, 3, 'This is comment one'),(2, 1, 'This is comment two'),(5, 3, 'This is comment three'),(2, 4, 'This is comment four'),(1, 2, 'This is comment five'),(3, 1, 'This is comment six'),(3, 2, 'This is comment six'),(5, 4, 'This is comment seven'),(2, 3, 'This is comment seven');
```

## Left Join

```sql
SELECT
comments.body,
posts.title
FROM comments
LEFT JOIN posts ON posts.id = comments.post_id
ORDER BY posts.title;

```

## Join Multiple Tables

```sql
SELECT
comments.body,
posts.title,
users.first_name,
users.last_name
FROM comments
INNER JOIN posts on posts.id = comments.post_id
INNER JOIN users on users.id = comments.user_id
ORDER BY posts.title;

```

## Aggregate Functions

```sql
SELECT COUNT(id) FROM users;
SELECT MAX(age) FROM users;
SELECT MIN(age) FROM users;
SELECT SUM(age) FROM users;
SELECT UCASE(first_name), LCASE(last_name) FROM users;

```




## Group By

```sql
SELECT age, COUNT(age) FROM users GROUP BY age;
SELECT age, COUNT(age) FROM users WHERE age > 20 GROUP BY age;
SELECT age, COUNT(age) FROM users GROUP BY age HAVING count(age) >=2;

```