import argparse
import os
import sys 
import platform


def dym_check_lic():
	from dymola.dymola_interface import DymolaInterface
	from dymola.dymola_exception import DymolaException

	if platform.system()  == "Windows":
		dymola = DymolaInterface()
	else:
		dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
	dymola.ExecuteCommand("Advanced.TranslationInCommandLog:=true;")
	dym_sta_lic_available = dymola.ExecuteCommand('RequestOption("Standard");')
	if not dym_sta_lic_available:
		dymola.ExecuteCommand('DymolaCommands.System.savelog("Log_NO_DYM_STANDARD_LIC_AVAILABLE.txt");')
		print("No Dymola License is available")
		dymola.close()
	else:
		print("Dymola License is available")
	
	
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

	parser = argparse.ArgumentParser(description = "Check Dymola License")
	check_test_group = parser.add_argument_group("arguments to run check tests")
	check_test_group.add_argument("-DS", "--DymolaVersion",default="2020", help="Version of Dymola(Give the number e.g. 2020")
	args = parser.parse_args()
	

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
	dym_check_lic()
	
