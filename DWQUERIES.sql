-- �������� ���� �������� ��� ���� (1=������ 2=�������).

Select sex, sum(cost) 
   from customers, sales 
 where customers.customer_id=sales.customer_id
 group by sex

-- �������� ���� ��� �������� ��� �������.

Select location_code, sum(cost) 
   from stores, sales where stores.storecode=sales.storecode
   group by location_code  

-- �������� ����� ��� ������ ��������� ��������� ��������� (brand_code).  

Select brand_code, sum(profit) 
   from products, sales where products.product_id=sales.product_id
  group by brand_code

-- �������� ���� �������� ��� ������ ��� ����� 1998 ��� ����. 

select t_month, sum(cost), sum(profit) 
      from timeinfo, sales 
  where timeinfo.time_key = sales.time_key and t_year=1998
      group by t_month
	  order by t_month

-- �������� ���� ��� ��������  ��� ����, ������� ��� ����� ��� ���������.

select t_year, location_code, t_dayofweek, sum(cost)
      from timeinfo, stores, sales 
  where timeinfo.time_key = sales.time_key and 
        stores.storecode=sales.storecode 
      group by   t_year, location_code, t_dayofweek 
	  order by t_year, location_code, t_dayofweek

-- ������� �������� ��� ���� �� ���� ���������� ��� 20000.

create view v1 as 
select t_year, receipt_no, sum(cost) as cost
      from timeinfo, sales 
  where timeinfo.time_key = sales.time_key 
      group by   t_year, receipt_no 
	  having sum(cost) > 20000
	  
	  

select t_year, count(*) from v1 group by t_year

-- ROLLUP
-- ������� ������ ��� ����, ������� ��� ��������� (cat2) ���������
select t_year, location_code, cat2, sum(profit)   
  from timeinfo, stores, products, sales 
  where timeinfo.time_key=sales.time_key and 
        stores.storecode=sales.storecode and 
		products.product_id=sales.product_id
  group by ROLLUP (t_year, location_code, cat2)
  
-- CUBE 

-- ������� ������ ��� ����, ������� ��� ��������� (cat2) ���������
select t_year, location_code, cat2, sum(profit)   
  from timeinfo, stores, products, sales 
  where timeinfo.time_key=sales.time_key and 
        stores.storecode=sales.storecode and 
		products.product_id=sales.product_id
  group by CUBE (t_year, location_code, cat2)
  