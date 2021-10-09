--1.Выбрать названия тех городов, покупатели из которых обслуживаются отделами, расположенными в г.Даллас (DALLAS).

SELECT DISTINCT city
FROM CUSTOMER
JOIN EMPLOYEE ON CUSTOMER.salesperson_id = EMPLOYEE.employee_id
JOIN DEPARTMENT ON EMPLOYEE.department_id = DEPARTMENT.department_id
JOIN LOCATION ON DEPARTMENT.location_id = LOCATION.location_id
WHERE regional_group = 'DALLAS'


--2.Выбрать список штатов в порядке увеличения объема продаж в штате. Включить в список только те штаты, в которых было не менее 10 продаж.


WITH CUSTOMER_1 AS (
	SELECT state, COUNT(*) AS sumsale
	FROM CUSTOMER
	JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
	GROUP BY state)
SELECT CUSTOMER_1.state
FROM CUSTOMER_1
WHERE CUSTOMER_1.sumsale >= 10
ORDER BY sumsale

--3.Определить количество количество покупателей, приобретенных в 1990 году.


WITH TABL AS (
	SELECT CUSTOMER.customer_Id, MIN(YEAR(order_date)) AS mindate
	FROM CUSTOMER
	JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
	GROUP BY CUSTOMER.customer_id)
SELECT COUNT(TABL.customer_id) as Quantity
FROM TABL
WHERE mindate = 1990


--4.Какой покупатель за все время закупил товара, в названии которого имеется слово'DUNK', на наибольшую сумму.


SELECT TOP 1 name
FROM CUSTOMER
JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
JOIN ITEM ON SALES_ORDER.order_id = ITEM.order_id
JOIN PRODUCT ON ITEM.product_id = PRODUCT.product_id
WHERE description LIKE '%DUNK%'
GROUP BY name
ORDER BY (SUM(SALES_ORDER.total)) DESC
