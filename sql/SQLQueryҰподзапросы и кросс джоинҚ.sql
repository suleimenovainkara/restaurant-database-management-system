--Getting information about customers who have made online orders
select *
from customers
where customer_id in (select customer_id from online_orders);

--Getting a list of employees who have accepted orders from a certain customer:
select distinct s.staff_id, s.first_name, s.last_name
from staff s
join orders o on s.staff_id = o.staff_id
where o.customer_id = (select customer_id from customers where last_name = 'Smith');

--Getting all possible combinations of dishes and drinks:
select d.dish_name, dr.drink_name
from dish d
cross join drink dr;

--Getting all possible combinations of employees and tables:
select s.first_name, t.tables_id
from staff s
cross join tables t;

--find the customer_id whose average check is larger than the average check of most
select customer_id, avg(bill) as avg_bill
from orders
group by customer_id
having avg(bill) > (select avg(bill) from orders);

--find the customer_id whose invoice amount is greater than the maximum invoice
select customer_id, sum(bill) AS total_bill
from orders
group by customer_id
having sum(bill) > (select max(bill) from orders);

--find all the information about the customers who booked the table and who left their rooms
select *
from customers
where customer_id in (select customer_id from booked_table)
    and phone is not null;