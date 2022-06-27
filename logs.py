""" This file handles logging """
from datetime import datetime
import logging
import random
import string


def logs(log_file_name,output,errm):
      # configure and start logging
    logging.basicConfig(level=logging.DEBUG,
                        format='%(asctime)s %(name)-12s %(levelname)-8s %(message)s',
                        datefmt='%m-%d %H:%M',
                        filename=log_file_name,
                        filemode='w')

    logging.info("Log starts")

    # add some exception handling


