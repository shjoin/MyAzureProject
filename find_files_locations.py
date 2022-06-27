import os

def get_all_tomcats():
    list_of_files=[]
    for r,d,f in os.walk("/"):
        for each_file in f:
            if each_file == 'sample.csv':
                list_of_files.append(os.path.join(r,each_file))
    return list_of_files

def main():
    print("Find list of tomcats")

