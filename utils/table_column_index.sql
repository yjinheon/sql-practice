SELECT
      tbl.schemaname     스키마명
,      tbl.relname           테이블id
,      tbl_dec.description 테이블명
,      col.attname           컬럼명
,      col.attnum            컬럼순서
,      col_dec.description 컬럼설명
,      col_att.data_type     data_type
,      col_att.character_maximum_length max_len
,      col_att.is_nullable          null여부
,      col_att.column_default    default값
,      col_att.numeric_precision num_len
,      col_att.datetime_precision data_time
,      t_index.constraint_name   key_명
,      t_index.constraint_type     key_타입
FROM
      (
      SELECT
            *
      FROM
            PG_STAT_USER_TABLES            ---  사용자 테이블
      WHERE
            1 = 1
            AND relname = '테이블id'
            AND schemaname = '스키마이름') tbl

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
          ,
            INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE t_colu
      WHERE
            AND t_con.table_catalog    = t_colu.table_catalog
            AND t_con.table_schema    = t_colu.table_schema
            AND t_con.table_name       = t_colu.table_name
            AND t_con.constraint_name = t_colu.constraint_name) t_index     --- index 정보
ON
        t_index.table_schema        = tbl.schemaname
        AND t_index.table_name    = tbl.relname
        AND t_index.column_name = col.attname
WHERE
      1 = 1
      AND col.attstattarget = '-1'
ORDER BY
      tbl.relname,
      col.attnum;
