.LOGTABLE CVS_TD_DB.Employee_log;  
.LOGON 192.168.11.128 /dbc,dbc; 


   .BEGIN MLOAD TABLES CVS_TD_DB.employee1;  
 .LAYOUT Employee1;  
      .FIELD in_Employee_ID * VARCHAR(10);  
      .FIELD in_Employee_Name * VARCHAR(10); 
      .FIELD in_Dept_ID * varchar(10);  
      .FIELD in_Position_ * VARCHAR(10); 
      .FIELD in_salary * varchar(10);   
	 
      .DML LABEL EmpLabel; 
      INSERT INTO CVS_TD_DB.employee1 (
         Employee_ID,
         Employee_name,
         Dept_id,
         Position_,
         salary
      )  
      VALUES (
         :in_Employee_id,
         :in_Employee_Name,
         :in_Dept_ID,
         :in_Position_,
         :in_salary
         
      );
      .IMPORT INFILE "C:\Teradata\work\employee1.txt"  
      FORMAT vartext ','
      LAYOUT Employee1
      APPLY EmpLabel;    
.END MLOAD; 



   .BEGIN MLOAD TABLES CVS_TD_DB.employee2;  
 .LAYOUT Employee2;  
      .FIELD in_Employee_ID * VARCHAR(10); 
      .FIELD in_Employee_Name * VARCHAR(10); 
      .FIELD in_Dept_ID * varchar(10);  
      .FIELD in_Position_ * VARCHAR(10); 
      .FIELD in_salary * varchar(10);   
	 
      .DML LABEL EmpLabe2; 
      INSERT INTO CVS_TD_DB.employee2 (
         Employee_ID,
         Employee_name,
         Dept_id,
         Position_,
         salary
      )  
      VALUES (
         :in_Employee_id,
         :in_Employee_Name,
         :in_Dept_ID,
         :in_Position_,
         :in_salary
         
      );
      .IMPORT INFILE "C:\Teradata\work\employee1.txt"
      FORMAT vartext ','
      LAYOUT Employee2
      APPLY EmpLabe2;    
.END MLOAD; 
   
LOGOFF;

