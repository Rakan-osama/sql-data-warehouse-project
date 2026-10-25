
/*
===============================================================================
    Stored Procedure: bronze.load_bronze
    Project:          SQL Data Warehouse Project
    Layer:            Bronze Layer
    Description:      Loads raw data from CRM and ERP CSV files into the
                      Bronze Layer tables in the DataWarehouse database.

    Bronze Layer Purpose:
    ---------------------
    The Bronze Layer is the first layer in the Data Warehouse architecture.
    It stores raw data from source systems with minimal or no transformation.

    This layer preserves the source data before it is cleaned or transformed
    in the Silver Layer and prepared for analytics in the Gold Layer.

    Loading Process:
    ----------------
    1. Load raw data from CRM and ERP CSV files.
    2. Truncate existing table data before reloading.
    3. Use BULK INSERT to load data efficiently.
    4. Measure and print the loading duration for each table.
    5. Catch and display errors if the loading process fails.

    Important:
    ----------
    TRUNCATE TABLE removes all existing rows before loading new data.
    This procedure performs a full reload, not an incremental load.
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    -- Variables used to measure the loading duration of each table.
    DECLARE @start_time DATETIME, @end_time DATETIME;

    BEGIN TRY

        -- Display the beginning of the Bronze Layer loading process.
        PRINT '============================================================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '============================================================================================';


        -- =========================================================================
        -- 1. Load CRM Source Tables
        -- =========================================================================
        -- CRM stands for Customer Relationship Management.
        -- These files contain customer, product, and sales information.

        PRINT '--------------------------------------------------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '--------------------------------------------------------------------------------------------';


        -- -------------------------------------------------------------------------
        -- Load CRM Customer Information
        -- -------------------------------------------------------------------------
        -- Start measuring the loading duration.
        SET @start_time = GETDATE();

        -- Remove existing records to prepare for a complete reload.
        PRINT '>> Truncating Table : bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        -- Import the raw customer data from the CSV file.
        -- FIRSTROW = 2 skips the header row.
        -- FIELDTERMINATOR = ',' specifies that columns are comma-separated.
        -- TABLOCK allows SQL Server to acquire a table-level lock during loading.
        PRINT '>> inserting data into table : bronze.crm_cust_info ';
        BULK INSERT bronze.crm_cust_info
        FROM 'D:\family\rakan\stadying\database\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- Calculate and display the time taken to load the table.
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------------------------------------';


        -- -------------------------------------------------------------------------
        -- Load CRM Product Information
        -- -------------------------------------------------------------------------
        SET @start_time = GETDATE();

        -- Clear existing product records before reloading.
        PRINT '>> Truncating Table : bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        -- Import raw product information from the CSV file.
        PRINT '>> inserting data into table : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'D:\family\rakan\stadying\database\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- Calculate and display the loading duration.
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------------------------------------';


        -- -------------------------------------------------------------------------
        -- Load CRM Sales Details
        -- -------------------------------------------------------------------------
        SET @start_time = GETDATE();

        -- Clear existing sales records before reloading.
        PRINT '>> Truncating Table : bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        -- Import raw sales transactions from the CSV file.
        PRINT '>> inserting data into table : bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'D:\family\rakan\stadying\database\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- Calculate and display the loading duration.
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------------------------------------';


        -- =========================================================================
        -- 2. Load ERP Source Tables
        -- =========================================================================
        -- ERP stands for Enterprise Resource Planning.
        -- These files provide additional customer, location, and product category
        -- information that can be integrated with CRM data in later layers.

        PRINT '--------------------------------------------------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '--------------------------------------------------------------------------------------------';


        -- -------------------------------------------------------------------------
        -- Load ERP Customer Information
        -- -------------------------------------------------------------------------
        SET @start_time = GETDATE();

        -- Clear existing customer records before reloading.
        PRINT '>> Truncating Table : bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        -- Import raw ERP customer information from the CSV file.
        PRINT '>> inserting data into table : bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\family\rakan\stadying\database\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- Calculate and display the loading duration.
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------------------------------------';


        -- -------------------------------------------------------------------------
        -- Load ERP Customer Location Information
        -- -------------------------------------------------------------------------
        SET @start_time = GETDATE();

        -- Clear existing location records before reloading.
        PRINT '>> Truncating Table : bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        -- Import raw customer location data from the CSV file.
        PRINT '>> inserting data into table : bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\family\rakan\stadying\database\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- Calculate and display the loading duration.
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------------------------------------';


        -- -------------------------------------------------------------------------
        -- Load ERP Product Category Information
        -- -------------------------------------------------------------------------
        SET @start_time = GETDATE();

        -- Clear existing product category records before reloading.
        PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        -- Import raw product category data from the CSV file.
        PRINT '>> inserting data into table : bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\family\rakan\stadying\database\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- Calculate and display the loading duration.
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------------------------------------';


    END TRY

    BEGIN CATCH

        -- =========================================================================
        -- Error Handling
        -- =========================================================================
        -- If a SQL error occurs during loading, execution enters this block.
        -- The following messages help identify the error and its SQL Server details.
        -- Note: This block reports the error but does not automatically roll back
        -- previously completed table loads.

        PRINT '=================================================================================';
        PRINT 'Error according loading Bronze layer';
        PRINT 'Error Messsage' + ERROR_MESSAGE();
        PRINT 'Error Messsage' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Messsage' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=================================================================================';

    END CATCH
END;
GO


-- =============================================================================
-- Execute the Bronze Layer loading procedure
-- =============================================================================
-- Run this statement when you want to reload all CRM and ERP Bronze tables.
-- Make sure the database, tables, CSV files, and file permissions are configured.

-- EXEC bronze.load_bronze;
