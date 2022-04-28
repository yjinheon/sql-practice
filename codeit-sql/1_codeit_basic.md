- [SQL로 하는 데이터 분석](#sql로-하는-데이터-분석)
- [1. 데이터 조회하기](#1-데이터-조회하기)
  - [1.1 select 문](#11-select-문)
  - [1.2 문자열 매칭 조건식](#12-문자열-매칭-조건식)
  - [1.3 와일드 카드](#13-와일드-카드)
    - [1.3.정규표현식을 활용한 패턴매칭](#13정규표현식을-활용한-패턴매칭)
  - [1.4 DATE type 관련 함수](#14-date-type-관련-함수)
  - [1.5 여러개의 조건 걸기](#15-여러개의-조건-걸기)
  - [1.6 이스케이핑 문제](#16-이스케이핑-문제)
  - [1.7 정렬하기](#17-정렬하기)
  - [1.8 정렬 시 주의할 점](#18-정렬-시-주의할-점)
  - [1.9 데이터 일부만 추리기 : limit](#19-데이터-일부만-추리기--limit)
  - [1.10 Time 관련 함수 추가](#110-time-관련-함수-추가)
- [2. 데이터 분석 단계로 나아가기](#2-데이터-분석-단계로-나아가기)
  - [2.1 데이터 특성 구하기](#21-데이터-특성-구하기)
  - [2.2 집계함수와 산술함수](#22-집계함수와-산술함수)
  - [2.3 NULL을 다루는 방법](#23-null을-다루는-방법)
  - [2.5 이상치 다루기](#25-이상치-다루기)
  - [2.6 컬럼끼리 계산하기](#26-컬럼끼리-계산하기)
  - [2.7 alias 붙이기](#27-alias-붙이기)
  - [2.8 컬럼끼리 계산하기](#28-컬럼끼리-계산하기)
  - [2.9 CASE함수 종류](#29-case함수-종류)
  - [2.10 null 변환함수](#210-null-변환함수)
  - [2.11 고유값만 보기](#211-고유값만-보기)
  - [2.12 문자열 관련 함수](#212-문자열-관련-함수)
  - [2.13 GROUP BY](#213-group-by)
  - [2.14 group by의 규칙](#214-group-by의-규칙)
  - [2.15 ROLL UP](#215-roll-up)
  - [2.16 with rollup의 계층구조와 grouping 함수](#216-with-rollup의-계층구조와-grouping-함수)
  - [2.17-1  Window의 이해](#217-1--window의-이해)
  - [2.17-2 OVER 절의 이해](#217-2-over-절의-이해)
- [3.Join 활용 및 연습](#3join-활용-및-연습)
  - [3.1 foreign key 설정하기](#31-foreign-key-설정하기)
  - [3.2 서로다른 테이블 조인하기(left/right outer join)](#32-서로다른-테이블-조인하기leftright-outer-join)
  - [3.3 조인할 때 테이블에 alias 붙이기](#33-조인할-때-테이블에-alias-붙이기)
  - [3.4 다른 종류의 테이블 조인하기(inner join)](#34-다른-종류의-테이블-조인하기inner-join)
  - [3.5 집합연산](#35-집합연산)
  - [3.6 같은 종류의 테이블 조인하기](#36-같은-종류의-테이블-조인하기)
  - [3.7 서로 다른 3개의 테이블 조인하기](#37-서로-다른-3개의-테이블-조인하기)
  - [3.8 1대1, 1대n, n대m 관계의 이해](#38-1대1-1대n-n대m-관계의-이해)
      - [1:1 관계](#11-관계)
      - [1:N 관계(일대다 관계)](#1n-관계일대다-관계)
      - [N:M 관계(다대다 관계)](#nm-관계다대다-관계)
  - [3.9 의미있는 데이터 추출하기](#39-의미있는-데이터-추출하기)
  - [3.10 natural join,cross join,self join, full outer join, non equi join](#310-natural-joincross-joinself-join-full-outer-join-non-equi-join)
    - [natural join](#natural-join)
    - [cross join](#cross-join)
    - [self join](#self-join)
    - [full outer join](#full-outer-join)
    - [non equi join](#non-equi-join)
    - [nl join](#nl-join)
    - [hash join](#hash-join)
- [4.서브쿼리와 View를 활용한 데이터분석](#4서브쿼리와-view를-활용한-데이터분석)
  - [4.1 서브쿼리를 활용한 데이터 분석](#41-서브쿼리를-활용한-데이터-분석)
  - [4.2 select 절의 서브쿼리 : 보통 새로운 컬럼 추가를 의미, 원래 컬럼에 없던 컬럼 추가](#42-select-절의-서브쿼리--보통-새로운-컬럼-추가를-의미-원래-컬럼에-없던-컬럼-추가)
  - [4.3 WHERE 절의 서브쿼리 : '특정조건을 만족하는..' 에서 특정 조건을 담당함](#43-where-절의-서브쿼리--특정조건을-만족하는-에서-특정-조건을-담당함)
  - [4.4 WHERE 절의 서브쿼리(2) : 여러 값을 리턴하는 서브쿼리](#44-where-절의-서브쿼리2--여러-값을-리턴하는-서브쿼리)
  - [4.5 ANY(SOME),ALL](#45-anysomeall)
      - [ANY](#any)
      - [ALL](#all)
  - [4.6 서브쿼리 예제](#46-서브쿼리-예제)
  - [4.7 FROM 절에 있는 서브쿼리 (테이블형태의 결과를 리턴하는 서브쿼리)](#47-from-절에-있는-서브쿼리-테이블형태의-결과를-리턴하는-서브쿼리)
    - [SQL예제와 서브쿼리](#sql예제와-서브쿼리)
  - [4.8 서브쿼리의 종류 정리](#48-서브쿼리의-종류-정리)
  - [4.9 상관서브쿼리와 비상관서브쿼리](#49-상관서브쿼리와-비상관서브쿼리)
    - [exists가 없는 상관서브쿼리](#exists가-없는-상관서브쿼리)
  - [6.16 서브쿼리 중첩과 문제점 : 쿼리가 너무 길어지는 문제](#616-서브쿼리-중첩과-문제점--쿼리가-너무-길어지는-문제)
  - [서브쿼리 총정리](#서브쿼리-총정리)
  - [6.17 데이터 분석가의 자산, 뷰](#617-데이터-분석가의-자산-뷰)
    - [View의 사용방법](#view의-사용방법)
  - [6.19 실무에서 첫번째로 해야할 일](#619-실무에서-첫번째로-해야할-일)
  - [추가적인 학습사항(계속 업데이트)](#추가적인-학습사항계속-업데이트)
    - [NULLIF 함수 사용하기](#nullif-함수-사용하기)
  - [Unsorted Tricks : Data Prep with SQL](#unsorted-tricks--data-prep-with-sql)
    - [Dataset Profiling](#dataset-profiling)
    - [Validate Attributes](#validate-attributes)
    - [Standardize Attributes](#standardize-attributes)
    - [CREATE INTERFATE](#create-interfate)
    - [Clean Attributes](#clean-attributes)
    - [DERIVE ATTRIBUTES](#derive-attributes)
    - [COMBINE DATASETS](#combine-datasets)
    - [SPLIT DATASETS](#split-datasets)
- [DCL](#dcl)
  - [GRANT](#grant)
  - [REVOKE](#revoke)
- [TCL](#tcl)
  - [COMMIT](#commit)
  - [ROLLBACK](#rollback)
  - [SAVEPOINT](#savepoint)
  - [SET TRANSACTION](#set-transaction)
# SQL로 하는 데이터 분석

# 1. 데이터 조회하기
## 1.1 select 문
> SELECT * FROM `member`;

```sql

SELECT * FROM `MEMBER`  WHERE AGE >= 27; # 27세 이상 조회

SELECT * FROM MEMBER WHERE AGE BETWEEN 30 AND 39; # 30대 조회

SELECT * FROM MEMBER WHERE AGE NOT BETWEEN  30 AND 39; # 30대 제외 조회

SELECT * FROM MEMBER WHERE SIGN_UP_DAY > '2019-01-01'; # 2019년 1월 1일 이후로 가입한 회원 조회

SELECT  * FROM `member` WHERE SIGN_UP_DAY BETWEEN '2018-01-01' AND '2018-12-31'; # 2018년 내 가입자 조회
```

## 1.2 문자열 매칭 조건식

**와일드 카드 용법**

| LIKE Operator                  | Description                                                                   |
|--------------------------------|-------------------------------------------------------------------------------|
| WHERE CustomerName LIKE 'a%'   | Finds any values that starts with "a"                                         |
| WHERE CustomerName LIKE '%a'   | Finds any values that ends with "a"                                           |
| WHERE CustomerName LIKE '%or%' | Finds any values that have "or" in any position                               |
| WHERE CustomerName LIKE '_r%'  | Finds any values that have "r" in the second position                         |
| WHERE CustomerName LIKE 'a__%' | Finds any values that starts with "a" and are at least 3 characters in length |
| WHERE ContactName LIKE 'a%o'   | Finds any values that starts with "a" and ends with "o"                       |

```sql
SELECT * FROM copang_main.`member` WHERE address like '서울%'; # address가 서울로 시작하는 row 조회

SELECT * FROM copang_main.`member` WHERE address like '%고양시%'; # 고양시라는 단어 앞뒤로 임의의 길이를 가진 문자열 조건

```

## 1.3 와일드 카드

```sql
SELECT * FROM copang_main.`member` WHERE gender != 'm'; # 남성 제외

SELECT * FROM copang_main.`member` WHERE age IN (20,30); # IN은 범위 제한을 나타냄

SELECT * FROM copang_main.`member` WHERE email like 'c_____@%';
```

### 1.3.정규표현식을 활용한 패턴매칭

-'홍' 또는 '길' 또는 '동'이 포함된 문자열을 찾고 싶을 때
- 정규표현식을 사용하지 않을 때

```sql
SELECT *
FROM tbl
WHERE data like '%홍%'
OR data like '%길%'
OR data like '%동%'
```
- 정규표현식을 사용할 때

```sql
SELECT *
FROM tbl
WHERE data REGEXP '홍|길|동'
```

- ‘안녕’ 또는 ‘하이’로 시작하는 문자열을 찾고 싶을 때

- 정규표현식을 사용하지 않을 때 
```sql
SELECT *
FROM tbl  
WHERE data LIKE '안녕%' OR data LIKE '하이%';
```
- 정규표현식을 사용할 때 

```sql
SELECT *
FROM tbl
WHERE data REGEXP ('^안녕|^하이');
```


- 길이 7글자인 문자열 중 2번째 자리부터 abc를 포함하는 문자열을 찾고 싶을 때
- 정규표현식을 사용하지 않을 때

```sql
SELECT *
FROM tbl
WHERE CHAR_LENGTH(data) = 7 AND SUBSTRING(data, 2, 3) = 'abc';
```
- 정규표현식을 사용할 때

```sql
SELECT *
FROM tbl
WHERE data REGEXP ('^.abc...$');
```


- 텍스트와 숫자가 섞여 있는 문자열에서 숫자로만 이루어진 문자열을 찾고 싶을 때

- 정규표현식을 사용하지 않을 때

```sql
SELECT *
FROM tbl
WHERE data LIKE ??????????

- 정규표현식을 사용할 때
```

```sql
SELECT *
FROM tbl
WHERE data REGEXP ('^[0-9]+$'); 
-- OR data REGEXP ('^\d$') 
-- OR data REGEXP ('^[:digit:]$');

```

## 1.4 DATE type 관련 함수
```sql
SELECT * FROM copang_main.`member` WHERE year(birthday) = 1992; # year() : 날짜에서 연도 반환

SELECT * FROM copang_main.`member` WHERE MONTH (birthday) IN (6,7,8); # month() : 날짜에서 월 반환

SELECT * FROM copang_main.`member` WHERE DAYOFMONTH(birthday) BETWEEN  15 and 31; # date : 날짜에서 date 반환

SELECT email,sign_up_day,DATEDIFF(sign_up_day,'2019-01-01') FROM `member` ; # 각 회원이 가입한 날짜가 19년 1월 1일 이후 몇일인가?


SELECT email,sign_up_day,DATE_ADD(sign_up_day,INTERVAL 300 day) FROM `member` ; # 날짜 더하기

SELECT email,sign_up_day,DATE_SUB(sign_up_day,INTERVAL 300 day) FROM `member` ; # 날짜 빼기

SELECT email,sign_up_day,UNIX_TIMESTAMP(sign_up_day) FROM `member`; # unix_timestamp 변환

-- 가장 최근 시점을 구할 경우 max 함수 사용
SELECT max(DATETIME)
from t1

-- 가장 이전 시점을 구할 경우 min 함수 사용
SELECT max(DATETIME)
from t1
```

## 1.5 여러개의 조건 걸기

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

## 1.6 이스케이핑 문제

- 어떤 문자가 그것에 부여된 특정한 의미,기능으로 해석되는 것이 아니라 단순한 문자 하나로 해석되게끔 하는 것을 이스케이핑이라 한다.

  - ' 이스케이핑 -> select * from copang_main.test where sentence like '%\'%'
  - _ 이스케이핑 -> select * from copang_main.test where sentence like '%\_%'
  - " 이스케이핑 -> select * from copang_main.test where sentence like '%\"\"%'
  - 대문자 제외 소문자 찾기 select * from copang_main.test where sentence like binary '%g%'


## 1.7 정렬하기

- 실무에서는 orderby는 이름을 먼저 쓴 컬럼 기준으로 차례대로 수행된다.  
- SQL 문법 상 WHERE는 ORDERBY 앞에 나온다.

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


## 1.8 정렬 시 주의할 점

1. 숫자형인 경우 -> 숫자의 크고 작음 기준으로 정력
2. 문자열형인 경우 -> 문자 순서를 비교해서 정렬 수행
   1. 문자형을 숫자로 나타내고 싶을 경우 cast 함수를 사용한다

>ORDER BY CAST(data AS signed) -> 일시적으로 컬럼을 signed 라는 데이터 타입으로 변환

signed는 양과 음의 정수를 의미함

## 1.9 데이터 일부만 추리기 : limit

> limit n : 출력개수 n개 제한  
> limit m,n : m번째부터 n개 출력

```sql
SELECT * FROM copang_main.member
ORDER BY sign_up_day DESC
LIMIT 10;

SELECT * FROM copang_main.member
ORDER BY sign_up_day DESC
LIMIT 8,2; # 8번째 로우부터 2개 추림 // 로우는 0번부터 시작 9번째, 10번째로
```

## 1.10 Time 관련 함수 추가

- [참조](https://www.w3resource.com/mysql/date-and-time-functions/date-and-time-functions.php)


# 2. 데이터 분석 단계로 나아가기

## 2.1 데이터 특성 구하기

```sql
select count(email) copang_main.member; # count()는 해당컬럼에서 NULL의 개수는 제외함
select count(height) copang_main.member;

SELECT count(*) FROM copang_main.`member`;
```

## 2.2 집계함수와 산술함수

```sql
select max(height) from copang_main.`member`; # 최대

select min(weight) from copang_main.`member`; # 최소

SELECT avg(weight) FROM copang_main.`member`; # avg함수는 null이 있는 row는 제외하고 평균값을 구한다

SELECT sum(weight) FROM copang_main.`member`; # 합계

SELECT std(weight) FROM copang_main.`member`; # 표준편자

SELECT abs(weight) FROM copang_main.`member`; # 절대값

SELECT CEIL(weight) FROM copang_main.`member`; # 올림

SELECT floor(weight) FROM copang_main.`member`; # 내림

SELECT round(weight) FROM copang_main.`member`; # 반올림
```

## 2.3 NULL을 다루는 방법

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

## 2.5 이상치 다루기
```sql

SELECT AVG(AGE) FROM COPANG_MAIN.MEMBER;
SELECT AVG(AGE) FROM COPANG_MAIN.MEMBER
WHERE AGE BETWEEN 5 AND 100;

SELECT * FROM COPANG_MAIN.MEMBER
WHERE ADDRESS NOT LIKE '%호'; # 이상한 주소 조회

```

## 2.6 컬럼끼리 계산하기

```sql

SELECT EMAIL,
	   HEIGHT,
	   WEIGHT,
	   WEIGHT/((HEIGHT/100) * (HEIGHT/100))
FROM MEMBER; # HEIGHT를 100으로 나눈 이유는 단위를 맞춰주기 위함
```

## 2.7 alias 붙이기

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

## 2.8 컬럼끼리 계산하기
```sql

select email 이메일,
	   concat(height,'cm',', ',weight,'kg') AS '키와 몸무게',
	   weight/((height/100) * (height/100)) AS BMI,
(CASE
	WHEN weight IS NULL OR height IS NULL THEN '알 수 없음'
	WHEN weight/((height/100) * (height/100)) >= 25 THEN '과체중'
	WHEN weight/((height/100) * (height/100)) >= 18.5
    	AND  weight/((height/100) * (height/100)) < 25
    	THEN '정상'
    ELSE '저체중'
END) AS obesity_check

FROM copang_main.`member`
ORDER BY obesity_check;
```

## 2.9 CASE함수 종류
1. 단순 CASE 함수

```sql
CASE 컬럼 이름
  WHEN 값 THEN 값
  WHEN 값 THEN 값
  WHEN 값 THEN 값
  ELSE 값
END
```


2. 검색 CASE함수
```sql

CASE
  WHEN 조건1 THEN 값
  WHEN 조건2 THEN 값
  WHEN 조건3 THEN 값
  ELSE 값
END
```

3. 깔끔한 CASE WHEN 예시

```sql
SELECT
    USER_ID,
    CASE 
        WHEN REGISTER_DEVICE = 1 THEN 'DESKTOP'
        WHEN REGISTER_DEVICE = 2 THEN 'SMARTPHONE'
        WHEN REGISTER_DEVICE = 3 THEN 'APPLICATION'
    END AS DEVICE_NAME
FROM MST_USERS;        
```


## 2.10 null 변환함수

1. coalesce : 첫번째로 null이 아닌 값을 반환

2. ifnull(대상값,null일 경우 치환값) : 첫번째 인자가 null인 경우 두번째 인자, 아닐 경우 해당 값 표현

3. if(a1,a2,a3) : ifelse 처럼 사용가능

## 2.11 고유값만 보기

```sql

SELECT DISTINCT(GENDER) FROM COPANG_MAIN.`MEMBER`;

SELECT DISTINCT(SUBSTRING(ADDRESS,1,2)) FROM COPANG_MAIN.`MEMBER`;
# SUBSTRING을 활용한 지역 고윳값 찾기

SELECT COUNT(DISTINCT(SUBSTRING(ADDRESS,1,2))) FROM COPANG_MAIN.`MEMBER`; #고윳값 개수구하기
```

## 2.12 문자열 관련 함수

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

## 2.13 GROUP BY

```sql
SELECT gender,count(*) FROM copang_main.`member`
GROUP BY gender;

# aggregate function : 그루핑을 통해 생성된 각 그룹의 통계량을 계산해주는 함수
SELECT
	GENDER,
	COUNT(*),
	AVG(HEIGHT),
	MIN(WEIGHT)
FROM COPANG_MAIN.`MEMBER`
GROUP BY GENDER;

# substring을 통해 도시명 구한 뒤 도시명 및 성별로 그룹화 한뒤  서울만 추리기
SELECT substring(address,1,2) AS region,gender,count(*)
FROM copang_main.`member`
GROUP BY
	substring(address,1,2),
	gender
HAVING region="서울";

SELECT substring(address,1,2) AS region,gender,count(*)
FROM copang_main.`member`
GROUP BY
	substring(address,1,2),
	gender
HAVING region="서울" AND gender = 'm'; # 위와 같지만 조건을 추가함

# select 문에서 조건을 선별할 때 where을 쓰지만 group by 다음에는 having을 사용

SELECT SUBSTRING(ADDRESS,1,2) AS REGION,GENDER,COUNT(*)
FROM COPANG_MAIN.`MEMBER`
GROUP BY
	SUBSTRING(ADDRESS,1,2),
	GENDER
HAVING REGION IS NOT NULL # REGION이 NULL인 경우 제외
ORDER BY REGION, GENDER DESC;
```

## 2.14 group by의 규칙

GROUP BY를 사용할 때는, SELECT 절에는

(1) GROUP BY 뒤에서 사용한 컬럼들 또는

(2) COUNT, MAX 등과 같은 집계 함수만

사용가능 -> **GROUP BY 뒤에 쓰지 않은 컬럼 이름을 SELECT 뒤에 쓸 수는 없음**


## 2.15 ROLL UP

```sql

SELECT SUBSTRING(address, 1, 2) as region, gender, COUNT(*)
FROM member
GROUP BY SUBSTRING(address, 1, 2), gender WITH ROLLUP # address의 부분총계, 계층 존재
HAVING region IS NOT NULL
ORDER BY region ASC, gender DESC;

### group by 뒤에 with roll up을 넣으면 부분총계를 산출할 수 있다
```

## 2.16 with rollup의 계층구조와 grouping 함수


GROUPING 함수는

(1) 실제로 NULL을 나타내기 위해 쓰인 NULL인 경우에는 0을 표시한다.

(2) 부분 총계를 나타내기 위해 표시된 NULL은 1을 표시한다.

## 2.17-1  Window의 이해

https://sodayeong.tistory.com/98


## 2.17-2 OVER 절의 이해

https://learnsql.com/blog/over-clause-mysql/

>**각 행별로 특정 기준에 따라 필요한 집합을 구해 함수를 적용시킬 때 OVER 을 이용한다.**

over 절은 기본적으로 함수를 적용시킬 행의 범위를 지정해준다.
over 은 행과 행 간의 관계를 정의하는 window 함수이다.
group by 와 달리 결과 행 개수에 영향을 미치지 않는다.
over 절 내부에 order by 속성을 적용할 경우  **날짜 단위로** window가 생성된다.

```sql
select id , crop_date, sum(count) over(order by crop_date) as Inventory
from house
```

over 함수에 partition by를 적용할 경우 partition by 를 적용한 속성의 고유값(unique value) 단위로 window가 생성되며  group by와 달리 행의 수는 변하지 않는다. 아래 예시데이터에서 쿼리문을 생성하면 경우 window가 'Golden' ,'SuperSun' 이 생성되며 각각의  그룹 기준으로 kilos_produced에 대한 합계가 계산된다.

```sql

SELECT farmer_name,
       orange_variety,
     crop_year,
       kilos_produced,
       SUM(kilos_produced) OVER(PARTITION BY orange_variety) AS total_same_variety
FROM orange_production

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


# 3.Join 활용 및 연습

## 3.1 foreign key 설정하기

```sql
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
```


## 3.2 서로다른 테이블 조인하기(left/right outer join)


```sql
-- left outer join 예시


SELECT
	item.id,
	item.NAME,
	stock.ITEM_ID,
	stock.INVENTORY_COUNT
FROM item LEFT OUTER JOIN stock
ON item.id = stock.item_id;

-- right outer join 예시

SELECT
	item.id,
	item.NAME,
	stock.ITEM_ID,
	stock.INVENTORY_COUNT
FROM item RIGHT	OUTER JOIN stock
ON item.id = stock.item_id;

```

## 3.3 조인할 때 테이블에 alias 붙이기

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

## 3.4 다른 종류의 테이블 조인하기(inner join)
- INNER JOIN 은 기준이 되는 테이블이 없다

```sql

SELECT
	i.id,
	i.NAME,
	s.ITEM_ID,
	s.INVENTORY_COUNT
FROM item AS i INNER JOIN stock AS s
ON i.id = s.item_id;

```

## 3.5 집합연산

- join은 결합연산이고 INTERSECT,UNION,minus 등의 연산은 집한연산이다.

(1) A ∩ B (INTERSECT 연산자 사용)
```sql

SELECT * FROM member_A

INTERSECT

SELECT * FROM member_B
```
(2) A - B (MINUS 연산자 또는 EXCEPT 연산자 사용)

```sql

SELECT * FROM member_A

MINUS

SELECT * FROM member_B
```

(3) B - A (MINUS 연산자 또는 EXCEPT 연산자 사용)
```sql
SELECT * FROM member_B

MINUS

SELECT * FROM member_A
```

(4) A U B (UNION 연산자 사용)
```sql
SELECT * FROM member_A

UNION

SELECT * FROM member_B
```

## 3.6 같은 종류의 테이블 조인하기

 - 차이점을 확인하기 위해 같은 종류의 테이블을 조인할 수 있다
 - 아래의 경우 기존 상품 정보 중 누락된 정보를 찾기 위해 사용
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
## 3.7 서로 다른 3개의 테이블 조인하기
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
## 3.8 1대1, 1대n, n대m 관계의 이해
![](relationship-sql.png)
#### 1:1 관계
- 1:1 관계란 어느 엔티티 쪽에서 상대 엔티티와 반드시 단 하나의 관계를 가지는 것을 말한다.

#### 1:N 관계(일대다 관계)

- 1:n 관계에서는 여러 명의 자식(N)의 입장에서 한 쌍의 부모(1)중 어떤 부모에 속해 있는지 표현해야하므로 부모 테이블의 PK를 자식 테이블에 FK로 집어 넣어 관계를 표현한다.
- 부모 테이블(1)에서는 내 자식들이 누구인지 정보를 넣을 필요가 없고, 자식 테이블(N)에서만 각각의 자식들이 자신의 부모 정보(FK)를 넣음 으로써 관계를 표현할 수 있다.
#### N:M 관계(다대다 관계)

- N:M 관계는 서로가 서로를 1:N 관계, 1:M 관계로 갖고 있기 때문에, 서로의 PK를 자신의 외래키 컬럼으로 갖고 있으면 된다.

- 일반적으로 N:M 관계는 두 테이블의 대표키를 컬럼으로 갖는 또 다른 테이블을 생성해서 관리한다.
## 3.9 의미있는 데이터 추출하기

```sql
SELECT
	i.id,i.name,avg(star),count(*) # 상품별 별점평균,리뷰 수
FROM
	item AS i LEFT OUTER JOIN review AS r
		ON r.item_id = i.id
	LEFT OUTER JOIN member AS m
		ON r.mem_id = m.id
WHERE m.gender = "f"
GROUP BY i.id
HAVING count(*) > 1
ORDER BY avg(star) DESC,
		 count(*) desc;

SELECT
	i.id,i.name,avg(star),count(*) # 상품별 별점평균,리뷰 수
FROM
	item AS i LEFT OUTER JOIN review AS r
		ON r.item_id = i.id
	LEFT OUTER JOIN member AS m
		ON r.mem_id = m.id
WHERE m.gender = "m"
GROUP BY i.id
HAVING count(*) > 1
ORDER BY avg(star) DESC,
		 count(*) desc;

SELECT * FROM review WHERE item_id = 2;
```

## 3.10 natural join,cross join,self join, full outer join, non equi join

### natural join
### cross join
### self join
### full outer join
### non equi join


### nl join
### hash join

# 4.서브쿼리와 View를 활용한 데이터분석

## 4.1 서브쿼리를 활용한 데이터 분석

```sql
SELECT i.id, i.name , avg(star) AS avg_star
FROM item AS i LEFT OUTER JOIN review AS r
ON r.item_id = i.id
GROUP BY i.id, i.name
HAVING avg_star < (SELECT avg(star) FROM review) ## 서브쿼리 사용시 괄호로 감싸주어야 한다.
ORDER BY avg_star DESC;
```

## 4.2 select 절의 서브쿼리 : 보통 새로운 컬럼 추가를 의미, 원래 컬럼에 없던 컬럼 추가

```sql
SELECT id,
	   name,
	   price,
	   (SELECT max(price) FROM item) as max_price,
	   (SELECT avg(price) FROM item) as avg_price
FROM COPANG_MAIN.item;
```

## 4.3 WHERE 절의 서브쿼리 : '특정조건을 만족하는..' 에서 특정 조건을 담당함

where 절의 서브쿼리는 결국 조건이다.

```sql
SELECT ID,
       NAME,
       PRICE,
       (SELECT AVG(PRICE) FROM ITEM) AS AVG_PRICE
FROM COPANG_MAIN.ITEM
WHERE PRICE > (SELECT AVG(PRICE) FROM ITEM);

SELECT ID,
       NAME,
       PRICE,
       (SELECT AVG(PRICE) FROM ITEM) AS AVG_PRICE
FROM COPANG_MAIN.ITEM
WHERE PRICE = (SELECT MAX(PRICE) FROM ITEM); # 최대가격알아보기

SELECT ID,
       NAME,
       PRICE,
       (SELECT AVG(PRICE) FROM ITEM)AS AVG_PRICE
FROM COPANG_MAIN.ITEM
WHERE PRICE = (SELECT MIN(PRICE) FROM ITEM); # 최소가격 알아보기
```

## 4.4 WHERE 절의 서브쿼리(2) : 여러 값을 리턴하는 서브쿼리

 상품중에서 리뷰가 최소 3개 이상 달린 상품들의 정보만 보고싶을 경우
 -> 다른 테이블의 값을 조건으로 하는 서브쿼리

찾고자 하는 값이 서브쿼리안에 존재하는 경우만 리턴하기

```SQL

SELECT * FROM ITEM
WHERE ID IN
(
SELECT ITEM_ID
FROM REVIEW
GROUP BY ITEM_ID HAVING COUNT(*)>=3 # REVIEW 수 3개 이상인 ITEM의 ITEM_ID 조회
)
```

## 4.5 ANY(SOME),ALL

#### ANY
where view_count > any(서브쿼리)
-> 서브쿼리의 값 중 단 하나의 값보다도 크다면 true 리턴
#### ALL
-> 모든 경우에 대해서 서브쿼리의 조건을 만족해야 true 반환

## 4.6 서브쿼리 예제

```SQL
SELECT * FROM REVIEW
WHERE ITEM_ID IN
(
SELECT ID
FROM ITEM
WHERE REGISTRATION_DATE < ('2018-12-31')
)
```

## 4.7 FROM 절에 있는 서브쿼리 (테이블형태의 결과를 리턴하는 서브쿼리)

FROM 절에 있는 서브쿼리는 In-Line View 라고 한다.

### SQL예제와 서브쿼리

```sql
select
    substring(address,1,2) as region,
    count(*) as review_count
from review as r left outer join member as m
on r.mem_id = m.id
group by substring(address,1,2)
having region is not null
    and region != '어디'

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
    and region != '어디') as review_count_summary #서브쿼리로 탄생한 파생테이블은 반드시 alias를 가져야 한다
```

## 4.8 서브쿼리의 종류 정리

 1. 단일값을 리턴하는 서브쿼리
 2. 하나의 컬럼에 여러 row들이 있는 형태의 결과를 리턴하는 서브쿼리
 3. 테이블 형태의 결과를 리턴하는 서브쿼리

## 4.9 상관서브쿼리와 비상관서브쿼리

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

### exists가 없는 상관서브쿼리

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


## 6.16 서브쿼리 중첩과 문제점 : 쿼리가 너무 길어지는 문제

- 서브쿼리가 여러번 중첩될 경우 쿼리가 너무 길어지고 보기 어려워진다.

```sql
select
    i.id,
    i.name,
    avg(star) as avg_star,
    count(*) as count_star
from item as i left outer join review as r on r.item_id = i.id
    left outer join member as m on r.mem_id = m.id
where m.gender = 'f'
group by i.id, i.name
having count(*) >= 2 and avg_star =
(
    select max(avg_star) from (
        select i.id,i.name,avg(star) as avg_star , count(*) as count_star
        from item as i left outer join review as r
            on r.item_id = i.id
        left outer join member as m
            on r.mem_id = m.id
        where m.gender = 'f'
        group by i.id, i.name
        having count(*) >= 2
        order by avg(star) desc, count(*) desc
    ) as final
)
order by avg(star) desc , count(*) desc;
```


## 서브쿼리 총정리

## 6.17 데이터 분석가의 자산, 뷰

https://sassun.tistory.com/92

```sql
## 별점평균 가장높은 id
create view three_tables_joined as
    select i.id,i.name,avg(star) as avg_star , count(*) as count_star
        from item as i left outer join review as r
            on r.item_id = i.id
        left outer join member as m
            on r.mem_id = m.id
        where m.gender = 'f'
        group by i.id, i.name
        having count(*) >= 2
        order by avg(star) desc, count(*) desc;

    select * from copang_main.three_tables_joined
        where avg_star = (
            select max(avg_star) from copang_main.three_tables_joined
        ); # View를 활용해 짧은 쿼리로 중첩서브쿼리와 같은 쿼리 반환
```

###   View의 사용방법

## 6.19 실무에서 첫번째로 해야할 일

(1) 어떤 데이터베이스들이 있는지
-> show databases;
(2) 각 데이터베이스 안에 어떤 테이블들이 있는지
-> show full tables in copang_main;
(3) 각 테이블의 컬럼 구조는 어떻게 되는지
-> describe item;
(4) 테이블들 간의 Foreign Key 관계는 어떤지


## 추가적인 학습사항(계속 업데이트)

### NULLIF 함수 사용하기


```sql
--empty string을 NULL로 보여주는 쿼리

# NULLIF(컬럼,'')는 empty string에 대해서 NULL로 보여주라는 의미

SELECT NULLIF(address,'') as address from `member`; 

--empty string을 NULL로 바꾸는 쿼리

update `member` set address = NULL where length(address)=0;
```

## Unsorted Tricks : Data Prep with SQL

데이터 사이언스를 위한 EDA과정에서 데이터 양이 매우 많을 경우 전처리 자체를 SQL로 해야할 경우가 있다. 아래는 일반적인 데이터 분석 과정에서 검토할 수있는 Data Preperation 용 SQL 쿼리이다. 

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

SELECT attr1, attr2 
from t
where attr1 is not null

-- Filter Based on Aggregation


-- Sampling

-- Sampling

```

# DCL

## GRANT

## REVOKE

# TCL

## COMMIT

## ROLLBACK

## SAVEPOINT

## SET TRANSACTION