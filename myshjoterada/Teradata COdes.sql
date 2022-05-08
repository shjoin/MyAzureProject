  Working fine -->
  https://docs.teradata.com/r/GVKfXcemJFkTJh_89R34UQ/ZA5BdXxlxaleZUFk9gUeVg
  
  
   create  procedure CVS_TD_DB.shjo_proc_6( OUT out_Rowcnt INTEGER,
                                          in inSalary DEC(10,2),
                                          IN in_dept_name varchar(50),
                                          IN inFlag varchar(1))
  Lmain: BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 100;
    DECLARE cur_employee_id VARCHAR(50);
    DECLARE cur_employee_name VARCHAR(50);
    DECLARE cur_dept_id INTEGER DEFAULT 0;
    DECLARE cur_position_ VARCHAR(50);
    DECLARE cur_salary INTEGER DEFAULT 0;
    DECLARE cur_dept_name VARCHAR(50);	
	DECLARE Loop_cnt INTEGER DEFAULT 1;
	DECLARE cnter INTEGER DEFAULT 1;
	DECLARE DB_Name varchar(20); 
	DECLARE col_Name varchar(20);
	DECLARE tab_Name varchar(20);
	DECLARE SqlStr varchar(200);
	DECLARE UpdStr varchar(200);
	--DECLARE price_read DECIMAL(8,2);
    --DECLARE sql_stmt VARCHAR(100);
	DECLARE C1 CURSOR FOR S1;
	SET DB_Name = 'CVS_TD_DB';
	SET col_Name = 'Salary';
	SET tab_Name = 'Temp_employee3';
	
	  
    SET SqlStr = 'SELECT count(*) FROM '|| DB_Name || '.'||tab_Name || ' where Dept_name = ?;';    
    SET UpdStr = 'update '|| DB_Name || '.'||tab_Name ||' SET '||col_Name ||' =  ? where dept_name = ?;' ;    
    --https://docs.teradata.com/r/Teradata-VantageTM-SQL-Stored-Procedures-and-Embedded-SQL/March-2019/SQL-Cursor-Control-and-DML-Statements/EXECUTE
   
    if inFlag = 'U' Then
      PREPARE S2 FROM UpdStr;      
      EXECUTE S2 USING inSalary, in_dept_name;    
      --EXECUTE IMMEDIATE UpdStr;
    ELSEIF inFlag='S' then
      PREPARE S1 FROM SqlStr;
      OPEN C1 USING in_dept_name;
      FETCH C1 INTO out_Rowcnt;    
      CLOSE C1;
    END IF;    
  END Lmain;
  
  
   
  update CVS_TD_DB.Temp_employee3  
  set dept_name ='Marketing'
  where dept_id =3;
 
       select * from CVS_TD_DB.Temp_employee3 ;
	   
	   
 CALL CVS_TD_DB.shjo_proc_6(:rowCount,5678.98,'Marketing','S');
 
 Outup is 3
 
  CALL CVS_TD_DB.shjo_proc_6(:rowCount,5678.98,'Marketing','U');
  
  updated 
 
 
  
   Replace procedure CVS_TD_DB.shjo_proc_5(-- OUT out_batch_no INTEGER,
 OUT outSalary DEC(10,2),
 IN in_dept_name varchar(50))
  Lmain: BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 100;
    DECLARE cur_employee_id VARCHAR(50);
    DECLARE cur_employee_name VARCHAR(50);
    DECLARE cur_dept_id INTEGER DEFAULT 0;
    DECLARE cur_position_ VARCHAR(50);
    DECLARE cur_salary INTEGER DEFAULT 0;
    DECLARE cur_dept_name VARCHAR(50);	
	DECLARE Loop_cnt INTEGER DEFAULT 1;
	DECLARE cnter INTEGER DEFAULT 1;
	--DECLARE cursor_emp CURSOR FOR Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
   --          from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
    --                     where e.dept_id=d.dept_id ORDER BY 1 FOR READ ONLY;
                         
    -- SELECT count(*) INTO Loop_cnt  from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
     --                    where e.dept_id=d.dept_id;                    
    --DECLARE US_STATES_DETAILS CURSOR WITH RETURN ONLY FOR SEL * FROM US_STATES;
   for cur_emp as c_emp cursor for Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
                                      from CVS_TD_DB.employee e ,CVS_TD_DB.dept d where e.dept_id=d.dept_id
   DO                      	 
	  -- FETCH cursor_emp INTO cur_employee_id,cur_employee_name,cur_dept_id,cur_position_,cur_salary,cur_dept_name;
	  --FETCH NEXT from cursor_emp into cur_employee_id,cur_employee_name,cur_dept_id,cur_position_,cur_salary,cur_dept_name;
       
        INSERT INTO CVS_TD_DB.Temp_employee3 (employee_id,employee_name,dept_id,position_,salary,dept_name,btach_no)
        values (cur_emp.employee_id,cur_emp.employee_name,cur_emp.dept_id,cur_emp.position_,cur_emp.salary,:in_dept_name,var_cnt_num);
	    SET Loop_cnt = Loop_cnt + 1 ;
	    SET cnter = cnter + 1 ;
	END FOR;
	--set out_batch_no = var_cnt_num;
	SET outSalary = 500.67;
	--Commit;Unfortunately COMMIT will close the outer cursor. I
    --CLOSE cursor_emp;
  END Lmain;
  
  
  
  CALL CVS_TD_DB.shjo_proc_5(:Salary,'Sales');
runs in teradat studio and we can see the output like this 

outSalary
500.67

    
     select * from CVS_TD_DB.Temp_employee3 ;
        
        delete CVS_TD_DB.Temp_employee3 ;

commit;






   Replace procedure CVS_TD_DB.shjo_proc_5(-- OUT out_batch_no INTEGER,
 IN in_dept_name varchar(50))
  Lmain: BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 100;
    DECLARE cur_employee_id VARCHAR(50);
    DECLARE cur_employee_name VARCHAR(50);
    DECLARE cur_dept_id INTEGER DEFAULT 0;
    DECLARE cur_position_ VARCHAR(50);
    DECLARE cur_salary INTEGER DEFAULT 0;
    DECLARE cur_dept_name VARCHAR(50);	
	DECLARE Loop_cnt INTEGER DEFAULT 1;
	DECLARE cnter INTEGER DEFAULT 1;
	--DECLARE cursor_emp CURSOR FOR Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
   --          from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
    --                     where e.dept_id=d.dept_id ORDER BY 1 FOR READ ONLY;
                         
    -- SELECT count(*) INTO Loop_cnt  from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
     --                    where e.dept_id=d.dept_id;                    
    --DECLARE US_STATES_DETAILS CURSOR WITH RETURN ONLY FOR SEL * FROM US_STATES;
   for cur_emp as c_emp cursor for Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
                                      from CVS_TD_DB.employee e ,CVS_TD_DB.dept d where e.dept_id=d.dept_id
   DO                      	 
	  -- FETCH cursor_emp INTO cur_employee_id,cur_employee_name,cur_dept_id,cur_position_,cur_salary,cur_dept_name;
	  --FETCH NEXT from cursor_emp into cur_employee_id,cur_employee_name,cur_dept_id,cur_position_,cur_salary,cur_dept_name;
       
        INSERT INTO CVS_TD_DB.Temp_employee3 (employee_id,employee_name,dept_id,position_,salary,dept_name,btach_no)
        values (cur_emp.employee_id,cur_emp.employee_name,cur_emp.dept_id,cur_emp.position_,cur_emp.salary,:in_dept_name,var_cnt_num);
	    SET Loop_cnt = Loop_cnt + 1 ;
	    SET cnter = cnter + 1 ;
	END FOR;
	--set out_batch_no = var_cnt_num;
	--Commit;Unfortunately COMMIT will close the outer cursor. I
    --CLOSE cursor_emp;
  END Lmain;
  
  
  
  CALL CVS_TD_DB.shjo_proc_5('Sales');
    
     select * from CVS_TD_DB.Temp_employee3 ;
        
        delete CVS_TD_DB.Temp_employee3 ;
		
		
		
		
		
  
  
  Replace  procedure CVS_TD_DB.shjo_proc_2()
  Lmain: BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 100;
    DECLARE cur_employee_id VARCHAR(50);
    DECLARE cur_employee_name VARCHAR(50);
    DECLARE cur_dept_id INTEGER DEFAULT 0;
    DECLARE cur_position_ VARCHAR(50);
    DECLARE cur_salary INTEGER DEFAULT 0;
    DECLARE cur_dept_name VARCHAR(50);	
	DECLARE Loop_cnt INTEGER DEFAULT 1;
	DECLARE cnter INTEGER DEFAULT 1;
	DECLARE cursor_emp CURSOR FOR Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
             from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id ORDER BY 1 FOR READ ONLY;
                         
     SELECT count(*) INTO Loop_cnt  from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id;                    
    --DECLARE US_STATES_DETAILS CURSOR WITH RETURN ONLY FOR SEL * FROM US_STATES;                     
	 OPEN cursor_emp;	 
	 while (cnter <= 5)
     Do
	   FETCH cursor_emp INTO cur_employee_id,cur_employee_name,cur_dept_id,cur_position_,cur_salary,cur_dept_name;
	  --FETCH NEXT from cursor_emp into cur_employee_id,cur_employee_name,cur_dept_id,cur_position_,cur_salary,cur_dept_name;
       
        INSERT INTO CVS_TD_DB.Temp_employee3 (employee_id,employee_name,dept_id,position_,salary,dept_name,btach_no)
        values (cur_employee_id,cur_employee_name,cur_dept_id,cur_position_,cur_salary,cur_dept_name,var_cnt_num);
	    SET Loop_cnt = Loop_cnt + 1 ;
	    SET cnter = cnter + 1 ;
	END WHILE;
	--Commit;Unfortunately COMMIT will close the outer cursor. I
    CLOSE cursor_emp;
  END Lmain;
  
    CALL CVS_TD_DB.shjo_proc_2();
    
     select * from CVS_TD_DB.Temp_employee3 ;
        
        delete CVS_TD_DB.Temp_employee3 ;
		
		
		
		
		
****************************************************		
  
  
  
  
  Replace  procedure CVS_TD_DB.shjo_proc_3()
  Lmain: BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 100;
    DECLARE cur_employee_id INTEGER DEFAULT 0;
    DECLARE cur_employee_name INTEGER DEFAULT 0;
    DECLARE cur_dept_id INTEGER DEFAULT 0;
    DECLARE cur_position_ INTEGER DEFAULT 0;
    DECLARE cur_salary INTEGER DEFAULT 0;
    DECLARE cur_dept_name INTEGER DEFAULT 0;
	DECLARE rec_cnt INTEGER DEFAULT 0;
	delete CVS_TD_DB.Temp_employee3 ;
        
        INSERT INTO CVS_TD_DB.Temp_employee3 (employee_id,employee_name,dept_id,position_,salary,dept_name) 
          Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
             from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id ;
         commit;
  END Lmain; 
  
  CALL CVS_TD_DB.shjo_proc_3();
  
     select * from CVS_TD_DB.Temp_employee3 ; 
  
  
  
  
  
  
  CREATE MULTISET TABLE CVS_TD_DB.Temp_employee3 as 
(Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id and 1=2) 
       with data primary index(employee_id)
	   
	   
	   
	   
	    INSERT INTO CVS_TD_DB.Temp_employee3 (employee_id,employee_name,dept_id,position_,salary,dept_name) 
      Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
             from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id ;
						 
						 
	     select * from CVS_TD_DB.Temp_employee3 
		 


https://docs.teradata.com/r/Teradata-VantageTM-SQL-Stored-Procedures-and-Embedded-SQL/March-2019/SQL-Cursor-Control-and-DML-Statements/DECLARE-CURSOR-Stored-Procedures-Form




need to execute in dbc user -->
MODIFY USER shjoin AS      
       SPOOL = 3000 bytes;


REPLACE procedure shjo_proc_1( OUT out_batch_no INTEGER,IN in_dept_name varchar)
  Lmain: BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 100;
    DECLARE cur_employee_id INTEGER DEFAULT 0;
    DECLARE cur_employee_name INTEGER DEFAULT 0;
    DECLARE cur_dept_id INTEGER DEFAULT 0;
    DECLARE cur_position_ INTEGER DEFAULT 0;
    DECLARE cur_salary INTEGER DEFAULT 0;
    DECLARE cur_dept_name INTEGER DEFAULT 0;
	DECLARE rec_cnt INTEGER DEFAULT 0;
	DECLARE cursor_emp CURSOR FOR Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
             from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id ORDER BY 1;
    --DECLARE US_STATES_DETAILS CURSOR WITH RETURN ONLY FOR SEL * FROM US_STATES;                     
	 OPEN cursor_emp;
	 label1:
	 
	 LOOP
	   FETCH cursor_emp INTO cur_employee_id,cur_employee_name,cur_dept_id,cur_position_,cur_salary,cur_dept_name;
	   IF (SQLSTATE = '02000') THEN
          LEAVE label1;
       END IF;
        SET var_cnt_num = var_cnt_num + 1; 
        INSERT INTO CVS_TD_DB.Temp_employee3 (employee_id,employee_name,dept_id,position_,salary,dept_name,btach_no) 
        values (cur_employee_id,cur_employee_name,cur_dept_id,cur_position_,cur_salary,:in_dept_name,var_cnt_num);
	   
	END LOOP label1;
       CLOSE cursor_emp;
  END Lmain; 
  



  
	   
Create procedure shjo_proc_1( OUT out_batch_no INTEGER,IN in_dept_name varchar)
  Lmain: BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 100;
	 DECLARE rec_cnt INTEGER DEFAULT 0;
	 DECLARE cursor_emp CURSOR FOR Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
             from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id ORDER BY 1;
	 OPEN cursor_emp;
	 label1:
	 
	 LOOP
	   FETCH cursor_emp INTO cur;
	   IF (SQLSTATE = ‘02000’) THEN
          LEAVE label1;
       END IF;
	   SET var_cnt_num = var_cnt_num + 1; 
	END LOOP label1;
       CLOSE cursor_emp;

  
  SELECT COUNT(*) INTO rec_cnt  FROM CVS_TD_DB.Temp_employee3;
  
  for cur_emp as c_emp cursor for 
   Select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id
   DO      
       SET var_cnt_num = var_cnt_num + 1;       
   end for;	
