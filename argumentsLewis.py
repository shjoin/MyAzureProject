""" This file parses out the command line arguments """
import argparse

def get_arguments(argv : list ):
    """ get the command line arguments and parse them """
   
    # This little if statement removes argv[0] which is the program name and not needed
    i = len(argv)
    if i > 2:
        argv = argv[1:i]
    else:
        argv = []        

    # setup the arrguments
    parser = argparse.ArgumentParser(description=f'Deploy script.')
    parser.add_argument('JSONFILE', help='name and path of json config file')
    parser.add_argument('--first_step', help='Step to start with')
    parser.add_argument('--last_step', help='Stop after this step')

    parser.add_argument('--overrideargs', nargs=argparse.REMAINDER)

    return parser.parse_args(argv)        

if __name__ == "__main__":
   import sys
   get_arguments(sys.argv)
