import subprocess,util,datetime
import os,logging,logs,socket


#from subprocess import Popen, PIPE

# $ORACLE_HOME/bin/sqlplus -l -s /@$GV_WALLET_USER @$SQLname $GV_SCHEMA  $STMT    >>  $LOGname 2>&1

def subprocessing():
    sql_command = ["sqlplus"]
    sql_command.append("-l")   # fail if password is incorrect or any other issue, do not retry
    sql_command.append("-s")   # don't show sqlplus banners and such
    #sql_command.append("-version")  # don't show sqlplus banners and such
    #ConnStr= util.connectionstring
    ConnStr='dtm/$dtm123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM'
    #print('connectstr',ConnStr)
    #sql_command.append(f"/@{ConnStr}")
    PYname='dtmk079.py'
    GV_WALLET_USER='SYNDWD_DTM'
    GV_SCHEMA='dtm'
    #>sqlplus -l -s dwh/$dwh123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM
    '''sql_command.append(f"/@{GV_WALLET_USER}")
    SQLname ='C:/Users/sjoshi2/Documents/PythonShjo/MyProject/dtms001.sql'
    sqlplus -l -s     dtm/$dtm123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM EXEC pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500,'test RUN','prc_ins_ft_pot_remit_summary'); 
    #sqlplus -l -s     dtm/$dtm123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM @C:/Users/sjoshi2/Documents/PythonShjo/MyProject/dtms002.sql
    sqlplus''-l''-s', 'dtm/$dtm123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM', ' @C:/Users/sjoshi2/Documents/PythonShjo/MyProject/dtms002.sql
    pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500,'test RUN','prc_ins_ft_pot_remit_summary')
    STMT = "pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500," + PYname+ ",prc_ins_ft_pot_remit_summary)"
    sql_command.append(f"@{SQLname}")
    sql_command.append(f"@{GV_SCHEMA}")
    sql_command.append(f"@{STMT}")
    print('sqlcommand', sql_command)
    '''

    SQLname = 'C:/Users/sjoshi2/Documents/PythonShjo/MyProject/dtms002.sql'

    sql_command.append(f"{ConnStr}")
    #sql_command.append(f" @{SQLname}")
    #print('SHJO sqlcommand', sql_command)
    #sqlplus -l -s dwh/$dwh123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM@select sysdate from dual
    #$ORACLE_HOME/bin/sqlplus -l -s /@$GV_WALLET_USER @$SQLname $GV_SCHEMA  $STMT    >>  $LOGname 2>&1
    #C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Oracle - OraClient12Home1\Application Development\

    #sp=subprocess.Popen(sql_command,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    #sp = subprocess.Popen(
    connstring='dtm/$dtm123@syndwd:1591/SYNDW.INT.SYNAPSEGROUPINC.COM'
    sqlpluspath='C:/Oracle/app/client/product/12.1.0/client_64bit/BIN/sqlplus.exe'
    GV_HOME='C:/Users/sjoshi2/Documents/PythonShjo/MyProject'
    PYname =GV_HOME +'/' + GV_SCHEMA +'/'+ 'py'

    sqlscript=GV_HOME +'/' + GV_SCHEMA +'/' +'dtms002.sql'
    hostname = socket.gethostname()
    log_file = 'dtmk079._' + datetime.datetime.now().strftime("%m%d%y") + '-' + datetime.datetime.now().strftime(
        "%H%M%S") + '.log'
    logging.basicConfig(level=logging.INFO,
                        format='%(asctime)s %(name)-12s %(levelname)-8s %(message)s',
                        datefmt='%m-%d %H:%M',
                        filename=log_file,
                        filemode='w')
    logging.info("********************************")
    logging.info(connstring)
    logging.info(sqlscript)
    logging.info(sqlpluspath)
    logging.info(hostname)
    logging.info(PYname)

    # get a temporary log file so we don't automatically spool large volumes of data to run log


    #logs.log_file(temp_log_file)


    #hostname #devbatch01 user #syndeploy:  file / home1 / syndw / dtm / ksh:
    #with open ('outputfile.txt','w') as f: # create a output file with below script stdout as log of sqlplus
    sp = subprocess.Popen(sqlpluspath + ' -l' ' -s ' + connstring + '  @'+ sqlscript,shell=True,
                          stdout=subprocess.PIPE,
                          #stdout=f,
                          stderr=subprocess.PIPE)

    print ('Running Now')
    #If PIPE is passed to stdin argument, the Process.stdin attribute will point to a StreamWriter instance.
    #If PIPE is passed to stdout or stderr arguments, the Process.stdout and Process.stderr attributes will point to StreamReader instances.
    rc=sp.wait()
    o,e = sp.communicate()

    #logs.log(temp_log_file, o, e)
    stdout_lines_out = o.decode('utf-8').split("\n")
    for line in stdout_lines_out:
        logging.info(line)

    stdout_lines_err = e.decode('utf-8').split("\n")
    for line in stdout_lines_err:
        logging.info(line)



   # print(f"Out:{o}")
   # print(f"Error:{e}")
    '''if rc==0:
        print('SHJO OUT PUT',o)
    else:
        print('SHJO ERROR',e)
'''

if __name__ == "__main__":
      subprocessing()




