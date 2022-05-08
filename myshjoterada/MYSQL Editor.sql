Create procedure shjo_proc(par_1 integer ,par_2 varchar)
BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 10;
  
  for cur_emp as c_emp cursor for 
   Select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id
   DO      
       SET var_cnt_num = var_cnt_num + 1;       
   end for;	
   
   insert into temp_table as Select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id 
END; 



Select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id;
       
       select * from CVS_TD_DB.Temp_employee3 
       
       
       delete CVS_TD_DB.Temp_employee3 ;
       
       commit;
       
       INSERT INTO CVS_TD_DB.Temp_employee3 (employee_id,employee_name,dept_id,position_,salary,dept_name) 
      Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
             from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id ;
     
       
      CREATE MULTISET VOLATILE TABLE CVS_TD_DB.Temp_employee2 as 
(Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id ) 
       with data primary index(employee_id)
       on commit preserve rows;
       
 
       CREATE MULTISET TABLE CVS_TD_DB.Temp_employee3 as 
(Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id and 1=2) 
       with data primary index(employee_id)
       
    
       
       
       SELECT * from DBC.DATABASES
WHERE DATABASENAME='DWHPRO';

       
  SELECT CURRENT_USER;
  
   SELECT DATE (FORMAT 'mm-dd-yy');
   
  SELECT DATE (FORMAT 'mmmbdd,byyyy');
  
  SELECT PROFILE ;
  
  SELECT ROLE;
  
  SELECT USER;
  
    SELECT DATABASE;
  
  SELECT * FROM DBC.ROLEMEMBERS
  
SELECT * FROM DBC.ALLROLERIGHTS



SELECT  UserName,
        CreatorName,
        DefaultDatabase,
        CreateTimeStamp,
        TRIM(TRAILING ',' FROM
            XMLAGG(R.RoleName || ',')(VARCHAR(255))) AS Roles
FROM DBC.UsersV U
LEFT JOIN DBC.RoleMembersV R
ON  U.Username = R.Grantee
WHERE   U.Username NOT IN ('TDPUSER', 'Crashdumps', 'tdwm', 'DBC',
        'LockLogShredder', 'TDMaps', 'Sys_Calendar', 'SysAdmin', 
        'SystemFe', 'External_AP')
GROUP BY    UserName,
            CreatorName,
            DefaultDatabase,
            CreateTimeStamp
ORDER BY U.Username;

GRANT CREATE EXTERNAL PROCEDURE
     ON DATABASE ROOT
     TO CVS_TD_DB;
     
     
     
CREATE MULTISET VOLATILE TABLE Temptable as 
(  Select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id );
       
       
      Select * from CVS_TD_DB.employee e ,
                    CVS_TD_DB.dept d
       where e.dept_id=d.dept_id
       LIMIT 5;
       
       SELECT * FROM FOO, BAR where FOO.A = BAR.A LIMIT 1000;
       
       

L1:
FOR CustCursor AS c_customer CURSOR FOR
  SELECT CustomerNumber AS Number
        ,CustomerName AS Name
        ,(Amount + 10000) a
    FROM customer
DO
  SET hCustNbr = CustCursor.Number;
  SET hCustName = CustCursor.Name;
  SET hAmount = CustCursor.a + CustCursor.a * 0.20;
  INSERT INTO Cust_temp VALUES (hCustNbr, hCustName);
END FOR L1;


CREATE MULTISET VOLATILE TABLE Temptable, 
    NO FALLBACK , 
    NO BEFORE JOURNAL, 
    NO AFTER JOURNAL, 
    CHECKSUM = DEFAULT, 
    DEFAULT MERGEBLOCKRATIO 
        ( 
            Person CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,       
            Claim INTEGER, 
            Start_Date DATE FORMAT 'YY/MM/DD', 
            DaysSupply INTEGER, 
            End_Date DATE FORMAT 'YY/MM/DD' 
        ) 
    ON COMMIT PRESERVE ROWS; 
INSERT INTO Pdc('A',1,'2005-02-17',30,'2005-03-18'); 
INSERT INTO Pdc('A',2,'2005-06-13',30,'2005-07-12'); 
INSERT INTO Pdc('A',3,'2005-08-11',30,'2005-09-09'); 
INSERT INTO Pdc('B',1,'2005-04-21',30,'2005-05-20'); 
INSERT INTO Pdc('B',2,'2005-06-03',30,'2005-07-02'); 
INSERT INTO Pdc('B',3,'2005-07-07',30,'2005-08-05'); 
INSERT INTO Pdc('B',4,'2005-07-30',30,'2005-08-28'); 
INSERT INTO Pdc('B',5,'2005-08-03',30,'2005-09-01'); 

