# Libraries
import matplotlib.pyplot as plt
from matplotlib.widgets import CheckButtons
import numpy as np
import sys,difflib
import os 
from git import Repo
from shutil import copyfile
import shutil
import pathlib
import glob
from matplotlib.pyplot import figure


def _CloneRepository():
	git_url = "https://github.com/ibpsa/modelica-ibpsa.git"
	repo_dir = "modelica-ibpsa"
	if os.path.exists(repo_dir):
		print("IBPSA folder exists already!")
	else:
		print("Clone IBPSA Repo")
		repo = Repo.clone_from(git_url, repo_dir)


def createFolder(directory):
    try:
        if not os.path.exists(directory):
            os.makedirs(directory)
    except OSError:
        print ('Error: Creating directory. ' +  directory)


def diff_mos(path_aix_mos,path_ibpsa_mos,path_diff_mos,path_new_mos):
	
	aix_mos_files = glob.glob(path_aix_mos+os.sep+'**/*.mos',recursive=True)
	ibpsa_mos_files = glob.glob(path_ibpsa_mos+os.sep+'**/*.mos',recursive=True)
	
	ibpsa_list = []
	aixlib_list = []
	## Give double mos files
	for i in ibpsa_mos_files:
		ibpsa_list.append(i.split(os.sep)[-1])
	for i in aix_mos_files:
		aixlib_list.append(i.split(os.sep)[-1])
	
	
	set1 = set(aixlib_list)
	set2 = set(ibpsa_list)
	set3 = set1.intersection(set2)
	list3 = list(set3)
	for i in list3:
		aixlib = glob.glob(path_aix_mos+os.sep+'**/*'+os.sep+i,recursive=True)
		ibpsa = glob.glob(path_ibpsa_mos+os.sep+'**/*'+os.sep+i,recursive=True)
		for l in aixlib:
			aix = l
			ibpsa = "modelica-ibpsa"+os.sep+l.replace("AixLib","IBPSA")
			result = path_diff_mos +os.sep+l
			result = (result.replace(os.sep+"AixLib"+os.sep+"Resources"+os.sep+"Scripts"+os.sep+"Dymola",""))
			createFolder(result[:result.rfind(os.sep)])
		
			outputFile = open(result,"w")
			inputFile1 = open(aix,"r")
			inputFile2 = open(ibpsa,"r")
			
			line1 = inputFile1.readline()
			line2 = inputFile2.readline()
			line3 = line2.replace("IBPSA","AixLib")
			while line1 != "" or line3 != "":
				if line1 != line3:
					outputFile.write("AixLib: "+line1)
					outputFile.write("IBPSA: "+line2+"\n")
					
				line1 = inputFile1.readline()
				line3 = inputFile2.readline()	
			inputFile1.close()
			inputFile2.close()
			outputFile.close()
			#print(result)
			if os.stat(result).st_size == 0:  
				os.remove(result)
			
	new_ref =(set1^set2)&set2
	new_mos_list = []
	for i in new_ref:
		if i.find("ConvertIBPSA") > -1 :
			continue
		else:
			ibpsa = glob.glob(path_ibpsa_mos+os.sep+'**/*'+os.sep+i,recursive=True)
			new_mos_list.append(ibpsa)
			source = path_new_mos+os.sep+i
			for l in ibpsa:
				shutil.copy2(l,source)
	

def diff_ref(path_aix,path_ibpsa,path_diff,path_new):
	aix_ref_files = os.listdir(path_aix) 
	ibpsa_ref_files = os.listdir(path_ibpsa) 
	ibpsa_list = []
	## Give double reference files
	for i in ibpsa_ref_files:
		i = i.replace("IBPSA","AixLib")
		ibpsa_list.append(i)
	
	set1 = set(aix_ref_files)
	set2 = set(ibpsa_list)
	set3 = set1.intersection(set2)
	list3 = list(set3)
	
	for f in list3:
		aix_ref = f
		ibpsa_ref = f.replace("AixLib","IBPSA")
		
		aix_ref = path_aix+os.sep+ aix_ref
		ibpsa_ref = path_ibpsa+os.sep+ibpsa_ref
		result = path_diff +os.sep+f
		
		
		outputFile = open(result,"w")
		inputFile1 = open(aix_ref,"r")
		inputFile2 = open(ibpsa_ref,"r")
		
		line1 = inputFile1.readline()
		line2 = inputFile2.readline()
		
		while line1 != "" or line2 != "":
			if line1 != line2:
				outputFile.write("AixLib: "+line1)
				outputFile.write("IBPSA: "+line2+"\n")
				
			line1 = inputFile1.readline()
			line2 = inputFile2.readline()	
		inputFile1.close()
		inputFile2.close()
		outputFile.close()

	for root,dirs,files in os.walk(path_diff):  
		for name in files:  
			filename = os.path.join(root,name)  
			if os.stat(filename).st_size == 0:  
				os.remove(filename)
	
	
	diff_ref = os.listdir(path_diff)
	new_ref =(set1^set2)&set2
	
	for i in new_ref:
		i = i.replace("AixLib","IBPSA")
		source = path_ibpsa+os.sep+i
		shutil.copy2(source,path_new)
		
		
	new_ref =os.listdir(path_new)
	return diff_ref, new_ref

	

