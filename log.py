""" This file handles logging """
from datetime import datetime
import logging
import environment 
import random
import string


def log_file(filename):
  """ print contents of a file """
  with open(filename) as f:
     print(f)

def get_new_temp_log_file(ev):
  """ get a unique log file name based on a random string and time """
  return f"{ev['TMP']}/{get_random_string(12)}logfile{datetime.now()}.log" \
                    .replace(" ","")                          \
                    .replace("-", "")                         \
                    .replace(":","")

def get_random_string(length):
    """ Generate a random string """
    letters = string.ascii_lowercase
    result_str = ''.join(random.choice(letters) for i in range(length))
    #print("Random string of length", length, "is:", result_str)  
    return result_str

def init_log(ev):
  """ Intialize the log file """

  # this uses several env variables to create the log file
  # This will contain the application and branch from the json config
  log_file_name = f"{environment.get_ev_key(ev, 'LOG')}/" +     \
                  f"{environment.get_ev_key(ev,'APPHOME')}_" +  \
                  f"{environment.get_ev_key(ev,'BRANCH')}_" +   \
                  f"{datetime.now()}.log"                       \
                    .replace(" ","")                            \
                    .replace("-", "")                           \
                    .replace(":","")

  #logger = logging.getLogger(__name__)

  #print(f"Log File is {log_file_name}")  

  # Make sure no default loggers are defined
  for handler in logging.root.handlers[:]:
    #print(f"removing {handler.get_name()}")
    logging.root.removeHandler(handler)

  # configure and start logging
  logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(name)-12s %(levelname)-8s %(message)s',
                    datefmt='%m-%d %H:%M',
                    filename=log_file_name,
                    filemode='w')

  logging.info("Log starts")                    

  # add some exception handling
  
 
