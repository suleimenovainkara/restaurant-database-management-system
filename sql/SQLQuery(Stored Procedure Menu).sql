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
-- Description:	Menu
-- =============================================
create procedure Menu
as
begin
select 
	dish.dish_name, 
    dish.dish_categories,
    dish.ingredients,
	dish.price as dish_price,
	drink.drink_name,
    drink.drink_category,
	drink.price as drink_price
from dish 
join drink_dish as a on dish.dish_id = a.dish_id
join drink on a.drink_id = drink.drink_id
order by dish_categories, drink_category
end 
