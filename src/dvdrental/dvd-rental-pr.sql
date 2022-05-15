
-- change db
\c dvdrental


SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns
WHERE 
   table_name = 'city';


-- https://ggarden.tistory.com/40?category=860990 SQL 100제
-- 1-1. dvd 렌탈 업체의 dvd 대여가 있었던 날짜를 확인해주세요.



select distinct date(rental_date)
from rental

-- SELECT DISTINCT와 DATE()를 활용하여 유니크한 날짜 추출   

-- 1-2. 영화길이가 120분 이상이면서, 대여기간이 4일 이상이 가능한, 영화제목을 알려주세요.
SELECT title 
from film
where rental_duration > 4 and length > 120

-- 1-3. 직원의 id가 2번인 직원의 id, 이름, 성을 알려주세요.

select staff_id,first_name, last_name
from staff
where staff_id = 2


-- 1-4. 지불 내역 중에서, 지불 내역 번호가 17510에 해당하는 고객의 지출 내역(amount)은 얼마인가요?

select amount 
from payment
where payment_id = 17510


-- 1-5. 영화 카테고리 중에서, Sci-Fi 카테고리의 카테고리 번호는 몇 번인가요?

select category_id
from category c
where name  = "Sci-Fi"


-- 1-6. film 테이블을 활용하여, rating 에 대해서, 몇 개의 등급이 있는지 확인해보세요.

SELECT count(distinct(rating))
from film


-- 1-7. 대여 기간이 (회수 - 대여일) 10일 이상이었던 rental 테이블에 대한 모든 정보를 알려주세요.
-- 단 , 대여기간은 대여일자부터 대여기간으로 포함하여 계산합니다.

SELECT * 
from rental
WHERE date(return_date)-date(rental_date)+1 >= 10;



-- 1-8. 고객의 id가 50,100,150.. 등 50번의 배수에 해당하는 고객들에 대해서, 회원 가입 감사 이벤트를 진행하려고 합니다. 
-- 고객 아이디가 50번 배수인 아이디와 고객의 이름(성, 이름)과 이메일에 대해서 확인해주세요.
-- mod()로 나머지를 계산할 수도 있다.


SELECT customer_id,first_name, last_name, email
from customer
where customer_id % 50 = 0

select mod(customer_id,50) -- 50 으로 나눈 나머지 계산
from customer
limit 10



-- 1-9. 영화 제목의 길이가 8글자인, 영화 제목 리스트를 나열해주세요.
-- 띄어쓰기도 길이에 포함된다.
-- length() 활용 

SELECT title
from film
where length(title) = 8




-- 1-10. city 테이블의 city 갯수는 몇 개인가요? 
-- 중복은 고려하지 않는다. 

SELECT count(distinct(city))
from city

-- 1-11. 영화배우의 이름(이름+' '+성)에 대해서 대문자로 이름을 보여주세요. 
-- 단, 고객의 이름이 동일한 사람이 있다면 중복 제거하고 알려주세요.

select upper(first_name || ' ' || last_name)
from actor


-- 1-12. 고객 중에서 active 상태가 0인, 즉 현재 사용하지 않고 있는 고객의 수를 알려주세요.
-- 중복된 고객이 있다면 유니크한 고객을 출력해야 한다. 

select count(distinct(customer_id))
from customer
where active = 0


-- 1-13. Customer 테이블을 활용하여, store_id = 1에 매핑된 고객의 수는 몇 명인지 확인해보세요.

select count(customer_id)
from customer
where store_id = 1


-- 1-14. rental 테이블을 활용하여, 고객이 return 했던 날짜가 2005년6월20일에 해당했던 rental의 갯수가 몇 개였는지 확인해보세요.
-- date()는 string을 반환한다. 

select count(rental_id)
from rental
where date(rental_date) = '2005-06-20'



-- 1-15. film 테이블을 활용하여, 2006년에 출시가 되고 rating이 'G' 등급에 해당하며, 대여기간이 3일에 해당하는 것에 대한 film 테이블의 모든 컬럼을 알려주세요.


select *
from film f 
where release_year=2006 and rating='G' and rental_duration=3


-- language 테이블에 있는 id, name 컬럼을 확인해보세요.

select language_id, name
from language


