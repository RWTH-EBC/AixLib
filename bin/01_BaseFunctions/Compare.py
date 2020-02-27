from buildingspy.development import error_dictionary_jmodelica
from buildingspy.development import error_dictionary_dymola

import codecs
import multiprocessing
import argparse
import os
import sys 
import platform
import buildingspy.development.regressiontest as u
from pathlib import Path
from git import Repo


def _compareIBPSA():

		AixLibPackage = "AixLib.Fluid"
		IBPSAPackage = "IBPSA.Fluid"
		Path = r"C:\01_Git\GitLabCI\bin\CITests\UnitTests\CheckPackages\LogFiles"
		IBPSAFile = open(Path+"\\"+IBPSAPackage+"-log.txt","r")
		IBPSA_ErrorList = []
		AixLib_ErrorList = []
		
		for line in  IBPSAFile:
			List = line.split()
			
			if len(List) > 1:
				if List[0] == "Error:":
					
					IBPSA_ErrorList.append(line)
		
		IBPSAFile.close()
		AixLibFile = open(Path+"\\"+AixLibPackage+"-log.txt","r")
		for line in AixLibFile:
			List = line.split()
			if len(List) > 1:
				if List[0] == "Error:":
					AixLib_ErrorList.append(line)
		AixLibFile.close()
		
		if len(AixLib_ErrorList) == len(IBPSA_ErrorList):
			print("Errors are already in IPBSA")
		elif len(AixLib_ErrorList) != len(IBPSA_ErrorList):
			print("Error in "+ AixLibPackage)
			
			
		for element in AixLib_ErrorList:
			if not element in IBPSA_ErrorList:
				print(element)	
		
		print(AixLib_ErrorList)
		print(IBPSA_ErrorList)

def _listAllModel():
	rootdir = r"D:\Gitlab\GitLabCI\AixLib\Airflow"
	ModelList = []

	for subdir, dirs, files in os.walk(rootdir):
		for file in files:
			filepath = subdir + os.sep + file
			if filepath.endswith(".mo") and file != "package.mo":
				model = filepath
				model = model.replace("\\",".")
				model = model.replace("//",".")
				model = model[model.rfind("AixLib"):model.rfind(".mo")]
				ModelList.append(model)
	return ModelList
		
def _listAllExamples():
	Package = "AixLib.Airflow"
	rootdir = Package.replace(".",os.sep)
	ModelList = []
	for subdir, dirs, files in os.walk(rootdir):
		for file in files:
			filepath = subdir + os.sep + file
			test = subdir.split(os.sep)
			
			
			if test[len(test)-1] == "Examples" or test[len(test)-1] == "Validation":
				if filepath.endswith(".mo") and file != "package.mo":
					model = filepath
					model = model.replace(os.sep,".")
					model = model[model.rfind("AixLib"):model.rfind(".mo")]
					ModelList.append(model)
	print(ModelList)
	return ModelList
		
def _WriteWhiteList():
	#_listAllModel
	rootdir = r"D:\Gitlab\modelica-ibpsa\IBPSA"
	#rootdir = self.Package
	ModelList = []

	for subdir, dirs, files in os.walk(rootdir):
		for file in files:
			filepath = subdir + os.sep + file
			if filepath.endswith(".mo") and file != "package.mo":
				model = filepath
				if platform.system()  == "Windows":
					model = model.replace("\\",".")
				else:
					model = model.replace("//",".")
					
				model = model[model.rfind("IBPSA"):model.rfind(".mo")]
				ModelList.append(model)
		
	#_CheckModel
	from dymola.dymola_interface import DymolaInterface
	from dymola.dymola_exception import DymolaException
	import buildingspy.development.regressiontest as u
		
	#ut = u.Tester(tool = self.tool)
	### Set Number of Threads
	#ut.setNumberOfThreads(self.n_pro)
	### Set GUI Show
	#ut.showGUI(self.show_gui)
	### Set in Batch Mode
	#ut.batchMode(self.batch)
	### Sets the Dymola path to activate the GUI
	if platform.system()  == "Windows":
		dymola = DymolaInterface()
	else:
		dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
	### Writes all information in the log file, not only the last entries
	dymola.ExecuteCommand("Advanced.TranslationInCommandLog:=true;")
	Library = "IBPSA/package.mo"
	PackageCheck = dymola.openModel(Library)
	if PackageCheck == True:
		print("Found AixLib Library and start Checkmodel Tests \n Check Package " + self.Package+" \n")
	elif PackageCheck == None:
		print("Library Path is wrong. Please Check Path of AixLib Library Path")
		exit(1)
	## Check the Package	
	
	ErrorList = []	
	
	for i in ModelList:
		result=dymola.checkModel(i)
		
		if result == True:
			print('\n Check of Package '+i+' was Successful! \n')
			
			#dymola.close()
			#return 0
			#exit(0)
	
		if result == False:
			#print('\n ModelCheck Failed in Package ' + i + ' Show Savelog \n')
			ErrorList.append(i)
			#print(Log)
			
			#dymola.clearlog()
			#dymola.close()
			#return 1
			#exit(1)"""
	dymola.close()
	IBPSA_PackageName = []
	### Write the Package Names of IBPSA
	for i in ModelList:
		i = i.split(".")
		i = i[1]
		if i not in IBPSA_PackageName:
			IBPSA_PackageName.append(i)
	
	filename= r"D:\Gitlab\GitLabCI\WhiteLists\CheckModel\WhiteList_CheckModel.txt"
	
	
	file = open(filename,"w")
	
	for i in IBPSA_PackageName:
		List  = []
		for l in ModelList:
			Package = l.split(".")[1]
			
			if Package == i:
				List.append(l)
				
		file.write(i+"\n"+str(List)+"\n"+"\n")
		
	file.close()
	
	
	print("Write Whitelist")
	
	
