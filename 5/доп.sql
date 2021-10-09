--Создать секционированное представление и вставить туда строку (надо поставить ограничения на айдишники, чтобы они не перекрестились(один > 100, другой < 100, и вставлять id, name)
--Это недоделанное решение!!

CREATE TABLE CITY2( 
	id int NOT NULL PRIMARY KEY IDENTITY (50, 1),
	name nvarchar (255) NOT NULL,
)
GO

INSERT INTO CITY2 (name) VALUES ('Кённигсберг')
go

CREATE VIEW DOPCITY
AS 
	SELECT id, name 
	FROM CITY
	UNION 
	SELECT id, name 
	FROM CITY2
GO



INSERT INTO DOPCITY ([name]) VALUES ('Дармштадт')



DROP TABLE CITY2
DROP VIEW DOPCITY