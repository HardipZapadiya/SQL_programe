use salesdb;

select * from sales.orders;

--single window function in query
select *,sum(orderid) over(partition by productid) from sales.orders;

--multiple window function in query

select * ,sum(orderid) over (partition by productid) Total_product_Sales,
sum(orderid) over() as Total_Sales
from sales.orders;


/*
order by ---- sort the data within window
order by ---- optional for aggregate function , required for rank and value function

*/

select orderstatus,orderid,productid,sales,rank() over(order by sales) as All_order_rank,
rank() over(partition by productid order by  sales) as rank_of_order_within_product
from sales.orders; 


--frame clause

--frame for aggregation sum(currentrow + 1 next row)
-- lower value (current row)  --upper value(1 following)
select orderid,productid,sales, 
sum(sales) over(order by sales rows between current row and 1 following )
from sales.orders;

--frame for sum(current row + ... + up to last row)
select orderid,productid,sales, 
sum(sales) over(order by sales rows between current row and unbounded following) as qwe
from sales.orders
;

--frame for sum(1 preceding +current row)
select orderid,productid,sales, 
sum(sales) over(order by sales rows between  1 preceding and  current  row )
from sales.orders;

---unbounded preceding,current row
--aggregate with all row present above current row and current row
--default frame

select orderid,productid,sales,
sum(sales) over (order by sales rows between unbounded preceding and current row)
from sales.orders;

---1 preceding , 1 following
select orderid,productid,sales,
sum(sales) over (order by sales rows between 1 preceding and 1 following)
from sales.orders;

---include all
-- unbounded preceding and following
select orderid,productid,sales,
sum(sales) over (order by sales rows between unbounded preceding and unbounded following)
from sales.orders;


