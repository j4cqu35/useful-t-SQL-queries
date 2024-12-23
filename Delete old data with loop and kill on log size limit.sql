DECLARE @BatchSize        INT = 10000;
DECLARE @counter          INT = 1;
DECLARE @LogFileSizeLimit INT = 10240; -- Set your log file size limit in MB
DECLARE @LogFileSize      INT;
DECLARE @LogFileName      NVARCHAR(128);

-- Get the log file name associated with the current database
SELECT @LogFileName = name
FROM sys.master_files
WHERE type_desc = 'LOG' AND database_id = DB_ID();

PRINT 'Log file name: ' + @LogFileName;

WHILE @counter > 0 
BEGIN
    -- Check the log file size
    SELECT @LogFileSize = size / 128 -- Convert from 8KB pages to MB
    FROM sys.master_files
    WHERE type_desc = 'LOG' AND name = @LogFileName;

    IF @LogFileSize > @LogFileSizeLimit
    BEGIN
        PRINT 'Log file size limit exceeded. Stopping the loop.';
        BREAK;
    END

    DELETE TOP (@BatchSize) FROM TSDBA.RS_BAY_SKU
        WHERE DATE_MODIFIED < '2024-01-01';

    SET @counter = @@ROWCOUNT;
END