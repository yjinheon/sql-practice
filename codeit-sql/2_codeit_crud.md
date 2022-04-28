- [1.데이터베이스와 테이블 구축](#1데이터베이스와-테이블-구축)
  - [1.1 데이터베이스 생성하기](#11-데이터베이스-생성하기)
  - [1.2 테이블 생성하기](#12-테이블-생성하기)
  - [1.3 테이블에 row 추가하기](#13-테이블에-row-추가하기)
  - [1.4 테이블의 row 갱신하기](#14-테이블의-row-갱신하기)
  - [1.5 table의 row 삭제하기](#15-table의-row-삭제하기)
  - [1.6 논리삭제와 물리삭제](#16-논리삭제와-물리삭제)
- [2. 테이블 다루기](#2-테이블-다루기)
  - [2.1 컬럼추가와 컬럼의 이름 변경](#21-컬럼추가와-컬럼의-이름-변경)
  - [2.1 컬럼삭제와 컬럼의 데이터 타입 변경](#21-컬럼삭제와-컬럼의-데이터-타입-변경)
  - [2.4 modify 를 사용한 컬럼 속성 추가](#24-modify-를-사용한-컬럼-속성-추가)
  - [2.5 컬럼에 default 값 달기](#25-컬럼에-default-값-달기)
  - [2. datetime, times6tamp 타입의 컬럼에 값 넣기](#2-datetime-times6tamp-타입의-컬럼에-값-넣기)
    - [2.6.1 now() 함수 활용하기](#261-now-함수-활용하기)
    - [2.6.2 컬럼에 default current_timestamp / on update 속성 설정하기](#262-컬럼에-default-current_timestamp--on-update-속성-설정하기)
  - [2.7 컬럼에 unique 속성 주기(고윳값)](#27-컬럼에-unique-속성-주기고윳값)
  - [2.8 CONSTRAINT](#28-constraint)
  - [2.9 컬럼 관련 작업들](#29-컬럼-관련-작업들)
    - [2.9.1 컬럼 가장 앞으로 당기기](#291-컬럼-가장-앞으로-당기기)
    - [2.9.2 컬럼 간의 순서 바꾸기](#292-컬럼-간의-순서-바꾸기)
    - [2.9.3 컬럼의 이름과 컬럼의 데이터 타입 및 속성 동시에 수정하기](#293-컬럼의-이름과-컬럼의-데이터-타입-및-속성-동시에-수정하기)
    - [2.9.4 여러 작업 동시에 수행하기](#294-여러-작업-동시에-수행하기)
  - [2.10 테이블 이름 변경, 복사본 만들기, 삭제](#210-테이블-이름-변경-복사본-만들기-삭제)
  - [2.11 테이블 컬럼 구조만 복사하기](#211-테이블-컬럼-구조만-복사하기)
  - [2.12 insert into 문과 서브쿼리](#212-insert-into-문과-서브쿼리)
  - [2.13 truncate문으로 데이터 한번에 날리기](#213-truncate문으로-데이터-한번에-날리기)
  - [2.14 기존 테이블로 새 테이블 만들기](#214-기존-테이블로-새-테이블-만들기)
- [3. Foreign Key 제대로 사용하기](#3-foreign-key-제대로-사용하기)
  - [3.1 Foreign Key가 필요한 이유](#31-foreign-key가-필요한-이유)
  - [3.2 Foreign Key 설정](#32-foreign-key-설정)
  - [3.3 참조무결성](#33-참조무결성)
  - [3.4 부모 테이블의 row가 삭제될 때 - restrict](#34-부모-테이블의-row가-삭제될-때---restrict)
  - [3.5 부모 테이블의 row가 삭제될 때 - cascade](#35-부모-테이블의-row가-삭제될-때---cascade)
  - [3.6 부모 테이블의 row가 삭제될 때 - set null](#36-부모-테이블의-row가-삭제될-때---set-null)
  - [3.7 부모 테이블의 row에서 참조당하는 컬럼이 갱신 될때](#37-부모-테이블의-row에서-참조당하는-컬럼이-갱신-될때)
  - [3.8 논리적 foreign key, 물리적 foreign key](#38-논리적-foreign-key-물리적-foreign-key)
  - [3.9 Foreign Key를 삭제하는 방법](#39-foreign-key를-삭제하는-방법)
  - [3.10 스키마](#310-스키마)
  - [3.11 Foreign Key로 테이블간 관계 파악하기](#311-foreign-key로-테이블간-관계-파악하기)
# 1.데이터베이스와 테이블 구축

## 1.1 데이터베이스 생성하기

```sql
#db생성
create database if not exists course_rating;
use course_rating; # 사용db지정
```

## 1.2 테이블 생성하기
```sql
create table 'course_rating'.`student`(
    `id` int not null auto_intrememt,
    `name` varchar(20) not null
    primary key (`id`)
);

```
## 1.3 테이블에 row 추가하기

- row를 추가할 시 값을 더 주지 않은 row는 null이됨
- PK는 반드시 값이 있어야함
- auto_increment 속성이 있을 경우 값이 자동으로 추가됨

```sql
# row 추가하기
INSERT INTO sample01 (name,age,gender) VALUES
    ('kim',20,'man'),
    ('Lee',26,'woman'),
    ('Gang',28,'man'),
    ('park',28,'man');
```

```sql
#테이블 생성과제
create table `animal_info` (
    `id` int not null auto_increment,
    `type` varchar(30) not null ,
    `name` varchar(10) not null,
    `age` tinyint not null,
    `sex`  char(1) not null,
    `weight` double not null,
    `feature` varchar(500) null,
    `entry_date` date not null,
    primary key(id)
);

/* 테이블이 생성된 후에 아래의
INSERT 문들이 실행되면서 row 3개가 추가될 겁니다.*/

INSERT INTO animal_info (type, name, age, sex, weight, feature, entry_date) VALUES ('사자', '리오', 8, 'm', 170.5, '상당히 날렵하고 성격이 유순한 편임', '2015-03-21');
INSERT INTO animal_info (type, name, age, sex, weight, feature, entry_date) VALUES ('코끼리', '조이', 15, 'f', 3000, '새끼 때 무리에서 떨어져 길을 잃고 방황하다가 동물원에 들어와서 적응을 잘 마침', '2007-07-16');
INSERT INTO animal_info (type, name, age, sex, weight, feature, entry_date) VALUES ('치타', '매튜', 20, 'm', 62, '나이가 노령이라 최근 활동량이 현저히 줄어든 모습이 보임', '2003-11-20');

SELECT * FROM animal_info;

```

```sql
# 값 삽입 예제
insert into food_menu (menu,price,ingredient) values
    ('라볶이' , 5000 ,'라면, 떡,양파..')
    ('치즈김밥' , 3000 ,'치즈, 김,단무지..')
    ('돈까스' , 8000 ,'국내산 돼지고기,양배추..')
    ('오므라이스' , 7000 ,'계란, 당근..');

```
## 1.4 테이블의 row 갱신하기
- 갱신시 where절을 사용해 조건을 설정해준다.

```sql
update student
    set major = '멀티미디어학과',name = `차소원`
    where id = 2;

# 전체 열 반영
update student
    set score = score + 3
```

## 1.5 table의 row 삭제하기

```sql
# row 삭제

delete from student where id =4;

```

## 1.6 논리삭제와 물리삭제

- 삭제 방식
  - 논리삭제 : 삭제여부를 반영하는 컬럼 추가
  - 물리삭제 : 실제 삭제
    - 이미 데이터 분석에 활용한 row
    - 고객이 동의한 데이터 보유기간이 지난 row  

# 2. 테이블 다루기

## 2.1 컬럼추가와 컬럼의 이름 변경

```sql

ALTER TABLE STUDENT ADD GENDER CHAR(1) NULL; # GENDER 컬럼의 추가
ALTER TABLE STUDENT RENAME STUDENT_NUMBER TO REGISTRATION_NUMBER

```
## 2.1 컬럼삭제와 컬럼의 데이터 타입 변경
- 데이터 타입 변경 시(modify) 변경하려는 데이터 타입이 기존 값에 적합하지 않다면 기존값부터 바꾼 후 타입변경을 해야한다

```sql

ALTER TABLE STUDENT DROP COLUMN ADMISSION_DATE;

```

```sql
#데이터 타입 변환


update student set major = 10 where major = '컴퓨터공학과';

alter table student modify major int;

```

## 2.4 modify 를 사용한 컬럼 속성 추가

```sql

alter table modify student not null;

```

## 2.5 컬럼에 default 값 달기

```sql

# major 컬럼에 default값 주기
alter table student modify major int not null default 101;
insert into student (name,registration_number)
    values('구지섭','20112405')

```

## 2. datetime, times6tamp 타입의 컬럼에 값 넣기

### 2.6.1 now() 함수 활용하기
- 온라인 포스트의 내용을 변경한다고 할 영우 recent_modified 컬럼의 값도 리턴값으로 갱신함

```sql
update post
    set content ='내용',
        recent_modified_time = now()
    where id = 1;
```

### 2.6.2 컬럼에 default current_timestamp / on update 속성 설정하기

datetime 타입이나 timestamp 타입 컬럼에는 default current_timestamp 라는 속성과 on update current_timestamp 라는 속성을 줄 수 있다.

- default current_timstamp : 테이블에 새 row를 추가할 때 따로 그 컬럼에 값을 주지 않다도 현재 시 간이 되도록 설정
- on update current_timestamp : 기존 row에서 단 하나의 컬럼이라도 갱신되면 갱신될 때의 시간이 설정되도록 하는 속성

```sql

alter table post
    modify upload_time datetime default current_timestamp,
    modify recent_modified_time datetime default current_timestamp,on update current_timestamp;

# 해당 설정후 row 추가 시 upload_time, recent modified 컬럼에는 별도로 값을 주지 않아도 현재 시간이 값으로 들어감
```

## 2.7 컬럼에 unique 속성 주기(고윳값)

```sql

alter table student
    modify registration_number int not null unique;

```

## 2.8 CONSTRAINT

- add constraint 구문을 사용한다
- constraint의 이름을 붙여준다

```sql

alter table student
    add constraint st_rule check(registration_number < 3000000);

alter table student
    drop constraint st_rule; # 제약삭제

alter table student
    add constraint st_rule check(registration_number < 3000000);

# 두 개 이상의 조건을 가진 문자열
alter table student
    drop constraint st_rule
    check (email like '%@%') and
        gender in ('m','f');
```

**SQL에서 주로 쓰는 Constraints**

- NOT NULL - Ensures that a column cannot have a NULL value
- UNIQUE - Ensures that all values in a column are different
- PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
- FOREIGN KEY - Prevents actions that would destroy links between tables
- CHECK - Ensures that the values in a column satisfies a specific condition
- DEFAULT - Sets a default value for a column if no value is specified
- CREATE INDEX - Used to create and retrieve data from the database very quickly

## 2.9 컬럼 관련 작업들

### 2.9.1 컬럼 가장 앞으로 당기기

```sql

# modify 구문에 first를 넣어준다.
alter table player_info
    modify id int not null auto_increment first;
```
### 2.9.2 컬럼 간의 순서 바꾸기

```sql

alter table player_info
    modify role char(5) null after name;

```

### 2.9.3 컬럼의 이름과 컬럼의 데이터 타입 및 속성 동시에 수정하기

- 컬럼 이름 수정시 rename column A to B 사용
- 컬럼의 타입 및 속성 수정시 modify 사용
- change를 활용 컬럼의 이름과 데이터타입 속성 수정

```sql
alter table player_info
    change role position varchar(2) not null;
# role : 기존컬럼이름
# position : 새로운 이름
```
### 2.9.4 여러 작업 동시에 수행하기

```sql
ALTER TABLE PLAYER_INFO
    CHANGE ID REGISTRATION_NUMBER INT NOT NULL AUTO_INCREMENT,
    CHANGE NAME NAME VARCHAR(20) NOT NULL,
    DROP COLUNM POSITION,
    ADD HEIGHT DOUBLE NOT NULL,
    ADD WEIGHT DOUBLE NOT NULL;
```

## 2.10 테이블 이름 변경, 복사본 만들기, 삭제

```sql
# 테이블 이름 변경
RENAME TABLE STUDENT TO UNDERGRADUATE;

CREATE TABLE CP_UNDERGRADUATE AS SELECT * FROM UNDERGRADUATE;

```
## 2.11 테이블 컬럼 구조만 복사하기


* 구조 복사

특징 : 기존 테이블의 설정 그대로 복사 된다.

응용 ==> Create Table IF NOT EXISTS new_table like old_table (new_table 이 없으면 복사)

```sql

CREATE TABLE NEW_TABLE LIKE OLD_TABLE

```


* 구조와 데이터 복사

특징 : 테이블의 구조와 함께 데이터도 함께 복사가 된다.


```sql

CREATE TABLE NEW_TABLE ( SELECT * FROM OLD_TABLE )

```

* 데이터 복사

참고 ==> 대상 테이블의 컬럼 중에 자동 증가 값 설정 이 된 컬럼이 있을 경우 해당 컬럼에 데이터 입력시 중복된 데이터가 있으면 오류 발생.

응용 ==> Insert Into destination_table (column_a, column_b) (select a, b from source_table) 원하는 필드의 데이터만 복사가 가능하다.

```sql

INSERT INTO DESTINATION_TABLE ( SELECT * FORM SOURCE_TABLE)  

```

## 2.12 insert into 문과 서브쿼리

 **insert into 테이블명 select 가져올필드 from 가져올테이블 where 가져올조건;**  
 **insert into 테이블명(넣을필드,넣을필드,넣을필드...) select 가져올필드,가져올필드,가져올필드... from 가져올테이블 where 가져올조건;**

## 2.13 truncate문으로 데이터 한번에 날리기

## 2.14 기존 테이블로 새 테이블 만들기

# 3. Foreign Key 제대로 사용하기

## 3.1 Foreign Key가 필요한 이유

## 3.2 Foreign Key 설정

## 3.3 참조무결성

## 3.4 부모 테이블의 row가 삭제될 때 - restrict

## 3.5 부모 테이블의 row가 삭제될 때 - cascade

## 3.6 부모 테이블의 row가 삭제될 때 - set null

## 3.7 부모 테이블의 row에서 참조당하는 컬럼이 갱신 될때

## 3.8 논리적 foreign key, 물리적 foreign key

## 3.9 Foreign Key를 삭제하는 방법

## 3.10 스키마

## 3.11 Foreign Key로 테이블간 관계 파악하기
