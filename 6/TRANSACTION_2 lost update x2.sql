

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--���������� ��������� 1
BEGIN TRANSACTION
	DECLARE @temp INT;
	SELECT @temp = capacity FROM STADIUMS WHERE hometeam_id = 24

	UPDATE STADIUMS SET capacity = @temp + 7 WHERE hometeam_id = 24
COMMIT
	


	SELECT *
  FROM STADIUMS
  WHERE hometeam_id = 24

 
 --���������� ��������� 2
 BEGIN TRANSACTION
	
	UPDATE STADIUMS SET capacity = 70000 WHERE stadium_id = 311	
	COMMIT




--������� ������
BEGIN TRANSACTION

	UPDATE STADIUMS SET capacity = 80000 WHERE stadium_id = 311

ROLLBACK


----------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--������� ������
BEGIN TRANSACTION

	UPDATE STADIUMS SET capacity = 80000 WHERE stadium_id = 311

ROLLBACK



--��������������� ������
BEGIN TRANSACTION

	UPDATE STADIUMS SET capacity = 80000 WHERE stadium_id = 311
COMMIT



---------------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
--��������������� ������
BEGIN TRANSACTION

	UPDATE STADIUMS SET capacity = 80000 WHERE stadium_id = 311
COMMIT





--������
BEGIN TRANSACTION

	SET IDENTITY_INSERT STADIUMS ON
	INSERT INTO STADIUMS (stadium_id, name, hometeam_id, capacity) VALUES (319, '����������� ����', 29, 26515)
COMMIT

ROLLBACK

---------------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
--������
BEGIN TRANSACTION
	
	SET IDENTITY_INSERT STADIUMS ON
	INSERT INTO STADIUMS (stadium_id, name, hometeam_id, capacity) VALUES (319, '����������� ����', 29, 26515)
COMMIT


---------------------------------------------------------------------