END Lmain; 





	   
REPLACE procedure shjo_proc( OUT oBranchId INTEGER,IN par_1 integer ,IN par_2 varchar)
Lmain: BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 10;
  
  for cur_emp as c_emp cursor for  Select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d where e.dept_id=d.dept_id
   DO      
       SET var_cnt_num = var_cnt_num + 1;       
   end for;	
   
END Lmain;


        alter table  CVS_TD_DB.Temp_employee3 add Btach_no integer;
		
		
	
CREATE PROCEDURE spsample1()
BEGIN
  L1: BEGIN
      DECLARE vname CHARACTER(30);
      DECLARE vamt INTEGER;
      DECLARE empcursor CURSOR FOR
        SELECT empname, salary
        FROM empdetails
        ORDER BY deptcode;
      DECLARE deptcursor CURSOR FOR
        SELECT deptname
        FROM department;
      DECLARE CONTINUE HANDLER FOR SQLSTATE '42000'
        BEGIN
          OPEN empcursor;
          ...
        END;
        ...
        ...
  END L1;
END;


	
	   ERRORS CODE -->
	   https://docs.teradata.com/r/GVKfXcemJFkTJh_89R34UQ/p7JSGaoifnvRQk0~ioJ9Cg
	   
	   
***********************************************************************************************************MY CODE END********************************************************************************************	   
CREATE PROCEDURE sp_QrRnTables()

BEGIN

DECLARE varTableOldName VARCHAR(500);
DECLARE varTableNewName VARCHAR(500);
DECLARE vardbName VARCHAR(100);
DECLARE varIDCod VARCHAR(5);
DECLARE varRename VARCHAR(100);
DECLARE varCt INT DEFAULT 0;
    
DECLARE renameTables CURSOR 
FOR
    
    SELECT
        nomeDB
        ,nomeTabela
    FROM (
        SELECT
            DatabaseName AS nomeDB
            ,TableName AS nomeTabela
            ,LastAccessTimeStamp AS dtUltimoAcesso
            ,(CURRENT_DATE - CAST(LastAccessTimeStamp AS DATE)) AS diasSemAcesso
        FROM
            DBC.TablesV
        WHERE
            1=1
            AND TableKind = 'T'
            AND DatabaseName IN ('P_BACKUP')
        GROUP BY
            DatabaseName
            ,TableName
            ,LastAccessTimeStamp
            ,LastAlterTimeStamp
    ) tbHig
    WHERE diasSemAcesso IS NULL OR diasSemAcesso >= 180
    ORDER BY nomeDB, nomeTabela

FOR READ ONLY;

OPEN renameTables;

    FETCH NEXT FROM renameTables INTO vardbName, varTableOldName;

    WHILE (SQLCODE = 0)
    
        DO
        
        SET varTableNewName = vardbName || '.' || vardbName || '_V' || CAST(EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS VARCHAR(20)) || '_' || CAST(varCt AS VARCHAR(20));
    
        SET varTableOldName = vardbName || '.' || varTableOldName;
    
        SET varRename = 'RENAME TABLE ' || varTableOldName || ' TO ' || varTableNewName;
        
        EXECUTE IMMEDIATE varRename;
    
        SET varCt = varCt + 1;
    
        FETCH NEXT FROM renameTables INTO vardbName, varTableOldName;
        
    END WHILE;

CLOSE renameTables;

END;

In the past I adapted a cursor I have in a stored procedure on SQL Server to Teradata but Im having some troubles trying to use. My procedure code is:

CREATE PROCEDURE sp_QrRnTables()

BEGIN

DECLARE varTableOldName VARCHAR(500);
DECLARE varTableNewName VARCHAR(500);
DECLARE vardbName VARCHAR(100);
DECLARE varIDCod VARCHAR(5);
DECLARE varRename VARCHAR(100);
DECLARE varCt INT DEFAULT 0;
    
DECLARE renameTables CURSOR 
FOR
    
    SELECT
        nomeDB
        ,nomeTabela
    FROM (
        SELECT
            DatabaseName AS nomeDB
            ,TableName AS nomeTabela
            ,LastAccessTimeStamp AS dtUltimoAcesso
            ,(CURRENT_DATE - CAST(LastAccessTimeStamp AS DATE)) AS diasSemAcesso
        FROM
            DBC.TablesV
        WHERE
            1=1
            AND TableKind = 'T'
            AND DatabaseName IN ('P_BACKUP')
        GROUP BY
            DatabaseName
            ,TableName
            ,LastAccessTimeStamp
            ,LastAlterTimeStamp
    ) tbHig
    WHERE diasSemAcesso IS NULL OR diasSemAcesso >= 180
    ORDER BY nomeDB, nomeTabela

FOR READ ONLY;

OPEN renameTables;

    FETCH NEXT FROM renameTables INTO vardbName, varTableOldName;

    WHILE (SQLCODE = 0)
    
        DO
        
        SET varTableNewName = vardbName || '.' || vardbName || '_V' || CAST(EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS VARCHAR(20)) || '_' || CAST(varCt AS VARCHAR(20));
    
        SET varTableOldName = vardbName || '.' || varTableOldName;
    
        SET varRename = 'RENAME TABLE ' || varTableOldName || ' TO ' || varTableNewName;
        
        EXECUTE IMMEDIATE varRename;
    
        SET varCt = varCt + 1;
    
        FETCH NEXT FROM renameTables INTO vardbName, varTableOldName;
        
    END WHILE;

CLOSE renameTables;




END;
The goal is is to collect the names of a series of tables and rename them using the cursor logic. Something like this: If I have three tables on my database "myTableA", "myTableB", "myTableC", by the cursor logic I hope these are renamed to "P_BACKUP_V2021_0", "P_BACKUP_V2021_1", "P_BACKUP_V2021_2".

The problem happens when I try to call the procedure. Only the first line of execution works and then an error is apparently returned when the cursor tries to continue its execution:

Executed as Single statement. Failed [3722 : HY000] SP_QRRNTABLES:Only a COMMIT WORK or null statement is legal after a DDL Statement.
Elapsed time = 00:00:05.668
 
STATEMENT 1: Unknown failed




Example: Using EXECUTE IMMEDIATE
CREATE PROCEDURE sales_update(store_table VARCHAR(10),
							     item INTEGER,
							     price DECIMAL(8,2) )
		BEGIN
			DECLARE sql_stmt VARCHAR(100);
			SET
			SET sql_stmt = 'UPDATE ' || store_table ||  ' SET store_price=' || price ||
					' WHERE store_item =' || item;
			EXECUTE IMMEDIATE sql_stmt;
    END;
	
	
	

Example: Opening the Cursor
The following CLOSE example is valid because the cursor identified by cursor name projcursor is OPEN before the CLOSE.

CREATE PROCEDURE sp1 (OUT par1 INTEGER, OUT Par2 CHAR(30))
BEGIN
  DECLARE projcursor CURSOR FOR
    SELECT *
    FROM project
    ORDER BY projid;
  OPEN projcursor;
  Label1:
  LOOP:
    FETCH projcursor INTO par1, par2;
    IF (SQLSTATE = '02000') THEN
      LEAVE label1;
    END IF;
  END LOOP label1;
  CLOSE projcursor;
END;
Example: Closing the Cursor
In the following example, CLOSE explicitly closes projcursor. The empcursor cursor is OPEN and there is no explicit CLOSE. In this case, empcursor closes implicitly when the stored procedure terminates.

CREATE PROCEDURE sp1 (IN par1 CHAR(5))
BEGIN
  DECLARE projcursor CURSOR FOR
    SELECT *
    FROM project
    ORDER BY projid;
  DECLARE empcursor CURSOR FOR
    SELECT *
    FROM employee
    WHERE dept_code = par1;
  OPEN projcursor;
  OPEN empcursor;
  CLOSE projcursor;
END;

Example: Using Dynamic SQL Statements in a Stored Procedure
The following example illustrates the use of dynamic SQL statements in a stored procedure defined without a WITH RETURN clause.

CREATE PROCEDURE GetEmployeeSalary
(IN EmpName VARCHAR(100), OUT Salary DEC(10,2))
BEGIN
  DECLARE SqlStr VARCHAR(1000);
  DECLARE C1 CURSOR FOR S1;
  SET SqlStr = 'SELECT Salary FROM EmployeeTable WHERE EmpName = ?';
  PREPARE S1 FROM SqlStr;
  OPEN C1 USING EmpName;
  FETCH C1 INTO Salary;
  CLOSE C1;
END;
Example: Using the Dynamic Form of the DECLARE CURSOR Statement
The following example illustrates the dynamic form of the DECLARE CURSOR statement. The cursor statement specifies a result cursor with a dynamic SELECT.

DECLARE statement1_str VARCHAR(500);
DECLARE result_set CURSOR WITH RETURN ONLY FOR stmt1;

SET statement1_str = 'SELECT store, item, on_hand FROM inventory ORDER BY store, item;'
PREPARE stmt1 FROM statement1_str;
OPEN result_set;
Example: Using a Dynamic Parameter Marker
The following example illustrates the use of a dynamic parameter marker. The data for the dynamic parameter marker is passed in the OPEN statement.

DECLARE Store_num INTEGER;
DECLARE statement1_str VARCHAR(500);
DECLARE result_set CURSOR WITH RETURN ONLY FOR stmt1;

SET statement1_str = 'SELECT store, item, on_hand'
               ' FROM inventory WHERE store = ? ORDER BY store, item;'
PREPARE stmt1 FROM statement1_str;
SET Store_num = 76;
OPEN result_set USING Store_num;



DECLARE Store_num INTEGER;
DECLARE statement1_str VARCHAR(500);
DECLARE result_set CURSOR WITH RETURN ONLY FOR stmt1;

SET statement1_str = 'SELECT store, item, on_hand'
               ' FROM inventory WHERE store = ? ORDER BY store, item;'
PREPARE stmt1 FROM statement1_str;
SET Store_num = 76;
OPEN result_set USING Store_num;


https://docs.teradata.com/r/Teradata-VantageTM-SQL-Stored-Procedures-and-Embedded-SQL/March-2019/SQL-Cursor-Control-and-DML-Statements/FETCH-Stored-Procedures-Form


CREATE PROCEDURE sp1()
BEGIN
  DECLARE var1 INTEGER;
  DECLARE var2 CHARACTER(30)
  DECLARE projcursor CURSOR FOR
    SELECT projid, projectdesc
    FROM project
    ORDER BY projid;
  OPEN projcursor;
   WHILE (SQLCODE=0)
   DO
    FETCH projcursor INTO var1, var2;
   END WHILE;
  CLOSE projcursor;
END;

https://docs.teradata.com/r/Teradata-VantageTM-SQL-Stored-Procedures-and-Embedded-SQL/March-2019/SQL-Cursor-Control-and-DML-Statements/FETCH-Stored-Procedures-Form


REPLACE PROCEDURE samplesp1 (IN pAccountNo INTEGER, OUT pAmount DECIMAL (10,2))
   BEGIN
      /* SPL Statements*/
      SELECT : Amount
      INTO : pAmount
      FROM : Account1 WHERE
      aCCTnO = :pAccountNo;
   END;
   
   
    CALL samplesp1 (8888, pAmount);
	
	Use a text editor to include a stored procedure in a BTEQ script or input stream file. To execute the procedure samplesp1 from a script, for example, enter the Teradata SQL CALL statement after the LOGON statement in the script:

   .LOGON tdpid/userid, password
   CALL samplesp1 (8888, pAmount);
   .LOGOFF
   
   https://docs.teradata.com/r/1fdhoBglKXYl~W_OyMEtGQ/lcA~5zcOCgd063Jdd4UYiQ
   
   
   
   CREATE PROCEDURE sp2 (OUT po1 INTEGER)
     BEGIN
       SET :po1 = 20;
     END;
	 
	 
	 In the following CALL statement, the OUT argument name p1 differs from the OUT parameter name po1 specified in the procedure definition:

     CALL sp2(p1);
 
      *** Procedure has been executed.
      *** Total elapsed time was 1 second.
	  
	  CREATE PROCEDURE prio2()
     BEGIN
       INSERT INTO temp(1, 'stored procedure before prio1') /* STMT1 */;
       CALL prio1()                                         /* STMT2 */;
       INSERT INTO temp(2, 'stored procedure after prio1')  /* STMT3 */;
     END;
	 
	 
	 
	 Executing Stored Procedures
Execute stored procedures either interactively, or include them in BTEQ scripts or input stream files.

Use the Teradata SQL CALL statement to execute a stored procedure interactively:

CALL samplesp1 (8888, pAmount);

Use a text editor to include a stored procedure in a BTEQ script or input stream file. To execute the procedure samplesp1 from a script, for example, enter the Teradata SQL CALL statement after the LOGON statement in the script:

.LOGON  tdpid/userid,  password 
CALL samplesp1 (8888, pAmount);
.LOGOFF


https://docs.teradata.com/r/Basic-Teradata-Query-Reference/October-2018/Using-BTEQ/Using-Scripts-Run-Files-Macros-and-Stored-Procedures/Creating-and-Using-Stored-Procedures/Executing-Stored-Procedures




*****************************************************************CODE SAMPLE 


CREATE MULTISET TABLE CVS_TD_DB.tAccounts2, NO FALLBACK,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL
     (
     BranchId INTEGER,
     AccountCode INTEGER,
     Balance DECIMAL(10,2),
         AccountNumber INTEGER,
         Interest DECIMAL(10,2))
PRIMARY INDEX (AccountNumber) ;


CREATE MULTISET TABLE CVS_TD_DB.Proc_Error_Tbl ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL
     (
     sql_state CHAR(5) CHARACTER SET LATIN CASESPECIFIC,
     time_stamp TIMESTAMP(6),
     Add_branch CHAR(15) CHARACTER SET LATIN CASESPECIFIC,
     msg VARCHAR(40) CHARACTER SET LATIN CASESPECIFIC)
PRIMARY INDEX ( sql_state );






CREATE USER SYSDBA FROM DBC AS PERM=10 SPOOL=10, TEMPORARY=0, PASSWORD=********;
password sysdba

GRANT SELECT,EXECUTE ON DBC TO SYSDBA WITH GRANT OPTION;

GRANT ALL ON SYSDBA TO SYSDBA WITH GRANT OPTION;


CREATE USER shjoin FROM CVS_TD_DB AS PERM=10 SPOOL=10, TEMPORARY=0, PASSWORD=********;
PASSWORD shjoin

--drop user SYSDBA

GRANT SELECT,EXECUTE ON CVS_TD_DB TO shjoin WITH GRANT OPTION;

GRANT CREATE PROCEDURE, DROP PROCEDURE, EXECUTE PROCEDURE, STATISTICS ON CVS_TD_DB TO shjoin;

