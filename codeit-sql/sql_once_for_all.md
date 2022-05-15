- [Data Manipulation](#data-manipulation)
  - [데이터 조회](#데이터-조회)
    - [SELECT](#select)
      - [IN](#in)
      - [ANY](#any)
      - [ALL](#all)
      - [EXISTS](#exists)
      - [여러개의 조건 걸기](#여러개의-조건-걸기)
    - [ORDER BY](#order-by)
    - [LIMIT](#limit)
    - [Regular Expression을 활용한 조회](#regular-expression을-활용한-조회)
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
  - [Window의 이해](#window의-이해)
    - [OVER](#over)
    - [RANK 만들기](#rank-만들기)
    - [Window Frame 내부 행 순서관련 함수](#window-frame-내부-행-순서관련-함수)
      - [LEAD](#lead)
      - [LAG](#lag)
      - [First Value](#first-value)
      - [Last Value](#last-value)
    - [Window Frame 내 비율 관련 함수](#window-frame-내-비율-관련-함수)
      - [CUME_DIST](#cume_dist)
      - [NTILE](#ntile)
  - [JOIN](#join)
    - [ALIAS IN JOIN](#alias-in-join)
    - [OUTER JOIN](#outer-join)
    - [같은 종류의 테이블조인](#같은-종류의-테이블조인)
    - [서로 다른 3개의 table 조인](#서로-다른-3개의-table-조인)
  - [SUBQUERY](#subquery)
    - [WHERE 절의 SUBQUERY](#where-절의-subquery)
    - [FROM 절의 SUBQUERY](#from-절의-subquery)
    - [SELECT 절의 SUBQUERY](#select-절의-subquery)
    - [상관서브쿼리와 비상관서브쿼리](#상관서브쿼리와-비상관서브쿼리)
  - [집합연산자 - Union, Minus](#집합연산자---union-minus)
  - [VIEW](#view)
    - [VIEW 예제](#view-예제)
  - [INDEX](#index)
    - [INDEX 예제](#index-예제)
  - [Unsorted Tricks : Data Prep with SQL](#unsorted-tricks--data-prep-with-sql)
    - [Dataset Profiling](#dataset-profiling)
    - [Validate Attributes](#validate-attributes)
    - [Standardize Attributes](#standardize-attributes)
    - [CREATE INTERFATE](#create-interfate)
    - [Clean Attributes](#clean-attributes)
    - [DERIVE ATTRIBUTES](#derive-attributes)
    - [COMBINE DATASETS](#combine-datasets)
    - [SPLIT DATASETS](#split-datasets)
- [CRUD](#crud)
  - [Managing DataBases](#managing-databases)
    - [Create Database](#create-database)
  - [Managing Tables](#managing-tables)
    - [Create Table](#create-table)
    - [Delete / Drop Table](#delete--drop-table)
    - [SHOW TABLES](#show-tables)
    - [테이블 구조 확인](#테이블-구조-확인)
    - [Rename Table](#rename-table)
    - [테이블 삽입, 수정, 삭제](#테이블-삽입-수정-삭제)
    - [Update와 SUBQUERY](#update와-subquery)
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
  - [String 함수들](#string-함수들)
  - [Time 관련 함수들](#time-관련-함수들)
- [DCL](#dcl)
  - [사용자관리](#사용자관리)
    - [Show Users](#show-users)
    - [Create User](#create-user)
    - [Grant All Priveleges On All Databases](#grant-all-priveleges-on-all-databases)
    - [Show Grants](#show-grants)
    - [Remove Grants](#remove-grants)
    - [Delete User](#delete-user)
- [Modeling](#modeling)
  - [데이터 모델링](#데이터-모델링)
    - [Relational 모델](#relational-모델)
- [절차적 SQL](#절차적-sql)
  - [Procedure](#procedure)
    - [프로시저 함수 디버깅](#프로시저-함수-디버깅)
  - [Trigger](#trigger)
  - [Optimizer](#optimizer)
- [TCL 트랜잭션 관리](#tcl-트랜잭션-관리)
  - [COMMIT](#commit)
  - [ROLLBACK](#rollback)
- [Preprocessing Tricks](#preprocessing-tricks)
  - [USE CASE](#use-case)
    - [매출액 조회](#매출액-조회)
  - [Unsorted Tricks](#unsorted-tricks)
    - [MySQL 스키마 별 전체 테이블 행 개수 확인](#mysql-스키마-별-전체-테이블-행-개수-확인)
    - [외부 DB 연결](#외부-db-연결)
  - [References](#references)

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

가장 흔하게 쓰이는 쿼리들

```sql
-- **칼럼조회**

SELECT CUSTOMERNUMBER
FROM CLASSICMODELS.CUSTOMERS;

-- **집계함수**

SELECT SUM(AMONUT), COUNT(CUSTOMERNUMBER)
FROM CLASSICMODELS.PAYMENTS;

-- **모든 결과 조회**

SELECT * FROM CLASSICMODELS.CUSTOMERS;

-- **ALIAS**

SELECT COUNT(PRODUCTCODE) AS N_PRODUCTS
FROM CLASSICMODELS.PRODUCTS;

-- **중복제거**

SELECT DISTINCT ORDERNUMBER
FROM CLASSICMODELS.ORDERDETAILS;

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

- OR 연산자

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
SELECT * from club.`member` where gender = 'm' # 성별 남자 및 주소 서울
	and address like '서울%'
	and age BETWEEN 25 and 29;

### 봄이나 가을에 가입한 회원 조회
SELECT * FROM club.`member`
where MONTH(sign_up_day) BETWEEN 3 and 5
or MONTH(sign_up_day) BETWEEN 7 and 9

### and와 or 같이 사용하기
SELECT * FROM club.`member`
where (gender = 'm' and height >= 180)
or (gender = 'f' and height >=170)

-- tip : and 가 or 보다 우선순위가 높으며 사용자가 우선적으로 실행되기 원하는 조건을 괄호를 씌우는 편이 좋다.

SELECT * FROM club.`member` Where age NOT BETWEEN 20 AND 29;

```

### ORDER BY

- ORDER BY는 이름을 먼저 쓴 컬럼 기준으로 차례대로 수행된다.  
- SQL 문법 상 WHERE는 ORDER BY 앞에 나온다.
- **주의사항**
  1. 숫자형인 경우 -> 숫자의 크고 작음 기준으로 정력
  2. 문자열형인 경우 -> 문자 순서를 비교해서 정렬 수행
  3. 문자형을 숫자로 나타내고 싶을 경우 CAST 함수를 사용한다 ->
     - ORDER BY CAST(DATA AS SIGNED) -> 일시적으로 컬럼을 SIGNED 라는 데이터 타입으로 변환

```SQL
SELECT * FROM CLUB.`MEMBER`  # ORDER BY는 DEFAULT로 오름차순으로 정렬
ORDER BY HEIGHT ;

SELECT * FROM CLUB.`MEMBER`  # 내림차순 정렬
ORDER BY HEIGHT DESC ;

SELECT * FROM CLUB.`MEMBER` # 조건식 걸고 정렬
WHERE GENDER = 'M'
	AND WEIGHT >= 70 # 내림차순 정렬
ORDER BY HEIGHT DESC ;

SELECT SIGN_UP_DAY,EMAIL FROM CLUB.`MEMBER` # 조건식 걸고 정렬
ORDER BY YEAR(SIGN_UP_DAY) DESC, EMAIL ASC; # 가입년 기준 내림차순 정렬,가입년이 같을 경우 이메일 기준 오름차순
```

### LIMIT

- LIMIT N : 출력개수 N개 제한  
- LIMIT M,N : M번째부터 N개 출력

```sql
SELECT * FROM club.member
ORDER BY sign_up_day DESC
LIMIT 10;

SELECT * FROM club.member
ORDER BY sign_up_day DESC
LIMIT 8,2; # 8번째 row부터 2개 추림 // row index는 0번부터 시작 9번째, 10번째로
```


### Regular Expression을 활용한 조회

1. `^(caret)`
:라인이나 문자열의 처음을 표시
   - ex) ^head : 문자열의 처음에 head를 포함하면 True

2. `$`
: 라인이나 문자열의 끝을 표시
   - ex) tail$ : 문자열의 끝에 tail이 있으면 True

3. `.(period)`
: 임의의 한 문자를 표시
   - ex) : ^a.c 일 경우 abc, adc, aHc 등은 True 반환, aa는 False

4. `{}(bracket)`
: {} 내의 숫자는 선행문자가 등장하는 횟수나 범위를 지정한다.
   - 문자{n} : n회 나타나는 문자
   - 문자{n,} : 적어도 n회 이상 나타나는 문자
   - 문자{n,m} : m회이상 n회 이하 나타나는 문자 
   - ex) : ab{2,3} abb와 abbb 만 해당
   - ex) : 육{1,3} '육'이 1회 이상 3회 이하 등장하는 문자열을 찾음
5. [](bracket)
: 문자의 집합이나 범위를 지정. 범위를 지정할 경우 "-" 사용
   - [] 안에서 의 ^는 일치하지 않음을 의미
   - [] 안에 \d(숫자) , \w(문자) 등 지정된 문자 클래스를 넣어서 조회할 수 있다.
   - ex) [abc] abc 중 어떤 문자
   - ex) [-a-z] hyphen과 모든 대문자
   - ex) [^a-z] 소문자 이외의 문자

6. `*(asterisk)`
: 직전의 문자가 0번 또는 여러번 나타나는 문자열 찾기
   - ex) ab*c ('b') 를 0 번 또는 여러번 포함하는 ac, abc, abbbbc
   - ex) * 선행문자가 없기에 임의의 문자열 및 공백문자열을 찾음
   - ex) .* 선행문자가 .이기 때문에 하나 이상의 문자를 포함하는 문자열
   - ex) num[1-9]* num

7. `+` 
: 직전의 선행문자가 1번 이상 나타나는 문자열
   - ex) [A-Z]+ 대문자로만 이루어진 문자열을 찾음
   - ex) ab+c b를 1번 또는 여러번포함하기 때문에 abc, abcd, abbc 등을 사용함
   - ex) like.+ 선행문자가 . 이기 때문에 like에 하나 이상의 문자가 추가된 문자열 리턴

8. `?` Question Mark
: '+' 직전의 선행문자가 1번 이상 나타나는 문자열
   - ex) ab?c b를 0번 또는 

9. `\`
: 뒤에 나오는 특수문자를 정규식 내에서 일반문자로 인식
   - ex) [\?\[\\\]] (‘?’, ‘[‘, ‘\’, ‘]’ 중 하나)
   - ex) filename\.ext (“filename.ext”를 나타냄)

10. `()`
: 괄호 내 표현식을 한 단위로 취급

11. `|`
: or 과 같은 기능 여러 문자중 하나와 일치

```sql
#'홍' 또는 '길' 또는 '동'이 포함된 문자열을 찾고 싶을 때

-- 정규표현식을 사용하지 않을 때

SELECT *
FROM tbl
WHERE data like '%홍%'
OR data like '%길%'
OR data like '%동%'

--- 정규표현식을 사용할 때

SELECT *
FROM tbl
WHERE data REGEXP '홍|길|동'

-- ‘안녕’ 또는 ‘하이’로 시작하는 문자열을 찾고 싶을 때
# 정규표현식을 사용하지 않을 때 

SELECT *
FROM tbl  
WHERE data LIKE '안녕%' OR data LIKE '하이%';
# 정규표현식을 사용할 때 

SELECT *
FROM tbl
WHERE data REGEXP ('^안녕|^하이');


-- 길이 7글자인 문자열 중 2번째 자리부터 abc를 포함하는 문자열을 찾고 싶을 때
# 정규표현식을 사용하지 않을 때

SELECT *
FROM tbl
WHERE CHAR_LENGTH(data) = 7 AND SUBSTRING(data, 2, 3) = 'abc';
# 정규표현식을 사용할 때
SELECT *
FROM tbl
WHERE data REGEXP ('^.abc...$');

-- 텍스트와 숫자가 섞여 있는 문자열에서 숫자로만 이루어진 문자열을 찾고 싶을 때
# 정규표현식을 사용하지 않을 때

SELECT *
FROM tbl
WHERE DATA LIKE ??????????  # WILD  CARD를 사용할 수 있다.

# 정규표현식을 사용할 때

SELECT *
FROM tbl
WHERE data REGEXP ('^[0-9]+$'); 
-- OR data REGEXP ('^\d$') 
-- OR data REGEXP ('^[:digit:]$');
```
MySQL에서 제공하는 정규표현식 함수들
- REGEXP :  정규식 일치 여부에 대한 True/False 반환
- REGEXP_INSTR : 정규식 일치가 발견된 인덱스를 반환
- REGEXP_LIKE : like 와 유사하지만 정규식 기준으로 
- REGEXP_REPLACE : 정규식 패턴을 검색하여 대체문자열로 바꾼다
- REGEXP_SUBSTR : SUBSTR 함수의 정규식 버전
  - [^:]+ = > ^: 아닌 연속된 문자(+) 중에서 3번째 문자열을 반환
  - [^ 문자] 를 이용하면 원하는 문자를 기준으로 데이터를 추출할 수 있다.

```sql
select regexp_substr('sys/oracle@racdb:1521:racdb' , '[^:]+' , 1, 3) 
from dual;
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

SELECT COUNT(*) FROM CLUB.`MEMBER`; # 테이블 전체 행 숫자 리턴

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
SELECT DISTINCT(GENDER) FROM club.`MEMBER`;

SELECT DISTINCT(SUBSTRING(ADDRESS,1,2)) FROM club.`MEMBER`;
# SUBSTRING을 활용한 지역 고윳값 찾기

SELECT COUNT(DISTINCT(SUBSTRING(ADDRESS,1,2))) FROM club.`MEMBER`; #고윳값 개수구하기
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

SELECT * FROM CLUB.MEMBER 
WHERE ADDRESS IS NULL
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

- https://royzero.tistory.com/50
- WITH statement는 SUBQUERY BLOCK에 naming을 해주는 것이다.
- WITH은 기본적으로 가상테이블을 생성하는 역할을 한다.
- **WITH절로 생성된 가상테이블은 재사용이 가능하기 때문에 조건절의 수정이 수월해진다.**

```sql
-- temp table 1개
WITH 임시테이블명 AS ( SUB QUERY문 (SELECT절) ) 
SELECT 컬럼, [컬럼, ...] FROM 임시테이블명 

--* 2개 이상의 임시테이블 */ 
WITH 임시테이블명1 AS ( SUB QUERY문 (SELECT절) ), 
     임시테이블명2 AS ( SUB QUERY문 (SELECT절) ) 
     SELECT 컬럼, [컬럼, ...] 
     FROM 임시테이블명1 , 임시테이블명2

```
- WITH 을 활용한 가상테이블 예시
이 경우 조건절을 여러번 수정할 필요가 없기 때문에 개발자 입장에서 사용하기 보다 수월해진다.

```sql
WITH VW_VENDOR AS ( 
  SELECT S.SITE_CODE, S.SITE_NAME, V.VNDR_CODE, V.VNDR_NAME 
  FROM TB_SITE AS S JOIN TB_SITE_VENDOR AS SV ON S.SITE_CODE = SV.SITE_CODE 
  WHERE S.SITE_CODE = '101' 
UNION ALL 
SELECT S.SITE_CODE, S.SITE_NAME, V.VNDR_CODE, V.VNDR_NAME 
FROM TB_SITE AS S JOIN TB_SITE_VENDOR AS SV ON S.SITE_CODE = SV.SITE_CODE 
WHERE S.SITE_CODE = '102' ) 
SELECT * FROM VW_VENDOR WHERE VNDR_CODE = '1001'
```

### GROUP BY

그룹단위로 통계량을 계산하고자 할 때 GROUP BY를 이용한다.

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

- 왼쪽이 원본데이터이고 오른쪽이 ROLLUP을 적용한 경우이다.
- 용법은 GROUP BY 그룹칼럼 , 그룹별 연산을 적용할 칼럼 WITH ROLLUP 이다. 

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

ROLLUP은 집계한 PRODUCT 값을 기본적으로 NULL값으로 대체한다. `COALESCE` 를 사용해 이를 원하는 텍스트로 치환할 수 있다.

```sql
SELECT COALESCE(COUNTRY,"SUM_COUNTRIES") AS COUNTRY, 
       COALESCE(PRODUCT,"SUM_PRODUCTS") AS PRODUCT, 
       SUM(PROFIT) FROM SALES GROUP BY COUNTRY, PRODUCT WITH ROLLUP;
```


### CASE WHEN

- CASE WHEN을 통해 파생변수를 생성한다.

```SQL

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

FROM CLUB.`MEMBER`
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
WITH ORDEREDLIST AS (
SELECT
	FULL_NAME,
	AGE,
	ROW_NUMBER() OVER (ORDER BY AGE) AS ROW_N # ROW_NUMBER()는 동일등수가 존재하지 않게끔  RANK를 매긴다.
FROM FRIENDS
),
IQR AS ( # OUTLIER의 범위를 지정하는 IQR TABLE을 만든다.
SELECT
	AGE,
    FULL_NAME,
	(
		SELECT AGE AS QUARTILE_BREAK
		FROM ORDEREDLIST
		WHERE ROW_N = FLOOR((SELECT COUNT(*)
			FROM FRIENDS)*0.75)
			) AS Q_THREE,
	(
		SELECT AGE AS QUARTILE_BREAK
		FROM ORDEREDLIST
		WHERE ROW_N = FLOOR((SELECT COUNT(*)
			FROM FRIENDS)*0.25)
			) AS Q_ONE,
	1.5 * ((
		SELECT AGE AS QUARTILE_BREAK
		FROM ORDEREDLIST
		WHERE ROW_N = FLOOR((SELECT COUNT(*)
			FROM FRIENDS)*0.75)
			) - (
			SELECT AGE AS QUARTILE_BREAK
			FROM ORDEREDLIST
			WHERE ROW_N = FLOOR((SELECT COUNT(*)
				FROM FRIENDS)*0.25)
			)) AS OUTLIER_RANGE
	FROM ORDEREDLIST
)

# IQR은 기본적으로 75% 지점 - 25% 지점이다.
# IQR에 1.5를 곱해 75% 지점의 값에 더하면 최댓값이다
# IQR에 1.5를 곱해 25% 지점의 값에서 빼면 최소값이다
# 최댓값과 최소값이 각각  OUTLIER의 THRESHOLD가 된다.

SELECT FULL_NAME, AGE
FROM IQR
WHERE AGE >= ((SELECT MAX(Q_THREE)
	FROM IQR) +
	(SELECT MAX(OUTLIER_RANGE)
		FROM IQR)) OR
		AGE <= ((SELECT MAX(Q_ONE)
	FROM IQR) -
	(SELECT MAX(OUTLIER_RANGE)
		FROM IQR))
```

### ALIAS

ALIAS 는 파생컬럼에 이름을 붙이거나 JOIN시 테이블 구분용으로 사용한다.

```sql

SELECT EMAIL 이메일,
	   HEIGHT 키,
	   WEIGHT 몸무게,
	   WEIGHT/((HEIGHT/100) * (HEIGHT/100)) AS BMI
FROM MEMBER; # HEIGHT를 100으로 나눈 이유는 단위를 맞춰주기 위해서


SELECT EMAIL 이메일,
	   CONCAT(HEIGHT,'CM',', ',WEIGHT,'KG') AS '키와 몸무게',
	   WEIGHT/((HEIGHT/100) * (HEIGHT/100)) AS BMI
FROM MEMBER;
```

## Window의 이해

기본적으로 행과 행 간의 관계를 쉽게 재정의하기 위해 만든 함수가 Window 함수이다.
분석함수나 순위함수로 주로 쓰인다.

**window function 종류**

- 그룹 내 순위 관련 함수 : RANK, DENSE_RANK, ROW_NUMBER
- 그룹 내 집계함수 : SUM, MAX , MIN, AVG, COUNT
- 그룹 내 행 순서 관련 함수 : FIRST_VALUE, LAST_VALUE, LAG, LEAD
- 그룹 내 비율 관련 함수 : CUME_DIST, NTILE

### OVER

https://learnsql.com/blog/over-clause-mysql/

>**각 행별로 특정 기준에 따라 필요한 집합을 구해 함수를 적용시킬 때 OVER 을 이용한다.**
>**Patition By는 기본적으로 WINDOW의 frame을 지정해주는 역할을 한다.**


over 절은 기본적으로 함수를 적용시킬 행의 범위를 지정해준다.
over 은 행과 행 간의 관계를 정의하는 window 함수이다.
group by 와 달리 결과 행 개수에 영향을 미치지 않는다.
over 절 내부에 order by 속성을 적용할 경우  **날짜 단위로** window가 생성된다.

```sql
SELECT ID , CROP_DATE, SUM(COUNT) OVER(ORDER BY CROP_DATE) AS INVENTORY
FROM HOUSE
```

over 함수에 partition by를 적용할 경우 partition by 를 적용한 속성의 고유값(unique value) 단위로 window가 생성되며  group by와 달리 행의 수는 변하지 않는다. 아래 예시데이터에서 쿼리문을 생성하면 경우 window가 'Golden' ,'SuperSun' 이 생성되며 각각의  그룹 기준으로 kilos_produced에 대한 합계가 계산된다.

```sql

SELECT FARMER_NAME,
       ORANGE_VARIETY,
     CROP_YEAR,
       KILOS_PRODUCED,
       SUM(KILOS_PRODUCED) OVER(PARTITION BY ORANGE_VARIETY) AS TOTAL_SAME_VARIETY
FROM ORANGE_PRODUCTION

```

| farmer_name | orange_variety | crop_year | number_of_trees | kilos_produced | year_rain | kilo_ price |
|-------------|----------------|-----------|-----------------|----------------|-----------|-------------|
| Pierre      | Golden         | 2015      | 2400            | 82500          | 400       | 1.21        |
| Pierre      | Golden         | 2016      | 2400            | 51000          | 180       | 1.35        |
| Olek        | Golden         | 2017      | 4000            | 78000          | 250       | 1.42        |
| Pierre      | Golden         | 2017      | 2400            | 62500          | 250       | 1.42        |
| Olek        | Golden         | 2018      | 4100            | 69000          | 150       | 1.48        |
| Pierre      | Golden         | 2018      | 2450            | 64500          | 200       | 1.43        |
| Simon       | SuperSun       | 2017      | 3500            | 75000          | 250       | 1.05        |
| Simon       | SuperSun       | 2018      | 3500            | 74000          | 150       | 1.07        |


### RANK 만들기

- RANK : ORDER BY를 포함한 쿼리문에서 특정 항목에 대한 순위 생성 . 동일한 값이라면 같은 순위를 부여함

```sql
SELECT JOB, ENAME, SAL,
  RANK() OVER (ORDER BY SAL DESC) ALL_RANK,  -- 급여 높은 순
  RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK -- job 별로 급여 높은 순
FROM EMP ;        
```

- OVER ORDER BY로 RANK 생성하는 경우

- DENSE_RANK : RANK와 같지만 동일한 순위를 하나의 건수로 취급. 1위개 2개일 경우 3위로 넘어감

```sql
SELECT   JOB, ENAME, SAL,
         RANK()       OVER (ORDER BY SAL DESC) ALL_RANK,  
         DENSE_RANK() OVER (ORDER BY SAL DESC) DENSE_RANK 
FROM     EMP ;    
```

- ROW_NUMBER :  RANK, DENSE_RANK가 동일한 값에 대해서는 동일한 순위를 부여하는데 반해 ROW_NUMBER는 동일한 값이라도 고유한 순위를 부여한다.
```sql
SELECT   JOB, ENAME, SAL,
         RANK()       OVER (ORDER BY SAL DESC) ALL_RANK,  
         ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUMBER
FROM     EMP ;    
```

- 각 RANK 함수 비교

```sql
mysql> SELECT
         val,
         ROW_NUMBER() OVER w AS 'row_number',
         RANK()       OVER w AS 'rank',
         DENSE_RANK() OVER w AS 'dense_rank'
       FROM numbers
       WINDOW w AS (ORDER BY val);
+------+------------+------+------------+
| val  | row_number | rank | dense_rank |
+------+------------+------+------------+
|    1 |          1 |    1 |          1 |
|    1 |          2 |    1 |          1 |
|    2 |          3 |    3 |          2 |
|    3 |          4 |    4 |          3 |
|    3 |          5 |    4 |          3 |
|    3 |          6 |    4 |          3 |
|    4 |          7 |    7 |          4 |
|    4 |          8 |    7 |          4 |
|    5 |          9 |    9 |          5 |
+------+------------+------+------------+
```

### Window Frame 내부 행 순서관련 함수

#### LEAD

현재 행 기준으로 다음 행의 값을 알고 싶을 때 사용

```sql

-- customer 기준으로  window frame을 만들어서 orderdate의 다음행 값을 출력

SELECT 
    CUSTOMERNAME,
    ORDERDATE,
    LEAD(ORDERDATE,1) OVER (
        PARTITION BY CUSTOMERNUMBER
        ORDER BY ORDERDATE ) NEXTORDERDATE
FROM 
    ORDERS
INNER JOIN CUSTOMERS USING (CUSTOMERNUMBER);
```

#### LAG

현재 행 기준으로 이전 행의 값을 알고 싶을 때 사용
파티션별 Window Frame에서 이전 N번째 행을 가져옴

- LAG(SAL, 2, 0) <-- 두번째 인수는 몇 번째 앞의 행을 가져올지 결정하는 것이고 (디폴트는 1. 여기서는 2을 지정했으니까 2번째 앞에 있는 행을 가져오는 것), 세번째 인수는 파티셧 첫 번째 행의 경우 가져올 데이터가 없어 NULL 값이 들어오는데, 이 경우 다른 값으로 바꾸어줄 수 있다.

```sql
-- 직원들을 입사일자가 빠른 기준으로 정렬하고 본인들보다 입사일자가 한 명 앞선 사원의 급여를 본인의 급여와 함께 출력

SELECT  ENAME, HIREDATE, SAL,
        LAG(SAL,1) OVER (ORDER BY HIREDATE) PREV_SAL
FROM    EMP
WHERE   JOB = 'SALESMAN' 
```

#### First Value

Window Frame에서 가장 먼저나온 값 반환

```sql
SELECT  DEPTNO, ENAME, SAL,
        FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC
        ROWS UNBOUNDED PRECEDING) DEPT_RICH
FROM    EMP ; 
```

#### Last Value

Window Frame에서 가장 나중에 나온 값 반환

```sql

-- 부서별 직원들을 연봉 높은 순으로 
SELECT  DEPTNO, ENAME, SAL,
        LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC
        ROW BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) DEPT_POOR
FROM    EMP ; 
```

### Window Frame 내 비율 관련 함수

#### CUME_DIST

: 누적분포치를 계산하는 함수
행의 해당하는 window frame(여기서는 val) 의 누적분포치를 계산한다.

```sql
mysql> SELECT
         val,
         ROW_NUMBER()   OVER w AS 'row_number',
         CUME_DIST()    OVER w AS 'cume_dist',
         PERCENT_RANK() OVER w AS 'percent_rank'
       FROM numbers
       WINDOW w AS (ORDER BY val);
+------+------------+--------------------+--------------+
| val  | row_number | cume_dist          | percent_rank |
+------+------------+--------------------+--------------+
|    1 |          1 | 0.2222222222222222 |            0 |
|    1 |          2 | 0.2222222222222222 |            0 |
|    2 |          3 | 0.3333333333333333 |         0.25 |
|    3 |          4 | 0.6666666666666666 |        0.375 |
|    3 |          5 | 0.6666666666666666 |        0.375 |
|    3 |          6 | 0.6666666666666666 |        0.375 |
|    4 |          7 | 0.8888888888888888 |         0.75 |
|    4 |          8 | 0.8888888888888888 |         0.75 |
|    5 |          9 |                  1 |            1 |
+------+------------+--------------------+--------------+
```

#### NTILE

partition 변수를 N개의 bucket으로 나눈 숫자를 부여한다.
구체적으로는 데이터를 그룹별로 나누어 차례대로 행 번호를 부여한다.

```sql
SELECT NTILE([그룹으로 나눌 정수]) OVER (PARTITION BY [컬럼1] ORDER BY [컬럼2])


mysql> SELECT
         val,
         ROW_NUMBER() OVER w AS 'row_number',
         NTILE(2)     OVER w AS 'ntile2',
         NTILE(4)     OVER w AS 'ntile4'
       FROM numbers
       WINDOW w AS (ORDER BY val);
+------+------------+--------+--------+
| val  | row_number | ntile2 | ntile4 |
+------+------------+--------+--------+
|    1 |          1 |      1 |      1 |
|    1 |          2 |      1 |      1 |
|    2 |          3 |      1 |      1 |
|    3 |          4 |      1 |      2 |
|    3 |          5 |      1 |      2 |
|    3 |          6 |      2 |      3 |
|    4 |          7 |      2 |      3 |
|    4 |          8 |      2 |      4 |
|    5 |          9 |      2 |      4 |
+------+------------+--------+--------+
```




## JOIN

JOIN을 쓰려면 우선 TABLE 간의 관계를 나타내는 FOREIGN KEY가 설정되어 있어야 한다.

- foregn key 설정하기

```sql
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
```


- 테이블 조인

```sql
SELECT ATT1, ATT2
FROM TB1 A INNER JOIN TB2 B 
ON A.ATT1 = B.ATT2

```

### ALIAS IN JOIN

*  alias는 FROM 절에 넣을 수 있다
* SELECT 명의 테이블 이름도 전부 alias로 바꿔준다
* 한번 alias 를 붙였으면 다른 모든 절에서 그 테이블은 그 alias로만 나타내야 한다

```sql
SELECT
	i.id,
	i.NAME,
	s.ITEM_ID,
	s.INVENTORY_COUNT
FROM item AS i RIGHT OUTER JOIN stock AS s
ON i.id = s.item_id;
```

### OUTER JOIN

-  두 테이블을 조인할 시 한 쪽에는 데이터가 있고, 한 쪽에는 데이터가 없는 경우, 데이터가 있는 쪽 테이블의 내용을 모두 출력하는 방법
-  

```sql
-- left outer join 예시

SELECT
	ITEM.ID,
	ITEM.NAME,
	STOCK.ITEM_ID,
	STOCK.INVENTORY_COUNT
FROM ITEM LEFT OUTER JOIN STOCK
ON ITEM.ID = STOCK.ITEM_ID;

-- right outer join 예시

SELECT
	ITEM.ID,
	ITEM.NAME,
	STOCK.ITEM_ID,
	STOCK.INVENTORY_COUNT
FROM ITEM RIGHT	OUTER JOIN STOCK
ON ITEM.ID = STOCK.ITEM_ID;

```

### 같은 종류의 테이블조인

- 시점에 따른 차이를 확인하기 위해 같은 종류의 테이블을 조인해야할 경우가 있다.
- 아래의 경우 기존 상품 정보 중 누락된 정보를 찾기 위해 사용한다.

```sql
SELECT
	OLD.id,
	OLD.name,
	NEW.id AS newid,
	NEW.name AS newname
FROM item AS OLD right OUTER JOIN item_new AS NEW
ON OLD.id = NEW.id
WHERE OLD.id is NULL; # new에서 새롭게 추가한 table을 보고싶은 경우

SELECT
	OLD.id,
	OLD.name,
	NEW.id AS newid,
	NEW.name AS newname
FROM item AS OLD left OUTER JOIN item_new AS NEW
ON OLD.id = NEW.id
WHERE NEW.id is NULL; # old에 있었지만 new에서 사라진 row 확인

SELECT * FROM item
UNION
SELECT * FROM item_new;
```

### 서로 다른 3개의 table 조인

- 연결고리 역할을 하는 테이블을 활용해 2번 Join한다.

```sql

SELECT
	i.name,i.id,
	r.item_id, r.star, r.comment, r.mem_id,
	m.id, m.email
FROM
	item AS i LEFT OUTER JOIN review AS r
		ON r.item_id = i.id
	LEFT OUTER JOIN member AS m
		ON r.mem_id = m.id;

SELECT *
FROM
    item AS i inner JOIN review AS r
        ON r.item_id = i.id
            inner JOIN member AS m
        ON r.mem_id = m.id;
```

## SUBQUERY

**서브쿼리 사용상황**

  - 가장 기본적으로 알려지지 않은 조건을 사용해서 조회해야할 때
  - DB에 접근하는 속도를 향상시킬 때

**사용시 주의점**

  - 항상 괄호로 감싸서 사용할 것
  - 서브쿼리의 결과가 2건 이상이라면(다중행) 반드시 비교연산자와 함께 사용한다,
  - 서브쿼리 내에서는 order by 사용 못함( order by는 쿼리에서 하나만 사용)
  - 서브쿼리는 메인쿼리의 컬럼을 모두 사용할 수 있지만, 메인쿼리는 서브쿼리의 컬럼을 사용할 수 없다.
  - 질의 결과에 서브쿼리 컬럼을 표시해야 한다면 조인 방식으로 변환하거나 함수, 스칼라 서브쿼리 등을 사용해야 한다.

**종류**

- 단일 행 서브쿼리 : 특정 행을 반환. 이 행을 조건절도도 사용가능
ex) 평균값알아내는 서브쿼리를 통해 평균값 이상의 그룹을 출력
- 다중행 서브쿼리 : 결과가 2건이상 반환되는 서브쿼리. 반드시 비교연산자와 함께 사용. Where 절에 괄호로 들어간다.
  - IN(서브쿼리) : 서브쿼리의 결과에 존재하는 값과 동일한 조건의미
  - ALL(서브쿼리) : 모든 값을 만족하는 조건
  - ANY(서브쿼리) : 비교연산자에 “>” 를 썼다면 ANY가 어떤 하나라도 맞는지 조건이기 때문에 결과중에 가장 작은값보다 크면 만족한다.
  - EXIST(서브쿼리) : 서브쿼리의 결과를 만족하는 값이 존재하는지 여부 확인. 존재유무만 확인하기에 1건만 찾으면 더 이상검색안함
- 다중 컬럼 서브쿼리 : 서브쿼리 결과로 여러 개의 컬럼이 반환되어 메인쿼리 조건과 동시에 비교되는 것
  ```SQL
  SELECT ORD_NUM, AGENT_CODE, ORD_DATE, ORD_AMOUNT
  FROM ORDERS
  WHERE(AGENT_CODE, ORD_AMOUNT) IN
  (SELECT AGENT_CODE, MIN(ORD_AMOUNT)
  FROM ORDERS 
  GROUP BY AGENT_CODE); 
  ```

### WHERE 절의 SUBQUERY

```sql
-- where 절에서 서브쿼리로 정의한 조건을 select 절에 쓸 수 있다.

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

-- 서브쿼리 조건문처럼 사용하기

SELECT *
  FROM tutorial.sf_crime_incidents_2014_01
 WHERE Date = (SELECT MIN(date)
                 FROM tutorial.sf_crime_incidents_2014_01
              )

```

### FROM 절의 SUBQUERY

- SQL이 실행될 때만 동적으로 생성되는 Inline View

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

- 서브쿼리로 생성한 파생테이블은 반드시 alias를 가져야 한다.

```sql
SELECT
    SUBSTRING(ADDRESS,1,2) AS REGION,
    COUNT(*) AS REVIEW_COUNT
FROM REVIEW AS R LEFT OUTER JOIN MEMBER AS M
ON R.MEM_ID = M.ID
GROUP BY SUBSTRING(ADDRESS,1,2)
HAVING REGION IS NOT NULL
    AND REGION != '안드'

SELECT AVG(REVIEW_COUNT),
       MAX(REVIEW_COUNT),
       MIN(REVIEW_COUNT)
FROM
(SELECT
    SUBSTRING(ADDRESS,1,2) AS REGION,
    COUNT(*) AS REVIEW_COUNT
FROM REVIEW AS R LEFT OUTER JOIN MEMBER AS M
ON R.MEM_ID = M.ID
GROUP BY SUBSTRING(ADDRESS,1,2)
HAVING REGION IS NOT NULL
    AND REGION != '안드') AS REVIEW_COUNT_SUMMARY #서브쿼리로 탄생한 파생테이블은 반드시 alias를 가져야 한다
```

### SELECT 절의 SUBQUERY

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

### 상관서브쿼리와 비상관서브쿼리

- 상관서브쿼리와 비상관서브쿼리의 차이는 기본적으로 단독실행가능 여부이다.
- 서브쿼리 단독실행 가능할 경우 비상관서브쿼리 
- 서브쿼리에 사용되는 테이블이 outer query에 있어 단독실행 불가능할 경우 상관서브쿼리

```sql
SELECT * FROM ITEM
    WHERE ID IN
    (SELECT ITEM_ID
     FROM REVIEW
     GROUP BY ITEM_ID
     HAVING COUNT(*) >= 3); # 서브쿼리 단독실행 가능할 경우 비상관 서브쿼리

SELECT * FROM ITEM
WHERE EXISTS (SELECT * FROM REVIEW
              WHERE REVIEW.ITEM_ID = ITEM.ID); # 상관서브쿼리
```

- exists가 없는 상관서브쿼리

```sql
SELECT * ,
(SELECT MIN(HEIGHT)
    FROM MEMBER AS M2 WHERE BIRTHDAY IS NOT NULL AND HEIGHT IS NOT NULL
        AND YEAR(M1.BIRTHDAY) = YEAR(M2.BIRTHDAY)) AS MIN_HEIGHT_IN_THE_YEAR
FROM MEMBER AS M1
ORDER BY MIN_HEIGHT_IN_THE_YEAR; # self 조인방식으로 같은 해에 태어난 회원들 중 가장 작은 키를 가진 회원정보를 담은 칼럼 추가

SELECT MAX(COPANG_REPORT.PRICE) AS MAX_PRICE,
       AVG(COPANG_REPORT.STAR) AS AVG_STAR,
       COUNT(DISTINCT(COPANG_REPORT.EMAIL)) AS DISTINCT_EMAIL_COUNT
FROM (SELECT PRICE,
             STAR,
             EMAIL
      FROM
      MEMBER AS M INNER JOIN REVIEW AS R
      ON R.MEM_ID = M.ID
            INNER JOIN ITEM AS I
      ON R.ITEM_ID = I.ID) AS COPANG_REPORT;
```


## 집합연산자 - Union, Minus

- JOIN은 결합연산이고 INTERSECT,UNION,MINUS 등의 연산은 집한연산이다.

(1) A ∩ B (INTERSECT 연산자 사용)

```SQL

SELECT * FROM MEMBER_A

INTERSECT

SELECT * FROM MEMBER_B
```
(2) A - B (MINUS 연산자 또는 EXCEPT 연산자 사용)

```SQL

SELECT * FROM MEMBER_A

MINUS

SELECT * FROM MEMBER_B
```

(3) B - A (MINUS 연산자 또는 EXCEPT 연산자 사용)
```SQL
SELECT * FROM MEMBER_B

MINUS

SELECT * FROM MEMBER_A
```

(4) A U B (UNION 연산자 사용)
```SQL
SELECT * FROM MEMBER_A

UNION

SELECT * FROM MEMBER_B
```


## VIEW

VIEW는 일종의 가상 테이블이다. 사용자의 입장에서는 테이블과 동일하지만 VIEW는 실제 데이터를 가지고 있지 않다.
실제 테이블에 링크된 개념으로 보안상의 이슈로 인한 접근제한을 위해 주로 사용된다.

### VIEW 예제
https://sassun.tistory.com/92

```sql
-- 별점평균 가장높은 ID
CREATE VIEW THREE_TABLES_JOINED AS
    SELECT I.ID,I.NAME,AVG(STAR) AS AVG_STAR , COUNT(*) AS COUNT_STAR
        FROM ITEM AS I LEFT OUTER JOIN REVIEW AS R
            ON R.ITEM_ID = I.ID
        LEFT OUTER JOIN MEMBER AS M
            ON R.MEM_ID = M.ID
        WHERE M.GENDER = 'F'
        GROUP BY I.ID, I.NAME
        HAVING COUNT(*) >= 2
        ORDER BY AVG(STAR) DESC, COUNT(*) DESC;

    SELECT * FROM COPANG_MAIN.THREE_TABLES_JOINED
        WHERE AVG_STAR = (
            SELECT MAX(AVG_STAR) FROM COPANG_MAIN.THREE_TABLES_JOINED
        ); # VIEW를 활용해 짧은 쿼리로 중첩서브쿼리와 같은 쿼리 반환
```

## INDEX

https://wakestand.tistory.com/515

INDEX는 기본적으로 테이블을 빨리 조회하기 위해 테이블데이터에 포인터를 주는 것이다.

- 인덱스는 책의 목차와도 같아서 특정 컬럼에 인덱스를 지정해주면 테이블 조회시 인덱스르 이용해 빠르게 조회가 가능
- 컬럼에 NULL이 많을 경우 검색속도가 오히려 느려진다.
- 지나치게 많은 INDEX를 지정하거나 NULL이 많은 컬럼 , 삽입 수정이 자주 이루어지는 테이블에는 INDEX 를 쓰지 않는 것이 좋다.


### INDEX 예제

```sql

-- 인덱스 타는지 확인 (Type가 ALL이고 possible keys가 NULL이면 안탐)
EXPLAIN
SELECT * FROM TB1
 WHERE NAME = '철수';

-- 테이블 인덱스 확인
SHOW INDEX FROM TB1;

-- 인덱스 생성
CREATE INDEX 인덱스명 ON 테이블명(컬럼명);
ALTER TABLE 테이블명 ADD INDEX 인덱스명(컬럼명);

-- 인덱스 삭제 (수정 시에는 DROP 후 재생성)
ALTER TABLE 테이블명 DROP INDEX 인덱스명;
```



## Unsorted Tricks : Data Prep with SQL

데이터 사이언스를 위한 EDA과정에서 데이터 양이 매우 많을 경우 전처리 자체를 SQL로 해야할 경우가 있다. 아래는 일반적인 데이터 분석 과정에서 검토할 수있는 Data Preprocessing용 SQL 쿼리이다. 

물론 R이나 Python으로 아래의 과정을 수행해도 되지만 데이터 양이 많아지는 경우를 생각해서 기본적인 전처리나 기술통계분석은 SQL로 하는 것에 익숙해지는 것이 좋다. 

### Dataset Profiling

```sql

-- VOLUME
SELECT COUNT(*) FROM T;

-- VELOCITY
SELECT T.DATE1, COUNT(*) 
FROM T 
GROUP BY T.DATE1
ORDER BY T.DATE1 DESC;

-- ATTRIBUTE SELECTION
SELECT ATTR1, ATTR2, ATTR3, ATTR4
FROM T; 

-- INCOMPLETE RECORDS
SELECT * FROM T
WHERE T.ATTR1 IS NULL AND T.ATTR2 IS NULL;

```

### Validate Attributes

```sql
-- Domain(unique value)

SELECT DISTINCT(ATTR1)
FROM T;

-- MISSING VALUES

SELECT * FROM T
WHERE T.ATTR1 ISNULL;

-- RANGE

SELECT MIN(ATTR1), MAX(ATTR1),AVG(ATTR1)
FROM T;

-- DATA TYPE

SELECT * FROM
INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'T';

-- OUTLIERS

WITH DEV_CTE AS (
    SELECT STDDEV(ATTR1) SDEV FROM T)
SELECT ATTR, ATTR2 
FROM T
CROSS JOIN DEV_CTE C
WHERE T.ATTR1 > C.SDEV * 2;


-- DISTRIBUTION

SELECT ATTR1,
WIDTH_BUCKET(ATTR1,100,500,5) # 분할컬럼, 분할 값 중 가장 작은 값, 가장 큰값, 분할 개수
FROM T;

# WIDTH_BUCKET 함수는 주어진 인자값이 전체 데이터 사이에서 어느 부분에 위치하고 있는지 값을 리턴함
# width_bucket 함수는 오라클에서만 제공한다.

-- MySQL을 사용할 경우 아래과 같은 쿼리를 사용해 분포를 확인 할 수 있다.

SELECT ROUND(numeric_value, -2)    AS bucket,
       COUNT(*)                    AS COUNT,
       RPAD('', LN(COUNT(*)), '*') AS bar
FROM   my_table
GROUP  BY bucket;

-- 결과 예시
+--------+----------+-----------------+
| bucket | count    | bar             |
+--------+----------+-----------------+
|   -500 |        1 |                 |
|   -400 |        2 | *               |
|   -300 |        2 | *               |
|   -200 |        9 | **              |
|   -100 |       52 | ****            |
|      0 |  5310766 | *************** |
|    100 |    20779 | **********      |
|    200 |     1865 | ********        |
|    300 |      527 | ******          |
|    400 |      170 | *****           |
|    500 |       79 | ****            |
|    600 |       63 | ****            |
|    700 |       35 | ****            |
|    800 |       14 | ***             |
|    900 |       15 | ***             |
|   1000 |        6 | **              |
|   1100 |        7 | **              |
|   1200 |        8 | **              |
|   1300 |        5 | **              |
|   1400 |        2 | *               |
|   1500 |        4 | *               |
+--------+----------+-----------------+

```

### Standardize Attributes


```sql

-- Data Types

# cast 함수를 통한 type casting 

SELECT cast(attr1 as DATE),
CAST(attr2 as INT)
FROM t;

-- Patterns

SELECT CASE WHEN attr1 = 조건,
REPLACE(attr2,'Street','St')
FROM t;

-- Formatting

SELECT UPPER(ATTR1), REPLACE(ATTR2,'-',',')
FROM T

-- SCALING

# GROUP BY 절을 사용하지 않고 조회된 각 행에 그룹으로 집계된 값을 표시할 때 OVER 절과 함께 PARTITION BY 절을 사용하면 된다.

SELECT ATTR1, ATTR2/(MAX(ATTR2) OVER PARTITION BY ATTR1 FROM T;

```

### CREATE INTERFATE

View를 쓰는 3가지 이유

- 자주 쓰는 쿼리문을 안쓰고 테이블만 조회하면 된다.
- 보안에 유리하다.
- 뷰 테이블에 자료가 추가되는 것은 실체 테이블에 반영되지 않는다.

```sql
-- view 생성 구문
CREATE VIEW AS SELECT ...

```

### Clean Attributes

SQL을 활용한 data preprocessing 방식들

```sql

-- Outlier 값 치환하기

SELECT CASE when attr1 < 0 then 0
            when attr > 1000 then 1000 
            else attr1 
        END as attr1
FROM t;


-- 결측값

SELECT COALESCE(attr1,avg(attr1)), coalesce(attr,'Unknown')
From t;

-- 결측값 , Not at Random

SELECT COALESCE(attr1,0)
FROM t;

-- Incorrect Values

```

### DERIVE ATTRIBUTES

파생변수 생성을 위해 보통 고려하는 방법들은 다음과 같다.

- Buckets/Binning : 구간화. 연속변수를 그룹화. 보통 나이대 변수 생성에 사용
- Date Parts: 날짜에서 연도, 월등 분리하기
- Date Difference : 시차구하기
- Last Period : n시점 전이나 n시점 후를 구하기
- Dummy Encoding : 머신러닝을 위한 Categorical Variable에 대한 원핫인코딩

```sql
-- Buckets/Binning 

SELECT ATTR1, CASE 
  WHEN ATTR1 <= 50 THEN 'BIN1'
  WHEN ATTR1 > 50 THEN 'BIN2'
  ELSE 'BIN3' END AS ATTR1_BIN
FROM T;

-- Date Parts 

SELECT DAYOFMONTH(DATE1), MONTHOFYEAR(DATE1)
FROM T;

-- DATE DIFF

SELECT DATEDIFF(DATE1,DATE2)
FROM T;

-- LAST PERIOD

# 1년 전 날짜 반환
SELECT DATEADD(YEAR,-1,DATE1) 

-- Dummy Encoding

SELECT ATTR1,
CASE WHEN ATTR1 = 'MALE' THEN 1 ELSE 0 AS MALE_GENDER 
FROM T;
```

### COMBINE DATASETS

- Full Match (Inner Join)
- Operational Match(LEFT, RIGHT JOIN)
- UNION 명령은 보통 여러 개의 SELECT 문 결과를 합치기 위해 사용한다.
  - row 단위 중복 제외하고 합치기
  - row 단위 중복 허용해서 vertical하게 합치기

```sql
-- JOIN HORIZONTALLY

SELECT T1.ATTR1, T2.ATTR2 
FROM T2
INNER JOIN T2 ON T1.ID = T2.ID

SELECT T1.ATTR1, T2.ATTR2 
FROM T2
LEFT JOIN T2 ON T1.ID = T2.ID

-- UNION VERTICALLY

SELECT ATTR1, ATTR2
FROM T1
UNION SELECT ATTR1, ATTR2 
FROM T2

SELECT ATTR1, ATTR2
FROM T1
UNION SELECT ATTR1, ATTR2 
FROM T2
```

### SPLIT DATASETS

- Simple Filter : 단순조건문이지만 보통 sql은 이런 식이다.
- Filter Based on Aggregation
- Sampling

```sql

-- Simple Filter

SELECT ATTR1, ATTR2 
FROM T
WHERE ATTR1 IS NOT NULL

-- FILTER BASED ON AGGREGATION
SELECT ATTR1,SUM(ATTR2)
FROM T
GROUP BY ATTR1
HAVING SUM(ATTR2) >10;

-- SAMPLING(RANDOM)
SELECT ATTR1,ROW_NUMBER() OVER (ORDER BY RANDOM()) AS RANDOM
FROM T;

-- SAMPLING (NON RANDOM)
SELECT ATTR1, NTILE(4) OVER (ORDER BY DATE()) AS QUARTILE 
FROM T;

```


# CRUD

## Managing DataBases

### Create Database

```sql
# mysql -u root -p  로그인

CREATE DATABASE IF NOT EXISTS COURSE_RATING; 
USE COURSE_RATING; # 사용DB지정
```

## Managing Tables

### Create Table

테이블 생성 예제

```SQL
CREATE TABLE 'COURSE_RATING'.`STUDENT`(
    `ID` INT NOT NULL AUTO_INTREMEMT,
    `NAME` VARCHAR(20) NOT NULL
    PRIMARY KEY (`ID`)
);

CREATE TABLE `ANIMAL_INFO` (
    `ID` INT NOT NULL AUTO_INCREMENT, -- 값이 자동으로 증가하면서 추가됨
    `TYPE` VARCHAR(30) NOT NULL ,
    `NAME` VARCHAR(10) NOT NULL,
    `AGE` TINYINT NOT NULL,
    `SEX`  CHAR(1) NOT NULL,
    `WEIGHT` DOUBLE NOT NULL,
    `FEATURE` VARCHAR(500) NULL,
    `ENTRY_DATE` DATE NOT NULL,
    PRIMARY KEY(ID)
);

```

### Delete / Drop Table

```sql
DROP TABLE tablename;
```

### SHOW TABLES

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

- 삽입(INSERT)
  - ROW를 추가할 시 값을 더 주지 않은 ROW는 NULL이됨
  - PK는 반드시 값이 있어야함
  - AUTO_INCREMENT 속성이 있을 경우 값이 자동으로 추가됨
- 수정(UPDATE)
  - SET 뒤에 변경할 컬럼명= 값을 넣어주고 WHERE절을 사용해 UPDATE할 ROW를 찾기 위한 조건을 설정해준다. 
  - 데이터 타입 변경 시(MODIFY) 변경하려는 데이터 타입이 기존 값에 적합하지 않다면 기존값부터 바꾼 후 타입변경을 해야한다.
- 삭제(DELETE)
  - DELETE문 사용 기본키 기반으로 삭제 WHERE 절 기반으로 삭제할 ROW를 찾음
  - 논리삭제 : 삭제여부를 반영하는 컬럼 추가
  - 물리삭제 : 실제 삭제
    - 이미 데이터 분석에 활용한 ROW
    - 고객이 동의한 데이터 보유기간이 지난 ROW 

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

### Update와 SUBQUERY

변경하고자 하는 값을 정확히 모르고 다른 테이블에서 조회한 값으로 갱신해야 하는 경우가 있을 수 있다.
아래와 같은 방식으로 SUBQUERY를 포함한 UPDATE문을 작성할 수 있다.

> UPDATE TB1
> SET COL1 = (SUBQUERY)
> WHERE CONDITION = VAL1

```SQL
-- 간단한 예시
UPDATE EMP
SEL SAL = (SELECT SAL FROM EMP WHERE LAST_NAME='HONG')
WHERE EMP_ID IN ('120','204')
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


## String 함수들

1. LENGTH : 길이 반환
2. UPPER, LOWER : 소문자 대문자 변환
3. LPAD,RPAD : PADDING 
   LPAD(AGE, 10, ’0’)는 AGE 컬럼의 값을, 왼쪽에 문자 0을 붙여서 총 10자리로 만든다. 보통 어떤 숫자의 자릿수를 맞출 때 자주 사용한다
4. TRIM : 공백문자 삭제
5. SUBSTRING(문자,시작인덱스,끝인덱스) :  문자열에서 인덱스 기준으로 일부를 추출할 때 사용
6. SUBSTRING_INDEX :  DELIMITER 기준으로 문자열을 구분해서 COUNT 위치의 값을 반환. COUNT의 값이 음수일 경우  COUNT하는 방향이 반대가 됨. 주소 구분시 사용가능.

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

## Time 관련 함수들

- [참조](https://www.w3resource.com/mysql/date-and-time-functions/date-and-time-functions.php)

# DCL

## 사용자관리

### Show Users

```sql
SELECT User, Host FROM mysql.user;
```

### Create User

- MYSQL 외부계정생성 및 권한부여는 아래와 같이 한다.

```sql
CREATE USER '계정이름'@'%' IDENTIFIED BY '패스워드';
GRANT ALL PRIVILEGES ON *.* TO '계정이름'@'%' WITH GRANT OPTION;
```

- mysql 에서 root의 비밀번호를 변경할 경우 ``FLUSH PRIVILEGES;``를 해주고 mysql을 재시작한다.


### Grant All Priveleges On All Databases

```sql
GRANT ALL PRIVILEGES ON * . * TO 'someuser'@'localhost';
FLUSH PRIVILEGES;
```

### Show Grants

```sql
SHOW GRANTS FOR 'someuser'@'localhost';
```

### Remove Grants

```sql
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'someuser'@'localhost';
```

### Delete User

```sql
DROP USER 'someuser'@'localhost';
```


# Modeling

## 데이터 모델링

### Relational 모델

# 절차적 SQL

사용자정의 함수 만들기
절차적 SQL 쿼리짜기

## Procedure

### 프로시저 함수 디버깅

## Trigger

## Optimizer



# TCL 트랜잭션 관리

## COMMIT

## ROLLBACK

# Preprocessing Tricks

- 데이터전처리 대전
- 통계 tricks
- 기타 unsorted Tricks

## USE CASE

### 매출액 조회

- 일별 매출액

```sql

SELECT A.ORDERDATE,PRICEEACH * QUANTITYORDERED AS SALES
FROM CLASSICMODELS.ORDERS A LEFT JOIN CLASSICMODELS.ORDERDETAILS B 
ON A.ORDERNUMBER = B.ORDERNUMBER
group by 1 # ORDERDATE 기준으로 GROUP BY
order by 1;

```

- 월별 매출액

```sql

```

- 연도별 매출액

```sql

```



## Unsorted Tricks

### MySQL 스키마 별 전체 테이블 행 개수 확인

``` sql
SELECT TABLE_NAME, TABLE_COMMENT, TABLE_ROWS
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'SCHEMA_NAME'
ORDER BY TABLE_ROWS DESC
```


### 외부 DB 연결

```python
import sqlite3
from sqlite3 import Error


def create_connection(db_file):
    """ create a database connection to a SQLite database """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print(sqlite3.version)
    except Error as e:
        print(e)
    finally:
        if conn:
            conn.close()


if __name__ == '__main__':
    create_connection("pythonsqlite.db")

```


## References

https://chobopark.tistory.com/117
https://velog.io/@lsh5039/MY-SQL-%EA%B0%81-%ED%85%8C%EC%9D%B4%EB%B8%94-%EC%9D%BC%EC%9E%90%EB%B3%84-%ED%86%B5%EA%B3%84%EC%BF%BC%EB%A6%AC