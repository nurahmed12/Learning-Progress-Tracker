-- Compare the Storage difference among all three structures of ColumnStore (Heap, RowStore, ColumnStore)

use AdventureWorksDW2022

-- Heap
-- Creating new table for the Heap
-- Since we did not define any clustered index, it will be Heap by default
select *
into FactInternetSales_HP
from FactInternetSales; 

-- RowStore
select *
into FactInternetSales_RS
from FactInternetSales;

create clustered index idx_FactInternetSales_RS_PK
on FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber);

-- ColumnStore

-- Clustered
select *
into FactInternetSales_CS
from FactInternetSales;

create clustered columnstore index idx_FactInternetSales_CS_PK
on FactInternetSales_CS;

-- Non-Clustered
select *
into FactInternetSales_CS_N
from FactInternetSales;

create nonclustered columnstore index idx_FactInternetSales_CS_N_PK
on FactInternetSales_CS_N (SalesOrderNumber);








