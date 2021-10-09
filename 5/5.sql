                                                                --VIEWS--
DROP VIEW IF EXISTS MATCHES, STADIUM1, BAYERN, SPONS
GO

--Таблица матчей: какие команды играют, дата и время, судья, стадион
CREATE VIEW MATCHES
AS
	WITH TABL AS 
		(SELECT [MATCH].match_id, 
			TEAMS.[name] AS hname, 
			[MATCH].ateam_id AS aid
		 FROM [MATCH]
		 JOIN TEAMS ON TEAMS.team_id = [MATCH].hteam_id)
	SELECT TABL.hname, 
		TEAMS.[name] AS aname, 
		[MATCH].date_time, 
		STADIUMS.[name] AS stadium, 
		REFEREE.[name] AS rname, 
		REFEREE.surname AS rsurname
	FROM TABL
	JOIN [MATCH] ON TABL.match_id = [MATCH].match_id
	JOIN TEAMS ON TEAMS.team_id = TABL.aid
	JOIN REFEREE ON REFEREE.ref_id = [MATCH].ref_id
	JOIN STADIUMS ON STADIUMS.hometeam_id = [MATCH].hteam_id
GO
	

--Команды, их стадионы и города
CREATE VIEW STADIUM1
AS
	SELECT TEAMS.[name] AS team, 
		CITY.[name] AS city, 
		STADIUMS.[name] AS stadium, 
		STADIUMS.capacity
	FROM TEAMS
	JOIN STADIUMS ON TEAMS.team_id = STADIUMS.hometeam_id
	JOIN CITY ON CITY.id = TEAMS.city_id
GO


-- Игроки Баварии в сезоне 2019/20
CREATE VIEW BAYERN
AS
	SELECT PL.[name], 
		PL.surname, 
		PL.nationality, 
		PL.birth_date, 
		PL1.position
	FROM PLAYERS PL
	JOIN PLAYERS_1 PL1 ON PL.player_id = PL1.player_id
	JOIN TEAMS ON TEAMS.team_id = PL1.team_id
	WHERE TEAMS.name = 'Бавария' 
		AND PL1.season = '2019'
GO


--Команды и их спонсоры в сезоне 2019/20
CREATE VIEW SPONS
AS 
	SELECT TOURNAMENT_TABLE.place, 
		TEAMS.team_id, 
		TEAMS.[name] AS team, 
		SPONSOR.sponsor
	FROM TEAMS
	JOIN TOURNAMENT_TABLE ON TEAMS.team_id = TOURNAMENT_TABLE.team_id
	LEFT JOIN TEAMS_SPONSORS TS ON TEAMS.team_id = TS.team_id
	JOIN SPONSOR ON SPONSOR.sponsor_id = TS.sponsor_id
	WHERE TS.season = '2019'
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                --SELECT--
--Игры Боруссии Д в сезоне 2019/20
SELECT hname, 
	aname, 
	date_time
FROM MATCHES
WHERE hname = 'Боруссия Д' 
	OR aname = 'Боруссия Д'
GO

--Вывести SPONS по порядку мест
SELECT place, 
	team, 
	sponsor 
FROM SPONS
ORDER BY place
GO

--Топ 10 стадионов и их домашние команды, у которых самая большая вместимость
SELECT TOP 10 capacity, 
	stadium, 
	team
FROM STADIUM1
ORDER BY capacity DESC
GO

--Сколько матчей судил каждый судья
SELECT COUNT (*) AS quantity, 
	rname, 
	rsurname 
FROM MATCHES
GROUP BY rname, 
	rsurname
ORDER BY quantity DESC
GO

