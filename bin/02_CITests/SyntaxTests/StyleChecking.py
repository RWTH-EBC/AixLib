from buildingspy.development import error_dictionary_jmodelica
from buildingspy.development import error_dictionary_dymola

import codecs
import multiprocessing
import argparse
import os
import sys 
import platform

class StyleCheck(object):
	""" Class to Check the Style of Packages and Models
	Export a HTML-Log File"""
	
	def __init__(self, Package, Library, tool,DymolaVersion):
		self.Package = Package 
		self.Library = Library
		self.tool = tool
		self.DymolaVersion = DymolaVersion
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
		dymola.ExecuteCommand('ModelManagement.Check.checkLibrary(false, false, false, true, "'+self.Package+'", translationStructure=false);')
		dymola.close()
		print("Style Check Complete")
		Logfile = self.Library.replace("package.mo",self.Package+"_StyleCheckLog.html")
		return Logfile

	def _StyleCheckLog_Check(self):
		inputfile = StyleCheck._CheckStyle(self)
		#outputfile = self.Package+"_StyleErrorLog.html"
		outputfile = inputfile.replace("_StyleCheckLog.html", "_StyleErrorLog.html")
		Logfile = codecs.open(inputfile, "r", encoding='utf8')
		ErrorLog = codecs.open(outputfile, "w", encoding='utf8')
		ErrorCount = 0
		for line in Logfile:
			if line.find("Check ok") > -1 :
				continue
			else:
				ErrorCount = ErrorCount + 1 
				ErrorLog.write(line)
		Logfile.close()
		ErrorLog.close()
		if ErrorCount == 0:
			print("Style Check was successful")
			exit(0)
		elif ErrorCount > 0 :
			print("Test failed. Look in "+ self.Package + "_StyleErrorLog.html")
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
	
	# Parse the arguments
	args = parser.parse_args()
	
	from StyleChecking import StyleCheck
	
	CheckStyleTest = StyleCheck(Package = args.single_package, 
								Library = args.path,
								tool = args.tool,
								DymolaVersion = args.DymolaVersion)	
								
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