GRANT CREATE table ,SELECT, INSERT, UPDATE, DELETE ON CVS_TD_DB TO shjoin;





Create procedure shjo_proc( OUT oBranchId INTEGER,IN par_1 integer ,IN par_2 varchar)
Lmain: BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 10;
  
  for cur_emp as c_emp cursor for 
   Select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id
   DO      
       SET var_cnt_num = var_cnt_num + 1;       
   end for;	
END Lmain; 


CREATE PROCEDURE AddBranch (
                       OUT oBranchId INTEGER,
                        IN iBranchName CHAR(15),
                        IN iBankCode INTEGER,
                        IN iStreet VARCHAR(30),
                        IN iCity VARCHAR(30),
                        IN iState VARCHAR(30),
                        IN iZip INTEGER
                        )
Lmain: BEGIN
     -- Lmain is the label for the main compound statement
  
  -- Local variable declarations follow
   DECLARE hMessage CHAR(50) DEFAULT
              'Error: Database Operation ...';
   DECLARE hNextBranchId INTEGER;
   DECLARE hAccountNumber INTEGER DEFAULT 10;
   DECLARE hBalance INTEGER;
                
     -- Condition Handler Declarations
   DECLARE CONTINUE HANDLER FOR SQLSTATE '21000'
      
   -- Label compoun statements within handlers as HCS1 etc.
   HCS1: BEGIN
         INSERT INTO Proc_Error_Tbl
       (:SQLSTATE, CURRENT_TIMESTAMP, 'AddBranch', hMessage);
      END HCS1;
   DECLARE CONTINUE HANDLER FOR SQLSTATE '42000'
      HCS2: BEGIN
         SET hMessage = 'Table Not Found ... ';
         INSERT INTO Proc_Error_Tbl
         (:SQLSTATE, CURRENT_TIMESTAMP, 'AddBranch', hMessage);
      END HCS2;
   -- Get next branch-id from tBranchId table
   --CALL GetNextBranchId  hNextBranchId);
   -- Add new branch to tBranch table
   INSERT INTO tBranch ( BranchId, BankId, BranchName, Street,                City,  State, Zip)
   VALUES ( hNextBranchId, iBankId, iBranchName, iStreet,              iCity, iState, iZip);
  -- Assign branch number to the output parameter;
  -- the value is returned to the calling procedure
   SET oBranchId = hNextBranchId;
   -- Insert the branch number and name in tDummy table
   INSERT INTO tDummy VALUES(hNextBranchId, iBranchName);
   -- Insert account numbers pertaining to the current branch
   SELECT max(AccountNumber) INTO hAccountNumber FROM tAccounts;
   WHILE (hAccountNumber <= 1000) 
   DO
      INSERT INTO tAccounts (BranchId, AccountNumber)
     VALUES ( hNextBranchId, hAccountNumber);
       -- Advance to next account number
      SET hAccountNumber = hAccountNumber + 1;
   END WHILE;
    
  -- Update balance in each account of the current branch-id
   SET hAccountNumber = 1;
   L1: LOOP
       UPDATE tAccounts SET Balance = 100000
         WHERE BranchId = hNextBranchId AND
          AccountNumber = hAccountNumber;
       -- Generate account number
       SET hAccountNumber = hAccountNumber + 1;
       -- Check if through with all the accounts
       IF (hAccountNumber > 1000) THEN
        LEAVE L1;
       END IF;
   END LOOP L1;
   -- Update Interest for each account of the current branch-id
   FOR fAccount AS cAccount CURSOR FOR
   -- since Account is a reserved word
      SELECT Balance AS aBalance FROM tAccounts
         WHERE BranchId = hNextBranchId
   DO
   -- Update interest for each account
      UPDATE tAccounts SET Interest = fAccount.aBalance * 0.10
         WHERE CURRENT OF cAccount;
   END FOR;
  -- Inner nested compound statement begins
  Lnest: BEGIN
    -- local variable declarations in inner compound statement
   DECLARE Account_Number, counter INTEGER;
   DECLARE Acc_Balance DECIMAL (10,2);
   -- cursor declaration in inner compound statement
   DECLARE acc_cur CURSOR FOR
         SELECT AccountCode, Balance FROM tAccounts
         ORDER BY AccountNumber;
  -- condition handler declarations in inner compound statement
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    HCS3: BEGIN
              DECLARE h_Message VARCHAR(50);
              DECLARE EXIT HANDLER FOR SQLWARNING
                 HCS4: BEGIN
                     SET h_Message = 'Requested sample is larger
                      than table rows';
                     INSERT INTO Proc_Error_Tbl (:SQLSTATE,
          CURRENT_TIMESTAMP, 'AddBranch', h_Message);
                 END HCS4;
               
       SET h_Message = 'Data not Found ...';
             INSERT INTO Proc_Error_Tbl (:SQLSTATE,
         CURRENT_TIMESTAMP, 'AddBranch', h_Message);
         SELECT COUNT(*) INTO :counter FROM Proc_Error_Tbl
         SAMPLE 10;
       -- Raises a warning. This is a condition raised by
       -- a handler action statement. This is handled.
        END HCS3;
        DELETE FROM tDummy1;
        -- Raises "no data found" warning
        OPEN acc_cur;
        L2: REPEAT
        BEGIN
            FETCH acc_cur INTO Account_code, Acc_Balance;
            CASE
              WHEN (Account_code  <= 1000) THEN
               INSERT INTO dummy1 (Account_code, Acc_Balance);
               ELSE
               LEAVE L3;
            END CASE;
        END;
        UNTIL (SQLCODE = 0)
        END REPEAT L2;
    CLOSE acc_cur;
  END Lnest; --- end of inner nested block.
END Lmain; -- This comment is part of stored procedure body
-- End-of-Create-Procedure.








Create procedure shjo_proc(par_1 integer ,par_2 varchar)
BEGIN
    DECLARE var_cnt_num INTEGER DEFAULT 10;
  
  for cur_emp as c_emp cursor for 
   Select * from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
       where e.dept_id=d.dept_id
   DO      
       SET var_cnt_num = var_cnt_num + 1;       
   end for;	
END; 
 
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
insert into CVS_TD_DB.EMPLOYEE('AA-581','anderson',14,'officer',);


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



	**************************************All Teradata codes from website -- DOC
	
	
	FETCH (Embedded SQL Form)
Purpose
Positions a cursor on the next row (default) or any specified row of a response set, and assigns the values in that row to host variables.

Invocation
Executable.

Embedded SQL only.

Syntax


NEXT
Fetches the next row from the response set relative to the current cursor position.
NEXT is the default.
PRIOR
Fetches the prior row from the response set relative to the current cursor position.
FIRST
Fetches the first row of the response set.
LAST
Fetches the last row of the response set.
ABSOLUTE n
Fetches the n th row of the response set relative to:
The first row of the set, if n is a positive number.
The last row of the set, if n is a negative number.
n can be a host_variable_name or an integer_constant.
The data types for the host variable can be any 8-byte numeric data type with zero scale.
An integer_constant can be up to 31 digits.
RELATIVE n
Fetches the n th row of the response set:
forward by the value of n, if n is a positive number,
backward by the value of n, if n is a negative number,
relative to the current cursor position.
n can be a host_variable_name or an integer_constant.
The data types for the host variable can be any 8-byte numeric data type with zero scale.
An integer_constant can be up to 31 digits.
cursor_name
The name of an open selection cursor from which one or more rows are to be fetched.
host_variable_name
The variable to which the current row column value is to be assigned.
The colon character preceding the name is optional.
host_indicator_variable
The indicator variable.
The colon character preceding the name is mandatory.
descriptor_area
An SQL Descriptor Area (SQLDA).
You can specify descriptor_area in a C program as a name or as a pointer reference (*sqldaname) when the SQLDA structure is declared as a pointer.
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

Scrollable Cursors
When you open a scrollable cursor, the cursor is positioned before the first row of the response set. You can fetch using one of the FETCH orientation keywords.

You can open scrollable cursors in a multisession connection to enhance performance for access. When an application does not access rows sequentially, you may achieve better performance by setting the response buffer size equal to the fetch row size. You can try different response buffer sizes to achieve the best performance.

Rules
You should define an SQLDA.
You cannot execute FETCH as a dynamic SQL statement.
Multistatement requests are not allowed in scrollable cursor FETCH.
Scrollable cursor FETCH is not allowed in PP2 COMMITTED mode.
You must previously declare the cursor identified by cursor_name.
Use the INTO clause with cursors that you declared with either static or dynamic SQL statements.
The USING DESCRIPTOR clause is intended for use with selection cursors that you declared with dynamic SQL statements.

The number of columns the request returns must match the number of host variable specifications or the number of elements in the SQLVAR array of the SQLDA. In other words, the number of columns returned in the result set must equal the value of the SQLD field.
The main host variable you specified by a host variable specification or in the SQLVAR array of the SQLDA, and the corresponding column in the returned data must be of the same data type group.
The only valid exception is if the main host variable data type is approximate numeric, in which case the spool table column data type can be either approximate numeric or exact numeric.

If you specify the USING DESCRIPTOR clause, verify that the SQLDATA and SQLIND pointer fields in SQLDA are set to point to the appropriate host variables.
Because the COBOL language provides no support for setting pointer values, the Teradata Database supplies a service routine that can be called to do this task.

The IBM dialect VS COBOL II provides a variant of the SET statement to set pointer values. Programmers coding in this COBOL dialect should consider this feature where appropriate.

The cursor identified by cursor_name must be open.
The cursor identified by cursor_name is positioned on the next row and values are assigned to host variables according to the following rules:
IF the cursor …	THEN …
has just been positioned	FETCH returns:
Requested data for successful data returning statements.
SQLCODE +100 and SQLSTATE ‘02xxx’ for no data.
An error for non-rollback inducing SQL < O and SQLSTATE > ‘02xxx’.
is positioned on or after the last row
or

does not return data
the cursor is positioned after the last row
the system assigns +100 to SQLCODE
the system assigns ‘02xxx’ to SQLSTATE
the host variables remain unchanged
is positioned before a row	
the cursor is positioned on that row
the system assigns values from the row to the host variables you specified in the INTO clause or in the output SQLDA.
is positioned on a row other than the last row	
the cursor is positioned on the row immediately following that row
the system assigns values from the new current row to the host variables you specified in the INTO clause or in the output SQLDA.
The system assigns values to the host variables you specified in the INTO clause, or in the SQLVAR array in the SQLDA in the order in which you specified the host variables. The system assigns a value to SQLSTATE and SQLCODE last.
If an error occurs in assigning a value to a host variable, the system stops assigning values to host variables, and assigns one of the following values to the result code variables.
SQLCODE	SQLSTATE
-303	‘22509’
-304	‘22003’
-413	‘22003’
The following table indicates what the system assigns if a field in the returned data is NULL, depending on whether or not you specified a corresponding host variable.
IF a corresponding host variable is …	THEN the system assigns …
specified	-1 to the host indicator variable.
not specified	
-305 to SQLCODE.
‘22002’ to SQLSTATE.
In either case, the host variables remain unchanged.
The following table indicates the host indicator value the system sets if a column value in the temporary table row is NOT NULL and you specified a corresponding indicator host variable.
IF …	THEN the system sets the host indicator value to …
the column and main host variables are typed CHARACTER and the column value is longer than the main host variable	the length of the column value.
anything else	0.
The system sets column values in the corresponding main host variables according to the rules for host variables.
Related Topics
For more information about:
descriptor_area, see Teradata® Preprocessor2 for Embedded SQL Programmer Guide, B035-2446.
Using a FETCH orientation other than NEXT, you must have declared a scrollable cursor. See DECLARE CURSOR (Selection Form).
Scrollable cursors, see SET BUFFERSIZE.
FETCH (Stored Procedures Form)
Purpose
Positions a cursor to the next row (default) or any specified row of a response set and assigns the values in that row to local variables or parameters.

Invocation
Executable.

Stored procedures only.

Syntax


NEXT
Fetches the next row from the response set, if it exists.
NEXT is the default.
FIRST
Fetches the first row from the response set.
cursor_name
The name of an open selection cursor, including a cursor that was allocated, from which a row is to be fetched.
local_variable_name
The name of the local variable into which the fetched row is to be assigned.
Both predefined data types and UDTs (except VARIANT_TYPE UDTs) are supported.
parameter_reference
The name of the INOUT or OUT parameter into which the fetched row is to be assigned.
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

When There Are No Rows in the Response Set
If there are no rows in the response set at the time you execute FETCH, the system returns the following runtime exception:
SQLCODE is set to 7362
SQLSTATE is set to ‘02000’
The system handles this runtime warning condition within the procedure. If it is not handled, the procedure continues from the next statement following the failed fetch operation.

Assignment Order for Fetched Rows
The system assigns row values to local variables or output parameters in the order you declared those variables and parameters in the INTO list.

General Rules
The specified cursor must be open when you submit FETCH.

If the cursor is not open, the system returns the following runtime exception:
SQLCODE is set to 7631
SQLSTATE is set to ‘24501’
The number of values FETCH returns must match the number of local variables and output parameters you declared in the INTO list.

IF a mismatch is identified at …	THEN the Teradata Database returns …
compilation	compilation error SPL1027.
runtime	a runtime exception:
SQLCODE is set to 7608
SQLSTATE is set to ‘T7608’
The data types of the fetched columns must match the data types you specified for the local variables or OUT parameters to which they are assigned.

This is particularly true for UDT types, because the system does not implicitly apply any casts defined for a type.

To work around this restriction, you can do either:
Explicitly CAST data types in the cursor select list from a predefined type to a UDT or from a UDT to a predefined type if you have also defined a cast to the target type that specifies the AS ASSIGNMENT option.
Call a method that returns the target type.
You cannot indicate a simple target specification that names table columns in the INTO list. If you specify a non-valid INTO list, the system returns error SPL1028 during compilation.

Instead, you must specify output parameters (INOUT and OUT) or local variables.

Rules for FIRST and NEXT
If you do not specify NEXT or FIRST, or if you specify NEXT, and the cursor is positioned on or after the last row in the response set, or if there is no data, then the stored procedure positions the cursor after the last row and the system returns the following completion condition:
SQLCODE is set to 7632
SQLSTATE is set to ‘02000’
The output parameter or local variable you specified in the INTO list for this value is not changed in this case.

If you specify FIRST, you must specify SCROLL in the declaration for the referenced cursor.

