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






CREATE USER SYSDBA FROM DBC AS PERM=10 SPOOL=10, TEMPORARY=0, PASSWORD=********;password sysdba

GRANT SELECT,EXECUTE ON DBC TO SYSDBA WITH GRANT OPTION;

GRANT ALL ON SYSDBA TO SYSDBA WITH GRANT OPTION;


CREATE USER shjoin FROM CVS_TD_DB AS PERM=10 SPOOL=10, TEMPORARY=0, PASSWORD=********;
shjoin

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