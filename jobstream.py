""" This file does the actual step processing from the deployment """
import json, logging, argparse
import run_commands, synemail

def get_jobs(args : dict, ev : dict):
    """this function reads the json file and sets some parameters"""

    # open and read the json file sent in the cli args
    with open(args.JSONFILE) as f:
        data = json.load(f)

    # move all json attributes that are outside of the steps into the EV variables for access globally
    for k,v in data['deployment'].items():
        # skip non-env variables
        if k == "env":
            for d,j in v[ev["APPENV"]].items():
                print(f"j={j} and d={d}")
                ev[d] = j


        if k != "steps":
            logging.debug(f"adding key {k} to ev with value {v}")
            ev[k] = v

    logging.debug("in jobstream")

    # the jobstream is the array of data defined in the json steps array
    jobstream = data['deployment']["steps"]

    return jobstream
    
def runstream(args : dict, ev : dict, jobstream : dict):
    """this function runs the steps in the jobstream"""
    for i, step in enumerate(jobstream):
        if i >= int(ev.get('first_step', 0)) and i <= int(ev.get('last_step', 9999)):
            x = runjobstep(args, ev, step) 
            logging.debug(f"just ran {step['name']} and got {x}")

    return x        


def runjobstep(args : dict, ev : dict, step : list):
    """this function determines the type of step and calls the correct function to run an individual job step"""
    logging.debug(step)

    #get the run type from the json for this step
    runtype = step['type']
    logging.debug(runtype)

    # build a function switcher for the run type (like a case statement but very pythonic)
    switcher = {
        "oracle": run_oracle_command,
        "ftp": run_ftp_command,
        "redshift": run_redshift_command
    }

    # Get the function from switcher dictionary
    func = switcher.get(runtype, lambda args, ev, step : "Invalid Run Type")

    # Execute the function
    x = func(args, ev, step)    

    return x

def run_oracle_command(args: object, ev: object, step: object) -> object:
    """ run sqlplus """

    #print(f"step: {step}")
    if step["commandType"] == "script":
        connect_type = step["env"][ev["APPENV"]]["connect_type"]
        connect_string = step["env"][ev["APPENV"]]["connect_string"]
        script = step["command"]
        try:
            params = step["env"][ev["APPENV"]]["parameters"]
        except:
            params = []    
        logging.debug(f'Running {connect_type}')
        ret_code = run_commands.run_sql_plus(ev, connect_type, connect_string, script, params)

        if ret_code != 0:
            raise Exception('jobstream', step["name"])

    return "oracle"
    
def run_ftp_command(args : dict, ev : dict, step : list):
    """ run an ftp script """
    return "ftp"
    
def run_redshift_command(args : dict, ev : dict, step : list):
    """ run a psql script - this would look like the USER type of sqlplus """
    return "redshift"

def send_log_email(ev : dict):    
    """  send the log file as an email """
    #print(ev)
    if ev["send_email"].lower() == "on":
        synemail.send_email(esubject = f"Log file for {ev['JSONFILE']}", \
                            efrom = ev["JOB_EMAIL_FROM"], \
                            eto = ev["email_group"], \
                            emsg = "Log File for deployment job.", \
                            eattach = logging.root.handlers[0].baseFilename)

