use salesdb;
select * from sales.Orders;

--total sales
select sum(sales) Total_Sales from sales.Orders;
--group by product id , total sales of each product

select productid,sum(sales) as totalSales 
from sales.Orders 
group by ProductID;


--window function 
--total sales of each product with all details

select orderid,productid,Sales as  orderSale, avg(sales) over(partition by productid) [Total Sales]
from sales.Orders ;


---order by in window function
--partion by col1 (generate unique windows with same col1)
--order by order record within window

select productid ,sales as ordersale ,rank() over(partition by productid order by sales desc)  as rankofsales,sum(sales) over(partition by productid) as TotalSales 
from sales.orders;