def add_new_ref(diff_ref,new_ref,path_aix,path_ibpsa,path_new,path_diff):
	new_ref_list = []
	for i in new_ref:
		source = path_new+os.sep+i
		ibp = path_new+os.sep+i.replace("IBPSA","AixLib")
		file = pathlib.Path(ibp)
		
		if file.exists ():
			new_ref_list.append(file)
			continue
		
		if i.find("IBPSA")> -1 :
			i = i.replace("IBPSA","AixLib")
			i = path_new+os.sep+i
			os.rename(source, i)
		else:
			i = path_new+os.sep+i
		new_ref_list.append(i)
	
	## Copy New Files
	for i in new_ref_list:
		path = path_aix
		shutil.copy2(i,path)
	
	for i in diff_ref:
		path = path_aix
		i = i.replace("AixLib","IBPSA")
		source = path_ibpsa+os.sep+i
		target = path+os.sep+i.replace("IBPSA","AixLib")
		shutil.copy2(source,target)	

def removeEmptyFolders(path, removeRoot=True):
  #'Function to remove empty folders'
  if not os.path.isdir(path):
    return

  # remove empty subfolders
  files = os.listdir(path)
  if len(files):
    for f in files:
      fullpath = os.path.join(path, f)
      if os.path.isdir(fullpath):
        removeEmptyFolders(fullpath)

  # if folder empty, delete it
  files = os.listdir(path)
  if len(files) == 0 and removeRoot:
    #print("Removing empty folder: "+ path)
    os.rmdir(path)

	
if  __name__ == '__main__':
	### Settings
	
	path_aix = "AixLib"+os.sep+"Resources"+os.sep+"ReferenceResults"+os.sep+"Dymola"
	path_ibpsa = "modelica-ibpsa"+os.sep+"IBPSA"+os.sep+"Resources"+os.sep+"ReferenceResults"+os.sep+"Dymola"
	
	path_aix_mos = "AixLib"+os.sep+"Resources"+os.sep+"Scripts"+os.sep+"Dymola"
	path_ibpsa_mos = "modelica-ibpsa"+os.sep+"IBPSA"+os.sep+"Resources"+os.sep+"Scripts"+os.sep+"Dymola"
	
	path_diff = "bin"+os.sep+"03_WhiteLists"+os.sep+"Ref_list"+os.sep+"diff_ref"
	createFolder(path_diff)
	path_new  = "bin"+os.sep+"03_WhiteLists"+os.sep+"Ref_list"+os.sep+"new_ref"
	createFolder(path_new)
	
	path_diff_mos = "bin"+os.sep+"03_WhiteLists"+os.sep+"mos_list"+os.sep+"diff_mos"
	createFolder(path_diff_mos)
	path_new_mos  = "bin"+os.sep+"03_WhiteLists"+os.sep+"mos_list"+os.sep+"new_mos"
	createFolder(path_new_mos)
	
	
	_CloneRepository()
	
	results = diff_ref(path_aix,path_ibpsa,path_diff,path_new)
	diff_ref = results[0]
	new_ref = results[1]
	
	add_new_ref(diff_ref,new_ref,path_aix,path_ibpsa,path_new,path_diff)
		
	mos_results = diff_mos(path_aix_mos,path_ibpsa_mos,path_diff_mos,path_new_mos)

	
	removeRoot = True
	removeEmptyFolders(path_diff_mos, removeRoot)
	
	
	