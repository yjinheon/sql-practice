### row id 기준 테이블 값 매칭해서 업데이트 하기

```sql
UPDATE table1 AS t1
SET (field1, field2) = (t2.field1, t2.field2)
FROM table2 AS t2
WHERE t2.id = t1.id
```


### 데이터 테이블 복사

```sql

-- 테이블 정보 전부 복사 복제

create table 복제_테이블 (like "원본_테이블" including all);
insert into 복제_테이블 ( select * from "원본_테이블");


-- create table t_wesc001_l01_prep (like "t_wesc001_l01" including all);
-- insert into t_wesc001_l01_prep ( select * from "t_wesc001_l01");

```

### 데이터 테이블 로컬 백업

- v : verbose
- U : user


```bash
pg_dump -v -U rfph_app_01 -Ft -t t_wesc001_m01 -d rfph -h 210.95.250.96 -p 5432 -f /home/jinheonyoon/test2.tar
```

reference : 

### 데이터 테이블 복원

```bash
pg_restore -h 14.63.170.170 -p 2087 -U rnduser -d rnd -t t_wesc001_m01 -v test2.tar
```

### 중복 제거


- 중복 제거하고자 하는 컬럼들만 group by 해서 가장 앞의 id만 남기는 로직

```sql
DELETE FROM table_name
WHERE id NOT IN (
  SELECT MIN(id)
  FROM table_name
  GROUP BY column_name
);
```

- 다른 방식

```sql
DELETE FROM 테이블명
WHERE 컬럼명 IN ( SELECT 컬럼명
FROM (SELECT 컬럼명, row_number() over(partition BY 컬럼 전체) AS rnum FROM 테이블명) t
WHERE t.rnum > 1);
```

### 유저명 변경

```sql
ALTER USER [아이디] WITH PASSWORD '[패스워드]';
```

### 계정 및 권한 확인


```bash
\du
```

권한 종류

| SUPERUSER or NOSUPERUSER                    | SUPERUSER 여부                    |
| ------------------------------------------- | --------------------------------- |
| CREATEDB or NOCREATEDB                      | DATABASE를 만들 수 있는 권한      |
| CREATEROLE or NOCREATEROLE                  | ROLE을 만들 수 있는 권한          |
| LOGIN or NOLOGIN                            | LOGIN 허용 여부                   |
| INHERIT or NOINHERIT                        | 상속 가능 여부                    |
| REPLICATION or NOREPLICATION                | 복제 권한                         |
| BYPASSRLS or NOBYPASSRLS                    | RLS(Row-Level Security) 무시 여부 |
| PASSWORD [password]                         | 패스워드                          |
| VALID UNTIL [timestamp]                     | 패스워드의 유효기간               |
| IN ROLE [role_name] or IN GROUP [role_name] | 지정한 ROLE의 구성원으로 포함     |
| ROLE [role_name] or GROUP [role_name]       | 지정한 ROLE 부여                  |
| ADMIN [role_name]                           | 윗 줄의 ROLE 속성 + WITH ADMIN    |


### 유저에게 권한 부여

```bash
postgres=# CREATE DATABASE my_db WITH OWNER [USER] ENCODING 'UTF8';

CREATE DATABASE

postgres=# GRANT ALL PRIVILEGES ON DATABASE my_db TO [USER];
GRANT
```



| SELECT         | 데이터 조회. UPDATE/DELETE 하려면 포함 필요 |
| -------------- | ------------------------------------------- |
| INSERT         | 데이터 추가                                 |
| UPDATE         | 데이터 수정                                 |
| DELETE         | 데이터 삭제                                 |
| TRUNCATE       | 데이터 모두 삭제                            |
| REFERENCES     | 외래키 제약 조건 생성                       |
| TRIGGER        | 트리거                                      |
| CREATE         | 스키마 생성                                 |
| CONNECT        | 데이터베이스 연결                           |
| TEMPORARY      | 임시 테이블 생성                            |
| EXECUTE        | 함수/프로시저 연산자 허용                   |
| USAGE          | 스키마 객체 접근 허용                       |
| ALL PRIVILEGES | 모든 권한                                   |



### CTAS (Create Table AS SELECT)

select 문을 기반으로 CREATE TABLE 생성


```sql

create table test_table as (
  select * from original_table
)

```


### global search funtion