-- film 테이블을 활용하여, rental_duration이 7일 이상 대여가 가능한 film에 대해서 film_id, title, description 컬럼을 확인해보세요.

select film_id, title, description
from film
where rental_duration >= 7


-- 1-18. film 테이블을 활용하여, rental_duration 대여가 가능한 일자가 3일 또는 5일에 해당하는 film_id, title, desciption을 확인해주세요.

select film_id, title, description
from film
where rental_duration in (3,5)

--desc film

-- 1-19. Actor 테이블을 이용하여, 이름이 Nick이거나 성이 Hunt인 배우의 id와 이름, 성을 확인해주세요.


select actor_id, first_name, last_name
from actor a
where first_name = "Nick" or last_name="Hunt"


-- 1-20. Actor 테이블을 이용하여, Actor 테이블의 first_name 컬럼과 last_name 컬럼을 firstname, lastname으로 컬럼명을 바꿔서 보여주세요.

select actor_id , first_name as firs , last_name as last
from actor a



-- 2-1. film 테이블을 활용하여 film 테이블의 100개의 row만 확인해보세요.

select * 
from film
limit 100

-- 2-2. actor의 성(last_name)이 Jo로 시작하는 사람의 id 값이 가장 낮은 사람 한 사람에 대하여, 사람의 id 값과 이름, 성을 알려주세요.


select actor_id,first_name,last_name
from actor
where last_name like 'Jo%'
order by actor_id
limit 1


-- 2-3. film 테이블을 이용하여, film 테이블의 아이디 값이 1~10 사이에 있는 모든 컬럼을 확인해주세요.

-- between A and B 는 A<=t<=B를 의미한다.

select * 
from film
where film_id between 1 and 10


-- 2-4. country 테이블을 이용하여, country 이름이 A로 시작하는 country를 확인


select *
from country c
where country like 'A%'


-- 2-5. country 테이블을 이용하여, country 이름이 s로 끝나는 country를 확인해주세요.
-- 대문자 S로 끝나는 데이터도 확인하고 싶다면 lower() 적용 


select country
from country c
where country like '%s'

-- 2-6. address 테이블을 이용하여, 우편번호(postal_code) 값이 77로 시작하는 주소에 대하여, address_id, address, district, postal_code 컬럼을 확인해주세요.


select address_id, address, district, postal_code
from address
where postal_code like '77%'

-- 2-7. address 테이블을 이용하여, 우편번호(postal_code) 값이 두 번째 글자가 1인 우편번호의 address_id, address, district, postal_code 컬럼을 확인해주세요.


select address_id, address, district, postal_code
from address
where postal_code like '_1%' -- 2번째 글자 매칭하기 :


-- 정규표현식으로 해결하기
select address_id, address, district, postal_code
from address
where postal_code regexp("^.[1]")



-- regex 참고
-- https://yurimkoo.github.io/analytics/2019/10/26/regular_expression.html

-- https://dataschool.com/how-to-teach-people-sql/how-regex-works-in-sql/



-- 2-8. payment 테이블을 이용하여, 고객번호가 341에 해당하는 사람이 결제를 2007년 2월 15~16일 사이에 한 모든 결제 내역을 확인해주세요.

select *
from payment
where customer_id = 341 and date(payment_date) between "2007-02-15" and "2007-02-16"


-- 2-9. payment 테이블을 이용하여, 고객번호가 355에 해당하는 사람의 결제 금액이 1~3원 사이에 해당하는 모든 결제 내역을 확인해주세요.


select *
from payment
where customer_id = 355 and amount between 1 and 3


-- 2-10. customer 테이블을 이용하여, 고객의 이름이 Maria, Lisa, Mike에 해당하는 사람의 id, 이름, 성을 확인해주세요.

select customer_id, first_name, last_name
from customer c
where first_name in ("Maria","Lisa","Mike")


-- 2-11. film 테이블을 이용하여, film의 길이가 100~120에 해당하거나 또는 rental 대여 기간이 3~5일에 해당하는 film의 모든 정보를 확인해주세요.

select *
from film
where length between 100 and 120 or rental_duration between 3 and 5

-- 2-12. address 테이블을 이용하여, postal_code 값이 공백('')이거나 35200, 17886에 해당하는 address에 모든 정보를 확인해주세요.
-- case문 사용 

select *
from address a 
where postal_code in ('', '35200', '17886')

