-- Monitor Missing Indexes

select
	fs.SalesOrderNumber,
	dp.EnglishProductName,
	dp.Color
from FactInternetSales fs
inner join DimProduct dp
on fs.ProductKey = dp.ProductKey
where dp.Color = 'Black'
and fs.OrderDateKey between 20101229 and 20101231;

select * from sys.dm_db_missing_index_details 









