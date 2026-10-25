
/*
===============================================================================
    Script:        ddl_bronze.sql
    Project:       SQL Data Warehouse Project
    Description:   Create all Bronze Layer tables for CRM and ERP source data.
    Database:      DataWarehouse
===============================================================================
*/

USE DataWarehouse;
GO


-- =============================================================================
-- 1. Create CRM Product Information Table
-- =============================================================================

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.crm_prd_info (
        prd_id       INT,
        prd_key      NVARCHAR(50),
        prd_nm       NVARCHAR(50),
        prd_cost     INT,
        prd_line     NVARCHAR(50),
        prd_start_dt DATETIME,
        prd_end_dt   DATETIME
    );
END;
GO


-- =============================================================================
-- 2. Create ERP Sales Details Table
-- =============================================================================

IF OBJECT_ID('bronze.erp_sales_details', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.erp_sales_details (
        sls_ord_num  NVARCHAR(50),
        sls_prd_key  NVARCHAR(50),
        sls_cust_id  INT,
        sls_order_dt INT,
        sls_ship_dt  INT,
        sls_due_dt   INT,
        sls_sales    INT,
        sls_quantity INT,
        sls_price    INT
    );
END;
GO


-- =============================================================================
-- 3. Create ERP Customer Information Table
-- =============================================================================

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.erp_cust_az12 (
        CID   NVARCHAR(50),
        BDATE DATE,
        GEN   NVARCHAR(50)
    );
END;
GO


-- =============================================================================
-- 4. Create ERP Customer Location Table
-- =============================================================================

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.erp_loc_a101 (
        CID   NVARCHAR(50),
        CNTRY NVARCHAR(100)
    );
END;
GO


-- =============================================================================
-- 5. Create ERP Product Category Table
-- =============================================================================

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.erp_px_cat_g1v2 (
        ID          NVARCHAR(50),
        CAT         NVARCHAR(100),
        SUBCAT      NVARCHAR(100),
        MAINTENANCE NVARCHAR(100)
    );
END;
GO


-- =============================================================================
-- End of Script
-- =============================================================================
