#!/usr/bin/sh

################################################################################################################
##                                                       ###
################################################################################################################
######             Revision History                                                                          ###
################################################################################################################

################################################################################################################


sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_EMPL.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_EMPL.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_EMPL.btq is Success.


    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_CPPGM.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_CPPGM.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_CPPGM.btq is Success.


    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_KA_BTLR_TCF_ALLOC.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_KA_BTLR_TCF_ALLOC.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_KA_BTLR_TCF_ALLOC.btq is Success.


    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_KA_HRCHY_GRP2_LVL_1_REL.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_KA_HRCHY_GRP2_LVL_1_REL.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_KA_HRCHY_GRP2_LVL_1_REL.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_FDSVC_RTE_HRCHY.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_FDSVC_RTE_HRCHY.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_FDSVC_RTE_HRCHY.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_GL_CHART_OF_ACCT.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_GL_CHART_OF_ACCT.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_GL_CHART_OF_ACCT.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_GL_LOC_COST_ACCT.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_GL_LOC_COST_ACCT.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_GL_LOC_COST_ACCT.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_HRCHY_FLAT_PROD.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_HRCHY_FLAT_PROD.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_HRCHY_FLAT_PROD.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_INVEN_COMP.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_INVEN_COMP.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_INVEN_COMP.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_INVEN_KIT.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_INVEN_KIT.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_INVEN_KIT.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_RTE_CLASS.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_RTE_CLASS.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_RTE_CLASS.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_RTE_SUBCLASS.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_RTE_SUBCLASS.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_RTE_SUBCLASS.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_CUST_INV_AR_ADJMT.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_CUST_INV_AR_ADJMT.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_CUST_INV_AR_ADJMT.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_INVEN_CONC_VGP_RATE.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_INVEN_CONC_VGP_RATE.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_INVEN_CONC_VGP_RATE.btq is Success.

    fi

sh /opt/pepsi/dev/inform/bdw/scripts/DB2TD/B_CDA_RATE_PERCS.btq

RC=$?

if [  ${RC} != 0 ]

then

 echo insert - Failed in BTEQ script B_CDA_RATE_PERCS.btq.

  exit ${RC} 

   else

    echo insert - BTEQ script B_CDA_RATE_PERCS.btq is Success.


    fi
