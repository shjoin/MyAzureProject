import os,subprocess
query = '''
WHENEVER SQLERROR EXIT FAILURE
SET FEEDBACK OFF
SET HEAD OFF
SET EMB ON PAGES 0 NEWP
SET LINE 10000
SELECT * from dual;
EXIT;
'''

#    $ORACLE_HOME/bin/sqlplus -l -s /@$GV_WALLET_USER @$SQLname $GV_SCHEMA  $STMT      >> $LOGname 2>&1

db_home=/orahome/Database/db12c
dbsession = subprocess.Popen(["/usr/bin/sudo","su","-","oracle","-c",""""""""+db_home+"""/bin/sqlplus -S / as sysdba"""""], stdin=subprocess.PIPE,stdout=subprocess.PIPE, stderr=subprocess.PIPE,env={"ORACLE_SID": "EMREP", "ORACLE_HOME": "+db_home+"})
dbsession.stdin.write(query)
query_result = dbsession.communicate()
print(query_result, dbsession.returncode)