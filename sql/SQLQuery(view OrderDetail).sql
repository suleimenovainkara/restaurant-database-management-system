--представление, которое объединяет информацию о заказах из таблиц orders и online_orders
--и которое дают все информацию о заказах
create view OrderDetails as
select 
    o.order_id,
    c.first_name + ' ' + c.last_name as customer_name,
    s.first_name + ' ' + s.last_name as staff_name,
    o.bill,
    p.method_name as payment_method,
    case 
        when o.drink_id is not null then 'Drink: ' + d.drink_name
        when o.dish_id is not null then 'Dish: ' + di.dish_name
    end as item_name,
    case
        when o.drink_id is not null then d.price
        when o.dish_id IS NOT NULL then di.price
    end as item_price,
    case 
        when o.drink_id is not null then 'Drink'
        when o.dish_id is not null then 'Dish'
    end as item_type
from 
    orders o
left join
    customers c on o.customer_id = c.customer_id
left join 
    staff s on o.staff_id = s.staff_id
left join
    payment_methods p on o.payment_id = p.payment_id
left join
    drink d on o.drink_id = d.drink_id
left join
    dish di ON o.dish_id = di.dish_id

union all

select
    oo.online_order_id,
    c.first_name + ' ' + c.last_name as customer_name,
    null as staff_name,
    oo.bill,
    p.method_name as payment_method,
    case
        when oo.drink_id is not null then 'Drink: ' + d.drink_name
        when oo.dish_id is not null then 'Dish: ' + di.dish_name
    end as item_name,
    case
        when oo.drink_id is not null then d.price
        WHEN oo.dish_id is not null then di.price
    end as item_price,
    case 
        when oo.drink_id is not null then 'Drink'
        when oo.dish_id is not null then 'Dish'
    end as item_type
from
    online_orders oo
left join 
    customers c ON oo.customer_id = c.customer_id
left join
    payment_methods p ON oo.payment_id = p.payment_id
left join
    drink d ON oo.drink_id = d.drink_id
left join
    dish di ON oo.dish_id = di.dish_id;