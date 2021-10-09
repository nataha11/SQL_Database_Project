--Вывести спонсоров топ 3 команд в сезоне 2019/20 

SELECT TOP 3 WITH TIES sponsor 
FROM SPONSOR
	JOIN TEAMS_SPONSORS ON SPONSOR.sponsor_id = TEAMS_SPONSORS.sponsor_id
	JOIN TEAMS ON TEAMS_SPONSORS.team_id = TEAMS.team_id
	JOIN TOURNAMENT_TABLE ON TEAMS.team_id = TOURNAMENT_TABLE.team_id
WHERE TOURNAMENT_TABLE.season = 2019 AND TEAMS_SPONSORS.season = 2019
ORDER BY TOURNAMENT_TABLE.place


--Вывести матчи второй половины сезона 2019/20, в которых было показано более 4 желтых карточек, но не показано красных

SELECT hteam_id, ateam_id, date_time, yellow_card, red_card
FROM [MATCH]
WHERE [MATCH].yellow_card > 4 AND [MATCH].red_card = 0 AND [MATCH].date_time  > '01.01.2020'


--На каком стадионе сколько сыграно матчей вничью

WITH TABL AS (SELECT *
	FROM [MATCH]
	WHERE [MATCH].hteam_score = [MATCH].ateam_score)
SELECT STADIUMS.[name], COUNT (*) AS drawmatches
FROM STADIUMS
	JOIN TEAMS ON TEAMS.team_id = STADIUMS.hometeam_id
	JOIN TABL ON TABL.hteam_id = TEAMS.team_id
GROUP BY STADIUMS.name


--Вывести, команды из каких городов по итогам сезона 2019/20 вышли в Лигу Европы (групповой раунд или квалификация)

SELECT CITY.name
FROM CITY
	JOIN TEAMS ON TEAMS.city_id = CITY.id
	JOIN TOURNAMENT_TABLE ON TEAMS.team_id = TOURNAMENT_TABLE.team_id
WHERE TOURNAMENT_TABLE.season = 2019 AND TOURNAMENT_TABLE.comment LIKE '%Лига Европы%'


--Сколько желтых карточек показал каждый судья

WITH TABL AS (SELECT REFEREE.ref_id, SUM (yellow_card) AS yellowtotal
	FROM REFEREE 
		JOIN [MATCH] ON [MATCH].ref_id = REFEREE.ref_id
	GROUP BY REFEREE.ref_id)
SELECT REFEREE.name, REFEREE.surname, TABL.yellowtotal
FROM TABL JOIN REFEREE ON TABL.ref_id = REFEREE.ref_id




--Если команда попала в топ 7 по итогам сезона 2019/20, то вместимость стадиона этой команды увеличивается на 10000

UPDATE STADIUMS
SET capacity = capacity + 10000
FROM STADIUMS 
JOIN TEAMS ON STADIUMS.hometeam_id = TEAMS.team_id 
JOIN TOURNAMENT_TABLE ON TEAMS.team_id = TOURNAMENT_TABLE.team_id
WHERE TOURNAMENT_TABLE.place <= 7


--Попытаемся изменить значение ref_id в таблице [MATCH], где он является внешним ключом, что вызовет ошибку из-за ограничения целостности (+IDENTITY)

UPDATE [MATCH]
SET ref_id = 650
WHERE red_card = 2


--Изменим название спонсора

UPDATE SPONSOR
SET sponsor = 'GALF'
WHERE sponsor ='Wirsol'



--Удалим из турнирной таблицы две последние команды (которые выбывают во 2 Бундеслигу)

DELETE FROM TOURNAMENT_TABLE
WHERE place = 18 OR place = 17


--Удалить данные о спонсорах команд ранее 2019 года

DELETE FROM TEAMS_SPONSORS
WHERE season < 2019


--Попытаемся удалить id города, в котором нет команд (team_id IS NULL из-за LEFT JOIN) - ошибка

DELETE CITY
FROM CITY 
LEFT JOIN TEAMS ON CITY.id = TEAMS.team_id
WHERE TEAMS.team_id IS NULL



---------------------------------------------------------------------------------

--3 доп  максимальное место для команды, и в каком сезоне
	select teams.[name], minn, season
	from 
		(select team_id, min(place) as minn
		from TOURNAMENT_TABLE
		group by team_id) as t join TOURNAMENT_TABLE on t.team_id = TOURNAMENT_TABLE.team_id 
		join teams on teams.team_id = TOURNAMENT_TABLE.team_id
	where  t.minn = TOURNAMENT_TABLE.place
	order by t.team_id