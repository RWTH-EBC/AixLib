from buildingspy.development import error_dictionary_jmodelica
from buildingspy.development import error_dictionary_dymola

import codecs
import multiprocessing
import argparse
import os
import sys 
import platform


from git import Repo

from sort_models import git_models

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
		


class StyleCheck(object):
	""" Class to Check the Style of Packages and Models
	Export a HTML-Log File"""
	
	def __init__(self, Package, Library, tool,DymolaVersion,Changedmodels):
		self.Package = Package 
		self.Library = Library
		self.tool = tool
		self.DymolaVersion = DymolaVersion
		self.Changedmodels = Changedmodels
	
	def _CheckStyle(self):
		DymolaVersion = self.DymolaVersion
		from dymola.dymola_interface import DymolaInterface
		from dymola.dymola_exception import DymolaException
		import buildingspy.development.regressiontest as u
		ut = u.Tester(tool = self.tool)
		if platform.system()  == "Windows":
			dymola = DymolaInterface(showwindow=True)
		else:
			dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
		# Load AixLib
		LibraryCheck = dymola.openModel(self.Library)
		if LibraryCheck == True:
			print("Found AixLib Library and start style check")
		elif LibraryCheck == False:
			print("Library Path is wrong. Please Check Path of AixLib Library Path")
			exit(1)
		
		# Load ModelManagement
		if platform.system()  == "Windows":
			dymola.ExecuteCommand('cd("C:\Program Files\Dymola '+DymolaVersion+'\Modelica\Library\ModelManagement 1.1.8\package.moe");')
		
		else:
			dymola.ExecuteCommand('cd("/opt/dymola-'+DymolaVersion+'-x86_64/Modelica/Library/ModelManagement 1.1.8/package.moe");')
		# Start CheckLibrary in ModelManagement
		print("Start Style Check")
		if self.Changedmodels == False:
			print("Check package or model "+ self.Package)
			dymola.ExecuteCommand('ModelManagement.Check.checkLibrary(false, false, false, true, "'+self.Package+'", translationStructure=false);')
			Logfile = self.Library.replace("package.mo",self.Package+"_StyleCheckLog.html")
			model_list = []
		else:
			changed_model_list=[]
			list_mo_models = git_models(".mo",self.Package)
			model_list= list_mo_models.sort_mo_models()
			#print(model_list)
			if len(model_list) > 100:
				print("Over 100 changed models. Check all models in AixLib Library")
				print("Check AixLib Library: "+ self.Package)
				dymola.ExecuteCommand('ModelManagement.Check.checkLibrary(false, false, false, true, "'+self.Package+'", translationStructure=false);')
				Logfile = self.Library.replace("package.mo",self.Package+"_StyleCheckLog.html")
				self.Changedmodels = False
			else:
				for l in model_list:
					print("Check package or model "+ l)
					path = self.Library.replace("package.mo", "")
					dymola.ExecuteCommand('ModelManagement.Check.checkLibrary(false, false, false, true, "'+l+'", translationStructure=false);')
					inputfile = path+l+"_StyleCheckLog.html"
					log = codecs.open(inputfile,"r",encoding='utf8')
					for line in log:
						changed_model_list.append(line)
					log.close()	
					os.remove(inputfile)
				path_outfile = 	"ChangedModels_StyleCheckLog.html"
				all_logs = codecs.open(path+path_outfile, "w", encoding='utf8')
				for i in changed_model_list:
					all_logs.write(i)
				all_logs.close()
				Logfile = path+path_outfile
		dymola.close()
		print("Style Check Complete")
		return Logfile, model_list

	def _StyleCheckLog_Check(self):
		result = StyleCheck._CheckStyle(self)
		inputfile = result[0]
		model_list = result[1]
		#print(inputfile)
		#outputfile = self.Package+"_StyleErrorLog.html"
		outputfile = inputfile.replace("_StyleCheckLog.html", "_StyleErrorLog.html")
		Logfile = codecs.open(inputfile, "r", encoding='utf8')
		ErrorLog = codecs.open(outputfile, "w", encoding='utf8')
		ErrorCount = 0
		
		for line in Logfile:
			line = line.strip()
			if line.find("Check ok") > -1 :
				continue
			if line.find("Library style check log") > -1:
				continue
			if self.Changedmodels == False:
				if line.find("HTML style check log for "+ self.Package) > -1:
					continue
			if self.Changedmodels == True:
				correct = 0
				for l in model_list:
					if line.find("HTML style check log for "+ l) > -1:
						correct = correct + 1
						break 
				if correct > 0 :
					continue
				
			if len(line) == 0:
				continue
			else:
				print("Error in model: \n \n"+line.lstrip())
				ErrorCount = ErrorCount + 1 
				ErrorLog.write(line)
			
			
		Logfile.close()
		ErrorLog.close()
		if self.Changedmodels == False:
			if ErrorCount == 0:
				print("Style Check of model or package "+self.Package+ " was successful")
				exit(0)
			elif ErrorCount > 0 :
				print("Test failed. Look in "+ self.Package + "_StyleErrorLog.html")
				exit(1)
		else:
			if ErrorCount == 0:
				for l in model_list:
					print("\n Style Check of model or package "+l+ " was successful")
					continue
				exit(0)
			elif ErrorCount > 0 :
				print("\nTest failed. Look in "+ outputfile.lstrip() )
				exit(1)
			
		

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
	parser = argparse.ArgumentParser(description = "Check the Style of Packages")
	check_test_group = parser.add_argument_group("arguments to run check tests")
	check_test_group.add_argument("-t", "--tool", metavar="dymola",default="dymola", help="Tool for the Checking Tests. Set to Dymola")
	check_test_group.add_argument('-s',"--single-package",metavar="AixLib.Package", help="Test only the Modelica package AixLib.Package")
	check_test_group.add_argument("-p","--path", default=".", help = "Path where top-level package.mo of the library is located")
	check_test_group.add_argument("-DS", "--DymolaVersion",default="2020", help="Version of Dymola(Give the number e.g. 2020")
	check_test_group.add_argument("-CM", "--Changedmodels",default=False, action="store_true")
	
	# Parse the arguments
	args = parser.parse_args()
	
	from StyleChecking import StyleCheck
	
	CheckStyleTest = StyleCheck(Package = args.single_package, 
								Library = args.path,
								tool = args.tool,
								DymolaVersion = args.DymolaVersion,
								Changedmodels = args.Changedmodels)	
								
	# Set path for python-dymola-interface: Operating System windows and linux
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
	CheckStyleTest._StyleCheckLog_Check()