-- сначала залогинитьс€ под login_test1, потом это выполн€ть
USE Bundesliga
GO
--1
BEGIN TRANSACTION

SELECT * FROM REFEREE

UPDATE REFEREE SET surname = '‘ойц' WHERE ref_id = 611

INSERT INTO REFEREE ([name], surname) VALUES ( ' рис', 'Ўтрайх')

DELETE FROM REFEREE WHERE ref_id = 605    --нет прав на делит

ROLLBACK

GO

--2
BEGIN TRANSACTION

SELECT capacity FROM STADIUMS

UPDATE STADIUMS SET capacity = 99999 WHERE capacity = 75000

UPDATE STADIUMS SET name = 'Arena' WHERE stadium_id = 303 -- нет прав измен€ть name и читать stadium_id

ROLLBACK

GO

--3
BEGIN TRANSACTION

SELECT * FROM TOURNAMENT_TABLE

UPDATE TOURNAMENT_TABLE SET points = 25 WHERE team_id = 15 ---запрещено апдейтить этот столбец

ROLLBACK

GO
--4
BEGIN TRANSACTION

SELECT * FROM MATCHES

UPDATE MATCHES SET date_time = '2020-10-30 20:00' -- права только на селект

ROLLBACK

GO

--5
BEGIN TRANSACTION

SELECT stadium, team FROM STADIUM1

UPDATE STADIUM1 SET stadium = '–ейн јрена' WHERE stadium = '–ейн Ёнерги'

SELECT * FROM STADIUM1 -- не на все столбцы есть разрешение на селект

ROLLBACK

GO
