--sp_who2 is a useful tool but often returns too much info, to make it more manageable / useful you can use and modify the following:

DECLARE @DBNAME VARCHAR(32)
SET @DBNAME = 'My_Database'
CREATE TABLE #sp_who2 (
    SPID INT
    ,STATUS VARCHAR(255)
    ,LOGIN VARCHAR(255)
    ,HostName VARCHAR(255)
    ,BlkBy VARCHAR(255)
    ,DBName VARCHAR(255)
    ,Command VARCHAR(255)
    ,CPUTime INT
    ,DiskIO INT
    ,LastBatch VARCHAR(255)
    ,ProgramName VARCHAR(255)
    ,SPID2 INT
    ,REQUESTID INT
    )
INSERT INTO #sp_who2
EXEC sp_who2
SELECT *
FROM #sp_who2
-- Add any filtering of the results here :
WHERE DBName = @DBNAME
-- Add any sorting of the results here :
ORDER BY DBName ASC
DROP TABLE #sp_who2