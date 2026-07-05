/*
if OBJECT_ID('name of table','U') is not null
drop 'name of table';
*/
/* Bulk insert "insert from csv" !! */
/* Truncate: make it tablme empty */
create  or alter procedure bronze.load_bronze as 
begin
declare  @start_time datetime,@end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
begin try
set @batch_start_time=getdate();
print'=========================================';
print'loading bronze layer';
print'=========================================';
print'-------------------------------';
print'loading crm table';
print'-------------------------------';
set @start_time=getdate();
print'>>>>> truncating and inserting bronze.crm_cust_info table';
truncate table bronze.crm_cust_info;
bulk insert bronze.crm_cust_info
from 'C:\Users\HP\Downloads\sql-data-warehouse-project-main (1)\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
with (
firstrow=2,
fieldterminator=',',
tablock);
select count(*) from bronze.crm_cust_info;
set @end_time=getdate();
print'>>load duration'+cast(datediff(second,@start_time,@end_time)as nvarchar)+'second';
print'********************';
set @start_time=getdate();
print'>>>>> truncating and inserting bronze.crm_prd_info table';
truncate table bronze.crm_prd_info;
bulk insert bronze.crm_prd_info 
from 'C:\Users\HP\Desktop\sql-data-warehouse-project-main (1)\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
with(
firstrow=2,
fieldterminator=',',
tablock);
select count(*) from  bronze.crm_prd_info;
set @end_time=getdate();
print'>>load duration'+cast(datediff(second,@start_time,@end_time)as nvarchar)+'second';
print'********************';
set @start_time=getdate();
print'>>>>> truncating and inserting bronze.crm_sales_details table';
truncate table bronze.crm_sales_details;
bulk insert bronze.crm_sales_details
from 'C:\Users\HP\Desktop\sql-data-warehouse-project-main (1)\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
with(
firstrow=2,
fieldterminator=',',
tablock);
select count(*) from  bronze.crm_sales_details ;
set @end_time=getdate();
print'>>load duration'+cast(datediff(second,@start_time,@end_time)as nvarchar)+'second';
print'-------------------------------';
print'loading erp table';
print'-------------------------------';
set @start_time=getdate();
print'>>>>> truncating and inserting bronze.erp_cust_az12 table';
truncate table bronze.erp_cust_az12;
bulk insert bronze.erp_cust_az12
from 'C:\Users\HP\Desktop\sql-data-warehouse-project-main (1)\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
with(
firstrow=2,
fieldterminator=',',
tablock);
select count(*) from bronze.erp_cust_az12 ;
set @end_time=getdate();
print'>>load duration'+cast(datediff(second,@start_time,@end_time)as nvarchar)+'second';
print'********************';
set @start_time=getdate();
print'>>>>> truncating and inserting bronze.erp_loc_a101 table';
truncate table bronze.erp_loc_a101;
bulk insert bronze.erp_loc_a101
from 'C:\Users\HP\Desktop\sql-data-warehouse-project-main (1)\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
with(
firstrow=2,
fieldterminator=',',
tablock);
select count(*) from bronze.erp_loc_a101 ;
set @end_time=getdate();
print'>>load duration'+cast(datediff(second,@start_time,@end_time)as nvarchar)+'second';
print'********************';
set @start_time=getdate();
print'>>>>> truncating and inserting bronze.erp_px_g1v2 table';
truncate table bronze.erp_px_cat_g1v2;
bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\HP\Desktop\sql-data-warehouse-project-main (1)\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
with(
firstrow=2,
fieldterminator=',',
tablock);
select count(*) from bronze.erp_px_cat_g1v2;
set @end_time=getdate();
print'>>load duration'+cast(datediff(second,@start_time,@end_time)as nvarchar)+'second';
set @batch_end_time=getdate();
print'_____________________________';
print'loading bronze layer is completed';
print'Total load duration:'+cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar)+'second';
print'_____________________________';
end try
begin catch
print'============================================';
print'error occured during loading bronze layer';
print'error message'+ error_message();
print'error message'+ cast(error_number()as nvarchar);
print'error message'+ cast(error_state()as nvarchar);
print'============================================';
end catch
end

/* to test is procedure storage created we do this comande */
exec bronze.load_bronze;
