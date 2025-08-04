-- Managing Indexes

-- List all the indexes on a specific table
sp_helpindex 'Sales.DBCustomers'

-- Monitoring Index Usage
select				-- Contains metadata about database tables, views, indexes		
	tbl.name IndexName,
	idx.name IndexName,
	idx.type_desc IndexType,
	idx.is_primary_key IsPrimaryKey,
	idx.is_unique IsUnique,
	idx.is_disabled IsDisabled
from sys.indexes idx
join sys.tables tbl
on idx.object_id = tbl.object_id
order by tbl.name, idx.name;


select * from sys.tables;

-- Dynamic Management View (DMV)
-- Provides real-time insights into Database performance and system health

select * from sys.dm_db_index_usage_stats;

select				
	tbl.name IndexName,
	idx.name IndexName,
	idx.type_desc IndexType,
	idx.is_primary_key IsPrimaryKey,
	idx.is_unique IsUnique,
	idx.is_disabled IsDisabled,
	s.user_seeks UserSeeks,
	s.user_scans UserScans,
	s.user_lookups UserLookups,
	s.user_updates UserUpdates,
	coalesce(s.last_user_seek, s.last_user_scan) LastUpdate
from sys.indexes idx
join sys.tables tbl
on idx.object_id = tbl.object_id
left join sys.dm_db_index_usage_stats s
on s.object_id = idx.object_id
and s.index_id = idx.index_id
order by tbl.name, idx.name;

select * from sales.Products
where product = 'Caps';