If you do not specify SCROLL, the system returns error SPL1132 at compilation.

If you specify FIRST, but there is no data, the system returns the following completion condition:
SQLCODE is set to 7632
SQLSTATE is set to ‘02000’
The output parameter or local variable you specified in the INTO list for this value is not changed in this case.

Example: Returning Columns Assigned to Local Variables with Matching Data Types
The following example demonstrates that the cursor referenced by the FETCH statement is a valid cursor specification that returns columns correctly assigned to local variables with matching data types.

CREATE PROCEDURE sp1()
BEGIN
  DECLARE var1 INTEGER;
  DECLARE var2 CHARACTER(30)
  DECLARE projcursor CURSOR FOR
    SELECT projid, projectdesc
    FROM project
    ORDER BY projid;
  OPEN projcursor;
   WHILE (SQLCODE=0)
   DO
    FETCH projcursor INTO var1, var2;
   END WHILE;
  CLOSE projcursor;
END;
Example: Using the FETCH Statement and the WHILE Loop
In the following example, the FETCH statement after the WHILE loop raises completion condition SQLCODE 7632 and SQLSTATE '02000' and returns the message no rows found because the cursor is already positioned after the last row in the result set:

CREATE PROCEDURE sp1 (OUT par1 CHARACTER(50))
BEGIN
  DECLARE var1 INTEGER;
  DECLARE projcursor CURSOR FOR
    SELECT projid, projectdesc
    FROM project;
  OPEN projcursor;
   WHILE (SQLCODE = 0)
   DO
    FETCH projcursor INTO var1, par1;
   END WHILE;
  FETCH projcursor INTO var1, par1;
  CLOSE projcursor;
END;
Example: Using Fetch Orientation in the FETCH Statement
The following example illustrates the usage of fetch orientation in the FETCH statement. Assume that the project table contains 10 rows at the time execution of sp1 begins.

The first FETCH statement returns the first row, and the second FETCH returns the second row if no other rows have been fetched since projcursor was opened.

CREATE PROCEDURE sp1 (OUT par1 INTEGER)
BEGIN
  DECLARE var1 CHARACTER(5);
  DECLARE var2 INTEGER;
  DECLARE projcursor SCROLL CURSOR FOR
    SELECT projectstatus
    FROM project;
  OPEN projcursor;
    FETCH FIRST projcursor INTO var1;
    ...
    FETCH NEXT projcursor INTO var1;
    ...
  CLOSE projcursor;
END;
Example: Using FETCH FIRST
The following example illustrates the usage of FETCH FIRST. Assume that the project table is empty at the time execution of sp1 begins.

The FETCH statement raises the completion condition SQLCODE 7632 and SQLSTATE '02000' and returns the message no rows found because the table does not contain any rows.

CREATE PROCEDURE sp1 (OUT par1 INTEGER)
BEGIN
  DECLARE var1 CHARACTER(5);
  DECLARE var2 INTEGER;
  DECLARE projcursor SCROLL CURSOR FOR
    SELECT projectstatus
    FROM project;
  OPEN projcursor;
    FETCH FIRST projcursor INTO var1;
    ...
  CLOSE projcursor;
END;
OPEN (Embedded SQL Form)
Purpose
Opens a declared cursor for an embedded SQL application and executes the SQL statement specified in its declaration.

Invocation
Executable.

Embedded SQL only.

Syntax


cursor_name
The name of the cursor to be opened.
host_variable_name
The variable to be used as input data for the cursor request.
The colon character preceding the name or names is optional.
host_indicator_variable
The indicator variable.
The colon character preceding the name is mandatory.
descriptor_area
An SQLDA.
You can specify descriptor_area in a C program as a name or as a pointer reference (*sqldaname) when the SQLDA structure is declared as a pointer.
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

General Rules
You should define an SQLDA.
You must previously declare the cursor identified by cursor_name.
The cursor identified by cursor_name must be closed.
Once the cursor is open, the system executes the associated static or dynamic SQL statement or statements. The system then creates the result spool file and positions the cursor before the first row of the spool file.
OPEN processing returns a 0 in the SQLCODE field of the SQLCA and ‘00000’ to SQLSTATE, unless a failure (implicit rollback) occurs. For an SQLCODE of 0, the system places the activity count in the third SQLERRD element of the SQLCA structure.
If the cursor is updatable, or a C or COBOL application program contains a REWIND or POSITION TO STATEMENT request for the cursor, execute the OPEN statement with KEEPRESP; otherwise, execute it with NOKEEPRESP. For PL/I applications, KEEPRESP is the default.
You cannot execute OPEN as a dynamic SQL statement.
No more than 16 cursors can be open at one time because the processing of non-cursor-related statements is increasingly affected for the worse as more cursors are opened.
If an application has 16 cursors open, no other request can be issued until one or more cursors are closed.

Rules for USING Clause
The USING clause identifies variables used as input to the SQL statement by cursor_name.
host_variable_name must be a valid client language variable you declared before the OPEN statement, to be used as an input variable.
You can use a client structure to identify the input variables.

The number of variables you specify must be the same as the number of parameter markers (the question mark character) in the identified statement.

The n th variable corresponds to the n th marker.

Use of the colon character prefix for host_variable_name is optional.

descriptor_area identifies an input SQLDA structure, previously defined by the application, that contains necessary information about the input variable set.
The number of variables identified by the SQLD field of the SQLDA must be the same as the number of parameter markers (the question mark character) in the identified statement.

The n th variable described by the SQLDS corresponds to the n th marker.

Related Topics
For more information about:
Cursors referenced in the ALLOCATE statement, see ALLOCATE.
Creating casts and using the AS ASSIGNMENT option, see Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
descriptor_area, see Teradata® Preprocessor2 for Embedded SQL Programmer Guide, B035-2446.
OPEN (Embedded SQL Form), see CLOSE.
OPEN (Stored Procedures Form)
Purpose
Opens a declared cursor in a stored procedure and executes the SQL statement specified in its declaration.

Invocation
Executable.

Stored procedures only.

Syntax


cursor_name
The name of the cursor to be opened.
USING
Variables used as input to the SQL statement specified by cursor_name that must be declared before the OPEN statement.
SQL_identifier
A valid SQL identifier.
SQL_parameter
An SQL parameter.
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

Returning a Result Set
The OPEN statement opens a result set cursor and executes the static or dynamic SELECT statement, which produces the result set. The system creates the result spool file, and positions the cursor before the first row of the spool file.

General Rules
You must previously declare the cursor identified by cursor_name.
The cursor identified by cursor_name must not already be open.
Rules for USING Clause
The number of variables specified must be the same as the number of parameter markers (the question mark character) in the identified statement. The n th variable corresponds to the n th marker.
You cannot execute OPEN as a dynamic SQL statement.
You can only use the USING clause in an OPEN cursor when the cursor is a dynamic SQL form.
No more than 15 cursors can be open at one time. If an application has 15 cursors open, no other request can be issued until one or more cursors are closed.
Example: Using the OPEN Statement
The following example is valid because the OPEN statement follows a valid cursor declaration statement in the same scope.

CREATE PROCEDURE sp1()
BEGIN
  DECLARE empcursor CURSOR FOR
    SELECT *
    FROM employee
    ORDER BY empid;
  OPEN empcursor;
  ...
END;
Example: Using the OPEN Cursor Statement and the USING Clause
In this example, the OPEN cursor statement is extended to allow a USING clause.

CREATE PROCEDURE abc (IN data1v VARCHAR(10), IN data2v VARCHAR(10) )
   DYNAMIC RESULT SETS 1
  BEGIN
     DECLARE sql_stmt1 VARCHAR(100);
     DECLARE sales DECIMAL(8,2);
     DECLARE item INTEGER;
     DECLARE cstmt CURSOR WITH RETURN ONLY FOR stmt1;
     SET sql_stmt1 = 'SELECT  T1.item, T1.sales FROM T1 WHERE ?'
                     '= store_name AND ? = region;';
     PREPARE stmt1 FROM sql_stmt1;
     OPEN cstmt USING data1v, data2v;
  END;
Related Topics
For more information about:
Returning a result set, see Returning Result Sets from a Stored Procedure.
OPEN (Stored Procedures Form), see CLOSE.
POSITION
Purpose
Positions a cursor to the beginning of the next statement or to the results of a specified statement.

Invocation
Executable.

Embedded SQL only.

Syntax


cursor_name
The name of an open cursor other than an Insertion cursor.
statement_number
An integer numeric for the statement number to which positioning is desired.
numeric_variable
A host variable conforming to type INTEGER that represents the statement number to which positioning is desired. Use of a colon character is optional.
ANSI Compliance
POSITION is ANSI/ISO SQL:2011-compliant.

Authorization
None.

Rules
The cursor is repositioned before the first result row (if any) of the statement specified and SQLSTATE, SQLCODE and other SQLCA values are set.

With POSITION TO NEXT, the cursor is positioned to the next statement.

With POSITION TO STATEMENT, the cursor is positioned to the specified statement.

If the specified statement number does not exist (for example, TO STATEMENT 3 is coded, but the cursor controls only two statements), the following runtime exception occurs, leaving the position of the cursor undefined:
SQLCODE is set to -501
SQLSTATE is set to ‘24501’
The cursor can be positioned either forward or backward from the current statement and can be repositioned to a given statement as many times as the application requires.

For COBOL programs with multiple compile units, the cursor can only be positioned backward if a REWIND or POSITION TO STATEMENT occurs in the same compile unit as the declaration and the opening of the cursor.

POSITION is valid with any cursor except an insertion cursor.

The statement set found by the cursor is not re-executed, but the cursor position in the spool file is adjusted accordingly.

You cannot execute POSITION as a dynamic SQL statement.

Related Topics
For more information about:
POSITION being valid with any cursor except an insertion cursor, see DECLARE CURSOR, DECLARE CURSOR (Macro Form), DECLARE CURSOR (Request Form) and DECLARE CURSOR (Selection Form)
POSITION, see REWIND.
PREPARE
Purpose
Prepares the dynamic DECLARE CURSOR statement to allow the creation of different result sets. Allows dynamic parameter markers.

Invocation
Executable.

Stored procedure only.

Syntax



statement_name
the same identifier as statement_name in a DECLARE CURSOR statement.
statement_string
the SQL text that is to be executed dynamically.
statement_string must be enclosed within apostrophes.
statement_string_variable
the name of an SQL local variable, or an SQL parameter or string variable, that contains the SQL text string to be executed dynamically.
This element should be a CHAR/VARCHAR variable less than 32000 characters.
ANSI Compliance
PREPARE is ANSI/ISO SQL:2011-compliant.

Authorization
None.

Rules
The Parser checks the syntax of the PREPARE statement. If there is a syntax error, the system returns a syntax exception.
You cannot execute PREPARE as a dynamic SQL statement.
The statement must be a dynamic cursor SELECT statement. If this is not the case, the system returns '07005' dynamic SQL error, prepared statement not a cursor specification.
The dynamic SQL statement text can be as long as 64 Kbytes (including SQL text, USING data, and parcel overhead).
You cannot specify multistatement requests.
The dynamic SQL statement can include parameter markers or placeholder tokens (the question mark), where any literal reference, particularly an SQL variable, is legal except in the select list.
The USING clause of the OPEN statement supplies values to the statement.
Example: Using PREPARE
CREATE PROCEDURE abc (IN data1v VARCHAR(10), IN data2v VARCHAR(10) )
   DYNAMIC RESULT SETS 1
  BEGIN
     DECLARE sql_stmt1 VARCHAR(100);
     DECLARE sales DECIMAL(8,2);
     DECLARE item INTEGER;
     DECLARE cstmt CURSOR WITH RETURN ONLY FOR stmt1;
     SET sql_stmt1 = 'SELECT  T1.item, T1.sales FROM T1 WHERE'  data1v
                     || '= store_name AND '   || data2v || '= region;';
     PREPARE stmt1 FROM sql_stmt1;
     OPEN cstmt;
  END;
Example: Using PREPARE with Parameter Markers
In this example, the PREPARE statement is written using parameter markers:

SET sql_stmt1 = 'SELECT  T1.item, T1.sales FROM T1 WHERE ?'
                '= store_name AND ? = region;';
PREPARE stmt1 FROM sql_stmt1;
OPEN cstmt USING data1v, data2v;
Related Topics
For use of the PREPARE statement in embedded SQL, see PREPARE.

REWIND
Purpose
Positions or repositions a cursor to the beginning of the results of its first or only statement.

Invocation
Executable.

Embedded SQL only.

Syntax


cursor_name
The name of an open cursor other than an Insertion cursor.
ANSI Compliance
REWIND is a Teradata extension to the ANSI/ISO SQL:2011 standard.

Authorization
None.

Usage Notes
The statement REWIND cursor_name is equivalent to the statement POSITION cursor_name TO STATEMENT 1.

Related Topics
See POSITION.

SELECT AND CONSUME … INTO
Purpose
Selects data from the row with the oldest insertion timestamp in the specified queue table, deletes the row from the queue table, and assigns the values in that row to host variables in an embedded SQL application or to local variables or parameters in stored procedures.

Invocation
Executable.

Stored procedures and embedded SQL.

Syntax: Stored Procedures Only


Syntax: Embedded SQL Only


select_list
An ASTERISK character (*) or a comma-separated list of valid SQL expressions.
If select_list specifies *, all columns from the queue table specified in the FROM clause are returned.
The select list must not contain aggregate or ordered analytical functions.
local_variable_name
The name of the local variable declared in the stored procedure into which the SELECTed data is to be placed.
You cannot use stored procedure status variables here.
queue_table_name
The name of a queue table that was created with the QUEUE option in the CREATE TABLE statement.
parameter_name
The name of the stored procedure parameter into which the SELECTed data is to be placed.
Only output parameters (INOUT and OUT type) can be specified.
host_variable_name
The name of the host variable into which the selected data is to be placed.
host_indicator_name
The name of the host indicator variable.
ANSI Compliance
SELECT AND CONSUME … INTO is a Teradata extension to the ANSI/ISO SQL:2011 standard.

Authorization
To execute a SELECT AND CONSUME … INTO from a queue table, you must have the SELECT and DELETE privileges on that table.

Attributes of a Queue Table
A queue table is similar to an ordinary base table, with the additional unique property of behaving like an asynchronous first-in-first-out (FIFO) queue.

The first column of a queue table contains Queue Insertion TimeStamp (QITS) values. The CREATE TABLE statement must define the first column with the following data type and attributes:

TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
The QITS value of a row indicates the time the row was inserted into the queue table, unless a different, user-supplied value is inserted.

Using a Colon Character in Embedded SQL
In embedded SQL, blanks before and after a colon character are optional; use of the colon character before host_variable_name is optional; a colon character must precede a host_indicator_name.

Rules for Embedded SQL
The same rules that apply to SELECT … INTO apply to SELECT AND CONSUME … INTO.

Related Topics
For more information about:
queue_table_name, see “CREATE TABLE (Queue Table Form)” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
Usage notes, information on transaction processing, locks, and restrictions, see “SELECT AND CONSUME” in Teradata Vantage™ SQL Data Manipulation Language , B035-1146 .
The rules that apply to SELECT … INTO and SELECT AND CONSUME … INTO, see Rules for Embedded SQL.
SELECT … INTO
Purpose
Selects at most one row from a table and assigns the values in that row to host variables in an embedded SQL application or to local variables or parameters in stored procedures.

Invocation
Executable.

Stored procedures and embedded SQL.

Syntax: Stored Procedures Only



Syntax: Embedded SQL Only



with_[recursive]_modifier
A recursive query that provides a way to search a table using iterative self-join and set operations if WITH RECURSIVE is used.
The nonrecursive WITH request modifier is similar to a derived table.
select_list
An asterisk (*) or a comma-separated list of valid SQL expressions.
The select list can contain instances of the DEFAULT function, but must not contain aggregate or ordered analytical functions.
Stored procedures only:
Teradata Database performs implicit conversions for DateTime data types. For all other data types, the select list data types must match the INTO clause target list data types.
If the select list data types do not match the INTO clause target list data types, you can specify an explicit CAST to the target type to enable the operation to succeed.
Columns specified in the select and INTO lists can have UDT data types, except for the VARIANT_TYPE UDT data type. The system automatically applies any implicit conversions defined for the UDT if they exist.
The system applies implicit casting of the select list data types from UDTs to predefined data types or from predefined types to UDTs only if a CAST to the target type exists and was created with the AS ASSIGNMENT option specified.
host_variable_name
The name of the host variable into which the selected data is to be placed.
host_indicator_name
The name of the host indicator variable.
from_clause
A clause listing the tables or views referenced by the SELECT.
where_clause
A clause narrowing a SELECT to those rows that satisfy a conditional expression that it specifies.
The WHERE clause can contain the DEFAULT function as a component of its predicate.
local_variable_name
The name of the local variable declared in the stored procedure into which the SELECTed data is to be placed.
You cannot use stored procedure status variables here.
Stored procedures only: A local variable can have a UDT type, except for the VARIANT_TYPE UDT data type.
You must have the UDTUSAGE privilege on any UDT used as a local variable.
parameter_name
The name of the stored procedure parameter into which the SELECTed data is to be placed.
Only output parameters (INOUT and OUT type) can be specified.
Stored procedures only: A parameter can have a UDT type, except for the VARIANT_TYPE UDT data type.
You must have the UDTUSAGE privilege on any UDT used as a parameter.
ANSI Compliance
SELECT … INTO is ANSI/ISO SQL:2011-compliant.

Authorization
To select data from a table, you must have SELECT privilege on that table.

To select data through a view, you must have the SELECT privilege on that view. Also, the immediate owner of the view (that is, the database in which the view resides) must have SELECT WITH GRANT OPTION privileges on all tables or views referenced in the view.

For stored procedures, the local variables and parameters in the select and INTO lists can be UDTs, except VARIANT_TYPE UDTs.

You must have the UDTUSAGE privilege on any local variable or parameter that has a UDT data type.

Recursive Query Example
The following example shows a recursive query used inside a client application:

EXEC SQL
      WITH RECURSIVE Reachable_From (Source, Destin, mycount)AS
   (      SELECT Root.Source, Root.Destin, 0 as mycount
          FROM Flights Root
          WHERE Root.Source = ‘Paris’
      UNION ALL
          SELECT in1.Source, out1.Destin, in1.mycount + 1
          FROM Reachable_From in1, Flights out1
          WHERE in1.Destin = out1.Source
          AND in1.mycount <= 100
      )
      SELECT Source, Destin
      INTO :intosource INDICATOR :indvar1
      :intodestin INDICATOR: indvar2
      FROM Reachable_From;
END-EXEC
In this example, the host variables intosource and intodestin and indicator variables indvar1 and indvar2 are being used in the final SELECT of the recursive query. These variables cannot be used inside the recursive query definition.

Rules for Using a Colon Character
Following are the rules for using a colon character in embedded SQL:
Pad characters preceding and following a colon character are optional.
A prepending colon character for host_variable_name is optional.
A prepending colon character must precede a host_indicator_name.
Following are the rules for using a colon character in stored procedures:
A prepending colon character preceding a local_variable_name is optional.
A prepending colon character preceding a param_name is optional.
Rules for Stored Procedures
The order of specifying the various clauses in SELECT … INTO is significant in stored procedures. The following must be specified in the given order:
WITH [RECURSIVE] request modifier
SELECT clause
INTO list
FROM clause
If any other element intervenes between the INTO list and FROM, it will result in an error. You can specify all other clauses in the statement in any order.

You have to specify the column list explicitly in the SELECT clause. The SELECT * syntax is not allowed in stored procedures.

The SELECT privilege is required on all tables specified in the FROM clause and in any subquery contained in the query specification, or on the database(s) containing the tables.

For stored procedures, you must also have the UDTUSAGE privilege on any UDT used as the data type for any column in the select and INTO lists.

UNION, INTERSECT and MINUS clauses are not supported in the SELECT … INTO statement.

The number of columns specified by the select list must match the number of local variable and parameter specifications.

The local variable or parameter and the corresponding column in the returned data must be of compatible data type. Teradata Database performs implicit conversions for DateTime data types when the data type of the local variable or parameter differs from the corresponding column data type.

For stored procedures, you must have the UDTUSAGE privilege on any UDT used as a local variable or parameter.

If an error or failure occurs for the statement, normal exception condition handling takes place.

The SELECT … INTO statement is normally expected to return at most one row. One of the following actions is taken after executing the statement:

IF SELECT … INTO returns …	The stored procedure status variables show these values …	Which mean …
more than one row	
SQLCODE = 7627
SQLSTATE = ‘21000’
ACTIVITY_COUNT =number of rows found.

an exception condition (a failure in Teradata session mode and error in ANSI session mode)
A specific condition handler or a generic handler can be specified to handle this condition. The values of local variables and parameters do not change.

no rows, without an execution warning	
SQLCODE = 7632
SQLSTATE = ‘02000’
ACTIVITY_COUNT = 0
a completion condition other than successful completion.
A specific condition handler can be specified to handle this completion condition. The values of local variables and parameters do not change.

no rows, with an execution warning	SQLCODE = the warning code.
SQLSTATE =SQLSTATE value corresponding to the warning.

ACTIVITY_COUNT = 0.
a completion condition other than successful completion.
A specific condition handler can be specified to handle this completion condition. The values of local variables and parameters do not change.

exactly one row without an execution warning	
SQLCODE = 0
SQLSTATE = ‘00000’
ACTIVITY_COUNT = 1
the fetched values are assigned to the local variables and parameters.
This is a successful completion. A specific handler cannot be specified to handle this.

exactly one row with an execution warning	SQLCODE = the warning code.
SQLSTATE =SQLSTATE value corresponding to the warning.

ACTIVITY_COUNT = 1
the fetched values are assigned to the local variables and parameters.
This is a completion condition other than successful completion. A specific handler can be specified to handle this condition.

Rules for Embedded SQL
UDTs are not specifically supported.

Note, however, that UDTs for which tosql and fromsql transforms have been defined can be externally referenced by means of their transform target data types. As a result, embedded SQL applications can use SQL statements that reference UDTs provided that the UDTs have a defined tosql or fromsql transform as appropriate.

Additionally, the application must send and receive UDT data in the form of its external (non-UDT) data type.

The SELECT privilege is required on all tables specified in the FROM clause and in any subquery contained in the query specification, or on the database set containing the tables.

The number of columns specified by select_list must match the number of host variable specifications.

Values are assigned to the host variables specified in the INTO clause in the order in which the host variables were specified. A value is assigned to SQLCODE last.

The main host variable and the corresponding column in the returned data must be of the same data type group, except that if the main host variable data type is approximate numeric, the temporary table column data type can be either approximate numeric or exact numeric.

If the temporary table contains zero rows (is empty), the value +100 is assigned to SQLCODE and no values are assigned to the host variables specified in the INTO clause.

If exactly one row of data is returned, the values from the row are assigned to the corresponding host variables specified in the INTO clause.

If more than one row of data is returned, the value -810 is assigned to SQLCODE, and no values are assigned to the host variables specified in the INTO clause.

If an error occurs in assigning a value to a host variable, one of the values -303, -304, or -413 is assigned to SQLCODE, and no further assignment to host variables occurs.

If a column value in the returned data is NULL and a corresponding indicator host variable is specified, the value -1 is assigned to the indicator host variable and no value is assigned to the main host variable. If no corresponding indicator host variable is specified, the value -305 is assigned to SQLCODE and no further assignment to host variables occurs.

If a column value in the returned data is NOT NULL and a corresponding indicator host variable is specified, the indicator host variable is set as follows:
If the column and main host variable are of character data type and the column value is longer than the main host variable, the indicator host variable is set to the length of the column value.
In all other cases, the indicator variable is set to zero.
If no other value is assigned to SQLCODE, the value zero is assigned to SQLCODE.

Column values are set in the corresponding main host variables according to the rules for host variables.

You cannot execute SELECT... INTO as a dynamic SQL statement.

SELECT … INTO supports browse mode SELECT operations for queue tables.

Rules for Using the DEFAULT Function With SELECT Statements
The DEFAULT function takes a single argument that identifies a relation column by name. The function evaluates to a value equal to the current default value for the column. For cases where the default value of the column is specified as a current built-in system function, the DEFAULT function evaluates to the current value of system variables at the time the request is executed.
The resulting data type of the DEFAULT function is the data type of the constant or built-in function specified as the default, unless the default is NULL. If the default is NULL, the resulting data type is the data type of the column or expression for which the default is being requested.

The DEFAULT function has two forms. It can be specified as DEFAULT or DEFAULT (column_name). When no column name is specified, the system derives the column based on context. If the column context cannot be derived, the request aborts and an error is returned to the requestor.
You can specify a DEFAULT function with a column name in the select list of a SELECT statement. The DEFAULT function evaluates to the default value of the specified column.
You cannot specify a DEFAULT function without a column name in the expression list. The system aborts the request and returns an error to the requestor.
If you specify a SELECT statement that does not also specify a FROM clause, the system always returns a single row with the default value of the column, regardless of how many rows are in the table.
This is similar to the existing TYPE function.

When the column passed as an input argument to the DEFAULT function does not have an explicit default value associated with it, the DEFAULT function evaluates to null.
Related Topics
For more information about:
with_[recursive]_ modifier, see “WITH [RECURSIVE] Request Modifier” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
select_list, see Rules for Using the DEFAULT Function With SELECT Statements.
Implicit data type conversions and the CAST function, see “Data Type Conversions” in Teradata Vantage™ Data Types and Literals, B035-1143.
See the CALL statement in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144 for more details on authorization required.
Creating a cast and using the AS ASSIGNMENT option, see “CREATE CAST” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
from_clause, see “FROM Clause” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
Rules for Using the DEFAULT Function With SELECT Statements and the documentation for “WHERE clause,” see Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
Performing implicit conversions for DateTime data, see “Data Type Conversions” in Teradata Vantage™ Data Types and Literals, B035-1143.
SELECT … INTO supporting browse mode SELECT operations for queue tables, see “CREATE TABLE (Queue Table Form)” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
the DEFAULT function, see Teradata Vantage™ SQL Functions, Expressions, and Predicates, B035-1145.
UPDATE (Positioned Form)
Purpose
Updates the most current fetched cursor row.

Invocation
Executable.

Stored procedures and embedded SQL.

Syntax


table_name
The name of the table to be updated.
correlation_name
An alias for the table name.
Correlation names are also referred to as range variables.
column_name = expression
A column name and value with which to update.
When host variables are used in the SET clause, they must always be preceded by a colon character.
cursor_name
The name of the updatable cursor being used to point to the rows to be updated.
ANSI Compliance
The positioned form of UPDATE is ANSI/ISO SQL:2011-compliant.

Authorization
You must have the UPDATE privilege on the table or columns to be updated.

When executing an UPDATE that also requires READ access to an object, you must have the SELECT right to data being accessed.

For example, in the following statement, READ access is required by the WHERE condition.

UPDATE table_1
SET field_1=1
WHERE field_1<0;
Similarly, the following statement requires READ access because you must read field_1 values from table_1 to compute the new values for field_1.

UPDATE table_1
SET field_1 = field_1 + 1;
An UPDATE operation sets a WRITE lock for the table or row being updated.

The activity count in the success response for an UPDATE statement reflects the total number of rows updated. If no rows qualify for update, then the activity count is zero.

UPDATE With Correlated Subqueries
See “Correlated Subqueries and the UPDATE Statement” in Teradata Vantage™ SQL Data Manipulation Language , B035-1146 for information about using correlated subqueries with UPDATE statements.

Large Objects and UPDATE
The behavior of truncated LOB updates differs in ANSI and Teradata session modes. The following table explains the differences in truncation behavior.

In this session mode …	When non-pad bytes are truncated on insertion …
ANSI	an exception condition is raised.
The UPDATE fails.

Teradata	no exception condition is raised.
The UPDATE succeeds: the truncated LOB is stored.

Update of GENERATED ALWAYS Identity Columns and PARTITION
You cannot update the following set of system-generated columns:
GENERATED ALWAYS identity columns
PARTITION
You can update a GENERATED BY DEFAULT identity column. The specified value is not constrained by identity column parameters, but is constrained by any CHECK constraints defined on the column.

Support of Mutator SET Clauses
Because UDTs are not supported in embedded SQL, the mutator SET clause is not supported for the positioned form of UPDATE.

Rules for UPDATE in ANSI Session Mode
The WHERE CURRENT OF clause enables a UPDATE statement to act on a data row currently pointed to by the cursor named in WHERE CURRENT OF cursor_name. Such a cursor is said to be updatable.
You need not include a specification of intent to update or delete a row when you declare cursor_name.
Multiple updates of the currently fetched row of cursor_name or updates followed by a delete of the currently fetched row of cursor_name are valid.
Rule for Updating Partitioning Columns of a PPI Table
If you are updating a partitioning column for a partitioned primary index, then updates to the partitioning columns must be in a range that permits the partitioning expression to produce, after casting values to INTEGER if the value is not already of that type, a value that is not null between 1 and 65535.

