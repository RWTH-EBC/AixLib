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
from sort_models import git_models
import time 

class Git_Repository_Clone(object):
	"""work with Repository in Git"""
	def __init__(self, Repository):
		self.Repository = Repository

	def  _CloneRepository(self):
		git_url = "https://github.com/ibpsa/modelica-ibpsa.git"
		repo_dir = "IBPSA"
		repo = Repo.clone_from(git_url, repo_dir)
		print(repo)

	def _git_push_WhiteList(self):
		WhiteList_file = "bin"+os.sep+"03_WhiteLists"+os.sep+"WhiteList_CheckModel.txt"
		repo_dir = ""
		try:
			repo = Repo(repo_dir)
			commit_message = "Update new WhiteList [ci skip]"
			repo.git.add(WhiteList_file)
			repo.index.commit(commit_message)
			origin = repo.remote('origin')
			origin.push('master')
			repo.git.add(update=True)
			print("repo push succesfully")
		except Exception as e:
			print(str(e))
		



			  
class ValidateTest(object):
	"""Class to Check Packages and run CheckModel Tests"""
	"""Import Python Libraries"""
	def __init__(self,Package,Library, batch, tool, n_pro, show_gui, WhiteList,SimulateExamples, Changedmodels):
		self.Package = Package
		self.Library = Library
		self.batch = batch
		self.tool = tool
		self.n_pro = n_pro
		self.show_gui = show_gui
		self.CreateWhiteList = WhiteList
		self.SimulateExamples = SimulateExamples
		self.Changedmodels = Changedmodels
		
		#self.path = path 
		###Set Dymola Tool		
		if tool	 == 'jmodelica':
			e = error_dictionary_jmodelica
		else:
			e = error_dictionary_dymola
		if tool in ['dymola', 'omc', 'jmodelica']:
			self._modelica_tool = tool
		else:
			raise ValueError(
                "Value of 'tool' of constructor 'Tester' must be 'dymola', 'omc' or 'jmodelica'. Received '{}'.".format(tool))
		
	def dym_check_lic(self):
		from dymola.dymola_interface import DymolaInterface
		from dymola.dymola_exception import DymolaException
		
		dym_sta_lic_available = dymola.ExecuteCommand('RequestOption("Standard");')
		if not dym_sta_lic_available:
			dymola.ExecuteCommand('DymolaCommands.System.savelog("Log_NO_DYM_STANDARD_LIC_AVAILABLE.txt");')
			print("No Dymola License is available")
			dymola.close()
			exit(1)
		else:
			print("Dymola License is available")
	
		
	''' Write a new Whitelist with all models in IBPSA Library of those models who have not passed the Check Test'''
	def _WriteWhiteList(self):
		#_listAllModel
		#rootdir = r"D:\Gitlab\modelica-ibpsa\IBPSA"
		Package = self.Package.replace("AixLib","IBPSA")
		Package = Package.split(".")[0]
		Package = Package.replace(".",os.sep)
		rootdir = "IBPSA"+os.sep+Package
		
		ModelList = []
		for subdir, dirs, files in os.walk(rootdir):
			for file in files:
				filepath = subdir + os.sep + file
				if filepath.endswith(".mo") and file != "package.mo":
					model = filepath
					model = model.replace(os.sep,".")
					model = model[model.rfind("IBPSA"):model.rfind(".mo")]
					ModelList.append(model)
		#_CheckModel
		from dymola.dymola_interface import DymolaInterface
		from dymola.dymola_exception import DymolaException
		import buildingspy.development.regressiontest as u
			
		ut = u.Tester(tool = self.tool)
		### Set Number of Threads
		ut.setNumberOfThreads(self.n_pro)
		### Set GUI Show
		ut.showGUI(self.show_gui)
		### Set in Batch Mode
		ut.batchMode(self.batch)
		### Sets the Dymola path to activate the GUI
		if platform.system()  == "Windows":
			dymola = DymolaInterface()
		else:
			dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
		### Writes all information in the log file, not only the last entries
		#dymola.ExecuteCommand("Advanced.TranslationInCommandLog:=true;")
		Library = "IBPSA"+os.sep+"IBPSA"+os.sep+"package.mo"
		dymola.ExecuteCommand("Advanced.TranslationInCommandLog:=true;")
		dym_sta_lic_available = dymola.ExecuteCommand('RequestOption("Standard");')
		if not dym_sta_lic_available:
			dymola.ExecuteCommand('DymolaCommands.System.savelog("Log_NO_DYM_STANDARD_LIC_AVAILABLE.txt");')
			print("No Dymola License is available")
			dymola.close()
			exit(1)
		else:
			print("Dymola License is available")
	
		PackageCheck = dymola.openModel(Library)
		
		if PackageCheck == True:
			print("Found IBPSA Library and start Checkmodel Tests \n Check Package " + self.Package+" \n")
		elif PackageCheck == False:
			print("Library Path is wrong. Please Check Path of IBPSA Library Path")
			exit(1)
		## Check the Package
		if len(ModelList) == 0:
			print("Wrong path")
			exit(1)
		ErrorList = []	
		for i in ModelList:
			result=dymola.checkModel(i)
			if result == True:
				print('\n Successful: '+i+'\n')
			if result == False:
				print('\ Error: '+i+'\n')
				Log = dymola.getLastError()
				print(Log)
				ErrorList.append(i)
		dymola.savelog("IBPSA-log.txt")
		dymola.close()
		IBPSA_PackageName = []
		### Write the Package Names of IBPSA
		for i in ModelList:
			i = i.split(".")
			i = i[1]
			if i not in IBPSA_PackageName:
				IBPSA_PackageName.append(i)
		filename= "bin"+os.sep+"03_WhiteLists"+os.sep+"WhiteList_CheckModel.txt"
		file = open(filename,"w")
		
		
		for i in IBPSA_PackageName:
			List  = []
			for l in ErrorList:
				Package = l.split(".")[1]
				if Package == i:
					List.append(l)
			file.write(i+"\n"+str(List)+"\n"+"\n")
		file.close()
		print("Write Whitelist")


	''' Write a Error log with all models, that don´t pass the check '''
	def _WriteErrorlog(self,logfile):
		package = self.Package
		logfile = "AixLib"+ os.sep+logfile
		log_Error = "AixLib"+os.sep+package+"-Errorlog.txt"
		file = open(logfile, "r")
		Errorlog = open(log_Error, "w")
		ErrorList = []
		falseList = []
		checkList = []
		for line in file:
			if line.find('checkModel("AixLib.') > -1:
				ErrorList.append(line)
				checkList.append(line)
			elif len(checkList) > 0:
				ErrorList.append(line)
			if line.find(' = false') > -1:
				falseList.append(line)
			if line.find(' = true') > -1: 
				ErrorList = []
				checkList = []
			
			if len(falseList) > 0 and len(checkList) > 0:
				Errorlog.write("\n--------------------------------------\n")
				if len(ErrorList) > 0:
					for i in ErrorList:
						Errorlog.write(i)
				Errorlog.write("\n--------------------------------------\n")
				ErrorList = []
				checkList = []
				falseList = []
		file.close()
		Errorlog.close()
		
	''' Compare AixLib models with IBPSA models of those have not  passed the Check.
		Remove all models from the WhiteList and will not be checked'''
	def _CompareWhiteList(self):
		WhiteList = ValidateTest._IgnoreWhiteList(self)
		AixLibModels   = ValidateTest._listAllModel(self)
		
		WhiteListModel = []
		for element in AixLibModels:
			for subelement in WhiteList:
				if element == subelement:
					WhiteListModel.append(element)
		WhiteListModel = list(set(WhiteListModel))
		for i in WhiteListModel:
			AixLibModels.remove(i)
		return AixLibModels
	
	''' Return a List with all models from the Whitelist '''
	def _IgnoreWhiteList(self):
		#Package = "AixLib.Fluid.Actuators"
		Package = self.Package
		if len(Package) > 1:
			Package = Package.split(".")[1]
		
		filename= r"bin/03_WhiteLists/WhiteList_CheckModel.txt"
		#if platform.system()  == "Windows":
		#				model = model.replace("\\",".")
		#else:
		
		file = open(filename,"r")
		RowNumer = 0
		WhiteListPackage = []
		for line in file:
			if line.rstrip() == Package:
				#print("WhiteList Package "+Package)
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
	''' List all models in AixLib Library '''		
	def _listAllModel(self):
		rootdir = self.Package
		rootdir = rootdir.replace(".",os.sep)
		ModelList = []
		for subdir, dirs, files in os.walk(rootdir):
			for file in files:
				filepath = subdir + os.sep + file
				if filepath.endswith(".mo") and file != "package.mo":
					model = filepath.replace(os.sep, ".")
					model = model[model.rfind("AixLib"):model.rfind(".mo")]
					ModelList.append(model)
		return ModelList
	''' List all Examples and Validation examples '''
	def _listAllExamples(self):
		Package = self.Package
		rootdir = Package.replace(".",os.sep)
		ModelList = []
		for subdir, dirs, files in os.walk(rootdir):
			for file in files:
				filepath = subdir + os.sep + file
				test = subdir.split(os.sep)
				if test[len(test)-1] == "Examples" or test[len(test)-1] == "Validation":
					if filepath.endswith(".mo") and file != "package.mo":
						model = filepath.replace(os.sep,".")
						model = model[model.rfind("AixLib"):model.rfind(".mo")]
						ModelList.append(model)
		return ModelList
		
		''' Check models and return a Error Log, if the check failed '''
	def _CheckModelAixLib(self):
		from dymola.dymola_interface import DymolaInterface
		from dymola.dymola_exception import DymolaException
		import buildingspy.development.regressiontest as u
		ut = u.Tester(tool = self.tool)
		### Set Number of Threads
		ut.setNumberOfThreads(self.n_pro)
		### Set GUI Show
		ut.showGUI(self.show_gui)
		### Set in Batch Mode
		ut.batchMode(self.batch)
		### Sets the Dymola path to activate the GUI
		if platform.system()  == "Windows":
			dymola = DymolaInterface(showwindow=True)
		else:
			dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
		### Writes all information in the log file, not only the last entries
		dymola.ExecuteCommand("Advanced.TranslationInCommandLog:=true;")
		dym_sta_lic_available = dymola.ExecuteCommand('RequestOption("Standard");')
		lic_counter = 0
		while dym_sta_lic_available == False:
			print("No Dymola License is available")
			dymola.close()
			print("Check Dymola license after 180.0 seconds")
			time.sleep(180.0)
			### Sets the Dymola path to activate the GUI
			if platform.system()  == "Windows":
				dymola = DymolaInterface(showwindow=True)
			else:
				dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
			dym_sta_lic_available = dymola.ExecuteCommand('RequestOption("Standard");')
			lic_counter = lic_counter +1 	
			if lic_counter > 30:
				if dym_sta_lic_available == False:
					print("There are currently no available Dymola licenses available. Please try again later.")
					dymola.close()
					exit(1)
		print("Dymola License is available")
		'''
		if not dym_sta_lic_available:
			dymola.ExecuteCommand('DymolaCommands.System.savelog("Log_NO_DYM_STANDARD_LIC_AVAILABLE.txt");')
			print("No Dymola License is available")
			dymola.close()
			exit(1)
		else:
			print("Dymola License is available")'''
													
		
		
		PackageCheck = dymola.openModel(self.Library)
		if PackageCheck == True:
			print("Found AixLib Library and start Checkmodel Tests \n Check Package " + self.Package+" \n")
		elif PackageCheck == False:
			print("Library Path is wrong. Please Check Path of AixLib Library Path")
			exit(1)
		## Check the Package	
		ErrorList = []	
		if self.Changedmodels == False:
		
			ModelList = ValidateTest._CompareWhiteList(self)
			if len(ModelList) == 0:
				print("Wrong Path")
				exit(1)
			
			for i in ModelList:
				result=dymola.checkModel(i)
				#result=dymola.checkModel(i,simulate=True)
				if result == True:
					print('\n Successful: '+i+'\n')
					#continue
				if result == False:
					print("Second Check Test for model "+i)
					result=dymola.checkModel(i)
					if result == True:
						print('\n Successful: '+i+'\n')
				
					if result == False:
						ErrorList.append(i)
						Log = dymola.getLastError()
						print('\n Error: '+i+'\n')
						print(Log)
		
		if self.Changedmodels == True:
			print("Test only changed or new models")
			list_path = 'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt'
			list_mo_models = git_models(".mo",self.Package,list_path)
			model_list = list_mo_models.sort_mo_models()
			if len(model_list) == 0:
				print("No changed models in Package :"+self.Package)
				exit(0)
			for i in model_list:
				print("Check Model: "+i)
				result=dymola.checkModel(i)
				#result=dymola.checkModel(i,simulate=True)
				if result == True:
					print('\n Successful: '+i+'\n')
					#continue
				if result == False:
					print("Second Check Test for model "+i)
					result=dymola.checkModel(i)
					if result == True:
						print('\n Successful: '+i+'\n')
				
					if result == False:
						ErrorList.append(i)
						Log = dymola.getLastError()
						print('\n Error: '+i+'\n')
						print(Log)
		
			
		
		dymola.savelog(self.Package+"-log.txt")
		dymola.close()
		logfile = self.Package+"-log.txt"
		ValidateTest._WriteErrorlog(self,logfile)
		return ErrorList

	''' Simulate examples and validation and return a Error log, if the check failed. '''
	def _SimulateModel(self):
		from dymola.dymola_interface import DymolaInterface
		from dymola.dymola_exception import DymolaException
		import buildingspy.development.regressiontest as u
		ut = u.Tester(tool = self.tool)
		### Set Number of Threads
		ut.setNumberOfThreads(self.n_pro)
		### Set GUI Show
		ut.showGUI(self.show_gui)
		### Set in Batch Mode
		ut.batchMode(self.batch)
		### Sets the Dymola path to activate the GUI
		if platform.system()  == "Windows":
			dymola = DymolaInterface()
		else:
			dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
		### Writes all information in the log file, not only the last entries
		dymola.ExecuteCommand("Advanced.TranslationInCommandLog:=true;")
		dym_sta_lic_available = dymola.ExecuteCommand('RequestOption("Standard");')
		lic_counter = 0
		while dym_sta_lic_available == False:
			print("No Dymola License is available")
			dymola.close()
			print("Check Dymola license after 60.0 seconds")
			time.sleep(180.0)
			### Sets the Dymola path to activate the GUI
			if platform.system()  == "Windows":
				dymola = DymolaInterface(showwindow=True)
			else:
				dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
			dym_sta_lic_available = dymola.ExecuteCommand('RequestOption("Standard");')
			lic_counter = lic_counter +1 	
			if lic_counter > 30:
				if dym_sta_lic_available == False:
					print("There are currently no available Dymola licenses available. Please try again later.")
					dymola.close()
					exit(1)
		print("Dymola License is available")
		
		'''
		if not dym_sta_lic_available:
			dymola.ExecuteCommand('DymolaCommands.System.savelog("Log_NO_DYM_STANDARD_LIC_AVAILABLE.txt");')
			print("No Dymola License is available")
			dymola.close()
			exit(1)
		else:
			print("Dymola License is available")
		'''
		
		PackageCheck = dymola.openModel(self.Library)
		if PackageCheck == True:
			print("Found AixLib Library and start Checkmodel Tests \n Check Package " + self.Package+" \n")
		elif PackageCheck == None:
			print("Library Path is wrong. Please Check Path of AixLib Library Path")
			exit(1)
		
		ErrorList = []
		if self.Changedmodels == False:	
			ModelList = ValidateTest._listAllExamples(self)
			if len(ModelList) == 0:
				print("Wrong Path")
				exit(0)
			for i in ModelList:
				result=dymola.checkModel(i,simulate=True)
				if result == True:
					print('\n Successful: '+i+'\n')
				if result == False:
					print("Second Check Test for model "+i)
					result=dymola.checkModel(i,simulate=True)
					if result == True:
						print('\n Successful: '+i+'\n')
					if result == False:
						ErrorList.append(i)
						Log = dymola.getLastError()
						print('\n Error: '+i+'\n')
						print(Log)
		
		if self.Changedmodels == True:
			list_path = 'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt'
			list_mo_models = git_models(".mo",self.Package, list_path)
			model_list= list_mo_models.sort_mo_models()
			examplelist= []
			for e in model_list:
				examples = e.split(".")
				if examples[len(examples)-2] == "Examples" or examples[len(examples)-2] == "Validation":
					examplelist.append(e)
			
			ErrorList = []
				
			if len(examplelist) == 0:
				print("No changed examples in Package: "+self.Package)
				exit(0)	
			for i in examplelist:
				result=dymola.checkModel(i,simulate=True)
				if result == True:
					print('\n Successful: '+i+'\n')
				if result == False:
					print("Second Check Test")
					result=dymola.checkModel(i,simulate=True)
					if result == True:
						print('\n Successful: '+i+'\n')
					if result == False:
						ErrorList.append(i)
						Log = dymola.getLastError()
						print('\n Error: '+i+'\n')
						print(Log)		
		dymola.savelog(self.Package+"-log.txt")
		dymola.close()
		logfile = self.Package+"-log.txt"
		ValidateTest._WriteErrorlog(self,logfile)
		return ErrorList
	
	
	
	
	
	"""Create a LogFIle from a package in IPBSA Library"""
	
	def _CreateIBPSALog(self):
		from dymola.dymola_interface import DymolaInterface
		from dymola.dymola_exception import DymolaException
		import buildingspy.development.regressiontest as u
		
		""" Check the IBPSA Model Automatical """	
		cmd = "git clone https://github.com/ibpsa/modelica-ibpsa.git"
		returned_value = os.system(cmd)  # returns the exit code in unix
		print('returned value:', returned_value)
		cmd = "cd modelica-ibpsa-master"
		os.system(cmd)
		Library = IBPSA/package.mo
		ut = u.Tester(tool = self.tool)
		### Set Number of Threads
		ut.setNumberOfThreads(self.n_pro)
		### Set GUI Show
		ut.showGUI(self.show_gui)
		### Set in Batch Mode
		ut.batchMode(self.batch)
		### Sets the Dymola path to activate the GUI
		
		dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
		### Writes all information in the log file, not only the last entries
		dymola.ExecuteCommand("Advanced.TranslationInCommandLog:=true;")
		dym_sta_lic_available = dymola.ExecuteCommand('RequestOption("Standard");')
		if not dym_sta_lic_available:
			dymola.ExecuteCommand('DymolaCommands.System.savelog("Log_NO_DYM_STANDARD_LIC_AVAILABLE.txt");')
			print("No Dymola License is available")
			dymola.close()
			exit(1)
		else:
			print("Dymola License is available")
	
		
		PackageCheck = dymola.openModel(Library)
		if PackageCheck == True:
			print("Found AixLib Library and start Checkmodel Tests \n Check Package " + self.Package+" \n")
		elif PackageCheck == None:
			print("Library Path is wrong. Please Check Path of AixLib Library Path")
			exit(1)
		result=dymola.checkModel(self.Package)
		dymola.savelog(self.Package+"-log.txt")
		Log = dymola.getLastError()
		if result == True:
			print('\n Check of Package '+self.Package+' was Successful! \n')
			dymola.close()
			#exit(0)
		if result == False:
			print('\n ModelCheck Failed in Package ' + self.Package+ ' Show Savelog \n')
			print(Log)
			dymola.clearlog()
			dymola.close()
			#exit(1)
		
	
	
	
	
	def _compareIBPSA(self):
		AixLibPackage = self.Package
		IBPSAPackage = self.Package.replace("AixLib", "IBPSA")
		""" Check the IBPSA Model Automatical """	
		cmd = "git clone https://github.com/ibpsa/modelica-ibpsa.git"
		returned_value = os.system(cmd)  # returns the exit code in unix
		print('returned value:', returned_value)
		Path = r"bin/CITests/UnitTests/CheckPackages/LogFiles"
		IBPSA_Data = Path+"//"+IBPSAPackage+"-log.txt"
		# Check if the Log File exists
		#if IBPSA_Data.is_file():
		IBPSAFile = open(IBPSA_Data,"r")
		#else:
		#	print("No Log deposited")
		#		exit(1)
		IBPSA_ErrorList = []
		AixLib_ErrorList = []
		for line in  IBPSAFile:
			List = line.split()
			if len(List) > 1:
				if List[0] == "Error:":
					IBPSA_ErrorList.append(line)
		IBPSAFile.close() 
		Path = r"AixLib/"	
		AixLibFile = open(Path+AixLibPackage+"-log.txt","r")
		for line in AixLibFile:
			List = line.split()
			if len(List) > 1:
				if List[0] == "Error:":
					AixLib_ErrorList.append(line)
		AixLibFile.close()
		if len(AixLib_ErrorList) == len(IBPSA_ErrorList):
			print("Errors are already in IPBSA Library")
			exit(0)
		elif len(AixLib_ErrorList) != len(IBPSA_ErrorList):
			print("Error in "+ AixLibPackage)
			for element in AixLib_ErrorList:
				if not element in IBPSA_ErrorList:
					print(element)	
			exit(1)
		
	
	def _setLibraryRoot(self):
		"""Set the root directory of the library.   
		The root directory is the directory that contains the ``Resources`` folder
        and the top-level ``package.mo`` file."""
		self._libHome = os.path.abspath(rootDir)
        
	def _validate_experiment_setup(path):
		import buildingspy.development.validator as v
		val = v.Validator()
		retVal = val.validateExperimentSetup(path)

	### Add to the environemtn variable 'var' the value 'value'
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

