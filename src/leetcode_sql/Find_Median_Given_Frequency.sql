-- Question 107
-- The Numbers table keeps the value of number and its frequency.

-- +----------+-------------+
-- |  Number  |  Frequency  |
-- +----------+-------------|
-- |  0       |  7          |
-- |  1       |  1          |
-- |  2       |  3          |
-- |  3       |  1          |
-- +----------+-------------+
-- In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.

-- +--------+
-- | median |
-- +--------|
-- | 0.0000 |
-- +--------+
-- Write a query to find the median of all numbers and name the result as median.

-- 중앙값 : 
-- 어떤 주어진 값들을 크기의 순서대로 정렬했을 때 가장 중앙에 위치하는 값

/*
select
    avg(number) median
from
    numbers n 
where 
    n.frequency >= abs(
                        (select sum(Frequency) from Numbers where Number<=n.number)
                        -
                        (select sum(Frequency) from Numbers where Number>=n.number));
*/


-- cumulative frequency

SELECT AVG(Number) AS median FROM (
  SELECT Number, Frequency, AccFreq, SumFreq FROM
  (SELECT    Number,
             Frequency, @curFreq := @curFreq + Frequency AS AccFreq
   FROM      Numbers n, (SELECT @curFreq := 0) r
   ORDER BY  Number) t1,
  (SELECT SUM(Frequency) SumFreq FROM Numbers) t2
) t
WHERE AccFreq BETWEEN SumFreq / 2 AND SumFreq / 2 + Frequency