Rules for Using the DEFAULT Function
The DEFAULT function takes a single argument that identifies a relation column by name. The function evaluates to a value equal to the current default value for the column. For cases where the default value of the column is specified as a current built-in system function, the DEFAULT function evaluates to the current value of system variables at the time the statement is executed.
The resulting data type of the DEFAULT function is the data type of the constant or built-in function specified as the default unless the default is NULL. If the default is NULL, the resulting date type of the DEFAULT function is the same as the data type of the column or expression for which the default is being requested.

The DEFAULT function has two forms. It can be specified as DEFAULT or DEFAULT (column_name). When no column name is specified, the system derives the column based on context. If the column context cannot be derived, the request aborts and an error is returned to the requestor.
You can specify a DEFAULT function without a column name argument as the expression in the SET clause. The column name for the DEFAULT function is the column specified as the column_name. The DEFAULT function evaluates to the default value of the column specified as column_name.







EXECUTE
Purpose
Executes a prepared statement in a stored procedure.

Invocation
Executable.

Stored procedures only.

Syntax


statement_name
The name associated with the previously prepared statement.
SQL_identifier
A valid SQL identifier.
SQL_parameter
An SQL parameter.
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

Rules
EXECUTE cannot be used with any of the following: a dynamic data returning statement or a dynamic multistatement request
EXECUTE itself cannot be performed as a dynamic SQL statement.
The following rules apply to the USING clause:
The USING clause identifies variables used as input to the SQL statement specified by statement_name.
The specified statement-name must be a valid and declared prior to the EXECUTE statement.
The number of variables specified must be the same as the number of parameter markers (the questions mark character) in the identified statement. The nth variable must correspond to the nth parameter marker.
The arguments must be compatible with the target. Necessary compatible conversion will be performed.
Example: Executing a Prepared Statement in a Stored Procedure
CREATE PROCEDURE sales_update(store_table VARCHAR(10),
							     item INTEGER,
							     price DECIMAL(8,2) )
		BEGIN
             DECLARE sql_stmt VARCHAR(100);
             SET sql_stmt = 'UPDATE ' || store_table || ' SET                  store_price=' || price || ' 
             WHERE store_item =' || item;
        PREPARE stmt1 FROM SQL_stmt;
	  EXECUTE stmt1;
    END;
Example: Executing a Prepared Statement in a Stored Procedure to Update the Price of an Item
CREATE PROCEDURE sales_update(store_table VARCHAR(10),
							    item INTEGER,
							    price DECIMAL(8,2) )
	BEGIN
          DECLARE price_read DECIMAL(8,2);
          DECLARE sql_stmt VARCHAR(100);
          SET sql_stmt = 'UPDATE ' || store_table || ' SET store_price=?           WHERE store_item = ?;';
      PREPARE stmt1 FROM sql_stmt;
          EXECUTE stmt1 USING price, item;
 END;
EXECUTE IMMEDIATE
Purpose
Prepares and executes a statement in a stored procedure.

Invocation
Executable.

Stored procedures only.

Syntax


statement_name
One of the following:
a literal
a reference to an SQL string variable
a parameter
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

Example: Using EXECUTE IMMEDIATE
CREATE PROCEDURE sales_update(store_table VARCHAR(10),
							     item INTEGER,
							     price DECIMAL(8,2) )
		BEGIN
			DECLARE sql_stmt VARCHAR(100);
			SET
			SET sql_stmt = 'UPDATE ' || store_table ||  ' SET store_price=' || price ||
					' WHERE store_item =' || item;
			EXECUTE IMMEDIATE sql_stmt;
    END;
FETCH (Embedded SQL Form)
Purpose
Positions a cursor on the next row (default) or any specified row of a response set, and assigns the values in that row to host variables.

Invocation
Executable.

Embedded SQL only.

Syntax


NEXT
Fetches the next row from the response set relative to the current cursor position.
NEXT is the default.
PRIOR
Fetches the prior row from the response set relative to the current cursor position.
FIRST
Fetches the first row of the response set.
LAST
Fetches the last row of the response set.
ABSOLUTE n
Fetches the n th row of the response set relative to:
The first row of the set, if n is a positive number.
The last row of the set, if n is a negative number.
n can be a host_variable_name or an integer_constant.
The data types for the host variable can be any 8-byte numeric data type with zero scale.
An integer_constant can be up to 31 digits.
RELATIVE n
Fetches the n th row of the response set:
forward by the value of n, if n is a positive number,
backward by the value of n, if n is a negative number,
relative to the current cursor position.
n can be a host_variable_name or an integer_constant.
The data types for the host variable can be any 8-byte numeric data type with zero scale.
An integer_constant can be up to 31 digits.
cursor_name
The name of an open selection cursor from which one or more rows are to be fetched.
host_variable_name
The variable to which the current row column value is to be assigned.
The colon character preceding the name is optional.
host_indicator_variable
The indicator variable.
The colon character preceding the name is mandatory.
descriptor_area
An SQL Descriptor Area (SQLDA).
You can specify descriptor_area in a C program as a name or as a pointer reference (*sqldaname) when the SQLDA structure is declared as a pointer.
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

Scrollable Cursors
When you open a scrollable cursor, the cursor is positioned before the first row of the response set. You can fetch using one of the FETCH orientation keywords.

You can open scrollable cursors in a multisession connection to enhance performance for access. When an application does not access rows sequentially, you may achieve better performance by setting the response buffer size equal to the fetch row size. You can try different response buffer sizes to achieve the best performance.

Rules
You should define an SQLDA.
You cannot execute FETCH as a dynamic SQL statement.
Multistatement requests are not allowed in scrollable cursor FETCH.
Scrollable cursor FETCH is not allowed in PP2 COMMITTED mode.
You must previously declare the cursor identified by cursor_name.
Use the INTO clause with cursors that you declared with either static or dynamic SQL statements.
The USING DESCRIPTOR clause is intended for use with selection cursors that you declared with dynamic SQL statements.

The number of columns the request returns must match the number of host variable specifications or the number of elements in the SQLVAR array of the SQLDA. In other words, the number of columns returned in the result set must equal the value of the SQLD field.
The main host variable you specified by a host variable specification or in the SQLVAR array of the SQLDA, and the corresponding column in the returned data must be of the same data type group.
The only valid exception is if the main host variable data type is approximate numeric, in which case the spool table column data type can be either approximate numeric or exact numeric.

If you specify the USING DESCRIPTOR clause, verify that the SQLDATA and SQLIND pointer fields in SQLDA are set to point to the appropriate host variables.
Because the COBOL language provides no support for setting pointer values, the Teradata Database supplies a service routine that can be called to do this task.

The IBM dialect VS COBOL II provides a variant of the SET statement to set pointer values. Programmers coding in this COBOL dialect should consider this feature where appropriate.

The cursor identified by cursor_name must be open.
The cursor identified by cursor_name is positioned on the next row and values are assigned to host variables according to the following rules:
IF the cursor …	THEN …
has just been positioned	FETCH returns:
Requested data for successful data returning statements.
SQLCODE +100 and SQLSTATE ‘02xxx’ for no data.
An error for non-rollback inducing SQL < O and SQLSTATE > ‘02xxx’.
is positioned on or after the last row
or

does not return data
the cursor is positioned after the last row
the system assigns +100 to SQLCODE
the system assigns ‘02xxx’ to SQLSTATE
the host variables remain unchanged
is positioned before a row	
the cursor is positioned on that row
the system assigns values from the row to the host variables you specified in the INTO clause or in the output SQLDA.
is positioned on a row other than the last row	
the cursor is positioned on the row immediately following that row
the system assigns values from the new current row to the host variables you specified in the INTO clause or in the output SQLDA.
The system assigns values to the host variables you specified in the INTO clause, or in the SQLVAR array in the SQLDA in the order in which you specified the host variables. The system assigns a value to SQLSTATE and SQLCODE last.
If an error occurs in assigning a value to a host variable, the system stops assigning values to host variables, and assigns one of the following values to the result code variables.
SQLCODE	SQLSTATE
-303	‘22509’
-304	‘22003’
-413	‘22003’
The following table indicates what the system assigns if a field in the returned data is NULL, depending on whether or not you specified a corresponding host variable.
IF a corresponding host variable is …	THEN the system assigns …
specified	-1 to the host indicator variable.
not specified	
-305 to SQLCODE.
‘22002’ to SQLSTATE.
In either case, the host variables remain unchanged.
The following table indicates the host indicator value the system sets if a column value in the temporary table row is NOT NULL and you specified a corresponding indicator host variable.
IF …	THEN the system sets the host indicator value to …
the column and main host variables are typed CHARACTER and the column value is longer than the main host variable	the length of the column value.
anything else	0.
The system sets column values in the corresponding main host variables according to the rules for host variables.
Related Topics
For more information about:
descriptor_area, see Teradata® Preprocessor2 for Embedded SQL Programmer Guide, B035-2446.
Using a FETCH orientation other than NEXT, you must have declared a scrollable cursor. See DECLARE CURSOR (Selection Form).
Scrollable cursors, see SET BUFFERSIZE.
FETCH (Stored Procedures Form)
Purpose
Positions a cursor to the next row (default) or any specified row of a response set and assigns the values in that row to local variables or parameters.

Invocation
Executable.

Stored procedures only.

Syntax


NEXT
Fetches the next row from the response set, if it exists.
NEXT is the default.
FIRST
Fetches the first row from the response set.
cursor_name
The name of an open selection cursor, including a cursor that was allocated, from which a row is to be fetched.
local_variable_name
The name of the local variable into which the fetched row is to be assigned.
Both predefined data types and UDTs (except VARIANT_TYPE UDTs) are supported.
parameter_reference
The name of the INOUT or OUT parameter into which the fetched row is to be assigned.
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

When There Are No Rows in the Response Set
If there are no rows in the response set at the time you execute FETCH, the system returns the following runtime exception:
SQLCODE is set to 7362
SQLSTATE is set to ‘02000’
The system handles this runtime warning condition within the procedure. If it is not handled, the procedure continues from the next statement following the failed fetch operation.

Assignment Order for Fetched Rows
The system assigns row values to local variables or output parameters in the order you declared those variables and parameters in the INTO list.

General Rules
The specified cursor must be open when you submit FETCH.

If the cursor is not open, the system returns the following runtime exception:
SQLCODE is set to 7631
SQLSTATE is set to ‘24501’
The number of values FETCH returns must match the number of local variables and output parameters you declared in the INTO list.

IF a mismatch is identified at …	THEN the Teradata Database returns …
compilation	compilation error SPL1027.
runtime	a runtime exception:
SQLCODE is set to 7608
SQLSTATE is set to ‘T7608’
The data types of the fetched columns must match the data types you specified for the local variables or OUT parameters to which they are assigned.

This is particularly true for UDT types, because the system does not implicitly apply any casts defined for a type.

To work around this restriction, you can do either:
Explicitly CAST data types in the cursor select list from a predefined type to a UDT or from a UDT to a predefined type if you have also defined a cast to the target type that specifies the AS ASSIGNMENT option.
Call a method that returns the target type.
You cannot indicate a simple target specification that names table columns in the INTO list. If you specify a non-valid INTO list, the system returns error SPL1028 during compilation.

Instead, you must specify output parameters (INOUT and OUT) or local variables.

Rules for FIRST and NEXT
If you do not specify NEXT or FIRST, or if you specify NEXT, and the cursor is positioned on or after the last row in the response set, or if there is no data, then the stored procedure positions the cursor after the last row and the system returns the following completion condition:
SQLCODE is set to 7632
SQLSTATE is set to ‘02000’
The output parameter or local variable you specified in the INTO list for this value is not changed in this case.

If you specify FIRST, you must specify SCROLL in the declaration for the referenced cursor.

If you do not specify SCROLL, the system returns error SPL1132 at compilation.

If you specify FIRST, but there is no data, the system returns the following completion condition:
SQLCODE is set to 7632
SQLSTATE is set to ‘02000’
The output parameter or local variable you specified in the INTO list for this value is not changed in this case.

Example: Returning Columns Assigned to Local Variables with Matching Data Types
The following example demonstrates that the cursor referenced by the FETCH statement is a valid cursor specification that returns columns correctly assigned to local variables with matching data types.

CREATE PROCEDURE sp1()
BEGIN
  DECLARE var1 INTEGER;
  DECLARE var2 CHARACTER(30)
  DECLARE projcursor CURSOR FOR
    SELECT projid, projectdesc
    FROM project
    ORDER BY projid;
  OPEN projcursor;
   WHILE (SQLCODE=0)
   DO
    FETCH projcursor INTO var1, var2;
   END WHILE;
  CLOSE projcursor;
END;
Example: Using the FETCH Statement and the WHILE Loop
In the following example, the FETCH statement after the WHILE loop raises completion condition SQLCODE 7632 and SQLSTATE '02000' and returns the message no rows found because the cursor is already positioned after the last row in the result set:

CREATE PROCEDURE sp1 (OUT par1 CHARACTER(50))
BEGIN
  DECLARE var1 INTEGER;
  DECLARE projcursor CURSOR FOR
    SELECT projid, projectdesc
    FROM project;
  OPEN projcursor;
   WHILE (SQLCODE = 0)
   DO
    FETCH projcursor INTO var1, par1;
   END WHILE;
  FETCH projcursor INTO var1, par1;
  CLOSE projcursor;
END;
Example: Using Fetch Orientation in the FETCH Statement
The following example illustrates the usage of fetch orientation in the FETCH statement. Assume that the project table contains 10 rows at the time execution of sp1 begins.

The first FETCH statement returns the first row, and the second FETCH returns the second row if no other rows have been fetched since projcursor was opened.

CREATE PROCEDURE sp1 (OUT par1 INTEGER)
BEGIN
  DECLARE var1 CHARACTER(5);
  DECLARE var2 INTEGER;
  DECLARE projcursor SCROLL CURSOR FOR
    SELECT projectstatus
    FROM project;
  OPEN projcursor;
    FETCH FIRST projcursor INTO var1;
    ...
    FETCH NEXT projcursor INTO var1;
    ...
  CLOSE projcursor;
END;
Example: Using FETCH FIRST
The following example illustrates the usage of FETCH FIRST. Assume that the project table is empty at the time execution of sp1 begins.

