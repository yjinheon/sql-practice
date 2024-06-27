with T as (
select indexname as idx_nm ,  schemaname ,tablespace
from pg_catalog.pg_indexes 
where 1=1
and schemaname ='gdip2_ods_tmp2'
--and indexname not in (
--select indexname 
--from pg_catalog.pg_indexes 
--where 1=1
--and "tablespace" <> 'rfph_data_00'
--)
) select 'alter index ' || schemaname || '."' || idx_nm || '" ' || 'set tablespace' || ' ' || 'gdip2_idx;' 
  from T
  
