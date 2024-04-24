DROP TABLE IF EXISTS action_counts_with_date;
CREATE TABLE action_counts_with_date(
    dt      varchar(255)
  , user_id varchar(255)
  , product varchar(255)
  , v_count integer
  , p_count integer
);

INSERT INTO action_counts_with_date
VALUES
    ('2016-10-03', 'U001', 'D001',  1, 0)
  , ('2016-11-03', 'U001', 'D001',  1, 1)
  , ('2016-10-03', 'U001', 'D002', 16, 0)
  , ('2016-10-03', 'U001', 'D003', 14, 0)
  , ('2016-10-03', 'U001', 'D004', 15, 0)
  , ('2016-10-03', 'U001', 'D005', 19, 0)
  , ('2016-10-25', 'U001', 'D005',  1, 0)
  , ('2016-11-03', 'U001', 'D005',  1, 0)
  , ('2016-11-05', 'U001', 'D005',  0, 1)
  , ('2016-10-03', 'U002', 'D001', 10, 0)
  , ('2016-11-30', 'U002', 'D001',  0, 1)
  , ('2016-11-20', 'U002', 'D003', 28, 0)
  , ('2016-11-20', 'U002', 'D005', 28, 0)
  , ('2016-11-30', 'U002', 'D005',  0, 1)
  , ('2016-11-01', 'U003', 'D001', 49, 0)
  , ('2016-11-01', 'U003', 'D004', 29, 0)
  , ('2016-11-03', 'U003', 'D004',  0, 1)
  , ('2016-11-01', 'U003', 'D005', 24, 0)
  , ('2016-12-01', 'U003', 'D005',  0, 1)
;
