--триггера для таблицы orders, 
--который будет обновлять общую сумму заказа после каждого обновления 
create trigger trg_update_order_total
on orders
after insert, update
as
begin
    update orders
    set bill = (select sum(d.price + dr.price) from inserted i
                join dish d on i.dish_id = d.dish_id
                join drink dr on i.drink_id = dr.drink_id)
    where order_id in (select order_id from inserted)
end;