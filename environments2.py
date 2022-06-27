import configparser
import os
import logging

# Perform a look up in the enviroment to get host name and compare to the hosts file
# The point is to find out if this is dev, acc or prod
def set_host_env(servername):
    # Create the hosts ini parser
    hosts = configparser.ConfigParser()
    # Turn on case sensitivity for INI keys
    hosts.optionxform = lambda option: option
    # read the INI
    hosts.read('hosts.ini')

    return hosts["DEFAULT"][servername]