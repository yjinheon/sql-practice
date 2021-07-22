/* 
- 연습삼아 하는 프로그래머스 sql 문제풀이
- level 5까지
*/

-- 1. 모든 row 조회
SELECT * from animal_ins

-- 2. 일부 열 조회
SELECT name, datetime
from animal_ins
order by animal_id desc;

-- 3. 조건일치 row 조회
SELECT animal_id, name
from animal_ins
where intake_condition like '%Sick%' -- like 용법 확인
order by animal_id;


-- 가장 최근 시점 구하기

SELECT max(DATETIME)
from animal_ins


-- 가장 이전 시점 구하기

SELECT max(DATETIME)
from animal_ins


-- 가장 이전 시점 구하기

SELECT max(DATETIME)
from animal_ins

-- 동물 몇마리 조회
SELECT count(animal_id) 
from animal_ins

-- 동물 이름기준 고유값 조회

select distinct(name)
from animal_ins

-- Group by 개와 고양이(고양이 먼저)

SELECT  animal_type,count(animal_id)
from animal_ins
group by animal_type
order by animal_type