The FETCH statement raises the completion condition SQLCODE 7632 and SQLSTATE '02000' and returns the message no rows found because the table does not contain any rows.

CREATE PROCEDURE sp1 (OUT par1 INTEGER)
BEGIN
  DECLARE var1 CHARACTER(5);
  DECLARE var2 INTEGER;
  DECLARE projcursor SCROLL CURSOR FOR
    SELECT projectstatus
    FROM project;
  OPEN projcursor;
    FETCH FIRST projcursor INTO var1;
    ...
  CLOSE projcursor;
END;
OPEN (Embedded SQL Form)
Purpose
Opens a declared cursor for an embedded SQL application and executes the SQL statement specified in its declaration.

Invocation
Executable.

Embedded SQL only.

Syntax


cursor_name
The name of the cursor to be opened.
host_variable_name
The variable to be used as input data for the cursor request.
The colon character preceding the name or names is optional.
host_indicator_variable
The indicator variable.
The colon character preceding the name is mandatory.
descriptor_area
An SQLDA.
You can specify descriptor_area in a C program as a name or as a pointer reference (*sqldaname) when the SQLDA structure is declared as a pointer.
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

General Rules
You should define an SQLDA.
You must previously declare the cursor identified by cursor_name.
The cursor identified by cursor_name must be closed.
Once the cursor is open, the system executes the associated static or dynamic SQL statement or statements. The system then creates the result spool file and positions the cursor before the first row of the spool file.
OPEN processing returns a 0 in the SQLCODE field of the SQLCA and ‘00000’ to SQLSTATE, unless a failure (implicit rollback) occurs. For an SQLCODE of 0, the system places the activity count in the third SQLERRD element of the SQLCA structure.
If the cursor is updatable, or a C or COBOL application program contains a REWIND or POSITION TO STATEMENT request for the cursor, execute the OPEN statement with KEEPRESP; otherwise, execute it with NOKEEPRESP. For PL/I applications, KEEPRESP is the default.
You cannot execute OPEN as a dynamic SQL statement.
No more than 16 cursors can be open at one time because the processing of non-cursor-related statements is increasingly affected for the worse as more cursors are opened.
If an application has 16 cursors open, no other request can be issued until one or more cursors are closed.

Rules for USING Clause
The USING clause identifies variables used as input to the SQL statement by cursor_name.
host_variable_name must be a valid client language variable you declared before the OPEN statement, to be used as an input variable.
You can use a client structure to identify the input variables.

The number of variables you specify must be the same as the number of parameter markers (the question mark character) in the identified statement.

The n th variable corresponds to the n th marker.

Use of the colon character prefix for host_variable_name is optional.

descriptor_area identifies an input SQLDA structure, previously defined by the application, that contains necessary information about the input variable set.
The number of variables identified by the SQLD field of the SQLDA must be the same as the number of parameter markers (the question mark character) in the identified statement.

The n th variable described by the SQLDS corresponds to the n th marker.

Related Topics
For more information about:
Cursors referenced in the ALLOCATE statement, see ALLOCATE.
Creating casts and using the AS ASSIGNMENT option, see Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
descriptor_area, see Teradata® Preprocessor2 for Embedded SQL Programmer Guide, B035-2446.
OPEN (Embedded SQL Form), see CLOSE.
OPEN (Stored Procedures Form)
Purpose
Opens a declared cursor in a stored procedure and executes the SQL statement specified in its declaration.

Invocation
Executable.

Stored procedures only.

Syntax


cursor_name
The name of the cursor to be opened.
USING
Variables used as input to the SQL statement specified by cursor_name that must be declared before the OPEN statement.
SQL_identifier
A valid SQL identifier.
SQL_parameter
An SQL parameter.
ANSI Compliance
ANSI/ISO SQL:2011-compliant.

Authorization
None.

Returning a Result Set
The OPEN statement opens a result set cursor and executes the static or dynamic SELECT statement, which produces the result set. The system creates the result spool file, and positions the cursor before the first row of the spool file.

General Rules
You must previously declare the cursor identified by cursor_name.
The cursor identified by cursor_name must not already be open.
Rules for USING Clause
The number of variables specified must be the same as the number of parameter markers (the question mark character) in the identified statement. The n th variable corresponds to the n th marker.
You cannot execute OPEN as a dynamic SQL statement.
You can only use the USING clause in an OPEN cursor when the cursor is a dynamic SQL form.
No more than 15 cursors can be open at one time. If an application has 15 cursors open, no other request can be issued until one or more cursors are closed.
Example: Using the OPEN Statement
The following example is valid because the OPEN statement follows a valid cursor declaration statement in the same scope.

CREATE PROCEDURE sp1()
BEGIN
  DECLARE empcursor CURSOR FOR
    SELECT *
    FROM employee
    ORDER BY empid;
  OPEN empcursor;
  ...
END;
Example: Using the OPEN Cursor Statement and the USING Clause
In this example, the OPEN cursor statement is extended to allow a USING clause.

CREATE PROCEDURE abc (IN data1v VARCHAR(10), IN data2v VARCHAR(10) )
   DYNAMIC RESULT SETS 1
  BEGIN
     DECLARE sql_stmt1 VARCHAR(100);
     DECLARE sales DECIMAL(8,2);
     DECLARE item INTEGER;
     DECLARE cstmt CURSOR WITH RETURN ONLY FOR stmt1;
     SET sql_stmt1 = 'SELECT  T1.item, T1.sales FROM T1 WHERE ?'
                     '= store_name AND ? = region;';
     PREPARE stmt1 FROM sql_stmt1;
     OPEN cstmt USING data1v, data2v;
  END;
Related Topics
For more information about:
Returning a result set, see Returning Result Sets from a Stored Procedure.
OPEN (Stored Procedures Form), see CLOSE.
POSITION
Purpose
Positions a cursor to the beginning of the next statement or to the results of a specified statement.

Invocation
Executable.

Embedded SQL only.

Syntax


cursor_name
The name of an open cursor other than an Insertion cursor.
statement_number
An integer numeric for the statement number to which positioning is desired.
numeric_variable
A host variable conforming to type INTEGER that represents the statement number to which positioning is desired. Use of a colon character is optional.
ANSI Compliance
POSITION is ANSI/ISO SQL:2011-compliant.

Authorization
None.

Rules
The cursor is repositioned before the first result row (if any) of the statement specified and SQLSTATE, SQLCODE and other SQLCA values are set.

With POSITION TO NEXT, the cursor is positioned to the next statement.

With POSITION TO STATEMENT, the cursor is positioned to the specified statement.

If the specified statement number does not exist (for example, TO STATEMENT 3 is coded, but the cursor controls only two statements), the following runtime exception occurs, leaving the position of the cursor undefined:
SQLCODE is set to -501
SQLSTATE is set to ‘24501’
The cursor can be positioned either forward or backward from the current statement and can be repositioned to a given statement as many times as the application requires.

For COBOL programs with multiple compile units, the cursor can only be positioned backward if a REWIND or POSITION TO STATEMENT occurs in the same compile unit as the declaration and the opening of the cursor.

POSITION is valid with any cursor except an insertion cursor.

The statement set found by the cursor is not re-executed, but the cursor position in the spool file is adjusted accordingly.

You cannot execute POSITION as a dynamic SQL statement.

Related Topics
For more information about:
POSITION being valid with any cursor except an insertion cursor, see DECLARE CURSOR, DECLARE CURSOR (Macro Form), DECLARE CURSOR (Request Form) and DECLARE CURSOR (Selection Form)
POSITION, see REWIND.
PREPARE
Purpose
Prepares the dynamic DECLARE CURSOR statement to allow the creation of different result sets. Allows dynamic parameter markers.

Invocation
Executable.

Stored procedure only.

Syntax



statement_name
the same identifier as statement_name in a DECLARE CURSOR statement.
statement_string
the SQL text that is to be executed dynamically.
statement_string must be enclosed within apostrophes.
statement_string_variable
the name of an SQL local variable, or an SQL parameter or string variable, that contains the SQL text string to be executed dynamically.
This element should be a CHAR/VARCHAR variable less than 32000 characters.
ANSI Compliance
PREPARE is ANSI/ISO SQL:2011-compliant.

Authorization
None.

Rules
The Parser checks the syntax of the PREPARE statement. If there is a syntax error, the system returns a syntax exception.
You cannot execute PREPARE as a dynamic SQL statement.
The statement must be a dynamic cursor SELECT statement. If this is not the case, the system returns '07005' dynamic SQL error, prepared statement not a cursor specification.
The dynamic SQL statement text can be as long as 64 Kbytes (including SQL text, USING data, and parcel overhead).
You cannot specify multistatement requests.
The dynamic SQL statement can include parameter markers or placeholder tokens (the question mark), where any literal reference, particularly an SQL variable, is legal except in the select list.
The USING clause of the OPEN statement supplies values to the statement.
Example: Using PREPARE
CREATE PROCEDURE abc (IN data1v VARCHAR(10), IN data2v VARCHAR(10) )
   DYNAMIC RESULT SETS 1
  BEGIN
     DECLARE sql_stmt1 VARCHAR(100);
     DECLARE sales DECIMAL(8,2);
     DECLARE item INTEGER;
     DECLARE cstmt CURSOR WITH RETURN ONLY FOR stmt1;
     SET sql_stmt1 = 'SELECT  T1.item, T1.sales FROM T1 WHERE'  data1v
                     || '= store_name AND '   || data2v || '= region;';
     PREPARE stmt1 FROM sql_stmt1;
     OPEN cstmt;
  END;
Example: Using PREPARE with Parameter Markers
In this example, the PREPARE statement is written using parameter markers:

SET sql_stmt1 = 'SELECT  T1.item, T1.sales FROM T1 WHERE ?'
                '= store_name AND ? = region;';
PREPARE stmt1 FROM sql_stmt1;
OPEN cstmt USING data1v, data2v;
Related Topics
For use of the PREPARE statement in embedded SQL, see PREPARE.

REWIND
Purpose
Positions or repositions a cursor to the beginning of the results of its first or only statement.

Invocation
Executable.

Embedded SQL only.

Syntax


cursor_name
The name of an open cursor other than an Insertion cursor.
ANSI Compliance
REWIND is a Teradata extension to the ANSI/ISO SQL:2011 standard.

Authorization
None.

Usage Notes
The statement REWIND cursor_name is equivalent to the statement POSITION cursor_name TO STATEMENT 1.

Related Topics
See POSITION.

SELECT AND CONSUME … INTO
Purpose
Selects data from the row with the oldest insertion timestamp in the specified queue table, deletes the row from the queue table, and assigns the values in that row to host variables in an embedded SQL application or to local variables or parameters in stored procedures.

Invocation
Executable.

Stored procedures and embedded SQL.

Syntax: Stored Procedures Only


Syntax: Embedded SQL Only


select_list
An ASTERISK character (*) or a comma-separated list of valid SQL expressions.
If select_list specifies *, all columns from the queue table specified in the FROM clause are returned.
The select list must not contain aggregate or ordered analytical functions.
local_variable_name
The name of the local variable declared in the stored procedure into which the SELECTed data is to be placed.
You cannot use stored procedure status variables here.
queue_table_name
The name of a queue table that was created with the QUEUE option in the CREATE TABLE statement.
parameter_name
The name of the stored procedure parameter into which the SELECTed data is to be placed.
Only output parameters (INOUT and OUT type) can be specified.
host_variable_name
The name of the host variable into which the selected data is to be placed.
host_indicator_name
The name of the host indicator variable.
ANSI Compliance
SELECT AND CONSUME … INTO is a Teradata extension to the ANSI/ISO SQL:2011 standard.

Authorization
To execute a SELECT AND CONSUME … INTO from a queue table, you must have the SELECT and DELETE privileges on that table.

Attributes of a Queue Table
A queue table is similar to an ordinary base table, with the additional unique property of behaving like an asynchronous first-in-first-out (FIFO) queue.

The first column of a queue table contains Queue Insertion TimeStamp (QITS) values. The CREATE TABLE statement must define the first column with the following data type and attributes:

TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
The QITS value of a row indicates the time the row was inserted into the queue table, unless a different, user-supplied value is inserted.

Using a Colon Character in Embedded SQL
In embedded SQL, blanks before and after a colon character are optional; use of the colon character before host_variable_name is optional; a colon character must precede a host_indicator_name.

Rules for Embedded SQL
The same rules that apply to SELECT … INTO apply to SELECT AND CONSUME … INTO.

Related Topics
For more information about:
queue_table_name, see “CREATE TABLE (Queue Table Form)” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
Usage notes, information on transaction processing, locks, and restrictions, see “SELECT AND CONSUME” in Teradata Vantage™ SQL Data Manipulation Language , B035-1146 .
The rules that apply to SELECT … INTO and SELECT AND CONSUME … INTO, see Rules for Embedded SQL.
SELECT … INTO
Purpose
Selects at most one row from a table and assigns the values in that row to host variables in an embedded SQL application or to local variables or parameters in stored procedures.

Invocation
Executable.

Stored procedures and embedded SQL.

Syntax: Stored Procedures Only



Syntax: Embedded SQL Only



with_[recursive]_modifier
A recursive query that provides a way to search a table using iterative self-join and set operations if WITH RECURSIVE is used.
The nonrecursive WITH request modifier is similar to a derived table.
select_list
An asterisk (*) or a comma-separated list of valid SQL expressions.
The select list can contain instances of the DEFAULT function, but must not contain aggregate or ordered analytical functions.
Stored procedures only:
Teradata Database performs implicit conversions for DateTime data types. For all other data types, the select list data types must match the INTO clause target list data types.
If the select list data types do not match the INTO clause target list data types, you can specify an explicit CAST to the target type to enable the operation to succeed.
Columns specified in the select and INTO lists can have UDT data types, except for the VARIANT_TYPE UDT data type. The system automatically applies any implicit conversions defined for the UDT if they exist.
The system applies implicit casting of the select list data types from UDTs to predefined data types or from predefined types to UDTs only if a CAST to the target type exists and was created with the AS ASSIGNMENT option specified.
host_variable_name
The name of the host variable into which the selected data is to be placed.
host_indicator_name
The name of the host indicator variable.
from_clause
A clause listing the tables or views referenced by the SELECT.
where_clause
A clause narrowing a SELECT to those rows that satisfy a conditional expression that it specifies.
The WHERE clause can contain the DEFAULT function as a component of its predicate.
local_variable_name
The name of the local variable declared in the stored procedure into which the SELECTed data is to be placed.
You cannot use stored procedure status variables here.
Stored procedures only: A local variable can have a UDT type, except for the VARIANT_TYPE UDT data type.
You must have the UDTUSAGE privilege on any UDT used as a local variable.
parameter_name
The name of the stored procedure parameter into which the SELECTed data is to be placed.
Only output parameters (INOUT and OUT type) can be specified.
Stored procedures only: A parameter can have a UDT type, except for the VARIANT_TYPE UDT data type.
You must have the UDTUSAGE privilege on any UDT used as a parameter.
ANSI Compliance
SELECT … INTO is ANSI/ISO SQL:2011-compliant.

