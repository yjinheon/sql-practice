with tbl as (
            SELECT
            *
            FROM
            PG_STAT_USER_TABLES            ---  사용자 테이블
        WHERE
            1 = 1
            --AND relname = 't_edcc001_d04'
            AND schemaname = 'gdip2_dm'
) 
--coalesce(col_att.numeric_precision,col_att.numeric_precision_radix)
select 
        'gdip2' as DB명
,
      tbl.schemaname     스키마명
,      tbl.relname           테이블id
,      coalesce(tbl_dec.description,tbl.relname) 테이블설명
,      col.attname           컬럼명
,      col.attnum            컬럼순서
--,      col_dec.description 컬럼설명
,      coalesce(col_dec.description,col.attname) 컬럼설명
--,      col_att.numeric_scale
--,      col_att.numeric_precision
--,      col_att.numeric_precision_radix
,      col_att.data_type     data_type
,      case 
                  when col_att.data_type like '%character%' then 'varchar' || '(' || col_att.character_maximum_length || ')'
                  --when col_att.data_type ='numeric' then col_att.data_type || '(' ||  coalesce(col_att.numeric_precision,col_att.numeric_precision_radix) || ',' ||  col_att.numeric_scale  || ')'
                  when col_att.data_type like '%timestamp%' then 'timestamp'
                  when (col_att.numeric_precision is not null or  col_att.numeric_scale is not null) then 'numeric' || '(' ||  coalesce(col_att.numeric_precision,col_att.numeric_precision_radix) || ',' ||  col_att.numeric_scale  || ')'
                  --when col_att.data_type is null and  (col_att.numeric_precision is not null or  col_att.numeric_scale is not null) then 'numeric' || '(' ||  coalesce(col_att.numeric_precision,col_att.numeric_precision_radix) || ',' ||  col_att.numeric_scale  || ')'
                  --when col_att.data_type ='numeric' and col_att.data_type is null and (coalesce(col_att.numeric_precision,col_att.numeric_precision_radix) is null or col_att.numeric_scale is null ) then 'numeric'
                  --when col_att.character_maximum_length is not null then col_att.data_type || '(' || col_att.character_maximum_length || ')' 
       else col_att.data_type  end as data_type
,      col_att.character_maximum_length max_len
,case when 
      col_att.is_nullable = 'NO' then 'N' 
      else 
      null 
    end as null여부
,      col_att.column_default    default값
,      t_index.constraint_name   key_명
,      t_index.constraint_type     key_타입
,      case when trim(t_index.constraint_type) ='PRIMARY KEY' then 'Y' else null end as pk여부
from tbl 
LEFT JOIN PG_DESCRIPTION tbl_dec      --- 테이블 정보
ON
      tbl_dec.objsubid = 0
      AND tbl.relid = tbl_dec.objoid
LEFT JOIN PG_ATTRIBUTE col               --- 컬럼 
ON
      tbl.relid = col.ATTRELID
LEFT JOIN PG_DESCRIPTION col_dec      --- 컬럼 정보
ON
      col_dec.objsubid <> 0
      AND col_dec.objoid  = tbl.relid
      AND col_dec.objoid = col.attrelid
      AND col_dec.objsubid = col.attnum
LEFT JOIN INFORMATION_SCHEMA.COLUMNS col_att      --- data_type 정보
ON
      col_att.table_schema = tbl.schemaname
      AND col_att.table_name = tbl.relname
      AND col_att.column_name = col.attname
      AND col_att.ordinal_position = col.attnum
LEFT JOIN 
(
      SELECT
            t_con.table_schema    table_schema
,            t_con.table_name      table_name
,            t_colu.column_name   column_name
,            t_con.constraint_name constraint_name
,            t_con.constraint_type   constraint_type
      FROM
            INFORMATION_SCHEMA.TABLE_CONSTRAINTS t_con
          , INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE t_colu
      where 1=1
            AND t_con.table_catalog    = t_colu.table_catalog
            AND t_con.table_schema    = t_colu.table_schema
            AND t_con.table_name       = t_colu.table_name
            AND t_con.constraint_name = t_colu.constraint_name
            ) t_index     --- index 정보
ON
        t_index.table_schema        = tbl.schemaname
        AND t_index.table_name    = tbl.relname
        AND t_index.column_name = col.attname
WHERE
      1 = 1
      AND col.attstattarget = '-1'