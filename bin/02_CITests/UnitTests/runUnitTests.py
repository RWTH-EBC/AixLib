#!/usr/bin/env python
#######################################################
# Script that runs all unit tests or, optionally,
# only checks the html syntax or the validity of
# the simulation parameters of the models
#
# To run the unit tests, this script
# - creates temporary directories for each processor,
# - copies the library directory into these
#   temporary directories,
# - creates run scripts that run all unit tests,
# - runs these unit tests,
# - collects the dymola log files from each process,
# - writes the combined log file 'unitTests.log'
#   in the current directory,
# - checks whether all unit tests run successfully,
#   and produced the same results as the reference
#   results, and
# - exits with the message
#    'Unit tests completed successfully.' or with
#   an error message.
#
# If no errors occurred during the unit tests, then
# this script returns 0. Otherwise, it returns a
# non-zero exit value.
#
# MWetter@lbl.gov                            2011-02-23
# TSNouidui@lbl.gov                          2017-04-11
#######################################################


def _validate_experiment_setup(path):
    import buildingspy.development.validator as v

    val = v.Validator()
    retVal = val.validateExperimentSetup(path)

def _validate_html(path):
    import buildingspy.development.validator as v

    val = v.Validator()
    errMsg = val.validateHTMLInPackage(path)
    n_msg = len(errMsg)
    for i in range(n_msg):
        if i == 0:
            print("The following malformed html syntax has been found:\n%s" % errMsg[i])
        else:
            print(errMsg[i])

    if n_msg == 0:
        return 0
    else:
        return 1

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

def _runUnitTests(batch, tool, package, path, n_pro, show_gui,modified_models):
	
	import buildingspy.development.regressiontest as u

	ut = u.Tester(tool=tool)
	ut.batchMode(batch)
	ut.setLibraryRoot(path)
	Errorlist = []
	if modified_models == False:
		if package is not None:
			ut.setSinglePackage(package)
		ut.setNumberOfThreads(n_pro)
		ut.pedanticModelica(False)
		ut.showGUI(show_gui)
		# ut.get_test_example_coverage()
		# Below are some option that may occassionally be used.
		# These are currently not exposed as command line arguments.
		# ut.setNumberOfThreads(1)
		# ut.deleteTemporaryDirectories(False)
		# ut.useExistingResults(['/tmp/tmp-Buildings-0-fagmeZ'])

		# ut.writeOpenModelicaResultDictionary()
		# Run the regression tests

		retVal = ut.run()
		# comment out this line for local usage
		ut.get_test_example_coverage()
		return retVal
	
	if modified_models == True:
		#regression_models = func_list_models.list_regression_tests()
		regression_models = func_list_models._remove_duplicate()
		
		if len(regression_models) == 0:
			print("No models to start a regression test")
			retVal = 0
		
		if len(regression_models) > 0:
			print("Number of checked packages: "+ str(len(regression_models)))
			print("Check examples : ")
			for l in regression_models:
				print(l)
		if len(regression_models) > 10:
			print("Over 10 changed models. Check all models in AixLib package "+package)
			if package is not None:
				ut.setSinglePackage(package)
			ut.setNumberOfThreads(n_pro)
			ut.pedanticModelica(False)
			ut.showGUI(show_gui)
			retVal = ut.run()
			ut.get_test_example_coverage()
			#return retVal
		else:
			for l in regression_models:
				if l.rfind("package")> -1:
					print("packages")
					continue
				#print("\n*****************************\nRegression test for model: "+l) 
				#model_package = l[:l.rfind(".")]
				model_package = l
				ut.setSinglePackage(model_package)
				ut.setNumberOfThreads(n_pro)
				ut.pedanticModelica(False)
				ut.showGUI(show_gui)
				# ut.get_test_example_coverage()
				# Below are some option that may occassionally be used.
				# These are currently not exposed as command line arguments.
			    # ut.setNumberOfThreads(1)
			    # ut.deleteTemporaryDirectories(False)
			    # ut.useExistingResults(['/tmp/tmp-Buildings-0-fagmeZ'])

			    # ut.writeOpenModelicaResultDictionary()
				# Run the regression tests

				retVal = ut.run()
				if retVal == 1:
					Errorlist.append(l)
					print("Regression test for model "+l+ " was not successfull")
				if retVal != 0:
					print("Regression test for model "+l+ " was successful")
				# comment out this line for local usage
				ut.get_test_example_coverage()
			if len(Errorlist) > 0:
				retVal = 1
				print("Regression test failed")
				print("The following packages failed")
				for l in Errorlist:
					print("		Error: "+l)
			else:
				retVal = 0
				print("Regression test was successful")
			
		return retVal


