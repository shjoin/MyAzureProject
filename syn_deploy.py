"""
This file contains the starting point for JSON driven deployment code

basic syntax is:
    The script name - syn_deploy.py 
    A JSON Config Path and File name
    Any optional parameters are identified by specifyign --overrideargs followed by key value pairs

i.e.

syn_deploy.py <path/filename>.json [[--first_step] [--last_step] --overrideargs [key=value] [key=value]]

Example:

syn_deploy.py /home/lewis/app/json/config.json --first_step=1 --last_step=10 --overrideargs abc=123 
"""

import sys, logging, socket
import argumentsLewis, environment, jobstream, log, synemail

def main():
    """
        Main proc to run dployments
    """
    # parse command line arguments and save them to args
    args = argumentsLewis.get_arguments(sys.argv)

    # Create a new empty environment dictionary, used later
    ev = {}

    # find out if this is dev, acc or prod by hostname in hosts.ini
    deployment = environment.set_host_env(socket.gethostname())
    ev["APPENV"] = deployment

    # read the config JSON file and return the jobstream 
    # which is the array of data defined in the json steps array
    job = jobstream.get_jobs(args, ev)

    # combine the ev values set previously with the actual OS environment
    ev = environment.populate_environment(args, ev)

    # set up job logging
    log.init_log(ev)

    logging.debug("Starting run stream.")

    # run the job stream
    # This is where you would want to decide what to do to a failed run
    try:
        result_code = jobstream.runstream(args, ev, job)
    except:
        print(f"Exception found in jobstream")    
        result_code = -1
        #raise

    # Send an email on completion (success or failure)
    jobstream.send_log_email(ev)

    # Set the os return code to success or failure so job scheduling can read it
    return result_code

# Run main() by default
if __name__ == "__main__":
    main()


