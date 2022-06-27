import os,sys
from dtm.env import OracleDbWallet,config
import logging

def connectionstring():
    constring = OracleDbWallet.DbUser + '/' + OracleDbWallet.DbPassword + '@' + OracleDbWallet.DbTns
    return constring
    # $ORACLE_HOME/bin/sqlplus -l -s /@$GV_WALLET_USER @$SQLname $GV_SCHEMA  $STMT    >>  $LOGname 2>&1

def parameter_check (PV_MODULE,PV_ACTUAL_PARAMETER,PV_REQUIRED_PARAMETER):
  if PV_REQUIRED_PARAMETER != PV_ACTUAL_PARAMETER:
     print (PV_MODULE ,': Insufficient Parameter')
     #mailx -s "$PV_MODULE : Insufficient Parameter" "$EMAIL_ERROR_GROUP" < $LOGname
     sys.exit()

# Check File exist Function
#*******************************************************************************************#
# chk_file_exists <FileName> <EmailGroup>                                                   #
# Description           : This function will verify the existance of the file and exists    #
#                         the application if the required file is not existing              #
# Parameters                                                                                #
# ----------                                                                                #
# File Name             : camsxxx.sql                                                       #
# Email Group           : xyzjones@synapsegroupinc.com                                      #
# Email Subject         : Script Name or Module Name                                        #
#*******************************************************************************************#
#def chk_file_exists(sqlscript, IBS_SUCCESS_GROUP, PYname,GV_CURRENT_STEP):
def chk_file_exists(*args):
  LV_TOTAL_PARAMETER=len(args)
  #parameter_check "chk_file_exists" "$LV_TOTAL_PARAMETER" "4" Check The total Number of parameters Passed
  PV_FILE_NAME=args[0]
  PV_EMAIL_GROUP=args[1]
  PV_EMAIL_SUBJECT=args[2]
  PV_CURRENT_STEP = args[3]
  LV_ERROR=0
  parameter_check('chk_file_exists',LV_TOTAL_PARAMETER,4)
  #---- Check the file exists --------
  if os.path.isfile(PV_FILE_NAME):
    LV_ERROR=0 # File Found and Accessible
    LV_ERROR_CODE = ''
  else:
    print(PV_EMAIL_SUBJECT +':' +PV_CURRENT_STEP , ':' , 'No such file or directory or Not able to access',PV_FILE_NAME)
    LV_ERROR_CODE=PV_EMAIL_SUBJECT +':' +PV_CURRENT_STEP +':' + 'No such file or directory or Not able to access',PV_FILE_NAME
    LV_ERROR=1  # File Not Found or Not Accessible

  return LV_ERROR ,LV_ERROR_CODE

def err_chk():
    LV_STATUS=''
    KeyWordList = ['ORA-', 'Error']
    with open(config.GV_LOGname,"r") as f:
        for line in f:
            for w in KeyWordList:
                if w in line:
                    config.GV_ERROR=1
                    LV_STATUS ='FAILED'
                    #sys.exit()

    if LV_STATUS != 'FAILED' and config.GV_ERROR != 1:
       LV_STATUS='SUCCESS'

      # Pre-Fix Status and Step to the subject
    LV_EMAIL_SUBJECT= LV_STATUS + ':'+ config.GV_EMAIL_SUBJECT


    # Send Email logic
    if config.GV_SEND_MAIL == 'Y' and config.GV_ERROR == 0:
       #send_email "$GV_EMAIL_GROUP" "$LV_EMAIL_SUBJECT1" "$GV_SEND_LOG_FILE"
       print('send email Subject :',LV_EMAIL_SUBJECT,'Log File:',config.GV_LOGname,'Email Group',config.GV_EMAIL_GROUP )

     # Exit with return code
    if config.GV_ERROR != 0 and config.GV_EXIT_FLAG == 'Y':
       print(" ")
       print("******************************************************" )
       print( "**** ERROR: " + config.PYname + " HAS FAILED! ***")
       print( "******************************************************")
       logging.basicConfig(level=logging.INFO,
                           format='%(message)s',
                           datefmt='%m-%d %H:%M',
                           filename=config.GV_LOGname,
                           filemode='a')
       logging.info('******************************************************************************')
       logging.info('**** ERROR: %s' % config.PYname + 'HAS FAILED! ***')
       logging.info('******************************************************************************')
       #logging.shutdown()
       sys.exit(config.GV_ERROR)









