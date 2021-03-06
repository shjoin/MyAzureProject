       SELECT * from DBC.DATABASES
WHERE DATABASENAME='DWHPRO';


need to execute in dbc user -->
MODIFY USER shjoin AS      
       SPOOL = 3000 bytes;
       
       MODIFY [PROFILE profile_name | USER user_name ] AS SPOOL = 100000000 bytes ;
       
       
       
SELECT vproc AS
"AMP", TableName (FORMAT 'X(20)'), CurrentPerm
FROM DBC.TableSizeV
WHERE DatabaseName = 'CVS_TD_DB'
ORDER BY TableName, "AMP" ;
 
SELECT
  *
FROM DBC.TableSizeV
WHERE DatabaseName = 'shjoin' LIMIT 1;



BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 10;
  
  for cur_emp as c_emp cursor for 
   Select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id
   DO      
       SET var_cnt_num = var_cnt_num + 1;       
   end for;	
END ; 


CREATE MULTISET VOLATILE TABLE Temptable as 
(Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id ) 
       with data primary index(employee_id)
       on commit preserve rows;
       

       select * from DBC.AllTempTables where upper(tvmName)= upper('Temptable');
       
       select * from DBC.Tables where upper(tableName)= upper('employee');
       
       select t.* from Temptable t;
       
 CREATE MULTISET TABLE CVS_TD_DB.TARGET_TABLE 
  (
     SNO INTEGER GENERATED BY DEFAULT AS IDENTITY
       (START WITH 1
        INCREMENT BY 20) ,
   NAME VARCHAR(20) NOT NULL
  ) UNIQUE PRIMARY INDEX pidx (SNO);
  
  
  select * from CVS_TD_DB.TARGET_TABLE;

  insert into CVS_TD_DB.target_table (1,'shailendra');
  
  
  select
    coalesce((select max(dept_id) from CVS_TD_DB.dept),0)
    , row_number() over (order by employee_id)
-- , t.*
from CVS_TD_DB.employee as t;

select * from CVS_TD_DB.employee_log;

select salary from CVS_TD_DB.employee where dept_id in (3)
group by employee_id;

select avg(salary) from CVS_TD_DB.employee where dept_id in (3)
group by employee_id;


select * from CVS_TD_DB.dept;

select * from CVS_TD_DB.temp1;

select employee_id , Employee_name , Dept_id , Position_ , salary  from CVS_TD_DB.employee;

select * from CVS_TD_DB.temp2;

select * from CVS_TD_DB.employee2;

create table CVS_TD_DB.employee2 as
  (select a.* from CVS_TD_DB.employee a) with no data ;
  

select cast(employee_ID as char(10)),cast(employee_name as char(10)),CAST(dept_id as char(10)),
CAST(Position_ as char(10)),CAST(salary as char(10))
from CVS_TD_DB.employee;


https://docs.teradata.com/r/Teradata-Tools-and-Utilities-Access-Module-Reference/November-2020/Teradata-Access-Module-for-OLE-DB/Loading-and-Exporting-at-the-Command-Prompt/Starting-an-Access-Module-Export-Job-Without-Teradata-OleLoad/Exporting-from-Teradata-Database-Using-FastExport



https://docs.teradata.com/r/Basic-Teradata-Query-Reference/October-2018/Introduction-to-BTEQ/Overview-of-BTEQ


https://docs.teradata.com/r/Teradata-Database-Data-Dictionary/June-2017/Data-Dictionary-Views/Types-of-Views/Compatibility-Views

