# DEFAULT값을 지정할 경우 else 구분 사용
# 코드를 레이블로 매핑하는 쿼리

SELECT
    user_id,
    case 
        WHEN register_device = 1 THEN 'desktop'
        WHEN register_device = 2 THEN 'smartphone'
        WHEN register_device = 3 THEN 'application'
    end as device_name
from mst_users;
        