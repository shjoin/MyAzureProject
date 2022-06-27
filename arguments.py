import argparse


def get_arguments(argv : list):
    """ get the command line arguments and parse them """
    #SYNDWD_DWHSTG dtmstg dtm step02 step04
    i = len(argv)
    #print("length",i)
    # This little if statement removes argv[0] which is the program name and not needed
    i = len(argv)
    #if i >= 4:
    if i > 2:
       argv = argv[1:i]
    else:
       argv = [] # if parameter is only one ,then make empty the list
    #else:
        #raise Exception("Don't have enough arguments :", argv[1:i])

        # setup the arrguments
    parser = argparse.ArgumentParser(description='Execute the Oracle Procedure',add_help=True)
    parser.add_argument('WALLET', help='Name of DB Wallet',type=str)
    parser.add_argument('SCHEMA', help='Name of DB Schema', type=str)
    parser.add_argument('DBENV', help='Name of DB Env', type=str)
    parser.add_argument('--first_step', help='Step to start with', type=str)
    parser.add_argument('--last_step', help='Stop after this step', type=str)

    #print(argvs.WALLET,argvs.SCHEMA,argvs.DBENV,argvs.first_step)

    return parser.parse_args(argv)




        # print("argument list :", argv[1:i])



if __name__ == "__main__":
      import sys
      get_arguments(sys.argv)

