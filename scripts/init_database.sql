
/*
===============================================================================
    Script:        init_database.sql
    Project:       SQL Data Warehouse Project
    Description:   Create the DataWarehouse database and its schemas.
    Database:      Microsoft SQL Server
===============================================================================
*/

-- =============================================================================
-- 1. Create the DataWarehouse Database if it does not exist
-- =============================================================================

USE master;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    CREATE DATABASE DataWarehouse;
END;
GO


-- =============================================================================
-- 2. Switch to the DataWarehouse Database
-- =============================================================================

USE DataWarehouse;
GO


-- =============================================================================
-- 3. Create the Bronze Schema if it does not exist
-- =============================================================================

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'bronze'
)
BEGIN
    EXEC('CREATE SCHEMA bronze');
END;
GO


-- =============================================================================
-- 4. Create the Silver Schema if it does not exist
-- =============================================================================

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'silver'
)
BEGIN
    EXEC('CREATE SCHEMA silver');
END;
GO


-- =============================================================================
-- 5. Create the Gold Schema if it does not exist
-- =============================================================================

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'gold'
)
BEGIN
    EXEC('CREATE SCHEMA gold');
END;
GO


-- =============================================================================
-- End of Script
-- =============================================================================
