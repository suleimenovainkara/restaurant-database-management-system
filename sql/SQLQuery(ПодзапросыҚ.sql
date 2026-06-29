--найти клиентов, у которых количество заказов 
--больше среднего количества заказов всех клиентов
SELECT * 
FROM customers 
WHERE customer_id IN (
    SELECT customer_id 
    FROM (
        SELECT customer_id, SUM(bill) AS total_bill
        FROM orders
        GROUP BY customer_id
    ) AS bill_sum
    WHERE total_bill > (
        SELECT AVG(total_bill)
        FROM (
            SELECT SUM(bill) AS total_bill
            FROM orders
            GROUP BY customer_id
        ) AS avg_bill
    )
)