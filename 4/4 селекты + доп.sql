--������� ��������� ��� 3 ������ � ������ 2019/20 

SELECT TOP 3 WITH TIES sponsor 
FROM SPONSOR
	JOIN TEAMS_SPONSORS ON SPONSOR.sponsor_id = TEAMS_SPONSORS.sponsor_id
	JOIN TEAMS ON TEAMS_SPONSORS.team_id = TEAMS.team_id
	JOIN TOURNAMENT_TABLE ON TEAMS.team_id = TOURNAMENT_TABLE.team_id
WHERE TOURNAMENT_TABLE.season = 2019 AND TEAMS_SPONSORS.season = 2019
ORDER BY TOURNAMENT_TABLE.place


--������� ����� ������ �������� ������ 2019/20, � ������� ���� �������� ����� 4 ������ ��������, �� �� �������� �������

SELECT hteam_id, ateam_id, date_time, yellow_card, red_card
FROM [MATCH]
WHERE [MATCH].yellow_card > 4 AND [MATCH].red_card = 0 AND [MATCH].date_time  > '01.01.2020'


--�� ����� �������� ������� ������� ������ ������

WITH TABL AS (SELECT *
	FROM [MATCH]
	WHERE [MATCH].hteam_score = [MATCH].ateam_score)
SELECT STADIUMS.[name], COUNT (*) AS drawmatches
FROM STADIUMS
	JOIN TEAMS ON TEAMS.team_id = STADIUMS.hometeam_id
	JOIN TABL ON TABL.hteam_id = TEAMS.team_id
GROUP BY STADIUMS.name


--�������, ������� �� ����� ������� �� ������ ������ 2019/20 ����� � ���� ������ (��������� ����� ��� ������������)

SELECT CITY.name
FROM CITY
	JOIN TEAMS ON TEAMS.city_id = CITY.id
	JOIN TOURNAMENT_TABLE ON TEAMS.team_id = TOURNAMENT_TABLE.team_id
WHERE TOURNAMENT_TABLE.season = 2019 AND TOURNAMENT_TABLE.comment LIKE '%���� ������%'


--������� ������ �������� ������� ������ �����

WITH TABL AS (SELECT REFEREE.ref_id, SUM (yellow_card) AS yellowtotal
	FROM REFEREE 
		JOIN [MATCH] ON [MATCH].ref_id = REFEREE.ref_id
	GROUP BY REFEREE.ref_id)
SELECT REFEREE.name, REFEREE.surname, TABL.yellowtotal
FROM TABL JOIN REFEREE ON TABL.ref_id = REFEREE.ref_id




--���� ������� ������ � ��� 7 �� ������ ������ 2019/20, �� ����������� �������� ���� ������� ������������� �� 10000

UPDATE STADIUMS
SET capacity = capacity + 10000
FROM STADIUMS 
JOIN TEAMS ON STADIUMS.hometeam_id = TEAMS.team_id 
JOIN TOURNAMENT_TABLE ON TEAMS.team_id = TOURNAMENT_TABLE.team_id
WHERE TOURNAMENT_TABLE.place <= 7


--���������� �������� �������� ref_id � ������� [MATCH], ��� �� �������� ������� ������, ��� ������� ������ ��-�� ����������� ����������� (+IDENTITY)

UPDATE [MATCH]
SET ref_id = 650
WHERE red_card = 2


--������� �������� ��������

UPDATE SPONSOR
SET sponsor = 'GALF'
WHERE sponsor ='Wirsol'



--������ �� ��������� ������� ��� ��������� ������� (������� �������� �� 2 ����������)

DELETE FROM TOURNAMENT_TABLE
WHERE place = 18 OR place = 17


--������� ������ � ��������� ������ ����� 2019 ����

DELETE FROM TEAMS_SPONSORS
WHERE season < 2019


--���������� ������� id ������, � ������� ��� ������ (team_id IS NULL ��-�� LEFT JOIN) - ������

DELETE CITY
FROM CITY 
LEFT JOIN TEAMS ON CITY.id = TEAMS.team_id
WHERE TEAMS.team_id IS NULL



---------------------------------------------------------------------------------

--3 ���  ������������ ����� ��� �������, � � ����� ������
	select teams.[name], minn, season
	from 
		(select team_id, min(place) as minn
		from TOURNAMENT_TABLE
		group by team_id) as t join TOURNAMENT_TABLE on t.team_id = TOURNAMENT_TABLE.team_id 
		join teams on teams.team_id = TOURNAMENT_TABLE.team_id
	where  t.minn = TOURNAMENT_TABLE.place
	order by t.team_id