def _run_coverage_only(batch, tool, package, path, n_pro, show_gui):
    import buildingspy.development.regressiontest as u

    ut = u.Tester(tool=tool)
    ut.batchMode(batch)
    ut.setLibraryRoot(path)
    if package is not None:
        ut.setSinglePackage(package)
    # ut.setNumberOfThreads(n_pro)
    # ut.pedanticModelica(True)
    # ut.showGUI(show_gui)
    ut.get_test_example_coverage()
    return 0


def _runOpenModelicaUnitTests():
    import buildingspy.development.regressiontest as u
    ut = u.Tester()
    ut.batchMode(batch)
    ut.test_OpenModelica(cmpl=True, simulate=True,
                         packages=['Examples'], number=-1)

if __name__ == '__main__':
	import multiprocessing
	import platform
	import argparse
	import os
	import sys
	
	# Configure the argument parser
	parser = argparse.ArgumentParser(description='Run the unit tests or the html validation only.')
	unit_test_group = parser.add_argument_group("arguments to run unit tests")

	unit_test_group.add_argument("-b", "--batch",
                        action="store_true",
                        help="Run in batch mode without user interaction")
	unit_test_group.add_argument('-t', "--tool",
                        metavar="dymola",
                        default="dymola",
                        help="Tool for the regression tests. Set to dymola or jmodelica")
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

	unit_test_group.add_argument("--coverage-only",
                        help='Only run the coverage test',
                        action="store_true")


	unit_test_group.add_argument("--modified-models",
                        help='Regression test only for modified models',
						default=False,
                        action="store_true")
	
	unit_test_group.add_argument("-DS", "--DymolaVersion",default="2020", help="Version of Dymola(Give the number e.g. 2020")
	
	html_group = parser.add_argument_group("arguments to check html syntax only")
	html_group.add_argument("--validate-html-only",
                           action="store_true")

	experiment_setup_group = parser.add_argument_group("arguments to check validity of .mos and .mo experiment setup only")
	experiment_setup_group.add_argument("--validate-experiment-setup",
                           action="store_true")

    # Set environment variables
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
	
	from list_extended_models import Extended_model
	func_list_models = Extended_model(package = args.single_package,
									  library = "package.mo",
									  DymolaVersion = args.DymolaVersion)
	
	if args.validate_html_only:
        # Validate the html syntax only, and then exit
		ret_val = _validate_html(args.path)
		exit(ret_val)

	if args.validate_experiment_setup:
		# Match the mos file parameters with the mo files only, and then exit
		ret_val = _validate_experiment_setup(args.path)
		exit(ret_val)

	if args.single_package:
		single_package = args.single_package
	else:
		single_package = None

	if args.coverage_only:
		ret_val = _run_coverage_only(batch = args.batch,
                           tool = args.tool,
                           package = single_package,
                           path = args.path,
                           n_pro = args.number_of_processors,
                           show_gui = args.show_gui)
		exit(ret_val)


	retVal = _runUnitTests(batch = args.batch,
                           tool = args.tool,
                           package = single_package,
                           path = args.path,
                           n_pro = args.number_of_processors,
                           show_gui = args.show_gui,
						   modified_models = args.modified_models)
	exit(retVal)

#   _runOpenModelicaUnitTests()