```sql
CREATE OR REPLACE FUNCTION global_search(
    search_term text,
    param_tables text[] default '{}',
    param_schemas text[] default '{public}',
    progress text default null -- 'tables','hits','all'
)
RETURNS table(schemaname text, tablename text, columnname text, rowctid tid)
AS $$
declare
  query text;
  hit boolean;
begin
  FOR schemaname,tablename IN
      SELECT t.table_schema, t.table_name
        FROM information_schema.tables t
  JOIN information_schema.schemata s ON
    (s.schema_name=t.table_schema)
      WHERE (t.table_name=ANY(param_tables) OR param_tables='{}')
        AND t.table_schema=ANY(param_schemas)
        AND t.table_type='BASE TABLE'
  AND EXISTS (SELECT 1 FROM information_schema.table_privileges p
    WHERE p.table_name=t.table_name
      AND p.table_schema=t.table_schema
      AND p.privilege_type='SELECT'
  )
  LOOP
    IF (progress in ('tables','all')) THEN
      raise info '%', format('Searching globally in table: %I.%I',
         schemaname, tablename);
    END IF;

    query := format('SELECT ctid FROM ONLY %I.%I AS t WHERE strpos(cast(t.* as text), %L) > 0',
      schemaname,
      tablename,
      search_term);
    FOR rowctid IN EXECUTE query
    LOOP
      FOR columnname IN
    SELECT column_name
    FROM information_schema.columns
    WHERE table_name=tablename
      AND table_schema=schemaname
      LOOP
  query := format('SELECT true FROM ONLY %I.%I WHERE cast(%I as text)=%L AND ctid=%L',
    schemaname, tablename, columnname, search_term, rowctid);
        EXECUTE query INTO hit;
  IF hit THEN
    IF (progress in ('hits', 'all')) THEN
      raise info '%', format('Found in %I.%I.%I at ctid %s',
       schemaname, tablename, columnname, rowctid);
    END IF;
    RETURN NEXT;
  END IF;
      END LOOP; -- for columnname
    END LOOP; -- for rowctid
  END LOOP; -- for table
END;
$$ language plpgsql;

```

- 사용 예제

```sql
select *
from global_search(
  search_term => 'int17894', -- 검색대상 단어
  param_schemas => '{rfph}' -- 검색
)

```

### global search 예제

- global search

```sql
select *
from global_search(
  search_term => '',
  param_schemas => '{rfph}'
  )
```
- global match

```sql
select *
from global_match(
  search_term => '%비넷%',
  comparator => 'texticlike',
  schemas => '{rfph}'
  )
```

### insert-into-select 예제

```sql
insert into t_kndb001_m01
(
  lgn_id 
  ,mbr_id 
  ,spclt_rlm_se_cd 
  ,rtfrm_scnrnk_item_nm
) 
select 
  lgn_id
  ,mbr_id 
  ,case 
      when rtfrm_rtrrl_se_cd='귀농'  and etc_spclt_rlm_nm in ('귀농닥터' , '귀농닥터-기존','교육강사','영농네비게이터') then 'A1'
      when rtfrm_rtrrl_se_cd='귀촌'  and etc_spclt_rlm_nm in ('귀농닥터','교육강사','귀농닥터-기존') then 'A2'
      when rtfrm_rtrrl_se_cd='자산관리사1기' then 'A3'
      when rtfrm_rtrrl_se_cd='자산관리사2기' then 'A3'
      when  rtfrm_rtrrl_se_cd ='귀농' and etc_spclt_rlm_nm in ('교육 수료생','우수사례자(지자체)','우수사례자(종합센터선정)','동네작가') then 'B1'
      when  rtfrm_rtrrl_se_cd ='귀촌' and etc_spclt_rlm_nm in ('교육 수료생','우수사례자(지자체)','우수사례자(종합센터선정)','동네작가') then 'B2'
      else null
    end as tmp_cd
  ,etc_spclt_rlm_nm 
from
tmp_edcb001_m01 
```

### update-from-select 예제

```sql
update t_kndb001_m01 t1
set spclt_rlm_se_cd = t2.tmp_cd
from (
  select 
      rtfrm_rtrrl_se_cd
    end as tmp_cd
  from
  tmp_edcb001_m01      
) as t2

```

### rollup 사용 총합 예제

```sql
select case 
    when grouping(spclt_rlm_se_cd) =1 then 'total' -- Null 로 나오지 않게끔 case when 걸기
    else spclt_rlm_se_cd 
    end spclt_rlm_se_cd 
    ,count(*) as cnt
from t_kndb001_m01 tkm 
group by rollup(spclt_rlm_se_cd) -- 집계함수 전체 row에 적용
order by cnt
```

### 특정 위치(위도, 경도)에서 반경 안에 드는 장소 SQL로 조회하기

해당 순으로 입력한 뒤, 계산을 하면 현재 위치에서 각각 원하는 장소가 얼마나 떨어져 있는지 계산이 된다.

앞에 6371은 지구의 반지름 값으로 기본적으로 들어가는 값이다.

거리는 km로 계산이 되기 때문에 만약 3km 근처에 있는 장소들만 표시해주고 싶다면 해당식의 값이 3보다 작은것들만 보여주면 된다. 


Example SQL

```sql
SELECT count(*)
FROM (
SELECT ( 6371 * acos( cos( radians( 37.4097995 ) ) * cos( radians( lat) ) * cos( radians( lot ) - radians(127.128697) ) + sin( radians(37.4097995) ) * sin( radians(lat) ) ) ) AS distance
FROM cf_location
) DATA
WHERE DATA.distance < 3
```

### 재귀쿼리 만들기
- https://mine-it-record.tistory.com/447

```sql
WITH RECURSIVE recursive_name [(column1, ...)] AS (
   -- initial query (처음 호출하는 쿼리)
   -- non-recursive query
   SELECT [(column1, ...)]
   UNION [ALL]
   -- recursive query (반복 쿼리)
   SELECT [(column1, ...)] FROM recursive_name [WHERE]
)
-- parent query
SELECT * FROM recursive_name
```

### 계층형 쿼리 만들기

http://happy1week.blogspot.com/2012/07/postgresql_19.html

