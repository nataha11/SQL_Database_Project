

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--���������� ��������� 1
BEGIN TRANSACTION
	DECLARE @temp INT;
	SELECT @temp = capacity FROM STADIUMS WHERE hometeam_id = 24;
	WAITFOR DELAY '00:00:10';
	

	UPDATE STADIUMS SET capacity = @temp + 5 WHERE hometeam_id = 24
COMMIT	

	SELECT *
  FROM STADIUMS
  WHERE hometeam_id = 24                          
--UPDATE STADIUMS SET capacity = 75000 WHERE hometeam_id = 24

--���������� ��������� 2
BEGIN TRANSACTION
	UPDATE STADIUMS SET capacity = 80000 WHERE stadium_id = 311


	COMMIT
SELECT * FROM STADIUMS WHERE stadium_id = 311
--UPDATE STADIUMS SET capacity = 30000 WHERE stadium_id = 311

--������� ������
BEGIN TRANSACTION
	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311

	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311

	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311
COMMIT
--------------------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ COMMITTED --DEFAULT
--������� ������ 
BEGIN TRANSACTION
	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311

	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311


COMMIT

--��������������� ������
BEGIN TRANSACTION
	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311


	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311
COMMIT
--UPDATE STADIUMS SET capacity = 30000 WHERE stadium_id = 311
--------------------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
--��������������� ������
BEGIN TRANSACTION
	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311


	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311
COMMIT
	SELECT stadium_id, name, capacity FROM STADIUMS WHERE stadium_id = 311
--UPDATE STADIUMS SET capacity = 30000 WHERE stadium_id = 311

--������
BEGIN TRANSACTION
	SELECT name, capacity FROM STADIUMS WHERE capacity <= 29000



	SELECT name, capacity FROM STADIUMS WHERE capacity <= 29000
COMMIT ROLLBACK
--DELETE FROM STADIUMS WHERE stadium_id = 319
-----------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
--������
BEGIN TRANSACTION
	SELECT name, capacity FROM STADIUMS WHERE capacity <= 29000



	SELECT name, capacity FROM STADIUMS WHERE capacity <= 29000
COMMIT
SELECT name, capacity FROM STADIUMS WHERE capacity <= 29000
--DELETE FROM STADIUMS WHERE stadium_id = 319
----------------------------------------------------------------