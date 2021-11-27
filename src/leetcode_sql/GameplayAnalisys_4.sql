-- Question 91
-- Table: Activity

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | player_id    | int     |
-- | device_id    | int     |
-- | event_date   | date    |
-- | games_played | int     |
-- +--------------+---------+
-- (player_id, event_date) is the primary key of this table.
-- This table shows the activity of players of some game.
-- Each row is a record of a player who logged in and played a number of games (possibly 0) 
-- before logging out on some day using some device.
 

-- Write an SQL query that reports the fraction of players that logged in again 
-- on the day after the day they first logged in, rounded to 2 decimal places. 
-- In other words, you need to count the number of players that logged in for at least two consecutive 
-- days starting from their first login date, then divide that number by the total number of players.

-- The query result format is in the following example:

-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-03-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+

-- Result table:
-- +-----------+
-- | fraction  |
-- +-----------+
-- | 0.33      |
-- +-----------+
-- Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

-- Solution

use leetcode_sql;

-- select * from game_activity;
-- use left join

/*
select count(distinct self.player_id)/count(distinct min_table.player_id) as fraction from
(select player_id,min(event_date) as first_login_date 
from game_activity
group by player_id) as min_table left join game_activity as self
on min_table.player_id = self.player_id and datediff(self.event_date,min_table.first_login_date) = 1;)))
*/


-- WSL 에서 안돌아가는건 테이블 타입캐스팅 문제인듯

select *  from
(select player_id, min(event_date) as event_date
from game_activity
group by player_id) as a left join game_activity as b
on a.player_id = b.player_id and datediff(a.event_date,b.event_date) = 1;)
