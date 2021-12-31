/*
- 별거 아니지만 돌아가는 코드를 만드는데 하루종일 걸림

Ref:
- https://cirius.tistory.com/1475
- https://www.sqlite.org/lang_createtable.html
- https://ohgyun.com/777
*/

use instacart;

CREATE TABLE aisle(
    aisle_id int PRIMARY KEY,
    aisle VARCHAR(255)  
) default charset utf8 COMMENT '';

CREATE TABLE department(
    department_id SERIAL PRIMARY KEY,
    department VARCHAR(255)  
) default charset utf8 COMMENT '';


use instacart;

create TABLE orders (
    order_id bigint PRIMARY KEY,
    user_id int,
    eval_set VARCHAR(255),
    order_number int,
    order_dow int,
    order_hour_of_day int,
    days_since_prior_order int
)


use instacart;
create table orders_products_prior (
    order_id bigint,
    product_id bigint,
    add_to_cart_order int,
    reordered int
    )

use instacart;
create table products (
    product_id bigint PRIMARY KEY,
    product_name VARCHAR(255),
    aisle_id int,
    department_id int
)

-- rename table
use instacart;

--alter table order_products_prior rename to orders_products_prior;


use instacart;

load data local infile 'C:\\Project\\Python_Project\\python-scripts\\web_base\\departments.csv'
    into table orders
    fields terminated by ','
    lines terminated by '\n'
    ignore 1 rows;


use instacart;

load data local infile 'C:\\Project\\Python_Project\\python-scripts\\web_base\\aisle.csv'
    into table orders
    fields terminated by ','
    lines terminated by '\n'
    ignore 1 rows;


use instacart;
load data local infile 'C:\\Project\\Python_Project\\python-scripts\\web_base\\orders.csv'
    into table orders
    fields terminated by ','
    lines terminated by '\n'
    ignore 1 rows;
    


use instacart;


load data local infile 'C:\\Project\\Python_Project\\python-scripts\\web_base\\order_products_prior.csv'
    into table orders_products_prior
    fields terminated by ','
    lines terminated by '\n'
    ignore 1 rows;
    


use instacart;
load data local infile 'C:\\Project\\Python_Project\\python-scripts\\web_base\\products.csv'
    into table products
    fields terminated by ','
    lines terminated by '\n'
    ignore 1 rows;


use instacart;
select count(*) from instacart.orders_products_prior;