SEL * FROM PDC 
ORDER BY Person, Claim; 


CREATE DATABASE CVS_TD_DB    FROM DBC     AS    PERM = 1000000000;
 
 CREATE TABLE CVS_TD_DB.employee
(
EMPLOYEE_ID VARCHAR(50),
EMPLOYEE_NAME VARCHAR (50),
DEPT_ID INTEGER,
POSITION_ VARCHAR (50),
SALARY INTEGER
);

insert into CVS_TD_DB.EMPLOYEE('AA-567','Donald',1,'Manager',10000);
insert into CVS_TD_DB.EMPLOYEE('AA-568','John',2,'Manager',12000);
insert into CVS_TD_DB.EMPLOYEE('AA-569','Rock',3,'AM',7000);
insert into CVS_TD_DB.EMPLOYEE('AA-570','Bob',1,'AM',7500);

select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
where e.dept_id=d.dept_id;

select * from CVS_TD_DB.dept;


commit;

insert into CVS_TD_DB.dept ('HEALTH',1);


insert into CVS_TD_DB.dept ('REBATES',2);
insert into CVS_TD_DB.dept ('COMP ENGINE',3);
insert into CVS_TD_DB.dept ('FUND',4);
insert into CVS_TD_DB.dept ('BI',5);


insert into CVS_TD_DB.EMPLOYEE('AA-571','Lee',3,'Manager',13000);
insert into CVS_TD_DB.EMPLOYEE('AA-572','Trump',4,'AM',6000);
insert into CVS_TD_DB.EMPLOYEE('AA-573','Johnson',6,'AM',9000);
insert into CVS_TD_DB.EMPLOYEE('AA-573','Brock',7,'Director',20000);
insert into CVS_TD_DB.EMPLOYEE('AA-574','Michael',3,'Manager',13000);
insert into CVS_TD_DB.EMPLOYEE('AA-574','Alex',7,'Director',20000);
insert into CVS_TD_DB.EMPLOYEE('AA-575','Kim',8,'Director',25000);
insert into CVS_TD_DB.EMPLOYEE('AA-576','Ronaldo',9,'Director',29000);
insert into CVS_TD_DB.EMPLOYEE('AA-577','Kim',10,'Executive',3000);
insert into CVS_TD_DB.EMPLOYEE('AA-577','Hobart',7,'Director',30000);
insert into CVS_TD_DB.EMPLOYEE('AA-578','Wiliam',11,'Executive',3000);
insert into CVS_TD_DB.EMPLOYEE('AA-579','Roger',12,'Officer',2000);
insert into CVS_TD_DB.EMPLOYEE('AA-580','Andy',13,'officer',1000);
insert into CVS_TD_DB.EMPLOYEE('AA-581','anderson',14,'officer,);


Commit;


select * from CVS_TD_DB.employee;


 CREATE TABLE CVS_TD_DB.Dept
(
DEPT_NAME VARCHAR (50),
DEPT_ID INTEGER
) PRIMARY INDEX (DEPT_ID);


insert into CVS_TD_DB.Dept('SALES',10);

insert into CVS_TD_DB.Dept('IT',20);

insert into CVS_TD_DB.Dept('MARKETING',30);


commit;

select * from CVS_TD_DB.Dept where DEPT_ID= 10;


replace macro MY_MACRO(DEPTID integer)
as (
select * from cvs_td_db.employee
where DEPT_ID= :DEPTID;

select * from cvs_td_db.Dept
where DEPT_ID= :DEPTID;

);




exec MY_MACRO(10);

select * from  CVS_TD_DB.employee1;

select * from  CVS_TD_DB.employee2;

select * from  CVS_TD_DB.Employee_log;

Syntax error, expected something like ')' between ')' and ';'.

drop table CVS_TD_DB.employee1;

create table CVS_TD_DB.employee2
(
Employee_ID  VARCHAR(10),  
Employee_Name  VARCHAR(10), 
Dept_ID varchar(10),  
Position_  VARCHAR(10), 
salary  varchar(10)
)PRIMARY INDEX employee2(Employee_ID);




select  * from CVS_TD_DB.

SELECT  InfoData AS Version
FROM    DBC.DBCInfoV
WHERE   InfoKey = 'VERSION';

    