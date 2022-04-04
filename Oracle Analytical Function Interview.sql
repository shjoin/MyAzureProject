1222	7890	4-SEP-21 21:21:58
1222	7680	4-SEP-21 21:22:09
1222	2345	4-SEP-21 21:22:22
1222	2345	5-SEP-21 03:09:38

1234	4567	4-SEP-21 21:17:51
1234	2345	4-SEP-21 21:18:08
1234	3456	4-SEP-21 21:18:27
1234	3456	4-SEP-21 21:20:48
1234	4567	4-SEP-21 21:21:08

-- Please provide an SQL query to display the source_phone_number 
-- and a flag where the flag needs to be set to Y if first called 
-- number and last called number are the same and N if the first 
-- called number and last called number are different.

SELECT DISTINCT
    source_phone_number,
    CASE
        WHEN destination_phone_number_first = destination_phone_number_last THEN
            'Y'
        ELSE
            'N'
    END state
FROM
    (
        SELECT
            source_phone_number,
            destination_phone_number,
            call_start_datetime,
            FIRST_VALUE(destination_phone_number)
            OVER(PARTITION BY source_phone_number
                 ORDER BY source_phone_number,
                          call_start_datetime
            )  destination_phone_number_first,
            LAST_VALUE(destination_phone_number)
            OVER(PARTITION BY source_phone_number
                ORDER BY
                    source_phone_number,
                    call_start_datetime
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            )  destination_phone_number_last
        FROM
            phone_log
        ORDER BY
            source_phone_number,
            call_start_datetime
    );
	
	
1234	Y
1222	N


create table Order_amazon
(ORDER_DAY date ,
 ORDER_ID varchar2(10),
 PRODUCT_ID varchar2(10),
 QUANTITY number ,
 PRICE number );
 insert into Order_amazon values (to_date('07/01/2021','mm/dd/yyyy'),'O1','P1',5,12298);
 insert into Order_amazon values (to_date('07/01/2021','mm/dd/yyyy'),'O2','P2',15,14398);
 insert into Order_amazon values (to_date('07/01/2021','mm/dd/yyyy'),'O3','P1',45,6298); 
 insert into Order_amazon values (to_date('07/01/2021','mm/dd/yyyy'),'O4','P3',65,655298);
  
 insert into Order_amazon values (to_date('07/02/2021','mm/dd/yyyy'),'O5','P1',435,5544298);
 
 insert into Order_amazon values (to_date('07/02/2021','mm/dd/yyyy'),'O6','P2',328,55298);
 insert into Order_amazon values (to_date('07/02/2021','mm/dd/yyyy'),'O7','P4',24,67298);
 insert into Order_amazon values (to_date('07/02/2021','mm/dd/yyyy'),'O8','P5',3522,298);
 insert into Order_amazon values (to_date('07/02/2021','mm/dd/yyyy'),'O9','P3',354,98);
 insert into Order_amazon values (to_date('07/02/2021','mm/dd/yyyy'),'O10','P1',335,11298);
 insert into Order_amazon values (to_date('07/02/2021','mm/dd/yyyy'),'O11','P6',145,884298);
 
 
-- Consider an Order Table with the following table structure with some Sample Data:
-- |------------|-----------|------------|----------|--------|
-- |ORDER_DAY   |  ORDER_ID | PRODUCT_ID | QUANTITY | PRICE  |
-- |------------|-----------|------------|----------|--------|
-- |01-JUL-11   |     O1    |     P1     |    5     | 5      |
-- |01-JUL-11   |     O2    |     P2     |    2     | 10     |
-- |01-JUL-11   |     O3    |     P3     |    10    | 25     |
-- |01-JUL-11   |     O4    |     P1     |    20    | 5      |
-- |02-JUL-11   |     O5    |     P3     |    5     | 25     |
-- |02-JUL-11   |     O6    |     P4     |    6     | 20     |
-- |02-JUL-11   |     O7    |     P1     |    2     | 5      |
-- |02-JUL-11   |     O8    |     P5     |    1     | 50     |
-- |02-JUL-11   |     O9    |     P6     |    2     | 50     |
-- |02-JUL-11   |     O10   |     P2     |    4     | 10     |
-- |------------|-----------|------------|----------|--------|
-- 
-- Write SQL to report only the products that were sold on BOTH 01-JUL and 02-JUL and the total number of orders for each.



