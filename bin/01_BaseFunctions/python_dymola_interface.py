
def _Test():
	
	# Import dymola package
	from dymola.dymola_interface import DymolaInterface
	from dymola.dymola_exception import DymolaException
	
	dymola = None
	
	#dymola.dymola_interface.DymolaInterface(dymolapath="", port=-1, showwindow=True, debug=False, allowremote=False, nolibraryscripts=False) 
	
	try: 
		dymola = DymolaInterface(showwindow=True)
		dymola.simulateModel("Modelica.Mechanics.Rotational.Examples.CoupledClutches")
		print("Simulate")
	
	except DymolaException as ex:
		print("Error")


def print_format_table():
    """
    prints table of formatted text format options
    """
    for style in range(8):
        for fg in range(30,38):
            s1 = ''
            for bg in range(40,48):
                format = ';'.join([str(style), str(fg), str(bg)])
                s1 += '\x1b[%sm %s \x1b[0m' % (format, format)
            print(s1)
        print('\n')

		

def _python_Interface():
	from dymola.dymola_interface import DymolaInterface
	from dymola.dymola_exception import DymolaException
	
	dymola = DymolaInterface(showwindow=True)
	dymola.openModel("D:/Gitlab/GitLabCI/AixLib/package.mo")

	result=dymola.checkModel("AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve")
	print(result)
	Log = dymola.getLastError()
	print(Log)
	#Errorlog = dymola.getLastErrorLog()
    #print(Errorlog)
	dymola.savelog("Fluid-log.txt")
	dymola.close()
	if result == True:
		print('\n Check was Successful! \n')
		exit(0)
	if result == False:
		print('\n Error: Look in Savelog \n')
		exit(1)
	
	
	#if dymola is not None:
	#	dymola.close()
	#	dymola = None
	#if Errorlog is not None:
	#	print(Errorlog)

	### Exit
	
	#if result == "False":
	#	exit(1)
	#if result == "true":
	#	print("Test was successful")
	#	exit(0)

	
def _Advanced():
	from dymola.dymola_interface import DymolaInterface
	from dymola.dymola_exception import DymolaException
	dymola = DymolaInterface()
	dymola.Execute(r"N:\Forschung\EBC0387_Vaillant_Low_GWP_HP_study_GES\Students\cve-shi\02_Hiwi\05_GIT\Dymola\GitLabCI\bin\CITests\UnitTests\CheckPackages\CheckModelTests.mos")



	
Checker = Checker	
if  __name__ == '__main__':
	import os
	import sys 
	sys.path.insert(0, os.path.join('C:\\',
                            'Program Files',
                            'Dymola 2019',
                            'Modelica',
                            'Library',
                            'python_interface',
                            'dymola.egg'))
	
	#_Test()
	_python_Interface()
	#_Advanced()