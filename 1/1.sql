--1.������� �������� ��� �������, ���������� �� ������� ������������� ��������, �������������� � �.������ (DALLAS).

SELECT DISTINCT city
FROM CUSTOMER
JOIN EMPLOYEE ON CUSTOMER.salesperson_id = EMPLOYEE.employee_id
JOIN DEPARTMENT ON EMPLOYEE.department_id = DEPARTMENT.department_id
JOIN LOCATION ON DEPARTMENT.location_id = LOCATION.location_id
WHERE regional_group = 'DALLAS'


--2.������� ������ ������ � ������� ���������� ������ ������ � �����. �������� � ������ ������ �� �����, � ������� ���� �� ����� 10 ������.


WITH CUSTOMER_1 AS (
	SELECT state, COUNT(*) AS sumsale
	FROM CUSTOMER
	JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
	GROUP BY state)
SELECT CUSTOMER_1.state
FROM CUSTOMER_1
WHERE CUSTOMER_1.sumsale >= 10
ORDER BY sumsale

--3.���������� ���������� ���������� �����������, ������������� � 1990 ����.


WITH TABL AS (
	SELECT CUSTOMER.customer_Id, MIN(YEAR(order_date)) AS mindate
	FROM CUSTOMER
	JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
	GROUP BY CUSTOMER.customer_id)
SELECT COUNT(TABL.customer_id) as Quantity
FROM TABL
WHERE mindate = 1990


--4.����� ���������� �� ��� ����� ������� ������, � �������� �������� ������� �����'DUNK', �� ���������� �����.


SELECT TOP 1 name
FROM CUSTOMER
JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
JOIN ITEM ON SALES_ORDER.order_id = ITEM.order_id
JOIN PRODUCT ON ITEM.product_id = PRODUCT.product_id
WHERE description LIKE '%DUNK%'
GROUP BY name
ORDER BY (SUM(SALES_ORDER.total)) DESC
