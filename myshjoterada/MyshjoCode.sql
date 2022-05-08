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
  
 CALL CVS_TD_DB.shjo_proc_6(:rowCount,5678.98,'Marketing','U');
 
 
  update CVS_TD_DB.Temp_employee3  
  set dept_name ='Marketing'
  where dept_id =3;
 
       select * from CVS_TD_DB.Temp_employee3 ;
       
       

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
    
     select * from CVS_TD_DB.Temp_employee3 ;
        
        delete CVS_TD_DB.Temp_employee3 ;

commit;

INSERT INTO CVS_TD_DB.Temp_employee3 (employee_id,employee_name,dept_id,position_,salary,dept_name) 
      Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
             from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id ;
                         

                         
                         
        alter table  CVS_TD_DB.Temp_employee3 add Btach_no integer;
        
           alter table  CVS_TD_DB.Temp_employee3 add Dept_name varchar(10);

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
	--Commit;
    CLOSE cursor_emp;
  END Lmain;
  
    CALL CVS_TD_DB.shjo_proc_2();
    
     select * from CVS_TD_DB.Temp_employee3 ;
        
        delete CVS_TD_DB.Temp_employee3 ;
        
        commit;
    
        
        Executed as Single statement.  Failed [5526 : HY000] Stored Procedure is not created/replaced due to error(s).{Nested Failure Msg [5526 : HY000] SPL1035:E(L20), 
        No loop context for LEAVE statement with label 'label1'.} 
Elapsed time = 00:00:00.184 
 
STATEMENT 1: REPLACE  failed. 

  
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
	DECLARE cursor_emp CURSOR FOR Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
             from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id ORDER BY 1;
    OPEN cursor_emp;
	 label1: BEGIN                     
	    delete CVS_TD_DB.Temp_employee3 ;        
        INSERT INTO CVS_TD_DB.Temp_employee3 (employee_id,employee_name,dept_id,position_,salary,dept_name) 
          Select employee_id,employee_name,d.dept_id,position_,salary,dept_name
             from CVS_TD_DB.employee e ,CVS_TD_DB.dept d
                         where e.dept_id=d.dept_id ;
     END label1;                    
        commit;
         
     CLOSE cursor_emp;    
  END Lmain; 
  
  
   CALL CVS_TD_DB.shjo_proc_3();
   
   
   select * from CVS_TD_DB.Temp_employee3 ;
   
  
  Executed as Single statement.  Failed [5526 : HY000] Stored Procedure is not created/replaced due to error(s).{Nested Failure Msg [5526 : HY000] SPL1027:E(L25), 
  Missing/Invalid SQL statement'E(3810):Column/Parameter 'CVS_TD_DB.Temp_employee3.batch_no' does not exist.'.} 
Elapsed time = 00:00:00.067 
 
STATEMENT 1: Create Procedure failed. 

  
 Executed as Single statement.  Failed [5526 : HY000] Stored Procedure is not created/replaced due to error(s).{Nested Failure Msg [5526 : HY000] SPL2001:E(L13), 
 Undefined symbol 'cur_employee_id'.}{Nested Failure Msg [5526 : HY000] SPL2001:E(L13), 
 Undefined symbol 'cur_employee_name'.}{Nested Failure Msg [5526 : HY000] SPL2001:E(L13), 
 Undefined symbol 'cur_dept_id'.}{Nested Failure Msg [5526 : HY000] SPL2001:E(L13), 
 Undefined symbol 'cur_position_'.}{Nested Failure Msg [5526 : HY000] SPL2001:E(L13),
 Undefined symbol 'cur_salary'.}{Nested Failure Msg [5526 : HY000] SPL2001:E(L13),
 Undefined symbol 'cur_dept_name'.}{Nested Failure Msg [5526 : HY000] SPL1027:E(L19), Missing/Invalid
 SQL statement'E(5628):Column cur_employee_id not found in CVS_TD_DB.Temp_employee3.'.} 
Elapsed time = 00:00:00.066 
 
STATEMENT 1: Create Procedure failed. 
 
