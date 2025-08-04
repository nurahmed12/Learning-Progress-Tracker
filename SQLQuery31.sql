-- Unique Index 

select * from sales.Products;

-- Make sure the column that you use has no duplicate
create unique nonclustered index idx_Products_PK
on sales.products (ProductID);

create unique nonclustered index idx_Products_Product
on sales.products (Product);

-- Inserting duplicate values to PK and Product are not allowed from now
insert into sales.Products (ProductID, Product) 
values (106, 'Gloves');

delete from sales.products
where productid = 106;

