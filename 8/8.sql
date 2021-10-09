--1.¬ыбрать имена всех таблиц, созданных назначенным пользователем базы данных

select sys.objects.name as 'table'
	from sys.objects
		join sys.schemas on sys.schemas.schema_id = sys.objects.schema_id
	where sys.objects.type = 'U'
		and sys.schemas.principal_id = DATABASE_PRINCIPAL_ID () -- выбираем строки с текущим пользователем
		and sys.objects.object_id not in
				(select major_id from sys.extended_properties where name = 'microsoft_database_tools_support' and value = 1)  
 

--2.¬ыбрать им€ таблицы, им€ столбца таблицы, признак того, допускает ли данный столбец null-значени€, 
--название типа данных столбца таблицы, размер этого типа данных - дл€ всех таблиц, 
--созданных назначенным пользователем базы данных и всех их столбцов

select sys.objects.name as 'table', sys.columns.name as 'column', sys.columns.is_nullable as 'null', sys.types.name as 'type', sys.columns.max_length as 'size'
	from sys.objects 
		join sys.columns on sys.columns.object_id = sys.objects.object_id
		join sys.schemas on sys.schemas.schema_id = sys.objects.schema_id
		join sys.types on sys.types.system_type_id = sys.columns.system_type_id
	where sys.objects.type = 'U'
		and sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()
		and sys.objects.object_id not in
			(select major_id from sys.extended_properties where name = 'microsoft_database_tools_support' and value = 1)


--3.¬ыбрать название ограничени€ целостности (первичные и внешние ключи), им€ таблицы, в которой оно находитс€, 
--признак того, что это за ограничение ('PK' дл€ первичного ключа и 'F' дл€ внешнего) - дл€ всех ограничений целостности, созданных назначенным пользователем базы данных 

select sysobj2.name as 'keyname', sysobj1.name as 'table', sysobj2.[type]
	from sys.objects as sysobj1 
		join sys.objects as sysobj2 on sysobj2.parent_object_id = sysobj1.object_id
		join sys.schemas on sysobj1.schema_id = sys.schemas.schema_id
	where sysobj2.type in ('PK', 'F')
		and sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()
		and sysobj1.object_id not in
			(select major_id from sys.extended_properties where name = 'microsoft_database_tools_support' and value = 1)


--4.¬ыбрать название внешнего ключа, им€ таблицы, содержащей внешний ключ, им€ таблицы, содержащей его родительский ключ дл€ всех внешних ключей, 
--созданных назначенным пользователем базы данных 

select sys.foreign_keys.name as 'FK_name', sysobj1.name as 'parent', sysobj2.name as 'child'
	from sys.foreign_keys 
		join sys.objects as sysobj1 on sys.foreign_keys.parent_object_id = sysobj1.object_id
		join sys.objects as sysobj2 on sys.foreign_keys.referenced_object_id = sysobj2.object_id 
		join sys.schemas on sys.schemas.schema_id = sysobj1.schema_id
	where sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()
		and sysobj2.object_id not in
				(select major_id from sys.extended_properties where name = 'microsoft_database_tools_support' and value = 1)  


--5.¬ыбрать название представлени€, SQL-запрос, создающий это представление - дл€ всех представлений, созданных назначенным пользователем базы данных 

select sys.objects.name as 'view', sys.syscomments.text as 'code'
	from sys.objects 
		join sys.schemas on sys.objects.schema_id = sys.schemas.schema_id
		join sys.syscomments on sys.syscomments.id = sys.objects.object_id
	where sys.objects.type = 'V'
		and sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()
		and sys.objects.object_id not in
			(select major_id from sys.extended_properties where name = 'microsoft_database_tools_support' and value = 1)



--6.¬ыбрать название триггера, им€ таблицы, дл€ которой определен триггер - дл€ всех триггеров, созданных назначенным пользователем базы данных
-- —оздадим триггер
go
drop trigger trig
go

create trigger trig  on  CITY
after insert, update  
as raiserror ('Warning INSERT', 16, 10);  --выведет это сообщение при попытке insert-a  
go

select sys.triggers.name, obj.name as 'table'
	from sys.triggers 
		join sys.objects as obj on sys.triggers.parent_id = obj.object_id
		join sys.schemas on sys.schemas.schema_id = obj.schema_id
	where sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()
		and sys.triggers.type = 'TR'
		and obj.object_id not in
			(select major_id from sys.extended_properties where name = 'microsoft_database_tools_support' and value = 1)
			



