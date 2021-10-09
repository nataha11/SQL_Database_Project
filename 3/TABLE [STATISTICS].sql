/*была идея создать такую таблцу (статистика каждого игрока в каждом матче), но тут оч много заполнять бы пришлось. Эта таблица одобрена Вознюком и по смыслу лучше подходит, если не лень, лучше ее включить в схему.*/
CREATE TABLE [STATISTICS] (
	player_id int NOT NULL,
	match_id int NOT NULL,
	goals int,
	assists int,
	yellow_cards int,
	red_cards int,
	comment ntext,
	PRIMARY KEY (player_id, match_id)
)
GO


ALTER TABLE [STATISTICS] WITH CHECK ADD CONSTRAINT [STATISTICS_fk0] FOREIGN KEY ([player_id]) REFERENCES [PLAYERS]([player_id])
ON UPDATE CASCADE
GO

ALTER TABLE [STATISTICS] WITH CHECK ADD CONSTRAINT [STATISTICS_fk1] FOREIGN KEY ([match_id]) REFERENCES [MATCH]([match_id])
ON DELETE CASCADE ON UPDATE CASCADE
GO


ALTER TABLE [STATISTICS] DROP CONSTRAINT IF EXISTS [STATISTICS_fk0]
GO
ALTER TABLE [STATISTICS] DROP CONSTRAINT IF EXISTS [STATISTICS_fk1]
GO