def _setEnvironmentVariables(var,value):
	import os
	import platform
	if var in os.environ:
		if platform.system() == "Windows":
			os.environ[var] = value + ";" + os.environ[var]
		else:
			os.environ[var] = value + ":" + os.environ[var]
	else:
		os.environ[var] = value		



def _CompareWhiteList():
	
	WhiteList = _IgnoreWhiteList()
	AixLibModels   = _listAllModel()
	#print(WhiteList)
	#print("\n")
	#print(AixLibModels)
	WhiteListModel = []
	for element in AixLibModels:
		#print(element)
		for subelement in WhiteList:
			#print(subelement)
			if element == subelement:
				#print(element)
				WhiteListModel.append(element)
	for i in WhiteListModel:
		AixLibModels.remove(i)
	return AixLibModels
	
def _IgnoreWhiteList():
	Package = "AixLib.Airflow"
	Package = Package.split(".")[1]
	filename = r"D:\Gitlab\GitLabCI\WhiteLists\CheckModel\WhiteList_CheckModel.txt"
	file = open(filename,"r")
	RowNumer = 0
	WhiteListPackage = []
	for line in file:
		if line.rstrip() == Package:
			print("WhiteList Package "+Package)
			RowNumer = RowNumer + 1 
			continue
		elif RowNumer > 0:
			#WhiteListPackage = []
			line = line.rstrip() 
			line = line.replace("[","")
			line = line.replace("]","")
			line = line.replace("'","")
			line = line.replace(" ","")
			line = line.replace("IBPSA","AixLib")
			line = str(line)
			line = line.split(",")
			WhiteListPackage = line
			break
	file.close()
	return WhiteListPackage
		

def  _CloneRepository():
	git_url = "https://github.com/ibpsa/modelica-ibpsa.git"
	repo_dir = "IBPSA"
	repo = Repo.clone_from(git_url, repo_dir)
	print(repo)

def _git_push_WhiteList():
	WhiteList_file = "bin"+os.sep+"WhiteLists"+os.sep+"WhiteList_CheckModel.txt"
	#WhiteList_file = "bin/WhiteLists/WhiteList_CheckModel.txt"
	
	repo_dir = ""
	try:
		repo = Repo(repo_dir)
		commit_message = "Update new WhiteList"
		repo.git.add(WhiteList_file)
		repo.index.commit(commit_message)
		origin = repo.remote('origin')
		origin.push('master')
		repo.git.add(update=True)
		print("repo push succesfully")
	except Exception as e:
		print(str(e))
	

if  __name__ == '__main__':
	if platform.system()  == "Windows":
		_setEnvironmentVariables("PATH", os.path.join(os.path.abspath('.'), "Resources", "Library", "win32"))
		sys.path.insert(0, os.path.join('C:\\',
                            'Program Files',
                            'Dymola 2019',
                            'Modelica',
                            'Library',
                            'python_interface',
                            'dymola.egg'))
		print("operating system Windows")
	else:
		print("operating system Linux")
		_setEnvironmentVariables("LD_LIBRARY_PATH", os.path.join(os.path.abspath('.'), "Resources", "Library", "linux32") + ":" +
								os.path.join(os.path.abspath('.'),"Resources","Library","linux64"))
		sys.path.insert(0, os.path.join('opt',
							'dymola-2020-x86_64',
							'Modelica',
							'Library',
							'python_interface',
							'dymola.egg'))
	sys.path.append(os.path.join(os.path.abspath('.'), "..", "..", "BuildingsPy"))
	#_compareIBPSA()
	#_listAllModel()
	#_IgnoreWhiteList()
	#_CompareWhiteList()
	#_listAllExamples()
	#_CloneRepository()
	_git_push_WhiteList()