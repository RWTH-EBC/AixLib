import buildingspy.development.merger as m
import json
import os
from builtins import input

''' This script merges the Modelica IBPSA Library into AixLib

This approach is taken from
https://github.com/open-ideas/IDEAS/tree/master/IDEAS/Scripts/mergeAnnex60Script.py
'''

fileName = "mergePaths.json"
if os.path.isfile(fileName):
    with open(fileName, 'r') as dataFile:
        data = json.loads(dataFile.read())
        ibpsa_dir = data['ibpsa_dir']
        aixlib_dir = data['aixlib_dir']

else:
    print(fileName + " could not be found in your current working directory, please enter source and destination paths. \nThey will be saved for next time. Remove " + fileName + " to reset the paths.")
    ibpsa_dir = input("Enter path of IBPSA Modelica Library: \n")
    aixlib_dir = input("Enter path of AixLib: \n")
    data = {"ibpsa_dir":ibpsa_dir, "aixlib_dir":aixlib_dir}
    with open(fileName, 'w') as dataFile:
        json.dump(data, dataFile)

mer = m.IBPSA(ibpsa_dir, aixlib_dir)
mer.set_excluded_packages(["Experimental", "Obsolete"])
mer.merge()
