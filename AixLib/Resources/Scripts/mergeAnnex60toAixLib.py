import buildingspy.development.merger as m
import os

''' This script merges the Annex60 core library to AixLib. Make sure you're
    on up-to-date branches as intended with both libraries and that both libraries
	are included in your MODELICAPATH
'''

list_of_dirs = os.environ['MODELICAPATH']
print list_of_dirs.split(';')

dest_dir = None
annex60_dir = None

for dir in list_of_dirs.split(';'):
	if 'AixLib' in dir:
		dest_dir = os.path.join(dir, 'AixLib')
	elif 'annex60' in dir:
		annex60_dir = os.path.join(dir, 'Annex60')


assert dest_dir != None, 'AixLib directory was not found in MODELICAPATH'
assert annex60_dir != None, 'Annex60 directory was not found in MODELICAPATH'

this_merge = m.Annex60(annex60_dir, dest_dir) 
this_merge.set_excluded_packages(["Experimental", "Obsolete"])
this_merge.merge()