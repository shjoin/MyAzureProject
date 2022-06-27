import os.path

def testmain():
    SCHEMA ='dtm'
    PYname = 'dtmstg01_SP'
    GV_HOME = 'C:/Users/sjoshi2/Documents/PythonShjo/MyProject'
    sqlscript = GV_HOME + '/' + SCHEMA + '/' + 'dtms002.sql'
    STMT = "pkg_pot_remit_dm.prc_ins_ft_pot_remit_summary(500," + "'" + PYname + "'" + ",'prc_ins_ft_pot_remit_summary')"
    print(STMT)
    print(os.path.dirname(sqlscript)) #C:/Users/sjoshi2/Documents/PythonShjo/MyProject/dtm
    print(os.path.exists(sqlscript))#true
    #print(os.path.getsize(sqlscript)) #1079
    print(os.path.isfile(sqlscript)) #true
    print(os.path.isdir(sqlscript)) #false

if __name__ == "__main__":
    testmain()




