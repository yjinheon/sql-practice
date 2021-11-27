-- Question 75
-- The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

-- +------+----------+-----------+----------+
-- |Id    |Name 	  |Department |ManagerId |
-- +------+----------+-----------+----------+
-- |101   |John 	  |A 	      |null      |
-- |102   |Dan 	  |A 	      |101       |
-- |103   |James 	  |A 	      |101       |
-- |104   |Amy 	  |A 	      |101       |
-- |105   |Anne 	  |A 	      |101       |
-- |106   |Ron 	  |B 	      |101       |
-- +------+----------+-----------+----------+
-- Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table, your SQL query should return:

-- +-------+
-- | Name  |
-- +-------+
-- | John  |
-- +-------+
-- Note:
-- No one would report to himself.

-- Solution
use leetcode_sql;

select Name
from employee
where ManagerId in (
    select id
    from employee
    where ManagerId is not null
    group by ManagerId
    having count(id) >= 5
);


/*
## Soluttion with subquery
select Name
from Employee
where id in
   (select ManagerId
    from Employee
    group by ManagerId
    having count(1) >= 5)

## Solution with inner join
##    select Employee.Name
##    from (select ManagerId
##        from Employee
##        group by ManagerId
##        having count(1) >= 5) as t
##        inner join
##        Employee
##    on t.ManagerId = Employee.Id

*/