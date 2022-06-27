import subprocess
import sys, threading, logging
#from subprocess import Popen, PIPE
from datetime import datetime
import logging


'''
class DWH:
 def connetDWH(con):
#con = cx_Oracle.connect('pythonhol/welcome@localhost/orcl')
    con.db=cx_Oracle.connect(OracleDbWallet.DbUser,OracleDbWallet.DbPassword,OracleDbWallet.DbTns)
    con.cur=con.db.cursor()
    return con

def conExit(con,type,value,traceback)
    con.cursor.close()
    con.db.close()

'''

#syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM

#In python, Popen class (of subprocess module) can be used to invoke a sqlplus session.
#session = Popen([‘sqlplus’,’-S’,’hr/hr’], stdin=PIPE, stdout=PIPE, stderr=PIPE)

# function that takes the sqlCommand and connectString and returns the queryReslut and errorMessage (if any)
def runSqlPlusQuery_SP(APP_ENV, connectString,sqlscript ):
       d = datetime.now()
       only_date, only_time = d.date(), d.time()
       print(only_date, only_time)
       #cursor.execute("INSERT INTO myTable VALUES(to_date('" + str(datetime.now().replace(microsecond=0)) + "','yyyy-mm-dd hh24:mi:ss'))")
       test_id=100
       process_name='LOCAL TEST2'
       #sql = ('insert into dwh.TEST_PYTH (test_id, process_name) '
         #     'values(:test_id,:process_name)')

      # sp = subprocess.Popen(sqlpluspath + ' -l' ' -s ' + connectString + '  @' + sqlscript, shell=True,
      #                           stdout=subprocess.PIPE,
      #                           # stdout=f,
      #                           stderr=subprocess.PIPE)
       sp = subprocess.Popen(connectString , shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
       print('Running Now .. ',connectString)
       rc = sp.wait()
       print("Sctipt Executed ")
       o, e = sp.communicate()
       print("RUN END  ")
       return o, e
       # establish a new connection
            #curr=connectString.connect()
            #curr.callproc(sqlscript, [process_name])
            #connect = connectString.
            #cursor = connect.cursor()
            #cursor.execute(sql, [test_id, process_name])
            #connectString.callproc(sqlscript,[process_name])
            #cursor.callproc(sqlscript,[process_name])
                                 # [l_department_id, p_department_name, p_manager_id, p_location_id]) proc parameters
                           #https://www.oracle.com/technical-resources/articles/prez-stored-proc.html
                          #l_count = self.__cursor.callfunc("PKG_HR.GET_EMPLOYEE_COUNT",   cx_Oracle.NUMBER, [p_department_id])



def runSqlPlusQuery2(APP_ENV, connectString, sqlscript ):
    #session = Popen(['sqlplus', '-S', connectString], stdin=PIPE, stdout=PIPE, stderr=PIPE)
   # $ORACLE_HOME/bin/sqlplus -l -s /@$GV_WALLET_USER @$SQLname $GV_SCHEMA  $STMT
    # Start the SQL command
    sqlplus_command = ["sqlplus"]
    sqlplus_command.append("-l")  # fail if password is incorrect or any other issue, do not retry
    sqlplus_command.append("-S")  # don't show sqlplus banners and such
    sqlplus_command.append(f"/@{connectString}")
    #sqlplus_command.append(f"@{sqlscript}")
    # a user connection is user@db or user/pwd@db
    logging.info("********************************")
    logging.info(sqlplus_command)
    # get a temporary log file so we don't automatically spool large volumes of data to run log
    temp_log_file = 'MyTestLog.log' #logging.log.get_new_temp_log_file(APP_ENV)
    logging.info(f"SQL Command Temp Log File: {temp_log_file}")
    logging.info("********************************")


    print("RUN SQL ", sqlplus_command)
    process_session = subprocess.Popen(sqlplus_command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
# $ORACLE_HOME/bin/sqlplus -l -s /@$GV_WALLET_USER @$SQLname $GV_SCHEMA  $STMT
#    process = subprocess.Popen(sqlplus_cmd,
 #                              stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    # tee out and save the command output by piping into the stdin from the previous command
    #tee = subprocess.Popen(['tee', '-a', temp_log_file], stdin=process_session.stdout)

    process_session.stdin.write()
    stdout, stderr = process_session.communicate()
        # Get return code of sql query
    stdout_lines = stdout.split("\n")
    print('STDOUT')

    # close the stream
    process_session.stdout.close()
    # force a pause
    streamdata = process_session.wait()
    print("RUN END  ")
    # get the return code from the command not the tee
    #ret_code = tool.returncode
    # force the tee to flush and end
    #tee.communicate()
    # force the tee to flush and end
    #tee.communicate()
    # here we read the log file into the std log
    #with open(temp_log_file) as f:
     #   logging.info(f.read())



   # return ret_code