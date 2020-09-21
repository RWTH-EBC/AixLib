import os
import sys
from CheckPackages.sort_models import git_models
import platform
import multiprocessing

import argparse

class Reg_Reference(object):
	def __init__(self, package, library  ):
		self.package = package
		self.library = library
		
	## Sort alle 
	def _sort_mos_scripts(self):
		Name = self.package.replace("AixLib.","")
		Name = Name.replace("AixLib","")
		Name = Name.replace(".",os.sep)
		resource_file_path = "Resources"+os.sep+"Scripts"+os.sep+"Dymola"+os.sep+Name
		#resource_file_path = "Resources"+os.sep+"Scripts"+os.sep+"Dymola"
		
		mos_list = []
		
		
		for subdir, dirs, files in os.walk(resource_file_path):
				for file in files:
					filepath = subdir + os.sep + file
					if filepath.endswith(".mos"):
						mos_script = filepath[filepath.find("Dymola"):]
						mos_script = mos_script.replace("Dymola",self.library)
						mos_script = mos_script.replace(os.sep, ".")
						mos_script = mos_script.replace(".mos", "")
						mos_list.append(mos_script)
		#print(mos_list)
		return mos_list
	
	def _check_ref(self):
		ref_file_path = "Resources"+os.sep+"ReferenceResults"+os.sep+"Dymola"
		ref_list = []
		for subdir, dirs, files in os.walk(ref_file_path):
				for file in files:
					filepath = subdir + os.sep + file
					if filepath.endswith(".txt"):
						if filepath.find(self.package.replace(".","_")) > -1:
							ref_txt = filepath[filepath.find(self.library):]
							#ref_txt = ref_txt.replace("_",".")
							ref_txt = ref_txt.replace(".txt","")
							ref_list.append(ref_txt)
		return ref_list
	
	def compare_ref_mos(self):
		# Mos Scripts
		mos_list = Reg_Reference._sort_mos_scripts(self)
		# Reference files 
		ref_list = Reg_Reference._check_ref(self)
		
		
		
		err_list = []
		for i in mos_list:
			i_ch = i.replace(".","_")
			for l in ref_list:
				if i_ch == l:
					err_list.append(i)
					break
				else:
					continue
		
		
		for i in err_list:
			mos_list.remove(i)
		##Test 
		ref_file_path = "Resources"+os.sep+"ReferenceResults"+os.sep+"Dymola"
		for subdir, dirs, files in os.walk(ref_file_path):
				for file in files:
					filepath = subdir + os.sep + file
					if filepath.endswith(".txt"):
						if filepath.find(self.package) > -1:
							ref_txt = filepath[filepath.find(self.library):]
							for t in mos_list:
								t = t.replace(".","_")+".txt"
								if ref_txt == t:
									mos_list.remove(t)
									
		'''						
		if len(mos_list) > 0:
			for i in mos_list:
				print("Reference file " + i.replace(".","_")+".txt does not yet exist")
				continue
			print("Create new Reference files")
		'''
		return mos_list
	
	def create_ReferenceResults(self):
		mos_list = Reg_Reference.compare_ref_mos(self)
		import buildingspy.development.regressiontest as u
		
		
		self._libHome = os.path.abspath(".")
		ut = u.Tester(tool="dymola")
		ut.batchMode(False)
		ut.setLibraryRoot(".")
		
		Ref_List = []
		'''if mos_list is not None:
			ut.setSinglePackage(self.package)
			ut.setNumberOfThreads(self.n_pro)
			ut.pedanticModelica(False)
			ut.showGUI(True)
			#ut.showGUI(self.show_gui)
			retVal = ut.run()'''
				
		
		if mos_list is not None:
			for i in mos_list:
				name = i
				name = name[:name.rfind(".")]
				#name = name[:name.rfind("Example")+7]
				#name = name[:name.rfind("Validation")+10]
				
				Ref_List.append(name)
			Ref = list(set(Ref_List))
			#EOF = open('EOF', 'w')
			#EOF.write("y")
			for i in Ref:
				print("Generate new Reference File for "+i)
				#name = i.replace("_",".")
				#name = name[:name.rfind(".")]
				ut.setSinglePackage(i)
				ut.setNumberOfThreads(self.n_pro)
				ut.pedanticModelica(False)
				ut.showGUI(True)
				
				#ut.showGUI(self.show_gui)
				retVal = ut.run()
				continue
		else:
			print("All Reference files exists. Now the CI Tests will starts")
			exit(0)
		
		
		#return retVal

	
	
			
	
	
	
	

def _setEnvironmentVariables(var, value):
	''' Add to the environment variable `var` the value `value`
	'''
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
	
	
	
	# Set environment variables
	parser = argparse.ArgumentParser(description='Run the unit tests or the html validation only.')
	unit_test_group = parser.add_argument_group("arguments to run unit tests")

	unit_test_group.add_argument('-s', "--single-package",
                        metavar="Modelica.Package",
                        help="Test only the Modelica package Modelica.Package")
	
	unit_test_group.add_argument("-p", "--path",
                        default = ".",
                        help="Path where top-level package.mo of the library is located")
	
	unit_test_group.add_argument("-n", "--number-of-processors",
                        type=int,
                        default = multiprocessing.cpu_count(),
                        help='Maximum number of processors to be used')
	
	unit_test_group.add_argument("--show-gui",
                        help='Show the GUI of the simulator',
                        action="store_true")

	unit_test_group.add_argument('-t', "--tool",
                        metavar="dymola",
                        default="dymola",
                        help="Tool for the regression tests. Set to dymola or jmodelica")
	
	unit_test_group.add_argument("-b", "--batch",
                        action="store_true",
                        help="Run in batch mode without user interaction")
	
	
	if platform.system() == "Windows":
		_setEnvironmentVariables("PATH",
								 os.path.join(os.path.abspath('.'),
											  "Resources", "Library", "win32"))
	else:
		# For https://github.com/lbl-srg/modelica-buildings/issues/559, we add
		# 32 and 64 bit resources to run the Utilities.IO.Python27 regression tests.
		_setEnvironmentVariables("LD_LIBRARY_PATH",
								 os.path.join(os.path.abspath('.'),
											  "Resources", "Library", "linux32") + ":" +
								 os.path.join(os.path.abspath('.'),
											  "Resources", "Library", "linux64"))

	# The path to buildingspy must be added to sys.path to work on Linux.
	# If only added to os.environ, the Python interpreter won't find buildingspy
	sys.path.append(os.path.join(os.path.abspath('.'), "..", "..", "BuildingsPy"))

	    # Parse the arguments
	args = parser.parse_args()
	from reference_check import Reg_Reference
	ref_check = Reg_Reference(package = args.single_package,
									  library = args.path)
	
	#ref_check = Reg_Reference(package,library)
	ref_check.create_ReferenceResults()
	exit(0)