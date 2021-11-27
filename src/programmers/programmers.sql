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

-- 가장 최근 시점 구하기(최댓값 구하기)

SELECT max(DATETIME)
from animal_ins

-- 가장 이전 시점 구하기

SELECT min(DATETIME)
from animal_ins

-- 가장 이전 시점 구하기

SELECT max(DATETIME)
from animal_ins

-- 동물 수 구하기
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


-- 동명 동물 수 찾기(중복되는 이름과 횟수 조회)

SELECT name, count(name) as count
from animal_ins
group by name
having count(name) >= 2
order by name


--이름없는 동물 (is null)

select animal_id
from animal_ins
where name is null
order by animal_id


-- 이름 있는 동물

select animal_id
from animal_ins
where name is not null
order by animal_id


-- null 처리 ifnull(컬럼,"null치환 이름")

select animal_type ifnull(name,"noname"), sex_upon_intake --ifnull은 컬럼으로 사용
from animal_ins
order by animal_id


-- 없어진 기록 찾기

select animal_id ,name
from animal_outs
where animal_id not in(select animal_id from animal_ins) --유실된데이터
order by animal_id



-- 없어진 기록 찾기 join 활용
-- 한 테이블에 있는 데 다른 테이블에 없을 경우
-- left outer join으로 null 포함 값 구하기
-- join 시 alias 활용



select o.animal_id ,o.name
from animal_outs as o left outer join animal_ins as i
on o.animal_id = i.animal_id
WHERE i.animal_id is null
order by animal_id



-- 있었는데요 없었습니다.

select i.animal_id, i.name
from animal_ins as i
join animal_outs o 
	on i.animal_id = o.animal_id
where i.datetime > o.datetime
order by i.datetime



SELECT i.animal_id, i.name
from animal_ins as i join animal_outs as o
on i.animal_id = o.animal_id 
where (i.datetime - o.datetime) > 0
order by i.datetime


-- 오랜기간 보호한 동물

select name,datetime
from animal_ins
where animal_id not in (select animal_id from animal_outs)
order by datetime
limit 3


-- 오랜기간 보호한 동물 2

SELECT i.name, i.datetime
from animal_ins as i left outer join animal_outs as o
on i.animal_id = o.animal_id
where o.animal_id is null -- 나간 테이블에는 없어야 한다.
order by i.datetime
limit 3


--중성화된 동물
select animal_id,animal_type,name
from animal_ins
where sex_upon_intake  like "Intact%" and animal_id not in (select animal_id from animal_outs where sex_upon_outcome like "Intact%")
order by animal_id



-- 중성화된 동물 2
-- like로 조건에 대해 검색핟다

SELECT i.animal_id,i.animal_type,i.name
from animal_ins as i left outer join animal_outs as o
on i.animal_id = o.animal_id
where (o.sex_upon_outcome not like "Intact%") and (i.sex_upon_intake like "Intact%")
order by animal_id


-- 루시와 엘라 찾기

SELECT animal_id, name, sex_upon_intake
from animal_ins
where name in ("Lucy", "Ella", "Pickle", "Rogan", "Sabrina", "Mitty")


--중성화 여부 파악하기

SELECT animal_id, name,
case 
    when sex_upon_intake like "Intact%" then "O"
    else "X" 
end as "중성화"
from animal_ins
order by animal_id



-- 이름에 el 이 들어가는 개 찾기
SELECT animal_id, name 
from animal_ins
where name like "%el%" and animal_type = "Dog"
order by name


-- 오랜기간 보호한 동물 2

SELECT i.animal_id, i.name
from animal_ins as i join animal_outs as o 
on i.animal_id = o.animal_id
order by o.datetime - i.datetime desc ##입양을 간 날짜에서 보호가 시작된 날짜를 빼면 그만큼 보호소에 있었던 것
limit 2


-- 입양시간구하기

SELECT hour(datetime) as hour , count(animal_id) as count 
from animal_outs
where hour(datetime) >= 9 and  hour(datetime) <= 20
group by hour(datetime)
order by hour

-- date time관련 함수 정리

curdate() # 현재 날짜 반환

SELECT * FROM copang_main.`member` WHERE year(birthday) = 1992; # year() : 날짜에서 연도 반환

SELECT * FROM copang_main.`member` WHERE MONTH (birthday) IN (6,7,8); # month() : 날짜에서 월 반환

SELECT * FROM copang_main.`member` WHERE DAYOFMONTH(birthday) BETWEEN  15 and 31; # date : 날짜에서 date 반환

SELECT email,sign_up_day,DATEDIFF(sign_up_day,'2019-01-01') FROM `member` ; # 각 회원이 가입한 날짜가 19년 1월 1일 이후 몇일인가?

SELECT email,sign_up_day,DATE_ADD(sign_up_day,INTERVAL 300 day) FROM `member` ; # 날짜 더하기

SELECT email,sign_up_day,DATE_SUB(sign_up_day,INTERVAL 300 day) FROM `member` ; # 날짜 빼기

SELECT email,sign_up_day,UNIX_TIMESTAMP(sign_up_day) FROM `member`; # unix_timestamp 변환



--입양시각 2


# @ 가 붙은 변수는 프로시저가 종료되어도 유지됨. 이를 통해 값을 누적하여 0~23표현가능
# := 는 대입연산다
# SELECT (@hour := @hour +1) 은 @hour의 값에 1씩 증가시키면서 SELECT 문 전체를 실행
# @hour<23일 때까지 @hour 값이 계속 증가함


SET @hour := -1; -- 변수 선언

SELECT (@hour := @hour + 1) as HOUR,
(SELECT COUNT(*) FROM ANIMAL_OUTS WHERE HOUR(DATETIME) = @hour) as COUNT
FROM ANIMAL_OUTS
WHERE @hour < 23