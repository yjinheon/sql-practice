[출처](https://jins-dev.tistory.com/entry/MySql-%EA%B8%B0%EB%B3%B8-%EC%BF%BC%EB%A6%AC%EB%AC%B8%EB%93%A4-%EC%A0%95%EB%A6%AC?category=760014)

실무에서도 자주 사용하는 MySQL 쿼리문들을 정리해보았다. 많이 쓰는 기본 쿼리문 사용법들이므로, 필수적으로 알아두어야 한다.

응용만 한다면 어느정도 복잡한 쿼리문도 손쉽게 만들어낼 수 있다.



- 접속 방법

 : mysql -u root -p (dbname)



- 비밀번호 변경

 : mysqladmin -u root password 새로운 비밀번호



- 테이블의 생성

 : create table 테이블(col int);



- 구조 보기

 : desc 테이블 / explain 테이블



- 이름 변경

 : rename table A to B



- 삭제

 : drop table 테이블



- 레코드 삽입

 : Insert into table values(v1, v2) / Insert into table(col1, col2) values(v1, v2);



- 조회

 : select * from table A

> AS : 칼럼의 이름을 달리 명명해서 출력. (ex) Col1 as 'name'

> Desc : 내림차순, Asc : 오름차순 (ORDER BY)

> LIMIT 10 : 0~10 까지 레코드 수 제한. / LIMIT 100, 10 : 100~110까지 레코드 범위



- 수정

 : Update 테이블 set col1 = 칼럼1 where 조건



- 삭제

 : Delete from 테이블 where 조건



- 칼럼 추가

 : Alter table 테이블명 add col3 varchar(255) not null.



- 칼럼 삭제

 : Alter table 테이블명 drop col3



- 칼럼 수정

 : Alter table 테이블명 modify col3 char(50) not null.



- In : 원하는 필드값만을 선택 추출하는데 사용되는 그룹 조건문

- 조인

(1)   Inner join

 : Select * from tableA inner join tableB on tableA.col1 = tableB.col1

 => tableA의 col1과 tableB의 col1이 일치하는 데이터만을 출력. ON 절의 조건이 일치하는 조인테이블의 결과만을 출력한다.





(2)   Outer join

 : Select * from tableA left outer join tableB on tableA.col1 = tableB.col1

 => tableA.col1이 존재하나 tableB.col1이 존재하지 않으면 tableB.col1 = NULL인 상태로 출력. 

 조인하는 테이블의 ON 절 조건 중 한쪽의 모든 데이터를 가져옴(LEFT JOIN , RIGHT JOIN) 양쪽(FULL JOIN)





- 내장함수 Benchmark

 : Select Benchmark(반복횟수, 실행쿼리)

(ex) Select Benchmark(100, (“select * from table”)); => 해당 쿼리를 100번 반복한 벤치마크 결과를 출력.





- DISTINCT

 : 주로 UNIQUE한 COLUMN이나 TUPLE을 조회할 때 사용되는 키워드. 칼럼을 DISTINCT 를 이용하여 조회한다면 중복을 제거한 값들을 바로 얻을 수 있다. 단 이 때, 여러 개의 칼럼을 지정한다면 칼럼의 조합이 중복되는 것을 제외한다. DISTINCT는 함수처럼 WHERE이 아닌 HAVING 조건식에도 사용이 가능하다. 



(ex) Select DISTINCT email from table;



(ex) SELECT class FROM courses GROUP BY(class) HAVING count(distinct student) >= 5;





- GROUP BY

 : 데이터를 그루핑해서 결과를 가져오는 경우 사용. 내부적으로 중복값을 배제한채 정렬된 결과를 가져온다. 주로 HAVING과 같이 사용되며 그룹으로 묶어서 자체 정렬한다. 좀 더 정확히는 그룹의 대표값을 정렬해서 가져온다. 그렇기 때문에 모든 컬럼에 대해 단순 SELECT 하는 쿼리문에는 쓰기 적절치 않으며 테이블 내에서 데이터를 가공할 때 사용하기가 좋다. 예를 들어 accountType에 따라 해당하는 accountName의 row수를 그루핑 하고 싶다면 다음 쿼리를 사용해보자. 


Select accountType, COUNT(accountName) from accounts group by(accountType);





- HAVING

 : HAVING은 GROUP BY 와 같이 쓰이는 구문으로 GROUP BY의 조건문이라 할 수 있다. 위의 쿼리에서 COUNT가 1개 이상인 내용만 쿼리를 하는데 다음처럼 사용 가능하다. 



SELECT accountType, COUNT(accountName) FROM accounts GROUP BY(accountType) HAVING COUNT(accountName)>1; 



HAVING의 시점은 GROUPING이 끝난 이후이고 WHERE 절과 다르게 HAVING 절은 통계함수를 포함할 수 있다.

HAVING은 () 를 안 싸는 것이 좋다. 버전에 따라 오작동 위험이 있는듯하다 ;;





- SubQuery 사용법

 : 복잡한 쿼리문을 만들 때 많이 사용하게 되는 구문이 서브쿼리문이다. 서브쿼리의 사용은 Nested Loop 를 돌기 때문에 사용에 주의하자.



(ex) SELECT accountInfo from accounts where accountName in (select accountName from accountNames);



위의 쿼리는 accountNames 테이블에 있는 이름에 대해서만 accountInfo를 조회하는 쿼리(Validation)