-- 2-13. address 테이블을 이용하여, address의 상세주소(=address2) 값이 존재하지 않는 모든 데이터를 확인하여 주세요.

-- coalesce(칼럼,'null일 경우 대체')

select *,
coalesce (address2, 'empty') as new_address2
from address a 
where address2 is null


-- 2-14. staff 테이블을 이용하여, staff의 picture 사진의 값이 있는 직원의 id, 이름, 성을 확인해주세요. 단 이름과 성을 하나의 컬럼으로 이름, 성의 형태로 새로운 컬럼 name 컬럼으로 도출해주세요.


select staff_id, first_name || '_' || last_name as name
from staff s
where picture is not null

-- 2-15. rental 테이블을 이용하여, 대여는 했으나 아직 반납 기록이 없는 대여 건의 모든 정보를 확인해주세요.

select *
from rental
where rental_date is not null and return_date is null

-- 2-16. address 테이블을 이용하여, postal_code 값이 빈 값(NULL)이거나 35200, 17886에 해당하는 address의 모든 정보를 확인해주세요.
-- postal_code는 문자열이다. 

select * 
from address
where postal_code in ('35200','17886','') 


-- 2-17. 고객의 성에 John이라는 단어가 들어가는, 고객의 이름과 성을 모두 찾아주세요.

SELECT first_name ||'_' || last_name as name
from customer
where last_name like '%John%'


-- 2-18. 주소 테이블에서, address2 값이 null 값인 row 전체를 확인해볼까요? (2-13번) 
-- NULL과 공백 모두 존재 

select *
from address
where address2 is null


-- JOIN 

-- 3-1. 고객의 기본 정보인, 고객 id, 이름, 성, 이메일과 함께 고객의 주소 address, district, postal_code, phone 번호를 함께 보여주세요.

select customer_id, first_name || ' ' || last_name as name, email, address, district, postal_code, phone
from customer c join address a 
on c.address_id = a.address_id   
LIMIT 10


-- Decribe in postgresql

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'customer';


SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'address';


-- 3-2. 고객의 기본 정보인, 고객 id, 이름, 성, 이메일과 함께 고객의 주소 address, district, postal_code, phone, city를 함께 알려주세요.

select customer_id, first_name || ' ' || last_name as name, email, address, district, postal_code, phone, city
from customer c 
join address a on c.address_id = a.address_id
join city c2 on a.city_id = c2.city_id


-- 3-3. Lima City에 사는 고객의 이름과, 성, 이메일, phonenumber에 대해서 알려주세요.


SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'city';

-- 매칭이 안되더라도 한쪽 테이블의 정보를 전부 뽑고 싶을 경우 outer join을 사용한다.
-- 이건 outer join을 사용해야 하는 case는 아니다.

select first_name || ' ' || last_name as name, email,phone,city
from customer c 
join address a on c.address_id = a.address_id
join city c2 on a.city_id = c2.city_id
where c2.city like '%Lima'


-- 3-4. rental 정보에 추가로, 고객의 이름과, 직원의 이름을 함께 보여주세요.

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'rental';

select rental_id , c.first_name || '_' || c.last_name as customer_name, s.first_name || '_' || s.last_name  as staff_name
from rental r
join customer c on r.customer_id = c.customer_id
join staff s on r.staff_id = s.staff_id


-- 3-5. seth.hannon@sakilacustomer.org 이메일 주소를 가진 고객의  주소 address, address2, postal_code, phone, city 주소를 알려주세요.

select address,address2,postal_code, phone,city
from customer c
join address a on c.address_id = a.address_id
join city c2 on a.city_id = c2.city_id
where email = 'seth.hannon@sakilacustomer.org'


-- Jon Stephens 직원을 통해 dvd대여를 한 payment 기록 정보를 확인하려고 합니다.
-- payment_id, 고객 이름과 성, rental_id, amount, staff 이름과 성을 알려주세요.


select payment_id , c.first_name, c.last_name, p.rental_id , amount, s.first_name || ' ' || s.last_name as staff_name
from payment p
join customer c on p.customer_id = c.customer_id
join rental r on p.rental_id = r.rental_id
where staff_name = "Jon Stephens"

-- 배우가 출연하지 않는 영화의 film_id, title, release_year, rental_rate, length를 알려주세요.
-- ~가 하지 않는은 left outer join을 고려한다.

