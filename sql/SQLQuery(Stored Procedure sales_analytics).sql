-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Suleimenova Inkara
-- Create date: 22/04/2024
-- Description:	Sales Analytics
-- =============================================
create procedure sales_analytics
as
begin
with salescounts as (
    select 
        customers.visit_day,
        dish.dish_name,
        drink.drink_name,
        count(*) as sales_count,
        row_number() over (partition by customers.visit_day order by count(*) desc) as rn
    from 
        orders
    left join 
        dish ON orders.dish_id = dish.dish_id
    left join 
        drink ON orders.drink_id = drink.drink_id
	left join
		customers on orders.customer_id = customers.customer_id
    group by
        customers.visit_day, dish.dish_name, drink.drink_name
)
select 
    visit_day,
    dish_name,
    drink_name,
    sales_count
from 
    salescounts
where 
    rn = 1;
end
GO