### counter 만들기

- programmers 예제

### Exist 문 예제

```sql
INSERT INTO t_kndb001_m01 (mbr_id)
SELECT a.mbr_id
FROM T_CMNB002_M01 a
WHERE a.lgn_id IN (
  SELECT DISTINCT b.lgn_id
  FROM t_kndb001_m01 b
  WHERE length(b.lgn_id) > 2
)
AND NOT EXISTS (
  SELECT 1
  FROM t_kndb001_m01 c
  WHERE c.mbr_id = a.mbr_id
)
AND a.mbr_id <> ''
```

### A테이블에 있고 B에 없는 건 조회

```sql
SELECT A.column
FROM table1 A
LEFT OUTER JOIN table2 B
ON A.column=B.column
WHERE B.column IS NULL;
```

### left join 활용 중복제거

```sql
with cte as (
  select min(bbsctt_sn) id
  from t_wesc001_l01 twl 
  group by cntnts_sn, pst_ttl_nm , iem_cn1 
)
delete
from 
t_wesc001_l01 
where bbsctt_sn in (
    select bbsctt_sn
    from t_wesc001_l01 a
    left join cte c on a.bbsctt_sn=c.id
    where c.id  is null
  )
```

- 다른 예제

```sql
with cte as (
  select min(bbsctt_sn) id 
  from t_wesc001_l01 twl 
  where gnrlz_info_sbjt_clsf_cd ='C01'
  group by cntnts_sn, pst_ttl_nm, iem_cn1
)
delete 
from 
t_wesc001_l01 twl2 
where 1=1
and bbsctt_sn in (
  select bbsctt_sn 
  from t_wesc001_l01 a
  left join cte c on a.bbsctt_sn =c.id
  where 1=1 
  and c.id is null
  and a.gnrlz_info_sbjt_clsf_cd ='C01'
)
  
```



### 정규식 활용 html 파싱

```sql
update t_wesc001_l01 a
set iem_cn1 = t2.fin
from
(select t1.bbs_sn
         ,regexp_replace(regexp_replace(t1.test2,E'[\\n\\r]+','','g'),'&#9313;','','g') fin
  from 
  (
    SELECT  regexp_replace(bbsctt_html_cn, '<.*?>', '', 'g') AS text_column
           ,regexp_replace(split_part(bbsctt_html_cn,'사업내용',1), '<.*?>', '', 'g') test1
           ,regexp_replace(regexp_replace(split_part(bbsctt_html_cn,'사업내용',1), '<.*?>', '', 'g'),'&nbsp;|&middot;|-|목 적','','g') test2
           ,position('<p class="2"' in bbsctt_html_cn) pos
           ,bbs_sn
    from 
    t_wesc001_l01
    where cntnts_sn =201
  ) t1
) t2
where a.cntnts_sn = 201 
and a.bbs_sn = t2.bbs_sn
```

### split text into 2 parts

```sql

SELECT 
  substr('string_with_separator', 1, position('separator' in 'string_with_separator')-1) as first_part, 
  substr('string_with_separator', position('separator' in 'string_with_separator')+1) as second_part;
```

###


### 테이블 컬럼 코멘트 목록 조회


```sql

SELECT PS.RELNAME    AS TABLE_NAME
      ,PA.ATTNAME     AS COLUMN_NAME
      ,PD.DESCRIPTION AS COLUMN_COMMENT
  FROM PG_STAT_ALL_TABLES PS
      ,PG_DESCRIPTION     PD
      ,PG_ATTRIBUTE       PA
 WHERE PS.SCHEMANAME = (SELECT SCHEMANAME
                            FROM PG_STAT_USER_TABLES
                           WHERE RELNAME = [테이블명])
   AND PS.RELNAME  = [테이블명]
   AND PS.RELID   = PD.OBJOID
   AND PD.OBJSUBID <> 0
   AND PD.OBJOID    = PA.ATTRELID
   AND PD.OBJSUBID  = PA.ATTNUM
 ORDER BY PS.RELNAME, PD.OBJSUBID

```

### 테이블 정보 조회

```sql
SELECT datname FROM pg_database; -- 전체 데이터베이스 목록 조회
SELECT datname FROM pg_database WHERE datistemplate = false; -- 자신이 생성한 데이터베이스 목록만 조회
```

### 테이블 정보 조회2

```sql
SELECT datname FROM pg_database; -- 전체 데이터베이스 목록 조회
SELECT datname FROM pg_database WHERE datistemplate = false; -- 자신이 생성한 데이터베이스 목록만 조회
```

### 귀농인의 집 작업

