SELECT
      tbl.schemaname     AS table_schema
,     tbl.relname       AS table_name
,     tbl_dec.description AS table_desc
,     rfph.count_rows(tbl.schemaname, tbl.relname)
,     rfph.get_max_date(tbl.relname,'last_mdfcn_dt') as last_mdfcn_dt
,     tbl.relname       AS table_id
FROM
      (
      SELECT
            *
      FROM
            PG_STAT_USER_TABLES            ---  사용자 테이블
      WHERE
            1 = 1
            AND schemaname = 'rfph'
            ) tbl
LEFT JOIN PG_DESCRIPTION tbl_dec      --- 테이블 정보
ON tbl_dec.objsubid = 0
   AND tbl.relid = tbl_dec.objoid
WHERE 1=1