ORDER_DAY        ORDER_ID PRODUCT_ID   QUANTITY PRICE
5-JUL-21 00:00:00	O1		P1			5		12298
5-JUL-21 00:00:00	O3		P1			45		6298
5-JUL-21 00:00:00	O2		P2			15		14398
5-JUL-21 00:00:00	O4		P3			65		655298

6-JUL-21 00:00:00	O10		P1			335		11298
6-JUL-21 00:00:00	O5		P1			435		5544298
6-JUL-21 00:00:00	O6		P2			328		55298
6-JUL-21 00:00:00	O9		P3			354		98
6-JUL-21 00:00:00	O7		P4			24		67298
6-JUL-21 00:00:00	O8		P5			3522	298
6-JUL-21 00:00:00	O11		P6			145		884298

7-JUL-21 00:00:00	O12		P1			445		65298
7-JUL-21 00:00:00	O13		P4			445		65298

 SELECT
    product_id,   
    COUNT(order_id)
FROM order_amazon
WHERE  product_id IN (
        SELECT product_id
        FROM  order_amazon
        WHERE order_day >= TO_DATE('07/01/2021', 'mm/dd/yyyy')
            AND order_day <= TO_DATE('07/02/2021', 'mm/dd/yyyy')
        GROUP BY product_id
        HAVING  COUNT(DISTINCT trunc(order_day)) > 1 )
    AND order_day >= TO_DATE('07/01/2021', 'mm/dd/yyyy')
    AND order_day <= TO_DATE('07/02/2021', 'mm/dd/yyyy')
GROUP BY product_id  ;

P1	4
P2	2
P3	2

-- Refer to the same above Orders table for the following question. 
-- Write SQL to get, for each product, the total revenue on both days (as adjacent columns).
--
-- Example output:
--
-- product_id | 01_jul_revenue | 02_jul_revenue
-- --------------------------------------------
-- P1         | 125            | 10


SELECT
    product_id, 
    (select sum(QUANTITY * PRICE) from order_amazon b where b.product_id=a.product_id
                                        and  order_day=to_date('07/01/2021','mm/dd/yyyy'))as July01_Revenue,  
    (select sum(QUANTITY * PRICE) from order_amazon b where b.product_id=a.product_id
                              and  order_day=to_date('07/02/2021','mm/dd/yyyy'))as July02_Revenue   
FROM order_amazon a
WHERE  product_id IN (
        SELECT product_id
        FROM  order_amazon
        WHERE order_day >= TO_DATE('07/01/2021', 'mm/dd/yyyy')
            AND order_day <= TO_DATE('07/02/2021', 'mm/dd/yyyy')
        GROUP BY product_id
        HAVING  COUNT(DISTINCT trunc(order_day)) > 1 )
    AND order_day >= TO_DATE('07/01/2021', 'mm/dd/yyyy')
    AND order_day <= TO_DATE('07/02/2021', 'mm/dd/yyyy')
GROUP BY product_id;

P2	215970	18137744
P3	42594370	34692
P1	344900	2415554460

select ename ,deptno,sal,
max(sal) over (PARTITION by deptno) maxSal_dept_wise,
max(sal) over () maxSal_over,
sum(sal) over(order by deptno,ename) cummulative_sum_empwise,
sum(sal) over(PARTITION by deptno order by ename,deptno) cummulative_sum_empwise,
rank () over(order by sal desc nulls first) sal_rank_salWise,
dense_rank () over(order by sal desc nulls first) sal_denserank_salWise,
row_number() over (PARTITION by deptno order by sal ) sal_rownumber_deptwise,
rank () over(PARTITION by deptno order by sal nulls first) sal_rank_deptWise,
dense_rank () over(PARTITION by deptno order by sal nulls first) sal_Denserank_deptWise
from  EMP e  order by deptno,sal;

