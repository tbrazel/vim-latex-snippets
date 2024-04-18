import csv,os

master_envs_csv = 'master_envs.csv'

with open(master_envs_csv, 'r') as read_obj: 
    envs = list(csv.reader(read_obj))
    read_obj.close()

# envs is now a list of lists, first entry is full name
# second entry is short name

longnames = [x[0] for x in envs]
shortnames = [x[1] for x in envs]


longname_regex = '(' + '|'.join(shortnames) + ')'

shortname_regex = '(' + '|'.join(shortnames) + ')'



print(longname_regex)