```sql

select *
from tmp_t_lgoe002_l01

create table tmp_t_lgoe002_l01 (like "t_lgoe002_l01" including all);

drop table tmp_t_lgoe002_l01;

--insert into 복제_테이블 ( select * from "원본_테이블");


-- rfph.tmp_t_lgoe002_l01 definition

-- Drop table

-- DROP TABLE rfph.tmp_t_lgoe002_l01;


SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS

WHERE table_name = 'tmp_t_lgoe002_l01';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'tmp_t_lgoe002_l01';


select
    c.table_schema,
    c.table_name,
    c.column_name,
    pgd.description
from pg_catalog.pg_statio_all_tables as st
inner join pg_catalog.pg_description pgd on (
    pgd.objoid = st.relid
)
inner join information_schema.columns c on (
    pgd.objsubid   = c.ordinal_position and
    c.table_schema = st.schemaname and
    c.table_name   = st.relname
)
where c.table_name ='tmp_t_lgoe002_l01'
;



CREATE TABLE rfph.tmp_t_lgoe002_l01 (
    pstrrtn_hous_id varchar(20) NOT NULL, -- 귀농인 주택 아이디
    ctpv_cd varchar(10) NULL, -- 시도 코드
    sgg_cd varchar(10) NULL, -- 시군구 코드
    instt  varchar(30) NULL, -- 기관
    dpartm varchar(30) NULL, -- 부서
    manager varchar(10) NULL, -- 담당자
    daddr varchar(200) NULL, -- 상세주소
    gis_lat numeric(30, 20) NULL, --위도 
    gis_lot numeric(30, 20) NULL, --경도
    hous_pssn_wk_nm varchar(300) NULL, -- 주택소유주명
    rnt_price numeric(30) NULL,-- 임대료
    capacity varchar(30) NULL, -- 수용인원
    room_type varchar(20) NULL, -- 객실형태
    hous_sfc_cn varchar(200) NULL, -- 주택면적내용
    hous_rnt_cn varchar(1000) NULL,-- 주택임대내용
    hous_rnt_prd_cn varchar(1000) NULL,--주택임대기간 내용
    ctrt_bgng_ymd bpchar(8) NULL,
    ctrt_end_ymd bpchar(8) NULL,
    cntrct_period varchar(20) NULL, -- 계약기간
    rcrtm_crit varchar(100) NULL -- 모집기준 및 선정방법
    telno varchar(11) NULL, -- 전화번호
    telno2 varchar(12) NULL, -- 휴대전화번화
    ctpv_nm varchar(40) NULL, -- 시도명
    sgg_nm varchar(40) NULL, -- 시군구명
    hous_rmrk_cn varchar(1000) NULL, -- 비고
    fclty1 bpchar(1) null, -- 화장실
    fclty2  bpchar(1) null,-- 온수시설
    fclty3  bpchar(1) null,-- 샤워시설
    fclty4  bpchar(1) null,-- 욕조
    fclty5  bpchar(1) null,-- 세면대
    fclty6  bpchar(1) null,-- 싱크대
    fclty7  bpchar(1) null,-- 가스레인지
    fclty8  bpchar(1) null,-- 전자레인지
    fclty9  bpchar(1) null,-- 전기밥통
    fclty10 bpchar(1) null,-- 식탁
    fclty11 bpchar(1) null,-- 조리도구일체
    fclty12 bpchar(1) null,-- 식기류
    fclty13 bpchar(1) null,-- 주전자
    fclty14 bpchar(1) null,-- 옷장
    fclty15 bpchar(1) null,-- 옷걸이
    fclty16 bpchar(1) null,-- 침구류
    fclty17 bpchar(1) null,-- 청소도구
    fclty18 bpchar(1) null,-- 수건
    fclty19 bpchar(1) null,-- 세면도구
    fclty20 bpchar(1) null,-- 세탁기
    fclty21 bpchar(1) null,-- TV
    fclty22 bpchar(1) null,-- 컴퓨터
    fclty23 bpchar(1) null,-- 인터넷 
    fclty24 bpchar(1) null,-- 와이파이
    use_yn bpchar(1) NULL,
    atch_file_id varchar(50) NULL,
    del_yn bpchar(1) NULL,
    frst_reg_dt timestamp NOT NULL DEFAULT now(),
    frst_rgtr_id varchar(50) NOT NULL DEFAULT 'SYSTEM'::character varying,
    last_mdfcn_dt timestamp NOT NULL DEFAULT now(),
    last_mdfr_id varchar(50) NOT NULL DEFAULT 'SYSTEM'::character varying,
    zip bpchar(5) NULL, -- 우편번호
    resdnc_addr varchar(200) NULL, -- 거주지주소
    edu_rcpt_cd varchar(6) NULL, -- 교육접수코드
    aply_bgng_ymd bpchar(8) NULL,
    aply_end_ymd bpchar(8) NULL,
    CONSTRAINT tmp_t_lgoe002_l01_pkey PRIMARY KEY (pstrrtn_hous_id)
);

```

### UNEST


```sql
SELECT unnest(
  string_to_array('It''s an example sentence.', ' ')
) AS parts;
```

### 최근 3년치 데이터 추출

```sql
select count(*) --5772408
from mig.x_LNKA009_L01
where to_date(estate_ctrt_yr,'YYYY') >= date_trunc('year',current_date) - interval '3 year'; 
```

### type casting in postgres

```sql
-- Cast a string to an integer using the :: operator
SELECT '42'::integer;

-- Cast an integer to a string using the :: operator
SELECT 42::text;

-- Cast a string to a timestamp using the CAST() function
SELECT CAST('2022-01-01 12:00:00' AS timestamp);

-- Cast a float to a numeric using the CAST() function
SELECT CAST(3.14 AS numeric);
```


### create function regexp count

```sql
create or replace function regexp_count(text, text)
returns integer language sql as $$
    select count(m)::int
    from regexp_matches($1, $2, 'g') m
$$; 
```


