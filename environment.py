"""
This file contains everything related to environment processing including placing
  variables in strings 
"""

import configparser
import os
import logging

# Empty global environment dictionary
# started moving ev to a global so it is available everywhere but not complete
_ev = {}

def populate_environment(args, envrionment_values):
    """
    Create a working environment for any commands that shell out
    This envionment will include any variables defined in the OS, in the JSON file,
      from the command line, or in the ENV.ini
    """
    #print(args.__dict__)
    for k in args.__dict__:
        if args.__dict__[k] is not None:
            if k != "overrideargs":
                envrionment_values[k] = args.__dict__[k]

    # get any overrides from the command line
    overrides = args.overrideargs

    # find out if this is dev, acc or prod by hostname in hosts.ini
    #deployment = set_host_env(socket.gethostname())
    deployment = envrionment_values["APPENV"]

    logging.debug(f"Deployment = {deployment}")

    #debug.debug_msg(os.environ)
    #load the OS Environment
    envrionment_values.update(os.environ)

    #print(f"os.env={type(envrionment_values)}")
    # Create the env ini parser
    config = configparser.ConfigParser()
    # Turn on case sensitivity for INI keys
    config.optionxform = lambda option: option
    # read the INI
    config.read('env.ini')

    # Add INI entries to environment dict, overwriting existing entries
    for sect in config.sections():
        #print('Section:', sect)
        if sect in (deployment, 'DEFAULT'):
            for k,v in config.items(sect):
                envrionment_values[k] = v
                #print(' {} = {}'.format(k,v))
        
        #print()

    # Add cli overrides entries to environment dict, overwriting existing entries
    if overrides is not None:
        for override in overrides:
            ia = (override.split('='))
            if len(ia) == 1:
                envrionment_values[ia[0]] = ""
            else:
                envrionment_values[ia[0]] = ia[1]
                
    # The interprolation replaces parts of string with defined replacements
    envrionment_values = interpolate(envrionment_values)

    # We need a TMP variable for logging and stuff so create if not defined
    if "TMP" not in envrionment_values:
        envrionment_values["TMP"] = "/tmp"

    # Also need a LOG dir
    if "LOG" not in envrionment_values:
        envrionment_values["LOG"] = "/tmp"

    #print(envrionment_values)

    # set the global var value
    _ev = envrionment_values
    return envrionment_values    

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

# this function loops thru all environment variables and replaces variables (marked as {!varname!}) with the variable in the marker
# so {!APPENV!} would get replaced with DEV, ACC or PROD as determined by the env lookup function
def interpolate(envrionment_values):
    # The interprolation replaces parts of string with defined replacements
    # For example, the string LOG = {!HOME!}/{!APPHOME!}/log from env.ini creates a 
    # path that is used in the code. {!HOME!} will be replaced by the 
    # HOME variable (in env.ini - HOME = /home/lewis) and {!APPHOME!} will be replaced by the 
    # APPHOME variable (from the config.json command line argument - "APPHOME": "nss")
    for k,v in envrionment_values.items():

        if k != "env":
            #print(f"v={v} and v is of {type(v)}")
            # find any replacement marker starts
            istart = v.find("{!") 

            # this is a kludge that I want to return to and fix
            # I am adding this to prevent an infinite loop below if a key does not exist. 
            # I Don't think any variable will have more than 5 replacements so I am limit it to <= 5 in the loop
            iloop = 0

            #loop thru the value and replace markers one by one
            while istart > -1 and iloop <= 5:
                iloop += 1
                # get the ending location !}
                iend = v.find("!}", istart) 

                # get the string with the start marker
                srepl = v[istart:iend]
                #remove the start marker to get a key
                skey = srepl[2:iend]
            
                #just a debug
                #print(f"key = {k},  skey = {skey}, srepl = {srepl}")

                #try to replace the marked key with the actual key value. If the key does not exist, don't fail, just pass
                try:
                    envrionment_values[k] = v.replace(srepl+"!}", envrionment_values[skey])
                    v =  v.replace(srepl+"!}", envrionment_values[skey])
                except:
                    #print(f"Didn't find this key {k}")
                    # Didn't find this key
                    pass

                # look for the next marker in this key value [air]
                istart = v.find("{!") 

        #print(envrionment_values[k])

    return envrionment_values

# this function interpolates a specific variable
def interpolate_value(val, envrionment_values):

    # find any replacement marker starts
    istart = val.find("{!") 

    # this is a kludge that I want to return to and fix
    # I am adding this to prevent an infinite loop below if a key does not exist. 
    # I Don't think any variable will have more than 5 replacements so I am limit it to <= 5 in the loop
    iloop = 0

    #loop thru the value and replace markers one by one
    while istart > -1 and iloop <= 5:
        iloop += 1
        # get the ending location !}
        iend = val.find("!}", istart) 

        # get the string with the start marker
        srepl = val[istart:iend]
        #remove the start marker to get a key
        skey = srepl[2:iend]
            
        #just a debug
        #print(f"val = {val}, skey = {skey}, srepl = {srepl}")

        try:
            val = val.replace(srepl+"!}", envrionment_values[skey])
        except:
            #print(f"Didn't find this key {skey}")
            # Didn't find this key
            pass

        # look for the next marker in this key value [air]
        istart = val.find("{!") 

    #print(envrionment_values[k])

    return val


def get_ev_key(ev, key):
    """
    return a value for a key in the ev dictionary. I should have used the .get() 
    syntax in my code and I would not need this. The code should be fixed at some point
    """
    
    try:
        return ev[key]
    except:
        return ""

def get_env_key(key):
    """
    return a value for a key in the global _ev dictionary. I should have used the .get() 
    syntax in my code and I would not need this. The code should be fixed at some point
    """
    
    try:
        return _ev[key]
    except:
        return ""

