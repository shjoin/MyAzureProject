#!/usr/bin/sh

################################################################################################################
##                                                       ###
################################################################################################################
######             Revision History                                                                          ###
################################################################################################################

################################################################################################################


sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_USER_CUST_GRP.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_USER_CUST_GRP.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_USER_CUST_GRP.btq is Success.


    fi


sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_TRGT_LIST.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_TRGT_LIST.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_TRGT_LIST.btq is Success.


    fi

sh opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_CUST_TYPE_ASSOCN.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_CUST_TYPE_ASSOCN.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_CUST_TYPE_ASSOCN.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_CUST_TRGT.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_CUST_TRGT.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_CUST_TRGT.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_CUST_TRANS_TXBL_HIST.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_CUST_TRANS_TXBL_HIST.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_CUST_TRANS_TXBL_HIST.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_USER_CUST_GRP_ASSOCN.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_USER_CUST_GRP_ASSOCN.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_USER_CUST_GRP_ASSOCN.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_CUST_NATL_ACCT.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_CUST_NATL_ACCT.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_CUST_NATL_ACCT.btq is Success.


    fi