SELECT regexp_replace(address, '\([^)]*\)', '') AS new_address
FROM mytable;



### dfdf

-- rfph.t_lgoe002_l01 definition

-- Drop table

-- DROP TABLE rfph.t_lgoe002_l01;

CREATE TABLE rfph.t_lgoe002_l01 (
  pstrrtn_hous_id varchar(20) NOT NULL,
  ctpv_cd varchar(10) NULL,
  sgg_cd varchar(10) NULL,
  daddr varchar(200) NULL,
  gis_lat numeric(30, 20) NULL,
  gis_lot numeric(30, 20) NULL,
  hous_pssn_wk_nm varchar(300) NULL,
  hous_sfc_cn varchar(200) NULL,
  hous_rnt_cn varchar(1000) NULL,
  hous_rnt_prd_cn varchar(1000) NULL,
  ctrt_bgng_ymd bpchar(8) NULL,
  ctrt_end_ymd bpchar(8) NULL,
  telno varchar(11) NULL,
  ctpv_nm varchar(40) NULL,
  sgg_nm varchar(40) NULL,
  hous_rmrk_cn varchar(1000) NULL,
  use_yn bpchar(1) NULL,
  atch_file_id varchar(50) NULL,
  del_yn bpchar(1) NULL,
  frst_reg_dt timestamp NOT NULL DEFAULT now(),
  frst_rgtr_id varchar(50) NOT NULL DEFAULT 'SYSTEM'::character varying,
  last_mdfcn_dt timestamp NOT NULL DEFAULT now(),
  last_mdfr_id varchar(50) NOT NULL DEFAULT 'SYSTEM'::character varying,
  zip bpchar(5) NULL,
  resdnc_addr varchar(200) NULL,
  edu_rcpt_cd varchar(6) NULL,
  aply_bgng_ymd bpchar(8) NULL,
  aply_end_ymd bpchar(8) NULL,
  CONSTRAINT t_lgoa002_l01_pk PRIMARY KEY (pstrrtn_hous_id)
);


### postgresql 관련 터미널 명령어


\l - Display database
\c - Connect to database
\d - List table
\dn - List schemas
\dt - List tables inside public schemas
\dt schema1.*  - List tables inside particular schemas. For eg: 'schema1'.


- dt 명령어에서 스키마 검색 범위 확장하기

```bash

SET search_path TO my_schema, public;
\d

```




```sql
CREATE TABLE scvdb.school_meal (
  atpt_ofcdc_sc_code varchar(30)
  ,atpt_ofcdc_sc_nm varchar(30)
  ,sd_schul_code varchar(20)
  ,schul_nm varchar(30)
  ,mmeal_sc_code varchar(30)
  ,mmeal_sc_nm varchar(30)
  ,mlsv_ymd varchar(30)
  ,mlsv_fgr varchar(30)
  ,ddish_nm varchar(300)
  ,orplc_info varchar(300)
  ,cal_info varchar(300)
  ,ntr_info varchar(300)
  ,mlsv_from_ymd varchar(30)
  ,mlsv_to_ymd varchar(30)
);
```


### 다중컬럼 중복제거(join 활용)



### 다중선택 기준 한건만 넣기 예제

```sql
insert into t_lgof005_m01
(vlg_mngno,rum_no,rum_nm,rum_sfc_cn,rum_aceptnc_nop_cn,rum_shap_nm,ptcptn_inte_id,thumb_file_id,rum_stts_cd,esntl_fclt_cd_nm,rum_esntl_fclt_cn,adit_fclt_cd_nm,rum_adit_fclt_cn,iem_rmrk,frst_reg_dt,frst_rgtr_id,last_mdfcn_dt,last_mdfr_id,use_yn)
select vlg_mngno,rum_no,rum_nm,rum_sfc_cn,rum_aceptnc_nop_cn,rum_shap_nm,ptcptn_inte_id,thumb_file_id,rum_stts_cd,esntl_fclt_cd_nm,rum_esntl_fclt_cn,adit_fclt_cd_nm,rum_adit_fclt_cn,iem_rmrk,frst_reg_dt,frst_rgtr_id,last_mdfcn_dt,last_mdfr_id,use_yn
from (
select row_number() over (partition by vlg_mngno,rum_no order by vlg_mngno) as row_num ,vlg_mngno,rum_no,rum_nm,rum_sfc_cn,rum_aceptnc_nop_cn,rum_shap_nm,ptcptn_inte_id,thumb_file_id,rum_stts_cd,esntl_fclt_cd_nm,rum_esntl_fclt_cn,adit_fclt_cd_nm,rum_adit_fclt_cn,iem_rmrk,frst_reg_dt,frst_rgtr_id,last_mdfcn_dt,last_mdfr_id,use_yn
from t_lgof005_l01 a
where a.vlg_mngno || '-' || a.rum_no not in (
select a.vlg_mngno || '-' || a.rum_no 
from t_lgof005_l01 a
join t_lgof005_m01 b 
on a.vlg_mngno || '-' || a.rum_no = b.vlg_mngno || '-' || b.rum_no)
  ) subq
where row_num =1
```




### FOR LOOP

DO $$
DECLARE
  table_name text;
