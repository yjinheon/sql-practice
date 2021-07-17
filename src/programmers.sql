/* 
- 연습삼아 하는 프로그래머스 sql 문제풀이
- level 3까지
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