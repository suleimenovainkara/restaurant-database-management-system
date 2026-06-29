use restaurant
--думаю к айди можно добавить identity, так же стоит подумать куда добавить check
/*так же подумать об ссылочном ключе*/
create table customers
(customer_id int not null primary key,
first_name nvarchar(20) not null,
last_name nvarchar(20) not null,
phone int,
book_date date,
visit_day date,
last_visit_date date default null)


create table [tables]
(tables_id int not null primary key,
number_of_seats int)

create table booked_table
(book_id int not null primary key,
tables_id int references [tables](tables_id), --ссылочный ключ,
customer_id int not null references customers(customer_id), --ссылочный ключ,
)

/*create table menu --а может сделать меню как storage procedure, а создать отдельно таблицы с едой и напитками
(dish nvarchar(20) not null,
drink nvarchar(20) not null,
dish_categories nvarchar(20) not null,
drink_category nvarchar(20) not null)
*/
create table dish
(dish_id int not null primary key,
dish_name nvarchar(20) not null,
dish_categories nvarchar(20) not null,
price int,
ingredients varchar(500))

create table drink 
(drink_id int not null primary key,
drink_name nvarchar(20) not null,
drink_category nvarchar(20) not null,
price int
)

create table drink_dish
(drink_id int references drink(drink_id),
dish_id int references dish(dish_id))

create table staff
(staff_id int not null primary key,
first_name nvarchar(50) not null,
last_name nvarchar(50) not null,
job_title nvarchar(20) not null,
salary int not null,
phone bigint not null,
hire_date date
)

create table payment_methods 
(payment_id int not null primary key,
method_name varchar(50) not null)

create table orders
(order_id int not null primary key, 
customer_id int references customers(customer_id), --ссылочный ключ
staff_id int references staff(staff_id), --ссылочный ключ
drink_id int references drink(drink_id), --ссылочный ключ
dish_id int references drink(drink_id), --ссылочный ключ
bill int, 
payment_id int references payment_methods(payment_id))

create table online_orders (
online_order_id int not null primary key, 
customer_id int references customers(customer_id),
o_date date,
drink_id int references drink(drink_id),
dish_id int references dish(dish_id),
bill int,
payment_id int references payment_methods(payment_id)
)
--можно сделать хранимую процедуру, с помощью которой можно посмотреть какие заказы делают каждый день 
--так же думаю стоит обратить внимание на онлайн покупки, вдруг кто-то онлайн что-то заказывать будет.
--надо не хабыть еще таблицы сделать, а после показать как я их нормализую
--так же можно сделать отдельно вьюшку или хранимую процедуру в которой будут хранится данные только об официантах, поваре или 