BEGIN
  -- Iterate through the table names
  FOR i IN 1..43 LOOP
    table_name := 'lnka' || LPAD(i::TEXT, 3, '0');  -- Construct the table name
    
    BEGIN
      -- Truncate the destination table
      EXECUTE 'TRUNCATE TABLE mig.x_' || table_name || '_l01';
      
      -- Insert data from source table to destination table
      EXECUTE 'INSERT INTO mig.x_' || table_name || '_l01' || ' SELECT * FROM scv.t_' || table_name  || '_l01';
      
      -- Print the output from the destination table
      RAISE NOTICE 'Output from mig.x_%:', table_name;
      EXECUTE 'SELECT * FROM mig.x_' || table_name || '_l01';
      
    EXCEPTION
      WHEN OTHERS THEN
        -- Ignore the error and continue execution
        RAISE NOTICE 'Error occurred while processing table mig.x_%: %', table_name, SQLERRM;
    END;
  END LOOP;
END $$;


### 조회수 10회 이상 자동처리


```sql
--- 조회수 10회 이상 자동처리
update t_wesc001_l01
set inq_cnt = case when last_mdfcn_dt >= current_date - interval '6 months' then inq_cnt +  trunc(random() * (6) +17)
              else inq_cnt +  trunc(random() * (6) +10)
              end 
```


### 비율 데이터 계산하기

https://www.sisense.com/blog/calculating-proportional-values/


### 현재 폴더 내 특정 문자 포함 파일 찾기

```sql

grep -rnwi . -e 'word to find' | fzf


```


### Upsert 예제

```sql
INSERT INTO t_rgud001_m02  (
    pst_sn, bbs_id, pst_no, bbs_ttl_nm, bbs_intrcn_cn,
    inq_cnt, use_yn, rls_yn, frst_reg_dt, last_mdfcn_dt
)
SELECT
    atcl_id::int, 'BBSMSTR_000000000168', atcl_id::int, ttl_nm, atcl_cn,
    1, 'Y', 'Y', to_date(chg_ymd, 'YYYYMMDD'), to_date(chg_ymd, 'YYYYMMDD')
FROM mig.x_gisa043_l01
WHERE extract(year from to_date(chg_ymd, 'YYYYMMDD')) >= 2023
ON CONFLICT (pst_sn,bbs_id)
DO UPDATE SET
    bbs_ttl_nm = EXCLUDED.bbs_ttl_nm,
    bbs_intrcn_cn = EXCLUDED.bbs_intrcn_cn,
    last_mdfcn_dt = EXCLUDED.last_mdfcn_dt
where t_rgud001_m02.pst_sn = EXCLUDED.pst_sn
and t_rgud001_m02.bbs_id ='BBSMSTR_000000000168'
```


### table_count check

```sql

-- row count function 만들기


--SELECT table_name, rfph.count_rows('your_schema_name', table_name) AS row_count
--FROM information_schema.tables
--WHERE table_schema = 'your_schema_name';


CREATE OR REPLACE FUNCTION scv.count_rows(schema text, tablename text)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
declare 
	result integer;
	query varchar;
begin
	query := 'select count(*) from ' || schema || '.' || tablename;
	execute query into result;
	return result;
end;
$function$
;

CREATE OR REPLACE FUNCTION get_max_date(table_name text, column_name text)
RETURNS date AS
$$
DECLARE
    max_date date;
BEGIN
    EXECUTE format('SELECT MAX(%I) FROM %I', column_name, table_name) INTO max_date;
    RETURN max_date;
EXCEPTION
    WHEN undefined_column OR others THEN
        RETURN NULL;
END;
$$
LANGUAGE plpgsql;



SELECT table_name , scv.count_rows('scv',table_name), 
FROM information_schema.tables
WHERE table_schema = 'scv'
and table_name like '%l01%'
order by row_count


select 
	  table_schema
	  ,table_name 
	  ,count_rows(table_schema, table_name)
	  ,get_max_date(table_name,'last_mdfcn_dt') as last_mdfcn_dt
	  ,get_max_date(table_name,'updated_dt') as updated_dt
	  ,get_max_date(table_name,'created_dt') as created_dt
	 , current_date - get_max_date(table_name,'last_mdfcn_dt')
	 ,case 
		  when get_max_date(table_name,'last_mdfcn_dt') >= (current_date - interval '6 months') then 'Y' 
	  	else 'N' end as res 
from information_schema.tables
where 
1=1
and table_schema ='rfph'
and table_type='BASE TABLE'

```


### 권한 확인

```sql

select * from information_schema.role_table_grants
where table_schema = 'rfph'


```


### 권한 부여
```sql
GRANT USAGE ON SCHEMA pilot TO jinheonyoon;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pilot TO jinheonyoon;



--ACCESS DB
REVOKE CONNECT ON DATABASE nova FROM PUBLIC;
GRANT  CONNECT ON DATABASE nova  TO user;

--ACCESS SCHEMA
REVOKE ALL     ON SCHEMA public FROM PUBLIC;
GRANT  USAGE   ON SCHEMA public  TO user;

--ACCESS TABLES
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC ;
GRANT SELECT                         ON ALL TABLES IN SCHEMA public TO read_only ;
GRANT ALL                            ON ALL TABLES IN SCHEMA public TO admin ;

```