ENAME	DEPTNO	SAL	MAXSAL_DEPT_WISE	MAXSAL_OVER	CUMMULATIVE_SUM_EMPWISE	CUMMULATIVE_SUM_EMPWISE_1	SAL_RANK_SALWISE	SAL_DENSERANK_SALWISE	SAL_ROWNUMBER_DEPTWISE	SAL_RANK_DEPTWISE	SAL_DENSERANK_DEPTWISE
MILLER	10	1300	5000	5000	8750	8750	9	8	1	1	1
CLARK	10	2450	5000	5000	2450	2450	6	5	2	2	2
KING	10	5000	5000	5000	7450	7450	1	1	3	3	3
SMITH	20	800		3000	5000	19625	10875	14	12	1	1	1
ADAMS	20	1100	3000	5000	9850	1100	12	10	2	2	2
JONES	20	2975	3000	5000	15825	7075	4	3	3	3	3
SCOTT	20	3000	3000	5000	18825	10075	2	2	4	4	4
FORD	20	3000	3000	5000	12850	4100	2	2	5	4	4
JAMES	30	950		2850	5000	25025	5400	13	11	1	1	1
MARTIN	30	1250	2850	5000	26275	6650	10	9	2	2	2
WARD	30	1250	2850	5000	29025	9400	10	9	3	2	2
TURNER	30	1500	2850	5000	27775	8150	8	7	4	4	3
ALLEN	30	1600	2850	5000	21225	1600	7	6	5	5	4
BLAKE	30	2850	2850	5000	24075	4450	5	4	6	6	5


The syntax for the LISTAGG function in Oracle/PLSQL is:

LISTAGG (measure_column [, 'delimiter'])
  WITHIN GROUP (order_by_clause) [OVER (query_partition_clause)]
  
  
  
  

LAST_VALUE (expression) [ {RESPECT | IGNORE} NULLS ])
OVER (
    [ query_partition_clause ] 
    order_by_clause
    [frame_clause]
)

Note that the frame clause:

RANGE BETWEEN UNBOUNDED PRECEDING AND 
              UNBOUNDED FOLLOWING
Code language: SQL (Structured Query Language) (sql)
defines that the window frame starts at the first row and ends at last row of the result set.

FIRST_VALUE	Get the value of the first row in a specified window frame.
LAST_VALUE	Get the value of the last row in a specified window frame.
ROW_NUMBER	Assign a unique sequential integer starting from 1 to each row in a partition or in the whole result
NTH_VALUE	Get the Nth value in a set of values.


https://www.oracletutorial.com/oracle-analytic-functions/


RANK()	OVER ([ query_partition_clause ] order_by_clause)

Another example -->

select * from products order by  list_price desc;

product_id,     product_name,    		standard_cost, list_price category
50				Intel SSDPECME040T401	7123.66			8867.99		5
133	PNY VCQP6000-PB						4058.99			5499.99		2
206	PNY VCQM6000-24GB-PB				3619.14			4139		2
228	Intel Xeon E5-2699 V3 (OEM/Tray)	2867.51			3410.46		1
207	PNY VCQM6000-PB						2505.04			3254.99		2
110	ATI FirePro W9000					2785.55			3192.97		2
235	Hitachi A7K1000-1000				29.94			41.99		5
256	Western Digital WD5000AACS			20.14			26.99		5
56	Western Digital WD2500AAJS			15.23			16.99		5
94	Western Digital WD2500AVVS			12.63			15.55		5

QUEST-> returns the product id, product name, list price, and the name of the product that has the highest list price:

