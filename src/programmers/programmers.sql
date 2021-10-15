/* 
- 연습삼아 하는 프로그래머스 sql 문제풀이
- level 5까지
*/

-- 1. 모든 row 조회
SELECT * from animal_ins

-- 2. 일부 열 조회, 역순 정렬
SELECT name, datetime
from animal_ins
order by animal_id desc;

-- 3. 조건일치 row 조회
SELECT animal_id, name
from animal_ins
where intake_condition like '%Sick%' -- like 용법 확인
order by animal_id;


-- 특정조건에 해당하지 '않는' 샘플 구하기 

SELECT animal_id, name from animal_ins
where intake_condition != 'Aged'


-- 상위 n개 레코드 구하기
SELECT name 
from animal_ins
order by datetime 
limit 1

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

SELECT animal_type,count(*)
from animal_ins
order by animal_type


-- animal_id순으로 정렬하기

select animal_id,name 
from animal_ins
order by animal_id


-- 두 컬럼 기준으로 정렬하기

SELECT animal_id, name, datetime
from animal_ins
order by name , datetime desc


-- 동명 동물 수 찾기
SELECT name, count(name) as count
from animal_ins
group by name
having count(name) >= 2
order by name


--이름없는 동물

select animal_id
from animal_ins
where name is null
order by animal_id


-- 이름 있는 동물

select animal_id
from animal_ins
where name is not null
order by animal_id


-- null 처리

select animal_type ifnull(name,"noname"), sex_upon_intake
from animal_ins
order by animal_id


-- 없어진 기록 찾기

select animal_id ,name
from animal_outs
where animal_id not in(select animal_id from animal_ins) --유실된데이터
order by animal_id


-- 있었는데요 없었습니다.

select i.animal_id, i.name
from animal_ins as i
join animal_outs o 
	on i.animal_id = o.animal_id
where i.datetime > o.datetime
order by i.datetime


-- 오랜기간 보호한 동물

select name,datetime
from animal_ins
where animal_id not in (select animal_id from animal_outs)
order by datetime
limit 3

--중성화된 동물
select animal_id,animal_type,name
from animal_ins
where sex_upon_intake  like "Intact%" and animal_id not in (select animal_id from animal_outs where sex_upon_outcome like "Intact%")
order by animal_id


-- 루시와 엘라 찾기



-- 입양시간구하기

select hour(datetime) as hour,


--입양시각 2

set @hour = -1
select (@hour := +1) as 