### 특정 스키마에 테이블이 존재하는 지 확인

```sql

SELECT 
    table_name,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM information_schema.tables
            WHERE table_schema = 'your_schema_name'
            AND table_name IN ('table1', 'table2', 'table3', ... ) -- Add more tables as needed
        ) THEN 'Yes'
        ELSE 'No'
    END AS yn
FROM information_schema.tables
WHERE table_schema = 'your_schema_name' AND table_name IN ('table1', 'table2', 'table3', ... ); -- Add more tables as needed

```

### 운영: 배치실행확인


```sql

select *
from rfgis.t_gisa099_l01 tgl 
where dta_crtr_ymd ='20230918'
and batch_job_tbl_nm like '%T_GISA001%'
order by frst_reg_dt desc;


```

### 프로시저 배치 수정

#### 개발

- rfgis 변경


#### 운영

- 개발 스크립트 복제
- dblink 변경
- 필요할 경우 추가 수정

- T_GISA003_L01
- T_GISA004_L01
- T_GISA006_L01
- T_GISA008_L01


### 해당 db 스키마 정보

```sql
select table_catalog,table_schema  from INFORMATION_SCHEMA.tables where table_type = 'BASE TABLE'
and table_schema not in ('information_schema','pg_catalog')
group by table_catalog,table_schema;
```

### 테이블 속성 조회

```sql
select n.nspname 
     , c.relname 
     , obj_description(c.oid) 
  from pg_catalog.pg_class c  
 inner join pg_catalog.pg_namespace n on c.relnamespace = n.oid
where c.relkind = 'r'
 and n.nspname = 'rfgis'
 and c.relname not like '%_bak'
order by 2;
```

### 컬럼 조회

```sql
select c.relname
     , a.attrelid 
     , a.attname 
     , a.attnum 
     , (select col_description(a.attrelid,a.attnum )) as tanle_name
  from pg_catalog.pg_class c
inner join pg_catalog.pg_attribute a on a.attrelid = c.oid
inner join INFORMATION_SCHEMA.tables b on  table_schema in ('gdip2_ocs')
                                                     and b.table_name = 't_cmnb002_m01'
and c.relname = b.table_name
and a.attnum > 0;
```


### 컬럼 한글명 등록

```sql
select 'comment on column gdip2_dm.'||c.relname||'.'||a.attname|| ' is '||''''||(select col_description(a.attrelid,a.attnum ))||''''||';' as comments
  from pg_catalog.pg_class c
inner join pg_catalog.pg_attribute a on a.attrelid = c.oid
inner join INFORMATION_SCHEMA.tables b on  table_schema in ('rfph')
and c.relname = b.table_name
and b.table_name = 't_cmnb002_m01'
and a.attnum > 0;
```


### 컬럼 속성 조회

```sql
select a.attnum 
     , a.attname
     , (select col_description(a.attrelid,a.attnum )) as tanle_name
     , d.data_type
     , d.character_maximum_length
     , d.is_nullable 
  from pg_catalog.pg_class c
inner join pg_catalog.pg_attribute a on a.attrelid = c.oid
inner join INFORMATION_SCHEMA.tables b on  b.table_schema in ('gdip2_ods')
                                       and b.table_name = 't_cmnb002_m01'
inner join INFORMATION_SCHEMA.columns d on d.table_name = b.table_name                            
and c.relname = b.table_name
and d.column_name = a.attname      
and a.attnum > 0;
```


### UPSERT 로직

#### diff 지원할 경우(차집합)

- 타겟 db에 임시 테이블 생성
- diff 로 차이 산출 

#### 차집합 지원하지 않을 경우

- 전일 대비 변동분 찾을 경우 프라이머리 키 기준으로 일치하는값을 찾아 삭제
- 일치하지 않는값을 append하는방식



### UNLOAD, LOAD를 위한 Type Casting

- FFD 기준 컬럼 Length가 300 이상일 경우 cast를 통해 타입 명시
- Line Feed나 Carriage Return 의 경우 replace 사용

CAST(REPLACE(REPLACE(rtfrm_frsrnk_item_nm1,CHR(10),CHR(6)),CHR(13),CHR(7)) AS VARCHAR)

#### 컬럼 Length 문제로 인해

- invalid string byte 문제
- 데이터가 UTF8로 인식되지 않는다.

#### 업데이트 예제


```sql

UPDATE gdip2_ods.t_cmnb002_p01 SET 
       rtfrm_frsrnk_item_nm1 = REPLACE(REPLACE(rtfrm_frsrnk_item_nm1,CHR(6),CHR(10)),CHR(7),CHR(13)),
       rtfrm_scnrnk_item_nm2 = REPLACE(REPLACE(rtfrm_scnrnk_item_nm2,CHR(6),CHR(10)),CHR(7),CHR(13)),
       rtfrm_rtrrl_etc_cn = REPLACE(REPLACE(rtfrm_rtrrl_etc_cn,CHR(6),CHR(10)),CHR(7),CHR(13)),
       hld_ctfct_cd_list_nm = REPLACE(REPLACE(hld_ctfct_cd_list_nm,CHR(6),CHR(10)),CHR(7),CHR(13)),
       hld_ctfct_list_nm = REPLACE(REPLACE(hld_ctfct_list_nm,CHR(6),CHR(10)),CHR(7),CHR(13)),
       etc_spclt_tchnlg_list_nm = REPLACE(REPLACE(etc_spclt_tchnlg_list_nm,CHR(6),CHR(10)),CHR(7),CHR(13)),
       etc_inf_path_cn = REPLACE(REPLACE(etc_inf_path_cn,CHR(6),CHR(10)),CHR(7),CHR(13)),
       itrst_path_list_nm = REPLACE(REPLACE(itrst_path_list_nm,CHR(6),CHR(10)),CHR(7),CHR(13))
WHERE 1 = 1


```

