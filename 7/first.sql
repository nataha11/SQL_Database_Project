USE Bundesliga
GO
DROP LOGIN login_test1
GO
DROP USER user_test1
GO
DROP ROLE role_test1
GO


CREATE LOGIN login_test1 WITH PASSWORD = '1234'

CREATE USER user_test1 FOR LOGIN login_test1
GO

--1.��������� ������ ������������ ����� SELECT, INSERT, UPDATE � ������ ������ �� ���� �������
GRANT INSERT, SELECT, UPDATE ON REFEREE TO user_test1

GRANT ALTER ON REFEREE TO user_test1
GO

--2.��� ����� ������� ������ ������������ �������� ����� SELECT � UPDATE ������ ��������� ��������.
GRANT SELECT, UPDATE ON STADIUMS (capacity) TO user_test1
GO

--3.��� ����� ������� ������ ������������ �������� ������ ����� SELECT.
GRANT SELECT ON TOURNAMENT_TABLE TO user_test1
GO

--4.��������� ������ ������������ ����� ������� (SELECT) � �������������, ���������� � ������������ ������ �4.
GRANT SELECT ON MATCHES TO user_test1
GO

--5.C������ ����������� ���� ������ ���� ������, ��������� �� ����� ������� (UPDATE �� ��������� �������) � �������������, ��������� ������ ������������ ��������� ����
CREATE ROLE role_test1

GRANT SELECT, UPDATE ON STADIUM1 (stadium, team) TO role_test1

ALTER ROLE role_test1 ADD member user_test1
GO










/*
SELECT session_id FROM sys.dm_exec_sessions WHERE login_name = 'login_test1'
KILL 
GO

DROP LOGIN [login_test1]
GO
DROP USER user_test1
GO
DROP ROLE role_test1
GO
*/



