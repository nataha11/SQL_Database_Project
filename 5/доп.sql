--������� ���������������� ������������� � �������� ���� ������ (���� ��������� ����������� �� ���������, ����� ��� �� ��������������(���� > 100, ������ < 100, � ��������� id, name)
--��� ������������ �������!!

CREATE TABLE CITY2( 
	id int NOT NULL PRIMARY KEY IDENTITY (50, 1),
	name nvarchar (255) NOT NULL,
)
GO

INSERT INTO CITY2 (name) VALUES ('ʸ���������')
go

CREATE VIEW DOPCITY
AS 
	SELECT id, name 
	FROM CITY
	UNION 
	SELECT id, name 
	FROM CITY2
GO



INSERT INTO DOPCITY ([name]) VALUES ('���������')



DROP TABLE CITY2
DROP VIEW DOPCITY