### 트러블 슈팅 1

[DBAPI-E1101] PostgreSQL Error
ERROR:  missing data for column  cchng_expsr_yn 

[DBAPI-E1101] PostgreSQL Error
ERROR:  missing data for column  hous_rnt_prd_cn 
CONTEXT:  COPY x_gisa053_l01, line 65:  RFHOUSE_2464200004250000남면 시동로 217-437.6053900000127.7855590000복선영44.824월... 


라인피드, 캐리지 리턴 이슈




### 트러블 슈팅 2


Project : X_GISA042_L01
Block : LD_01
[DBAPI-E1101] PostgreSQL Error
ERROR:  value too long for type character varying(40)
CONTEXT:  COPY x_gisa042_l01, line 698, column now_prps_nm:  2차선에 접한 토지 시 도유지 140여평 접. 고모저수지 인근. 저렴한 상가터 

데이터 깨진거 



### UPSERT 로직

- 변경분 체크
- 변경분 Insert

```sql
INSERT INTO mig.x_gisa015_l01
SELECT * FROM mig.x_gisa015_l01_mgr
WHERE 1=1
```


### 테이블스페이스 생성

- 테이블 스페이스 디렉토리 생성 및 권한 부여

```sql
create tablespace [tbl_space] owner postgres location '/postgres_db'
```

### 현재 테이블 스페이스 조회

```sql
select * , pg_tablespace_location(oid)
from pg_catalog.pg_tablespace 
```

### 테이블 스페이스 삭제



```bash


```


### 시퀀스 업데이트

max+1

```sql
select setval('rfgis.sq_batch_log_sn',69928,true); 
```

### POSITION 함수

특정 문자열 위치 찾을 때 position 함수 활용

```sql
substr(column_name,position('find_name' in column_name))
```


### 연령대



```sql
select *
from 
  extract(year from age(current_date,birth_date)) as age
  ,floor(extract(year from age(current_date,birth_date))/10) as age_group
T

```


### 특정 컬럼 row기준 5개 컬럼으로 나누기

```sql
with test as (
	SELECT
	   (CASE WHEN row_number % 5 = 1 THEN pnu_code END) AS column1,
	    (CASE WHEN row_number % 5 = 2 THEN pnu_code END) AS column2,
	    (CASE WHEN row_number % 5 = 3 THEN pnu_code END) AS column3,
	    (CASE WHEN row_number % 5 = 4 THEN pnu_code END) AS column4,
	    (CASE WHEN row_number % 5 = 0 THEN pnu_code END) AS column5
	from (
	select  pnu_code
			,row_number() over(order by pnu_code) as row_number
	from com_pnu_code cpc 
	) foo
) , a as (
	select row_number() over(order by column1) as key_rownum
		 ,column1
  from test 
  where column1 is not null
) , b as (
	select row_number() over(order by column2) as key_rownum
		 ,column2
  from test 
  where column2 is not null
) , c as (
	select row_number() over(order by column3) as key_rownum
		 ,column3
  from test 
  where column3 is not null
) , d as (
	select row_number() over(order by column5) as key_rownum
		 ,column4
  from test 
  where column4 is not null
) , e as (
	select row_number() over(order by column5) as key_rownum
		 ,column5
  from test 
  where column5 is not null
) insert into com_pnu_code_split
  (rank, pnu_code1,pnu_code2,pnu_code3,pnu_code4,pnu_code5) 
  select a.key_rownum , column1, column2 , column3 ,column4 , column5
  from a,b,c,d,e
  where 1=1
  and a.key_rownum = b.key_rownum
  and b.key_rownum = c.key_rownum
  and c.key_rownum = d.key_rownum
  and d.key_rownum = e.key_rownum
```


### 테이블 건수 조회


```sql
      table_schema
      ,table_name 
      ,count_rows(table_schema, table_name)
      ,get_max_date(table_name,'last_mdfcn_dt') as last_mdfcn_dt
--      ,get_max_date(table_name,'updated_dt') as updated_dt
--      ,get_max_date(table_name,'created_dt') as created_dt
     , current_date - get_max_date(table_name,'last_mdfcn_dt') as 최종수정수정후일자
     ,case 
          when get_max_date(table_name,'last_mdfcn_dt') >= (current_date - interval '6 months') then 'Y' 
          else 'N' end as res 
from information_schema.tables
where 
1=1
and table_schema ='scv'
and table_type='BASE TABLE'
and table_name like '%l01'
and replace(replace(table_name,'t_lnka',''),'_l01','')::numeric between 100 and 130
order by table_name;
```
