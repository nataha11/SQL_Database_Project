-- ������� ������������ ��� login_test1, ����� ��� ���������
USE Bundesliga
GO
--1
BEGIN TRANSACTION

SELECT * FROM REFEREE

UPDATE REFEREE SET surname = '����' WHERE ref_id = 611

INSERT INTO REFEREE ([name], surname) VALUES ( '����', '������')

DELETE FROM REFEREE WHERE ref_id = 605    --��� ���� �� �����

ROLLBACK

GO

--2
BEGIN TRANSACTION

SELECT capacity FROM STADIUMS

UPDATE STADIUMS SET capacity = 99999 WHERE capacity = 75000

UPDATE STADIUMS SET name = 'Arena' WHERE stadium_id = 303 -- ��� ���� �������� name � ������ stadium_id

ROLLBACK

GO

--3
BEGIN TRANSACTION

SELECT * FROM TOURNAMENT_TABLE

UPDATE TOURNAMENT_TABLE SET points = 25 WHERE team_id = 15 ---��������� ��������� ���� �������

ROLLBACK

GO
--4
BEGIN TRANSACTION

SELECT * FROM MATCHES

UPDATE MATCHES SET date_time = '2020-10-30 20:00' -- ����� ������ �� ������

ROLLBACK

GO

--5
BEGIN TRANSACTION

SELECT stadium, team FROM STADIUM1

UPDATE STADIUM1 SET stadium = '���� �����' WHERE stadium = '���� ������'

SELECT * FROM STADIUM1 -- �� �� ��� ������� ���� ���������� �� ������

ROLLBACK

GO
