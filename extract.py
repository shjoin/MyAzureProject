import patoolib
import glob
import os

def extractzipfiles():
  Filesdir = 'C:/Users/shail/Documents/python/'
  os.chdir(Filesdir)
  fileList = glob.glob("*.gz*")
  for a_filename in fileList:
      patoolib.extract_archive(a_filename,outdir=Filesdir)

def main():
   extractzipfiles()

if __name__ == '__main__':
   print('extractzipfiles Starts ......')
   main()
   print("****DONE extractzipfiles ****")