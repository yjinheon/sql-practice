- [Data Manipulation](#data-manipulation)
  - [데이터 조회](#데이터-조회)
    - [SELECT](#select)
    - [WHERE](#where)
      - [BETWEEN](#between)
      - [IN](#in)
      - [ANY](#any)
      - [ALL](#all)
      - [EXISTS](#exists)
      - [여러개의 조건 걸기](#여러개의-조건-걸기)
    - [ORDER BY](#order-by)
    - [LIMIT](#limit)
  - [Data Analysis with SQL](#data-analysis-with-sql)
    - [Aggregation Function 집계함수](#aggregation-function-집계함수)
    - [Math Function](#math-function)
    - [DISTINCT](#distinct)
    - [NULL 다루기](#null-다루기)
    - [WITH의 의미](#with의-의미)
    - [GROUP BY](#group-by)
    - [ROLL UP](#roll-up)
    - [CASE WHEN](#case-when)
    - [이상치 다루기](#이상치-다루기)
    - [ALIAS](#alias)
    - [RANK](#rank)
    - [Window의 이해](#window의-이해)
    - [OVER](#over)
  - [JOIN](#join)
  - [SUBQUERY](#subquery)
    - [SELECT 절의 SUBQUERY](#select-절의-subquery)
    - [FROM 절의 SUBQUERY](#from-절의-subquery)
    - [중첩질의문](#중첩질의문)
    - [단일, 다중행 서브쿼리](#단일-다중행-서브쿼리)
  - [집합연산자 - Union, Minus](#집합연산자---union-minus)
  - [View](#view)
- [CRUD](#crud)
  - [Managing DataBases](#managing-databases)
    - [Create Database](#create-database)
  - [Managing Tables](#managing-tables)
    - [Create Table](#create-table)
    - [Delete / Drop Table](#delete--drop-table)
    - [Show Tables](#show-tables)
    - [테이블 구조 확인](#테이블-구조-확인)
    - [Rename Table](#rename-table)
    - [테이블 삽입, 수정, 삭제](#테이블-삽입-수정-삭제)
  - [Managing Columns](#managing-columns)
    - [컬럼 추가와 컬럼의 이름 변경](#컬럼-추가와-컬럼의-이름-변경)
    - [데이터 타입 변경 컬럼 삭제](#데이터-타입-변경-컬럼-삭제)
    - [modify를 사용한 컬럼 속성추가](#modify를-사용한-컬럼-속성추가)
    - [컬럼에 default 값 달기](#컬럼에-default-값-달기)
    - [컬럼에 UNIQUE 속성 주기](#컬럼에-unique-속성-주기)
    - [컬럼 가장 앞으로 당기기](#컬럼-가장-앞으로-당기기)
    - [컬럼 간의 순서 바꾸기](#컬럼-간의-순서-바꾸기)
    - [컬럼의 이름과 컬럼의 데이터 타입 및 속성 동시에 수정하기](#컬럼의-이름과-컬럼의-데이터-타입-및-속성-동시에-수정하기)
  - [Constraint](#constraint)
  - [Foreign Key](#foreign-key)
- [Data Type](#data-type)
  - [Type Casting](#type-casting)
  - [Time 관련 함수들](#time-관련-함수들)
  - [String 함수들](#string-함수들)
  - [](#)
- [Modeling](#modeling)
  - [데이터 모델링](#데이터-모델링)
    - [Relational 모델](#relational-모델)
- [프로시저 , 트리거 사용](#프로시저--트리거-사용)
- [DCL 사용자 관리](#dcl-사용자-관리)
- [TCL 트랜잭션 관리](#tcl-트랜잭션-관리)
  - [COMMIT](#commit)
  - [ROLLBACK](#rollback)
- [Preprocessing Tricks](#preprocessing-tricks)

# Data Manipulation


## 데이터 조회

모든 SQL SELECT 쿼리문은 기본적으로 3가지 타입으로 분류할 수있다

- SELECT ALL : 기본적으로 JOIN을 할 수 있는지 보는 것
- SELECT the group that did X : 특정 조건에 해당하는 그룹을 선별할 수 있는지 보는 것
- SELECT the group that didn't do X : 특정 조건에 해당하는 그룹을 제외할 수 있는지 보는 것

아무리 복잡해 보이는 쿼리도 이 3가지 타입을 벗어나지 않는다.

### SELECT

> SELECT * FROM `member`;

```sql

SELECT * FROM `MEMBER`  WHERE AGE >= 27; # 27세 이상 조회
SELECT * FROM MEMBER WHERE AGE BETWEEN 30 AND 39; # 30대 조회
SELECT * FROM MEMBER WHERE AGE NOT BETWEEN  30 AND 39; # 30대 제외 조회
SELECT * FROM MEMBER WHERE SIGN_UP_DAY > '2019-01-01'; # 2019년 1월 1일 이후로 가입한 회원 조회
SELECT  * FROM `member` WHERE SIGN_UP_DAY BETWEEN '2018-01-01' AND '2018-12-31'; # 2018년 내 가입자 조회
```

### WHERE

> SELECT ATTR FROM TB WHERE CONDITION

#### BETWEEN

- 특정 칼럼의 값이 시작점, 끝점인 데이터만 출력

```sql
SELECT *
FROM ORDERSDETAILS
WHERE PRICEEACH BETWEEN 30 AND 50;
```

#### IN

- or 연산자

```sql
SELECT CUSTOMERNUMBER
FROM CUSTOMERS
WHERE COUNTRY IN ('USA','CANADA')

```

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

#### 여러개의 조건 걸기


```sql
SELECT * from copang_main.`member` where gender = 'm' # 성별 남자 및 주소 서울
	and address like '서울%'
	and age BETWEEN 25 and 29;

### 봄이나 가을에 가입한 회원 조회
SELECT * FROM copang_main.`member`
where MONTH(sign_up_day) BETWEEN 3 and 5
or MONTH(sign_up_day) BETWEEN 7 and 9

### and와 or 같이 사용하기
SELECT * FROM copang_main.`member`
where (gender = 'm' and height >= 180)
or (gender = 'f' and height >=170)

#### tip : and 가 or 보다 우선순위가 높으며 사용자가 우선적으로 실행되기 원하는 조건을 괄호를 씌우는 편이 좋다.

SELECT * FROM copang_main.`member` Where age NOT BETWEEN 20 AND 29;

```

### ORDER BY

- 실무에서는 ORDER BY는 이름을 먼저 쓴 컬럼 기준으로 차례대로 수행된다.  
- SQL 문법 상 WHERE는 ORDER BY 앞에 나온다.
- **주의사항**
  1. 숫자형인 경우 -> 숫자의 크고 작음 기준으로 정력
  2. 문자열형인 경우 -> 문자 순서를 비교해서 정렬 수행
  3. 문자형을 숫자로 나타내고 싶을 경우 cast 함수를 사용한다

```sql
SELECT * FROM copang_main.`member`  # order by는 default로 오름차순으로 정렬
order by height ;

SELECT * FROM copang_main.`member`  # 내림차순 정렬
order by height DESC ;

SELECT * FROM copang_main.`member` # 조건식 걸고 정렬
where gender = 'm'
	and weight >= 70 # 내림차순 정렬
order by height DESC ;

SELECT sign_up_day,email FROM copang_main.`member` # 조건식 걸고 정렬
order by YEAR(sign_up_day) DESC, email ASC; # 가입년 기준 내림차순 정렬,가입년이 같을 경우 이메일 기준 오름차순
```

### LIMIT

- limit n : 출력개수 n개 제한  
- limit m,n : m번째부터 n개 출력

```sql
SELECT * FROM copang_main.member
ORDER BY sign_up_day DESC
LIMIT 10;

SELECT * FROM copang_main.member
ORDER BY sign_up_day DESC
LIMIT 8,2; # 8번째 로우부터 2개 추림 // 로우는 0번부터 시작 9번째, 10번째로
```

## Data Analysis with SQL

- SQL을 활용해 요약통계량 및 기술통계 자유자재로 산출하기
  - 데이터 특성 구하기
  - 집계함수 및 산술함수
  - NULL값 다루기
  - 이상치 다루기
  - 고유값 보기
  - 컬럼단위 연산(파생변수만들기)
  - alias
  - CASE WHEN 용법
  - Unique Value만 보기
  - 문자열 다루기
  - GROUP BY
  - HAVING
  - ROLL UP 을 활용한 부분총계 구하기
  - WINDOW의 의미

### Aggregation Function 집계함수

- count() 는 해당컬럼에서  NULL의 개수는 제외함
- 테이블의 전체 행 숫자를 알고 싶을 경우 count(*) 를 사용

```sql
SELECT COUNT(EMAIL) CLUB.MEMBER; 

SELECT COUNT(HEIGHT) CLUB.MEMBER;

SELECT COUNT(*) FROM CLUB.`MEMBER`;

SELECT MAX(HEIGHT) FROM CLUB.`MEMBER`; # 최대

SELECT MIN(WEIGHT) FROM CLUB.`MEMBER`; # 최소

SELECT AVG(WEIGHT) FROM CLUB.`MEMBER`; # AVG함수는 NULL이 있는 ROW는 제외하고 평균값을 구한다.

SELECT SUM(WEIGHT) FROM CLUB.`MEMBER`; # 합계

SELECT STDEV(WEIGHT) FROM CLUB.`MEMBER`; # 표준편자

SELECT VAR(WEIGHT) FROM CLUB.`MEMBER`; # 분산
```

### Math Function

- https://www.w3schools.com/sql/sql_ref_mysql.asp

```sql
SELECT SUM(WEIGHT) FROM CLUB.`MEMBER`; # 합

SELECT ABS(WEIGHT) FROM CLUB.`MEMBER`; # 절대값

SELECT CEIL(WEIGHT) FROM CLUB.`MEMBER`; # 올림


SELECT FLOOR(WEIGHT) FROM CLUB.`MEMBER`; # 내림

SELECT ROUND(WEIGHT) FROM CLUB.`MEMBER`; # 반올림
```

### DISTINCT

```sql
SELECT DISTINCT(GENDER) FROM COPANG_MAIN.`MEMBER`;

SELECT DISTINCT(SUBSTRING(ADDRESS,1,2)) FROM COPANG_MAIN.`MEMBER`;
# SUBSTRING을 활용한 지역 고윳값 찾기

SELECT COUNT(DISTINCT(SUBSTRING(ADDRESS,1,2))) FROM COPANG_MAIN.`MEMBER`; #고윳값 개수구하기
```

### NULL 다루기

- NULL을 포함하는 연산의 결과도 0이다.
- NULL을 연산하려면 시스템에서 의미없는 문자로 바꿔서 연산해야 한다.

**NULL 함수**

- COLESECE : 첫번째로 NULL이 아닌 값을 반환
- IFNULL(EXPR1,EXPR2): 첫번째 인자가 NULL인 경우 두번째 인자, 아닐 경우 해당 값 표현. 오라클에서는 NVL, sql server에서는 ISNULL과 같다.
- NULLIF(EXPR1,EXPR2) : EXPR1 = EXPR2 일 경우 NULL리턴, EXPR1 != EXPR2 일 경우 
  - 특정값을 NULL로 변경 시 사용

```SQL
SELECT * FROM CLUB.MEMBER WHERE ADDRESS IS NULL;
SELECT * FROM CLUB.MEMBER WHERE ADDRESS IS NOT NULL;

SELECT * FROM CLUB.MEMBER WHERE
ADDRESS IS NULL
OR HEIGHT IS NULL
OR WEIGHT IS NULL; # 세 컬럼중 하나라도 NULL이 있는 로우만 조회

-- COALESCE
SELECT 
	COALESCE(HEIGHT,'####'), # NULL이 아닌 값은 그대로 반환, NULL일 경우 입력한 값 반환
	COALESCE(WEIGHT,'----'),
	COALESCE(ADDRESS,'@@@@')
FROM CLUB.`MEMBER`;

SELECT IFNULL(HEIGHT,'N/A') FROM CLUB.MEMBER;

-- NULLIF
SELECT ENAME, EMPNO, NULLIF(MGR, 7877) # MGR이 7877이면 NULL 리턴
FROM   EMP ; 
```

### WITH의 의미

https://royzero.tistory.com/50

- WITH statement는 SUBQUERY BLOCK에 naming을 하는 해주는 역할을 한다.

```

```


### GROUP BY

```sql
SELECT GENDER,COUNT(*) FROM CLUB.`MEMBER`
GROUP BY GENDER;

# aggregate function : 그루핑을 통해 생성된 각 그룹의 통계량을 계산해주는 함수
SELECT
	GENDER,
	COUNT(*),
	AVG(HEIGHT),
	MIN(WEIGHT)
FROM CLUB.`MEMBER`
GROUP BY GENDER;

# SUBSTRING을 통해 도시명 구한 뒤 도시명 및 성별로 그룹화 한뒤  서울만 추리기
SELECT SUBSTRING(ADDRESS,1,2) AS REGION,GENDER,COUNT(*)
FROM CLUB.`MEMBER`
GROUP BY
	SUBSTRING(ADDRESS,1,2),
	GENDER
HAVING REGION="서울";

SELECT SUBSTRING(ADDRESS,1,2) AS REGION,GENDER,COUNT(*)
FROM CLUB.`MEMBER`
GROUP BY
	SUBSTRING(ADDRESS,1,2),
	GENDER
HAVING REGION="서울" AND GENDER = 'M'; # 위와 같지만 조건을 추가함

# SELECT 문에서 조건을 선별할 때 WHERE을 쓰지만 GROUP BY 다음에는 HAVING을 사용

SELECT SUBSTRING(ADDRESS,1,2) AS REGION,GENDER,COUNT(*)
FROM CLUB.`MEMBER`
GROUP BY
	SUBSTRING(ADDRESS,1,2),
	GENDER
HAVING REGION IS NOT NULL # REGION이 NULL인 경우 제외
ORDER BY REGION, GENDER DESC;
```

**GROUP BY의 규칙**

GROUP BY를 사용할 때는, SELECT 절에는

(1) GROUP BY 뒤에서 사용한 컬럼들 또는
(2) COUNT, MAX 등과 같은 집계 함수만 사용가능

**GROUP BY 뒤에 쓰지 않은 컬럼 이름을 SELECT 뒤에 쓸 수는 없음**

### ROLL UP

https://dev.mysql.com/doc/refman/5.7/en/group-by-modifiers.html

- rollup은 group by에서 선택한 기준에 따라 소계, 합계를 구하는 함수이다.

```sql
SELECT SUBSTRING(address, 1, 2) as region, gender, COUNT(*)
FROM member
GROUP BY SUBSTRING(address, 1, 2), gender WITH ROLLUP # address의 부분총계, 계층 존재
HAVING region IS NOT NULL
ORDER BY region ASC, gender DESC;
```

- 왼쪽이 원본데이터이고 오른쪽이 rollup을 적용한 경우이다.
- 용법은 GROUP BY 그룹칼럼 , 그룹별 연산을 적용할 칼럼 with rollup 이다. 

```sql

SELECT country, product, sum(profit) FROM sales GROUP BY country, product WITH ROLLUP;
```

| ountry  | product    | sum(profit) |   | country | product    | sum(profit) |
|---------|------------|-------------|---|---------|------------|-------------|
| Finland | Computer   | 1500        |   | Finland | Computer   | 1500        |
| Finland | Phone      | 110         |   | Finland | Phone      | 110         |
| India   | Calculator | 150         |   | Finland | NULL       | 1610        |
| India   | Computer   | 1200        |   | India   | Calculator | 150         |
| USA     | Calculator | 125         |   | India   | Computer   | 1200        |
| USA     | Computer   | 4200        |   | India   | NULL       | 1350        |
| USA     | TV         | 250         |   | USA     | Calculator | 125         |
|         |            |             |   | USA     | Computer   | 4200        |
|         |            |             |   | USA     | TV         | 250         |
|         |            |             |   | USA     | NULL       | 4575        |
|         |            |             |   | NULL    | NULL       | 7535        |

### CASE WHEN

- CASE WHEN을 통해 파생변수를 생성한다.

```sql

SELECT EMAIL 이메일,
	   CONCAT(HEIGHT,'CM',', ',WEIGHT,'KG') AS '키와 몸무게',
	   WEIGHT/((HEIGHT/100) * (HEIGHT/100)) AS BMI,
(CASE
	WHEN WEIGHT IS NULL OR HEIGHT IS NULL THEN '알 수 없음'
	WHEN WEIGHT/((HEIGHT/100) * (HEIGHT/100)) >= 25 THEN '과체중'
	WHEN WEIGHT/((HEIGHT/100) * (HEIGHT/100)) >= 18.5
    	AND  WEIGHT/((HEIGHT/100) * (HEIGHT/100)) < 25
    	THEN '정상'
    ELSE '저체중'
END) AS OBESITY_CHECK

FROM COPANG_MAIN.`MEMBER`
ORDER BY OBESITY_CHECK;


SELECT
    USER_ID,
    CASE 
        WHEN REGISTER_DEVICE = 1 THEN 'DESKTOP'
        WHEN REGISTER_DEVICE = 2 THEN 'SMARTPHONE'
        WHEN REGISTER_DEVICE = 3 THEN 'APPLICATION'
    END AS DEVICE_NAME
FROM MST_USERS;   

```


### 이상치 다루기

- 기본적인 이상치 다루기

```sql
SELECT AVG(AGE) FROM CLUB.MEMBER;
WHERE AGE BETWEEN 5 AND 100; # 범위지정

SELECT * FROM CLUB.MEMBER;
WHERE ADDRESS NOT LIKE '%호'; # 이상한 주소 조회
```

- Single Query로 table의 이상치 계산하기

```sql
with orderedList AS (
SELECT
	full_name,
	age,
	ROW_NUMBER() OVER (ORDER BY age) AS row_n # row_number()는 동일등수가 존재하지 않게끔  rank를 매긴다.
FROM friends
),
iqr AS ( # outlier의 범위를 지정하는 iqr table을 만든다.
SELECT
	age,
    full_name,
	(
		SELECT age AS quartile_break
		FROM orderedList
		WHERE row_n = FLOOR((SELECT COUNT(*)
			FROM friends)*0.75)
			) AS q_three,
	(
		SELECT age AS quartile_break
		FROM orderedList
		WHERE row_n = FLOOR((SELECT COUNT(*)
			FROM friends)*0.25)
			) AS q_one,
	1.5 * ((
		SELECT age AS quartile_break
		FROM orderedList
		WHERE row_n = FLOOR((SELECT COUNT(*)
			FROM friends)*0.75)
			) - (
			SELECT age AS quartile_break
			FROM orderedList
			WHERE row_n = FLOOR((SELECT COUNT(*)
				FROM friends)*0.25)
			)) AS outlier_range
	FROM orderedList
)

# IQR은 기본적으로 75% 지점 - 25% 지점이다.
# IQR에 1.5를 곱해 75% 지점의 값에 더하면 최댓값이다
# IQR에 1.5를 곱해 25% 지점의 값에서 빼면 최소값이다
# 최댓값과 최소값이 각각  outlier의 threshold가 된다.

SELECT full_name, age
FROM iqr
WHERE age >= ((SELECT MAX(q_three)
	FROM iqr) +
	(SELECT MAX(outlier_range)
		FROM iqr)) OR
		age <= ((SELECT MAX(q_one)
	FROM iqr) -
	(SELECT MAX(outlier_range)
		FROM iqr))
```

### ALIAS

### RANK

### Window의 이해

### OVER

over order by로 rank 생성

###

## JOIN

## SUBQUERY

### SELECT 절의 SUBQUERY

### FROM 절의 SUBQUERY

### 중첩질의문

### 단일, 다중행 서브쿼리

## 집합연산자 - Union, Minus

## View

# CRUD

## Managing DataBases


### Create Database

```sql
# mysql -u root -p  로그인

create database if not exists course_rating; 
use course_rating; # 사용db지정
```



## Managing Tables

### Create Table

테이블 생성 예제

```sql
create table 'course_rating'.`student`(
    `id` int not null auto_intrememt,
    `name` varchar(20) not null
    primary key (`id`)
);

create table `animal_info` (
    `id` int not null auto_increment, -- 값이 자동으로 증가하면서 추가됨
    `type` varchar(30) not null ,
    `name` varchar(10) not null,
    `age` tinyint not null,
    `sex`  char(1) not null,
    `weight` double not null,
    `feature` varchar(500) null,
    `entry_date` date not null,
    primary key(id)
);

```

### Delete / Drop Table

```sql
DROP TABLE tablename;
```

### Show Tables

```sql
SHOW TABLES;
```

### 테이블 구조 확인

```sql
DESC TABLE 

EXPLAIN TABLE
```

### Rename Table

```sql
ALTER TABLE T1 RENAME TO T2;
```

### 테이블 삽입, 수정, 삭제

- 삽입
  - row를 추가할 시 값을 더 주지 않은 row는 null이됨
  - PK는 반드시 값이 있어야함
  - auto_increment 속성이 있을 경우 값이 자동으로 추가됨
- 수정
  - update 시 where절을 사용해 조건을 설정해준다.
  - 데이터 타입 변경 시(modify) 변경하려는 데이터 타입이 기존 값에 적합하지 않다면 기존값부터 바꾼 후 타입변경을 해야한다.
- 삭제
  - delete문 사용 기본키 기반으로 삭제
  - 논리삭제 : 삭제여부를 반영하는 컬럼 추가
  - 물리삭제 : 실제 삭제
    - 이미 데이터 분석에 활용한 row
    - 고객이 동의한 데이터 보유기간이 지난 row 

```sql

-- 삽입
    
INSERT INTO sample01 (name,age,gender) VALUES
    ('kim',20,'man'),
    ('Lee',26,'woman'),
    ('Gang',28,'man'),
    ('park',28,'man');


-- 수정
update student
    set major = '심리학과',name = `홍길동`
    where id =32;

# 전체 컬럼에 반영
update student
    set score = score + 3

-- 삭제

DELETE FROM STUDENT WHERE ID = 42;

```

## Managing Columns

- AlTER 문을 사용해 table column을 수정한다.

### 컬럼 추가와 컬럼의 이름 변경

```sql

ALTER TABLE STUDENT ADD GENDER CHAR(1) NULL; # GENDER 컬럼의 추가
ALTER TABLE STUDENT RENAME STUDENT_NUMBER TO REGISTRATION_NUMBER # 컬럼이름 변경

```

### 데이터 타입 변경 컬럼 삭제

- 데이터 타입 변경 시(modify) 변경하려는 데이터 타입이 기존 값에 적합하지 않다면 기존값부터 바꾼 후 타입변경을 해야한다

```sql

# 데이터 타입 변환

UPDATE STUDENT SET MAJOR = 10 WHERE MAJOR = '컴퓨터공학과';
ALTER TABLE STUDENT MODIFY MAJOR INT;

# 컬럼 삭제
ALTER TABLE STUDENT DROP COLUMN ADMISSION_DATE;
```

### modify를 사용한 컬럼 속성추가

```sql
ALTER TABLE MODIFY STUDENT NOT NULL;
```

### 컬럼에 default 값 달기

```SQL

# MAJOR 컬럼에 DEFAULT값 주기
ALTER TABLE STUDENT MODIFY MAJOR INT NOT NULL DEFAULT 101;
INSERT INTO STUDENT (NAME,REGISTRATION_NUMBER)
    VALUES('구지섭','20112405')
```

### 컬럼에 UNIQUE 속성 주기

```SQL

ALTER TABLE STUDENT
    MODIFY REGISTRATION_NUMBER INT NOT NULL UNIQUE;

```
### 컬럼 가장 앞으로 당기기

```SQL

# MODIFY 구문에 FIRST를 넣어준다.
ALTER TABLE PLAYER_INFO
    MODIFY ID INT NOT NULL AUTO_INCREMENT FIRST;
```
### 컬럼 간의 순서 바꾸기

```SQL

ALTER TABLE PLAYER_INFO
    MODIFY ROLE CHAR(5) NULL AFTER NAME;

```

### 컬럼의 이름과 컬럼의 데이터 타입 및 속성 동시에 수정하기

- 컬럼 이름 수정시 rename column A to B 사용
- 컬럼의 타입 및 속성 수정시 modify 사용
- change를 활용 컬럼의 이름과 데이터타입 속성 수정

```SQL
ALTER TABLE PLAYER_INFO
    CHANGE ROLE POSITION VARCHAR(2) NOT NULL;
# ROLE : 기존컬럼이름
# POSITION : 새로운 이름
```


## Constraint

제약조건들

- add constraint 구문을 사용한다
- constraint의 이름을 붙여준다

```SQL
ALTER TABLE STUDENT
    ADD CONSTRAINT ST_RULE CHECK(REGISTRATION_NUMBER < 3000000);

ALTER TABLE STUDENT
    DROP CONSTRAINT ST_RULE; # 제약삭제

ALTER TABLE STUDENT
    ADD CONSTRAINT ST_RULE CHECK(REGISTRATION_NUMBER < 3000000);

# 두 개 이상의 조건을 가진 문자열
ALTER TABLE STUDENT
    DROP CONSTRAINT ST_RULE
    CHECK (EMAIL LIKE '%@%') AND
        GENDER IN ('M','F');
```

**SQL에서 주로 쓰는 Constraints**

- NOT NULL - Ensures that a column cannot have a NULL value
- UNIQUE - Ensures that all values in a column are different
- PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
- FOREIGN KEY - Prevents actions that would destroy links between tables
- CHECK - Ensures that the values in a column satisfies a specific condition
- DEFAULT - Sets a default value for a column if no value is specified
- CREATE INDEX - Used to create and retrieve data from the database very quickly



## Foreign Key

# Data Type

## Type Casting

## Time 관련 함수들

## String 함수들

1. length : 길이 반환
2. upper, lower : 소문자 대문자 변환
3. lpad,rpad : padding 
   LPAD(age, 10, ’0’)는 age 컬럼의 값을, 왼쪽에 문자 0을 붙여서 총 10자리로 만든다. 보통 어떤 숫자의 자릿수를 맞출 때 자주 사용한다
4. trim : 공백문자 삭제
5. substring(문자,시작인덱스,끝인덱스) :  문자열에서 인덱스 기준으로 일부를 추출할 때 사용
6. substring_index :  delimiter 기준으로 문자열을 구분해서 count 위치의 값을 반환. count의 값이 음수일 경우  count하는 방향이 반대가 됨. 주소 구분시 사용가능.

```sql
mysql> SELECT ip, SUBSTRING_INDEX(ip,'.',1) AS part1, 
SUBSTRING_INDEX(SUBSTRING_INDEX(ip,'.',2),'.',-1) AS part2, 
SUBSTRING_INDEX(SUBSTRING_INDEX(ip,'.',-2),'.',1) AS part3, 
SUBSTRING_INDEX(ip,'.',-1) AS part4  FROM log_file;
+-----------------+-------+-------+-------+-------+
| ip              | part1 | part2 | part3 | part4 |
+-----------------+-------+-------+-------+-------+
| 127.0.0.1       | 127   | 0     | 0     | 1     |
| 192.128.0.15    | 192   | 128   | 0     | 15    |
| 255.255.255.255 | 255   | 255   | 255   | 255   |
+-----------------+-------+-------+-------+-------+
```

## 

# Modeling

## 데이터 모델링

### Relational 모델

# 프로시저 , 트리거 사용

사용자정의 함수 만들기

절차적 SQL 쿼리짜기



# DCL 사용자 관리

- mysql 외부계정생성 및 권한부여는 아래와 같이 한다.

```sql
create user '계정이름'@'%' identified by '패스워드';
grant all privileges on *.* to '계정이름'@'%' with grant option;
```

- mysql 에서 root의 비밀번호를 변경할 경우 ``FLUSH PRIVILEGES;``를 해주고 mysql을 재시작한다.

# TCL 트랜잭션 관리

## COMMIT

## ROLLBACK

# Preprocessing Tricks

- 데이터전처리 대전
- 통계 tricks


https://chobopark.tistory.com/117

https://velog.io/@lsh5039/MY-SQL-%EA%B0%81-%ED%85%8C%EC%9D%B4%EB%B8%94-%EC%9D%BC%EC%9E%90%EB%B3%84-%ED%86%B5%EA%B3%84%EC%BF%BC%EB%A6%AC