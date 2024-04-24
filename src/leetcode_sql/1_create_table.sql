
-- https://futurists.tistory.com/12?category=587334 # 참고할 것


/*

*/

use leetcode_sql;

create TABLE employee (
    id int NOT NULL ,
    Name varchar(255) NOT NULL,
    department CHAR(255) NOT NULL,
    ManagerID int,
)

insert into employee values (101,'John','A',NULL);
insert into employee values (102,'Peter','A',101)
insert into employee values (103,'Amy','A',101)
insert into employee values (104,'Hannah','A',101)
insert into employee values (105,'Michael','B',101)
insert into employee values (106,'Sandy','B',101)


select * from employee;