if  __name__ == '__main__':
	"""Parser"""
	# Configure the argument parser
	parser = argparse.ArgumentParser(description = "Check and Validate single Packages")
	check_test_group = parser.add_argument_group("arguments to run check tests")
	check_test_group.add_argument("-b", "--batch", action ="store_true", help="Run in batch mode without user Interaction")
	check_test_group.add_argument("-t", "--tool", metavar="dymola",default="dymola", help="Tool for the Checking Tests. Set to Dymola")
	check_test_group.add_argument('-s',"--single-package",metavar="AixLib.Package", help="Test only the Modelica package AixLib.Package")
	check_test_group.add_argument("-p","--path", default=".", help = "Path where top-level package.mo of the library is located")
	check_test_group.add_argument("-n", "--number-of-processors", type=int, default= multiprocessing.cpu_count(), help="Maximum number of processors to be used")
	check_test_group.add_argument("--show-gui", help="show the GUI of the simulator" , action="store_true")
	check_test_group.add_argument("-WL", "--WhiteList", help="Create a WhiteList of IBPSA Library: y: Create WhiteList, n: Don´t create WhiteList" , action="store_true")
	check_test_group.add_argument("-SE", "--SimulateExamples", help="Check and Simulate Examples in the Package" , action="store_true")
	check_test_group.add_argument("-DS", "--DymolaVersion",default="2020", help="Version of Dymola(Give the number e.g. 2020")
	check_test_group.add_argument("-CM", "--Changedmodels",default=False, action="store_true")
	
	
	# Parse the arguments
	args = parser.parse_args()
	from validatetest import  ValidateTest
	# Set environment variables
	CheckModelTest = ValidateTest(Package = args.single_package, 
								Library = args.path, 
								batch = args.batch,
								tool = args.tool,
								n_pro = args.number_of_processors,
								show_gui = args.show_gui,
								WhiteList = args.WhiteList,
								SimulateExamples = args.SimulateExamples,
								Changedmodels = args.Changedmodels)
								
	Git_Operation_Class = Git_Repository_Clone(Repository="Repo")
	### Checks the Operating System, Important for the Python-Dymola Interface 							
	if platform.system()  == "Windows":
		_setEnvironmentVariables("PATH", os.path.join(os.path.abspath('.'), "Resources", "Library", "win32"))
		sys.path.insert(0, os.path.join('C:\\',
                            'Program Files',
                            'Dymola '+ args.DymolaVersion,
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
							'dymola-'+args.DymolaVersion+'-x86_64',
							'Modelica',
							'Library',
							'python_interface',
							'dymola.egg'))
	sys.path.append(os.path.join(os.path.abspath('.'), "..", "..", "BuildingsPy"))

	"""Start Check and Validate Test"""
	if args.single_package:
		single_package = args.single_package
	else:
		single_package = None
	
	"""Write a new WhiteList"""
	if args.WhiteList == True:
		print("Write new Writelist from IBPSA Library")
		Git_Operation_Class._CloneRepository()
		CheckModelTest._WriteWhiteList()
		#Git_Operation_Class._git_push_WhiteList()
		#filename= "bin"+os.sep+"WhiteLists"+os.sep+"WhiteList_CheckModel.txt"
		#filename= "CheckModel.txt"
		#print(filename)
		#file = open(filename,"w")
		#file.write("test")
		
		#file.close()
		exit(0)
		
	"""Simulate all Examples and Validation in a Package"""
	if args.SimulateExamples == True:
		print("Simulate")
		Error = CheckModelTest._SimulateModel()
		
		if len(Error) == 0:
			print("Simulate of all Examples was successful!")
			exit(0)
		elif len(Error) > 0:
			print("Simulate Failed")
			for i in Error:
				print("Error: Check Model "+i)
			exit(1)
	#Check all Models in a Package
	
	else:
		Error = CheckModelTest._CheckModelAixLib()
		if args.Changedmodels == False:
			IBPSA_Model = str(CheckModelTest._IgnoreWhiteList())
			print("\n"+"\n")
			if len(IBPSA_Model) > 0:
				print("Don´t Check these Models "+IBPSA_Model)
		if len(Error)  == 0:
			print("Test was Successful!")
			exit(0)
		elif len(Error)  > 0:
			print("Test failed!")
			for i in Error:
				print("Error:Check Model "+i)
			exit(1)
	
	
	