Authorization
To select data from a table, you must have SELECT privilege on that table.

To select data through a view, you must have the SELECT privilege on that view. Also, the immediate owner of the view (that is, the database in which the view resides) must have SELECT WITH GRANT OPTION privileges on all tables or views referenced in the view.

For stored procedures, the local variables and parameters in the select and INTO lists can be UDTs, except VARIANT_TYPE UDTs.

You must have the UDTUSAGE privilege on any local variable or parameter that has a UDT data type.

Recursive Query Example
The following example shows a recursive query used inside a client application:

EXEC SQL
      WITH RECURSIVE Reachable_From (Source, Destin, mycount)AS
   (      SELECT Root.Source, Root.Destin, 0 as mycount
          FROM Flights Root
          WHERE Root.Source = ‘Paris’
      UNION ALL
          SELECT in1.Source, out1.Destin, in1.mycount + 1
          FROM Reachable_From in1, Flights out1
          WHERE in1.Destin = out1.Source
          AND in1.mycount <= 100
      )
      SELECT Source, Destin
      INTO :intosource INDICATOR :indvar1
      :intodestin INDICATOR: indvar2
      FROM Reachable_From;
END-EXEC
In this example, the host variables intosource and intodestin and indicator variables indvar1 and indvar2 are being used in the final SELECT of the recursive query. These variables cannot be used inside the recursive query definition.

Rules for Using a Colon Character
Following are the rules for using a colon character in embedded SQL:
Pad characters preceding and following a colon character are optional.
A prepending colon character for host_variable_name is optional.
A prepending colon character must precede a host_indicator_name.
Following are the rules for using a colon character in stored procedures:
A prepending colon character preceding a local_variable_name is optional.
A prepending colon character preceding a param_name is optional.
Rules for Stored Procedures
The order of specifying the various clauses in SELECT … INTO is significant in stored procedures. The following must be specified in the given order:
WITH [RECURSIVE] request modifier
SELECT clause
INTO list
FROM clause
If any other element intervenes between the INTO list and FROM, it will result in an error. You can specify all other clauses in the statement in any order.

You have to specify the column list explicitly in the SELECT clause. The SELECT * syntax is not allowed in stored procedures.

The SELECT privilege is required on all tables specified in the FROM clause and in any subquery contained in the query specification, or on the database(s) containing the tables.

For stored procedures, you must also have the UDTUSAGE privilege on any UDT used as the data type for any column in the select and INTO lists.

UNION, INTERSECT and MINUS clauses are not supported in the SELECT … INTO statement.

The number of columns specified by the select list must match the number of local variable and parameter specifications.

The local variable or parameter and the corresponding column in the returned data must be of compatible data type. Teradata Database performs implicit conversions for DateTime data types when the data type of the local variable or parameter differs from the corresponding column data type.

For stored procedures, you must have the UDTUSAGE privilege on any UDT used as a local variable or parameter.

If an error or failure occurs for the statement, normal exception condition handling takes place.

The SELECT … INTO statement is normally expected to return at most one row. One of the following actions is taken after executing the statement:

IF SELECT … INTO returns …	The stored procedure status variables show these values …	Which mean …
more than one row	
SQLCODE = 7627
SQLSTATE = ‘21000’
ACTIVITY_COUNT =number of rows found.

an exception condition (a failure in Teradata session mode and error in ANSI session mode)
A specific condition handler or a generic handler can be specified to handle this condition. The values of local variables and parameters do not change.

no rows, without an execution warning	
SQLCODE = 7632
SQLSTATE = ‘02000’
ACTIVITY_COUNT = 0
a completion condition other than successful completion.
A specific condition handler can be specified to handle this completion condition. The values of local variables and parameters do not change.

no rows, with an execution warning	SQLCODE = the warning code.
SQLSTATE =SQLSTATE value corresponding to the warning.

ACTIVITY_COUNT = 0.
a completion condition other than successful completion.
A specific condition handler can be specified to handle this completion condition. The values of local variables and parameters do not change.

exactly one row without an execution warning	
SQLCODE = 0
SQLSTATE = ‘00000’
ACTIVITY_COUNT = 1
the fetched values are assigned to the local variables and parameters.
This is a successful completion. A specific handler cannot be specified to handle this.

exactly one row with an execution warning	SQLCODE = the warning code.
SQLSTATE =SQLSTATE value corresponding to the warning.

ACTIVITY_COUNT = 1
the fetched values are assigned to the local variables and parameters.
This is a completion condition other than successful completion. A specific handler can be specified to handle this condition.

Rules for Embedded SQL
UDTs are not specifically supported.

Note, however, that UDTs for which tosql and fromsql transforms have been defined can be externally referenced by means of their transform target data types. As a result, embedded SQL applications can use SQL statements that reference UDTs provided that the UDTs have a defined tosql or fromsql transform as appropriate.

Additionally, the application must send and receive UDT data in the form of its external (non-UDT) data type.

The SELECT privilege is required on all tables specified in the FROM clause and in any subquery contained in the query specification, or on the database set containing the tables.

The number of columns specified by select_list must match the number of host variable specifications.

Values are assigned to the host variables specified in the INTO clause in the order in which the host variables were specified. A value is assigned to SQLCODE last.

The main host variable and the corresponding column in the returned data must be of the same data type group, except that if the main host variable data type is approximate numeric, the temporary table column data type can be either approximate numeric or exact numeric.

If the temporary table contains zero rows (is empty), the value +100 is assigned to SQLCODE and no values are assigned to the host variables specified in the INTO clause.

If exactly one row of data is returned, the values from the row are assigned to the corresponding host variables specified in the INTO clause.

If more than one row of data is returned, the value -810 is assigned to SQLCODE, and no values are assigned to the host variables specified in the INTO clause.

If an error occurs in assigning a value to a host variable, one of the values -303, -304, or -413 is assigned to SQLCODE, and no further assignment to host variables occurs.

If a column value in the returned data is NULL and a corresponding indicator host variable is specified, the value -1 is assigned to the indicator host variable and no value is assigned to the main host variable. If no corresponding indicator host variable is specified, the value -305 is assigned to SQLCODE and no further assignment to host variables occurs.

If a column value in the returned data is NOT NULL and a corresponding indicator host variable is specified, the indicator host variable is set as follows:
If the column and main host variable are of character data type and the column value is longer than the main host variable, the indicator host variable is set to the length of the column value.
In all other cases, the indicator variable is set to zero.
If no other value is assigned to SQLCODE, the value zero is assigned to SQLCODE.

Column values are set in the corresponding main host variables according to the rules for host variables.

You cannot execute SELECT... INTO as a dynamic SQL statement.

SELECT … INTO supports browse mode SELECT operations for queue tables.

Rules for Using the DEFAULT Function With SELECT Statements
The DEFAULT function takes a single argument that identifies a relation column by name. The function evaluates to a value equal to the current default value for the column. For cases where the default value of the column is specified as a current built-in system function, the DEFAULT function evaluates to the current value of system variables at the time the request is executed.
The resulting data type of the DEFAULT function is the data type of the constant or built-in function specified as the default, unless the default is NULL. If the default is NULL, the resulting data type is the data type of the column or expression for which the default is being requested.

The DEFAULT function has two forms. It can be specified as DEFAULT or DEFAULT (column_name). When no column name is specified, the system derives the column based on context. If the column context cannot be derived, the request aborts and an error is returned to the requestor.
You can specify a DEFAULT function with a column name in the select list of a SELECT statement. The DEFAULT function evaluates to the default value of the specified column.
You cannot specify a DEFAULT function without a column name in the expression list. The system aborts the request and returns an error to the requestor.
If you specify a SELECT statement that does not also specify a FROM clause, the system always returns a single row with the default value of the column, regardless of how many rows are in the table.
This is similar to the existing TYPE function.

When the column passed as an input argument to the DEFAULT function does not have an explicit default value associated with it, the DEFAULT function evaluates to null.
Related Topics
For more information about:
with_[recursive]_ modifier, see “WITH [RECURSIVE] Request Modifier” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
select_list, see Rules for Using the DEFAULT Function With SELECT Statements.
Implicit data type conversions and the CAST function, see “Data Type Conversions” in Teradata Vantage™ Data Types and Literals, B035-1143.
See the CALL statement in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144 for more details on authorization required.
Creating a cast and using the AS ASSIGNMENT option, see “CREATE CAST” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
from_clause, see “FROM Clause” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
Rules for Using the DEFAULT Function With SELECT Statements and the documentation for “WHERE clause,” see Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
Performing implicit conversions for DateTime data, see “Data Type Conversions” in Teradata Vantage™ Data Types and Literals, B035-1143.
SELECT … INTO supporting browse mode SELECT operations for queue tables, see “CREATE TABLE (Queue Table Form)” in Teradata Vantage™ SQL Data Definition Language Syntax and Examples, B035-1144.
the DEFAULT function, see Teradata Vantage™ SQL Functions, Expressions, and Predicates, B035-1145.
UPDATE (Positioned Form)
Purpose
Updates the most current fetched cursor row.

Invocation
Executable.

Stored procedures and embedded SQL.

Syntax


table_name
The name of the table to be updated.
correlation_name
An alias for the table name.
Correlation names are also referred to as range variables.
column_name = expression
A column name and value with which to update.
When host variables are used in the SET clause, they must always be preceded by a colon character.
cursor_name
The name of the updatable cursor being used to point to the rows to be updated.
ANSI Compliance
The positioned form of UPDATE is ANSI/ISO SQL:2011-compliant.

Authorization
You must have the UPDATE privilege on the table or columns to be updated.

When executing an UPDATE that also requires READ access to an object, you must have the SELECT right to data being accessed.

For example, in the following statement, READ access is required by the WHERE condition.

UPDATE table_1
SET field_1=1
WHERE field_1<0;
Similarly, the following statement requires READ access because you must read field_1 values from table_1 to compute the new values for field_1.

UPDATE table_1
SET field_1 = field_1 + 1;
An UPDATE operation sets a WRITE lock for the table or row being updated.

The activity count in the success response for an UPDATE statement reflects the total number of rows updated. If no rows qualify for update, then the activity count is zero.

UPDATE With Correlated Subqueries
See “Correlated Subqueries and the UPDATE Statement” in Teradata Vantage™ SQL Data Manipulation Language , B035-1146 for information about using correlated subqueries with UPDATE statements.

Large Objects and UPDATE
The behavior of truncated LOB updates differs in ANSI and Teradata session modes. The following table explains the differences in truncation behavior.

In this session mode …	When non-pad bytes are truncated on insertion …
ANSI	an exception condition is raised.
The UPDATE fails.

Teradata	no exception condition is raised.
The UPDATE succeeds: the truncated LOB is stored.

Update of GENERATED ALWAYS Identity Columns and PARTITION
You cannot update the following set of system-generated columns:
GENERATED ALWAYS identity columns
PARTITION
You can update a GENERATED BY DEFAULT identity column. The specified value is not constrained by identity column parameters, but is constrained by any CHECK constraints defined on the column.

Support of Mutator SET Clauses
Because UDTs are not supported in embedded SQL, the mutator SET clause is not supported for the positioned form of UPDATE.

Rules for UPDATE in ANSI Session Mode
The WHERE CURRENT OF clause enables a UPDATE statement to act on a data row currently pointed to by the cursor named in WHERE CURRENT OF cursor_name. Such a cursor is said to be updatable.
You need not include a specification of intent to update or delete a row when you declare cursor_name.
Multiple updates of the currently fetched row of cursor_name or updates followed by a delete of the currently fetched row of cursor_name are valid.
Rule for Updating Partitioning Columns of a PPI Table
If you are updating a partitioning column for a partitioned primary index, then updates to the partitioning columns must be in a range that permits the partitioning expression to produce, after casting values to INTEGER if the value is not already of that type, a value that is not null between 1 and 65535.

Rules for Using the DEFAULT Function
The DEFAULT function takes a single argument that identifies a relation column by name. The function evaluates to a value equal to the current default value for the column. For cases where the default value of the column is specified as a current built-in system function, the DEFAULT function evaluates to the current value of system variables at the time the statement is executed.
The resulting data type of the DEFAULT function is the data type of the constant or built-in function specified as the default unless the default is NULL. If the default is NULL, the resulting date type of the DEFAULT function is the same as the data type of the column or expression for which the default is being requested.

The DEFAULT function has two forms. It can be specified as DEFAULT or DEFAULT (column_name). When no column name is specified, the system derives the column based on context. If the column context cannot be derived, the request aborts and an error is returned to the requestor.
You can specify a DEFAULT function without a column name argument as the expression in the SET clause. The column name for the DEFAULT function is the column specified as the column_name. The DEFAULT function evaluates to the default value of the column specified as column_name.
You cannot specify a DEFAULT function without a column name argument as part of the expression. Instead, it must be specified by itself. This rule is defined by the ANSI/ISO SQL:2011 specification.
You can specify a DEFAULT function with a column name argument in the source expression. The DEFAULT function evaluates to the default value of the column specified as the input argument to the DEFAULT function.
For example, DEFAULT(col2) evaluates to the default value of col2. This is a Teradata extension to the ANSI/ISO SQL:2011 specification.

You can specify a DEFAULT function with a column name argument anywhere in an update expression. This is a Teradata extension to the ANSI/ISO SQL:2011 specification.
When no explicit default value has been defined for a column, the DEFAULT function evaluates to null when that column is specified as its argument.
Example: Using the Cursor to Update the Table
In this example, the name of the cursor used to update the table is cursor_01.

EXEC SQL
 UPDATE table_1
 SET text = :text, K = :I + 1000
 WHERE CURRENT OF cursor_01;
Related Topics
For more information about:
The mutator SET clause, see “UPDATE” in Teradata Vantage™ SQL Data Manipulation Language , B035-1146 for details about mutator SET clauses.
General information about the DEFAULT function, see Teradata Vantage™ SQL Functions, Expressions, and Predicates, B035-1145.



