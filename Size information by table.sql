declare @tableName nvarchar(1000)
declare @res table
(
    name nvarchar(1000),
    rows int,
    reserved nvarchar(1000),
    data nvarchar(1000),
    index_size nvarchar(1000),
    unused nvarchar(1000)
)
DECLARE tablename_cursor CURSOR FOR
SELECT name FROM sysobjects
WHERE xtype = 'U'
OPEN tablename_cursor
FETCH NEXT FROM tablename_cursor
INTO @tableName
WHILE @@FETCH_STATUS = 0
BEGIN
    insert @res
    exec sp_spaceused @tablename;
   
    FETCH NEXT FROM tablename_cursor
    INTO @tableName
END
CLOSE tablename_cursor
DEALLOCATE tablename_cursor
select * from @res
order by LEN(reserved) desc, reserved desc