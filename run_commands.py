"""
  This file handles running shell commands
"""
import subprocess, sys, threading, logging
from datetime import datetime
import log, environment

def run_sql(cmd, logfile):
    """
        This proc runs commands created in other procs below
    """
    # Run the command asunchronously
    tool = subprocess.Popen(cmd,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    
    # tee out and save the command output by piping into the stdin from the previous command                        
    tee = subprocess.Popen(['tee', '-a', logfile], stdin=tool.stdout)

    # close the stream
    tool.stdout.close()
    # force a pause
    streamdata = tool.wait()
    #get the return code from the command not the tee
    ret_code =  tool.returncode
    # force the tee to flush and end
    tee.communicate()

    return ret_code

def run_sql_plus(ev, connect_type, connect_string, script, params):
    """
        This proc runs sqlplus

        Running psql for redshift would look a lot like this but would only need the 
        connect_type = user as there is no wallet for redshift
    """

    # Start the SQL command
    sql_command = ["sqlplus"]

    sql_command.append("-l")   # fail if password is incorrect or any other issue, do not retry
    sql_command.append("-s")   # don't show sqlplus banners and such

    # a user connection is user@db or user/pwd@db
    if connect_type == "user":
        # The -s prevents the password prompt from appearing
        # Hence the print statement below
        # if we need it, we can create a user type that prompts for user name also. Would need to send to stdin though
        print()
        print(f"Enter the password for {connect_string}")

        sql_command.append(connect_string)
        sql_command.append(f"@{script}")

    # a wallet connection is /@wallet
    elif connect_type == "wallet":
        sql_command.append(f"/@{connect_string}")
        sql_command.append(f"@{script}")
        
    # add any params to the command string
    for param in params:
        #print(f"param: {param}")
        sql_command.append(environment.interpolate_value(param, ev))
    
    logging.info("********************************")
    logging.info(sql_command)

    # get a temporary log file so we don't automatically spool large volumes of data to run log
    temp_log_file = log.get_new_temp_log_file(ev)

    logging.info(f"SQL Command Temp Log File: {temp_log_file}")
    logging.info("********************************")

    # run the command
    obj = run_sql(sql_command, temp_log_file)

    # here we read the log file into the std log
    with open(temp_log_file) as f:
        logging.info(f.read())

    return obj