select f.film_id ,title , release_year , rental_rate , f.length 
from film f
left outer join film_actor a on f.film_id = a.film_id 
where a.actor_id is NULL


-- 3.8 store 상점 id별 주소(address, address2, distict)와 해당 상점이 위치한 city 주소를 알려주세요.


select s.store_id,a.address,a.address2, a.district,c.city
from store s 
join address a on s.address_id = a.address_id
join city c on a.city_id = c.city_id


-------------------------------------------------- JOIN, LEFT JOIN CASE

-- 9 고객의 id별로 고객의 이름(first_name, last_name), 이메일, 고객의 주소(address, district), phone번호, city, country를 알려주세요.

select c.first_name ||' ' || c.last_name as name, email, a.address, a.district , phone, c2.city, c3.country
from customer c
join address a on c.address_id = a.address_id
join city c2 on a.city_id = c2.city_id
join country c3 on c2.country_id = c3.country_id

-- 10  country가 china가 아닌 지역에 사는 고객의 이름(first_name, last_name)과 email, phone, country, city를 알려주세요

select c.first_name ||' ' || c.last_name as name, email, phone, c3.country, c2.city
from customer c
join address a on c.address_id = a.address_id
join city c2 on a.city_id = c2.city_id
join country c3 on c2.country_id = c3.country_id
where c3.country != 'China'


-- 11. Horror 카테고리 장르에 해당하는 영화의 이름과 description에 대해서 알려주세요

select title, description
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Horror'


-- 12. Music 장르이면서, 영화길이가 60~180분 사이에 해당하는 영화의 title, description, length를 알려주세요.

-------------------------------------------------- SUBQUERY


-- 13. actor 테이블을 이용하여, 배우의 ID, 이름, 성 컬럼에 추가로 'Angels Life' 영화에 나온 영화 배우 여부를 Y, N으로 컬럼을 추가 표기해주세요. 해당 컬럼은 angelslife_flag로 만들어주세요.


-- CASE WHEN을 활용한 컬럼 생성
select a.actor_id, first_name, last_name, case when a.actor_id in (
   select fa.actor_id from film_actor where fa.film_id in 
   (select f.film_id 
   from film f 
   where f.title='Angels Life')) then 'Y' else 'N' end as angelslife_flag
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id

-- 원테이블에 조인한 테이블을 붙이는 느낌

SELECT a.actor_id, a.first_name, a.last_name,
	CASE WHEN a.actor_id = feat_actor.actor_id THEN 'Y'
		ELSE 'N' 
	END AS angelslife_flag
FROM actor a
LEFT JOIN (
	SELECT f.film_id, f.title, fa.actor_id 
	FROM film_actor fa
	JOIN film f ON fa.film_id = f.film_id
	WHERE f.title = 'Angels Life'
	) AS feat_actor ON a.actor_id = feat_actor.actor_id;


-- 서브쿼리는 `title = 'Angels Life'`를 만족하는 actor_id

-- 해당 배우가 서브쿼리에 포함되면 Y, 아니면 N 

-- 14. 대여일자가 2005-06-01~14일에 해당하는 주문 중에서, 직원의 이름(이름 성) = 'Mike Hillyer'이거나 고객의 이름(이름 성) = 'Gloria Cook'에 해당하는 rental의 모든 정보를 알려주세요.

-- 추가로 직원 이름과, 고객 이름에 대해서도 fullname으로 구성해서 알려주세요.

-- 15. 대여일자가 2005-06-01~14일에 해당하는 주문 중에서, 직원의 이름(이름 성) = 'Mike Hillyer'에 해당하는 직원에게 구매하지 않은 rental의 모든 정보를 알려주세요.
-- 추가로 직원 이름과, 고객 이름에 대해서도 fullname으로 구성해서 알려주세요.



-- SUBQUERY
-- 
-- 매출을 가장 많이 올린 dvd 고객 이름
-- 서브쿼리_테이블에 조인하는 패턴

SELECT c.customer_id, first_name || ' ' || last_name AS full_name, total_payments
from customer c 
join (
    select p.customer_id, sum(amount) as total_payments
    from payment p
    group by p.customer_id    
    order by sum(amount) desc
    limit 1) as t on c.customer_id = t.customer_id;