import os
import sys
import platform
import multiprocessing
import argparse
import time


class Reg_Reference(object):

    def __init__(self, package, library, n_pro, tool, batch, show_gui, path):
        self.package = package
        self.library = library
        self.n_pro = n_pro
        self.tool = tool
        self.batch = batch
        self.show_gui = show_gui
        self.path = path

        sys.path.append('../bin/CITests')
        from _config import ref_file_dir, resource_dir,  exit_file, ref_file, ref_whitelist_file, update_ref_file
        self.ref_file_path = ref_file_dir
        self.resource_file_path = resource_dir
        self.ref_whitelist = f'..{os.sep}{ref_whitelist_file}'
        self.update_ref_file = update_ref_file
        self.exit_file = f'..{os.sep}{exit_file}'
        self.ref_file = f'..{os.sep}{ref_file}'

        self.CRED = '\033[91m'  # Color
        self.CEND = '\033[0m'
        self.green = "\033[0;32m"

        import buildingspy.development.regressiontest as u  # Buildingspy
        self.ut = u.Tester(tool=self.tool)

    def _get_mos_scripts(self):  # obtain mos scripts that are feasible for regression testing
        mos_list = []
        for subdir, dirs, files in os.walk(self.resource_file_path):
            for file in files:
                filepath = subdir + os.sep + file
                if filepath.endswith(".mos"):
                    infile = open(filepath, "r")
                    lines = infile.read()
                    if lines.find("simulateModel") > -1:
                        mos_script = filepath[filepath.find("Dymola"):filepath.find(".mos")].replace("Dymola",
                                                                                                     self.library)
                        mos_script = mos_script.replace(os.sep, ".")
                        mos_list.append(mos_script)
                    if lines.find("simulateModel") == -1:
                        print(
                            f'{self.CRED}This mos script is not suitable for regression testing:{self.CEND} {filepath} ')
                    infile.close()
                    continue
        return mos_list

    def _write_reg_list(self):  # writes a list for feasible regression tests
        mos_list = Reg_Reference._get_mos_scripts(self)
        wh_file = open(self.ref_file, "w")
        for mos in mos_list:
            wh_file.write(f'\n{mos}\n')
        wh_file.close()

    def _get_check_ref(self):  # give a reference list
        ref_list = []
        for subdir, dirs, files in os.walk(self.ref_file_path):
            for file in files:
                filepath = subdir + os.sep + file
                if filepath.endswith(".txt"):
                    ref_file = filepath[filepath.rfind(self.library):filepath.find(".txt")]
                    ref_list.append(ref_file)
        return ref_list

    def _delte_ref_file(self, ref_list):  # delete reference files
        ref_dir = f'{self.library}{os.sep}{self.ref_file_path}'
        for ref in ref_list:
            print(f'Update reference file: {ref_dir}{os.sep}{ref}\n')
            if os.path.exists(f'..{os.sep}{ref_dir}{os.sep}{ref}') is True:
                os.remove(f'..{os.sep}{ref_dir}{os.sep}{ref}')
            else:
                print(f'File {ref_dir}{os.sep}{ref} does not exist\n')

    def _get_ref_package(self):  # reproduces packages in which reference results are missing
        mos_list = Reg_Reference._compare_ref_mos(self)
        package_list = []
        if mos_list is not None:
            for mos in mos_list:
                package_name = mos
                package_list.append(package_name)
        for package in package_list:
            print(f'{self.CRED}No Reference result for Model:{self.CRED} {package}')
        return package_list

    def _get_whitelist_package(self):  # get and filter package from reference whitelist
        ref_wh = open(self.ref_whitelist, "r")
        lines = ref_wh.readlines()
        wh_list = []
        for line in lines:
            if len(line.strip()) == 0:
                continue
            else:
                wh_list.append(line.strip())
        ref_wh.close()
        for wh_package in wh_list:
            print(
                f'{self.CRED} Don´t create reference results for package{self.CEND} {wh_package}: This Package is on the whitelist')
        return wh_list

    def _compare_ref_mos(self):  # compares if both files existed
        mos_list = Reg_Reference._get_mos_scripts(self)  # Mos Scripts
        ref_list = Reg_Reference._get_check_ref(self)  # Reference files
        err_list = []
        for mos in mos_list:
            for ref in ref_list:
                if mos.replace(".", "_") == ref:  # mos_script == reference results
                    err_list.append(mos)
                    break
        for err in err_list:
            mos_list.remove(err)  # remove all mos script for that a ref file exists
        return mos_list

    def _compare_wh_mos(self):  # filter model from whitelist
        package_list = Reg_Reference._get_ref_package(self)
        wh_list = Reg_Reference._get_whitelist_package(self)
        err_list = []
        for package in package_list:
            for wh_package in wh_list:
                if package[:package.rfind(".")].find(wh_package) > -1:
                    print(
                        f'{self.green}Don´t Create reference results for model{self.CEND} {package} This package is on the whitelist')
                    err_list.append(package)
                else:
                    continue
        for err in err_list:
            package_list.remove(err)
        return package_list


    def _create_reference_results(self):  # creates reference files that do not yet exist
        self.ut.batchMode(False)
        self.ut.setLibraryRoot(self.path)
        model_list = Reg_Reference._compare_wh_mos(self)
        package_list = []
        print(f'\n \n')
        model_list = list(set(model_list))
        for model in model_list:
            print(f'{self.green}Generate new reference results for model: {self.CEND} {model}')
            package_list.append(model[:model.rfind(".")])
        package_list = list(set(package_list))
        print(f'\n \n')
        if len(package_list) > 0:
            for package in package_list:
                print(f'{self.green}Generate new reference results for package: {self.CEND} {package}')
                self.ut.setSinglePackage(package)
                self.ut.setNumberOfThreads(self.n_pro)
                self.ut.pedanticModelica(False)
                self.ut.showGUI(self.show_gui)
                response = self.ut.run()
                print("I am still here")
                if response == 1:
                    print(f'{self.CRED}Error in package: {self.CEND} {package}')
                    continue
                else:
                    print(f'{self.green}New reference results in package: {self.CEND} {package}\n')
                    continue
        else:
            ex_file = open(self.exit_file, "w")
            ex_file.write("#!/bin/bash" + "\n" + "\n" + "exit 0")
            ex_file.close()
            print(f'{self.green}All Reference files exists, except the Models on WhiteList.{self.CEND}')
            exit(0)

    def _get_update_package(self, ref_list):
        ref_package_list = []
        for ref in ref_list:
            if ref.rfind("Validation") > -1:
                ref_package_list.append(ref[:ref.rfind("_Validation")+11].replace("_","."))
            elif ref.rfind("Examples") > -1:
                ref_package_list.append(ref[:ref.rfind("_Examples")+9].replace("_", "."))

        ref_package_list = list(set(ref_package_list))
        return ref_package_list

    def _get_update_ref(self):  # get a model to update
        file = open(f'..{os.sep}{self.update_ref_file}', "r")
        lines = file.readlines()
        ref_list = []
        for line in lines:
            if len(line) == 0:
                continue
            elif line.find(".txt") > -1:
                ref_list.append(line.strip())
        file.close()
        if len(ref_list) == 0:
            print(f'No reference files in file {self.update_ref_file}. Please add here your reference files you want to update')
            exit(0)
        return ref_list

    def _update_ref(self, package):  # Update reference results
        self.ut.batchMode(False)
        self.ut.setLibraryRoot(self.path)
        if package is not None:
            self.ut.setSinglePackage(package)
            print(f'{self.green}Update reference results for the packages: {self.CEND} {package}')
        self.ut.setNumberOfThreads(self.n_pro)
        self.ut.pedanticModelica(False)
        self.ut.showGUI(self.show_gui)
        retVal = self.ut.run()
        return retVal

    def _get_ref_model(self):
        mo_list = []
        ref_file = open(self.ref_file, "r")
        lines = ref_file.readlines()
        for line in lines:
            if line.find(self.package) > -1:
                mo_list.append(line.strip())
        ref_file.close()
        return mo_list

    def _compare_reg_model(self, modelica_list, mo_list):
        reg_list = []
        for model in modelica_list:
            for mo in mo_list:
                if model == mo:
                    reg_list.append(model)
        return reg_list

    def _check_regression_test(self, package):  # start regression test for a package
        if package is None:
            print(f'{self.CRED}Error:{self.CEND} Package is missing! (e.g. Airflow)')
            exit(1)
        if self.library is None:
            print(f'{self.CRED}Error:{self.CEND} Library is missing! (e.g. AixLib)')
            exit(1)
        self.ut.batchMode(self.batch)
        self.ut.setLibraryRoot(self.path)
        if package is not None:
            self.ut.setSinglePackage(package)
        self.ut.setNumberOfThreads(self.n_pro)
        self.ut.pedanticModelica(False)
        self.ut.showGUI(self.show_gui)
        retVal = self.ut.run()
        return retVal

class Extended_model(object):

    def __init__(self, package, library, dymolaversion, path):
        self.package = package
        self.library = library
        self.dymolaversion = dymolaversion
        self.path = path
        sys.path.append('../bin/CITests')
        from _config import ch_file, resource_dir
        self.changed_file = f'..{os.sep}{ch_file}'
        self.resource_file_path = f'{resource_dir}{os.sep}{self.package.replace(self.library + ".", "")}'
        self.package_path = f'{self.package}'

        self.CRED = '\033[91m'  # Color
        self.CEND = '\033[0m'
        self.green = "\033[0;32m"

        if self.package is None:
            print(f'{self.CRED}Error:{self.CEND} Package is missing! (e.g. Airflow)')
            exit(1)
        if self.library is None:
            print(f'{self.CRED}Error:{self.CEND} Library is missing! (e.g. AixLib)')
            exit(1)

        from dymola.dymola_interface import DymolaInterface
        from dymola.dymola_exception import DymolaException
        print(f'1: Starting Dymola instance')
        if platform.system() == "Windows":
            dymola = DymolaInterface()
        else:
            dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
        self.dymola = dymola
        self.dymola_exception = DymolaException()
        self.dymola.ExecuteCommand("Advanced.TranslationInCommandLog:=true;")
        librarycheck = self.dymola.openModel(self.path)
        if librarycheck == True:
            print(f'Found {self.library} Library. Start regression test.')
        elif librarycheck == False:
            print(f'Library Path is wrong. Please Check Path of {self.library} Library Path')
            exit(1)
        self.dymola.ExecuteCommand("Advanced.TranslationInCommandLog:=true;")

    def _dym_check_lic(self):  # check dymola license
        dym_sta_lic_available = self.dymola.ExecuteCommand('RequestOption("Standard");')
        lic_counter = 0
        while dym_sta_lic_available is False:
            print(f'{self.CRED} No Dymola License is available {self.CEND} \n Check Dymola license after 180.0 seconds')
            self.dymola.close()
            time.sleep(180.0)
            dym_sta_lic_available = self.dymola.ExecuteCommand('RequestOption("Standard");')
            lic_counter += 1
            if lic_counter > 30:
                if dym_sta_lic_available is False:
                    print(f'There are currently no available Dymola licenses available. Please try again later.')
                    self.dymola.close()
                    exit(1)
        print(
            f'2: Using Dymola port   {str(self.dymola._portnumber)} \n {self.green} Dymola License is available {self.CEND}')

    def _get_lines(self):  # get lines from reference whitelist
        changed_models = open(self.changed_file, "r", encoding='utf8')
        lines = changed_models.readlines()
        changed_models.close()
        return lines

    def _get_usedmodel(self, mo_list):  # get a list with all used models of regression models
        model_list = []
        lines = Extended_model._get_lines(self)
        if len(mo_list) > 0:
            if platform.system() == "Windows":  # Load ModelManagement
                self.dymola.ExecuteCommand(
                    'cd("C:\Program Files\Dymola ' + self.dymolaversion + '\Modelica\Library\ModelManagement 1.1.8\package.moe");')
            else:
                self.dymola.ExecuteCommand(
                    'cd("/opt/dymola-' + self.dymolaversion + '-x86_64/Modelica/Library/ModelManagement 1.1.8/package.moe");')
            for model in mo_list:
                use_model_list = []
                usedmodel_list = self.dymola.ExecuteCommand(
                    f'ModelManagement.Structure.Instantiated.UsedModels("{model}");')
                if usedmodel_list is None:
                    continue
                else:
                    for usemodel in usedmodel_list:
                        if usemodel.find("Modelica") > -1:
                            continue
                        if usemodel.find("Real") > -1:
                            continue
                        if usemodel.find("Integer") > -1:
                            continue
                        if usemodel.find("Boolean") > -1:
                            continue
                        if usemodel.find("String") > -1:
                            continue
                        use_model_list.append(usemodel)
                extendedmodel_list = self.dymola.ExecuteCommand(
                    f'ModelManagement.Structure.AST.ExtendsInClass("{model}");')
                if extendedmodel_list is None:
                    continue
                else:
                    for extendedmodel in extendedmodel_list:
                        if extendedmodel.find("Modelica") > -1:
                            continue
                        if extendedmodel.find("Real") > -1:
                            continue
                        if extendedmodel.find("Integer") > -1:
                            continue
                        if extendedmodel.find("Boolean") > -1:
                            continue
                        if extendedmodel.find("String") > -1:
                            continue
                        use_model_list.append(extendedmodel)
                ch_model_list = Extended_model.get_changed_used_model(self, lines, use_model_list)
                if len(ch_model_list) > 0:
                    model_list.append(model)
            self.dymola.close()
            model_list = list(set(model_list))
            return model_list

    def get_changed_used_model(self, lines, model_list):  # return all used models, that changed
        ch_model_list = []
        for line in lines:
            for model in model_list:
                if line[line.find(self.library):line.rfind(".mo")].strip() == model:
                    ch_model_list.append(model)
        return ch_model_list

    def _insert_list(self, ref_list, mos_list, modelica_list,
                     ch_model_list):  # return models, scripts, reference results and used models, that changed
        changed_list = []
        if ref_list is not None:
            for ref in ref_list:
                print(f'Changed reference files: {ref}')
                changed_list.append(ref[:ref.rfind("_")].replace("_", "."))
        if mos_list is not None:
            for mos in mos_list:
                print(f'Changed mos script files: {mos}')
                changed_list.append(mos[:mos.rfind(".")])
        if modelica_list is not None:
            for model in modelica_list:
                print(f'Changed model files: {model}')
                changed_list.append(model[:model.rfind(".")])
        if ch_model_list is not None:
            for usedmodel in ch_model_list:
                print(f'Changed used model files: {usedmodel}')
                changed_list.append(usedmodel[:usedmodel.rfind(".")])
        changed_list = list(set(changed_list))
        return changed_list

    def _get_ref(self, lines):  # return all reference results, that changed
        ref_list = []
        for line in lines:
            if line.rfind(".txt") > -1 and line.rfind("ReferenceResults") > -1 and line.find(
                    ".package") == -1 and line.rfind(self.package) > -1:
                line = line.replace("/", ".")
                line = line.replace(os.sep, ".")
                line = line.replace("..", ".")
                ref_list.append(line[line.rfind(self.library):line.rfind(".txt")])
                continue
        return ref_list

    def _get_mos(self, lines):  # return all mos script, that changed
        mos_list = []
        for line in lines:
            if line.rfind(".mos") > -1 and line.rfind("Scripts") > -1 and line.find(".package") == -1 and line.rfind(
                    self.package) > -1:
                line = line.replace("/", ".")
                line = line.replace(os.sep, ".")
                line = line.replace("Dymola", self.library)
                mos_list.append(line[line.rfind(self.library):line.rfind(".mos")])
        return mos_list

    def _get_mo(self, lines):  # return all models, that changed
        modelica_list = []
        for line in lines:
            if line.rfind(".mo") > -1 and line.find("package.") == -1 and line.rfind(self.package) > -1 and line.rfind(
                    "Scripts") == -1:
                line = line.replace("/", ".")
                line = line.replace(os.sep, ".")
                if len(line) == 0:
                    continue
                modelica_list.append(line[line.rfind(self.library):line.rfind(".mo")])
        return modelica_list


def _setEnvironmentVariables(var, value):  # Add to the environment variable `var` the value `value`
    if var in os.environ:
        if platform.system() == "Windows":
            os.environ[var] = value + ";" + os.environ[var]
        else:
            os.environ[var] = value + ":" + os.environ[var]
    else:
        os.environ[var] = value


def _validate_html(path):  # validate the html syntax
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


def _validate_experiment_setup(path):  # validate regression test setup
    import buildingspy.development.validator as v
    val = v.Validator()
    retVal = val.validateExperimentSetup(path)
    return retVal


def _run_coverage_only(batch, tool, package, path):  # Specifies which models are tested
    import buildingspy.development.regressiontest as u
    ut = u.Tester(tool=tool)
    ut.batchMode(batch)
    ut.setLibraryRoot(path)
    if package is not None:
        ut.setSinglePackage(package)
    ut.get_test_example_coverage()
    return 0


if __name__ == '__main__':
    # python bin/02_CITests/UnitTests/reference_check.py --single-package Airflow --library AixLib -DS 2019
    # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --single-package Airflow --library AixLib -DS 2019
    # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --single-package ci_update_ref_Airflow.Multizone --library AixLib -DS 2019 --update-ref
    # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --single-package ci_update_ref_AixLib.Airflow.AirHandlingUnit.Examples.AirCurtain --library AixLib -DS 2019 --update-ref
    parser = argparse.ArgumentParser(description='Run the unit tests or the html validation only.')
    unit_test_group = parser.add_argument_group("arguments to run unit tests")
    unit_test_group.add_argument("-b", "--batch",
                                 action="store_true",
                                 help="Run in batch mode without user interaction")
    unit_test_group.add_argument("--show-gui",
                                 help='Show the GUI of the simulator',
                                 action="store_true")
    unit_test_group.add_argument('-s', "--single-package",
                                 metavar="Modelica.Package",
                                 help="Test only the Modelica package Modelica.Package")
    unit_test_group.add_argument("-p", "--path",
                                 default=".",
                                 help="Path where top-level package.mo of the library is located")
    unit_test_group.add_argument("-L", "--library", default="AixLib", help="Library to test")
    unit_test_group.add_argument("-n", "--number-of-processors", type=int, default=multiprocessing.cpu_count(),
                                 help='Maximum number of processors to be used')
    unit_test_group.add_argument('-t', "--tool", metavar="dymola", default="dymola",
                                 help="Tool for the regression tests. Set to dymola or jmodelica")
    unit_test_group.add_argument("-DS", "--dymolaversion", default="2020",
                                 help="Version of Dymola(Give the number e.g. 2020")
    unit_test_group.add_argument("--coverage-only",
                                 help='Only run the coverage test',
                                 action="store_true")
    unit_test_group.add_argument("--create-ref",
                                 help='checks if all reference files exist',
                                 action="store_true")
    unit_test_group.add_argument("--ref-list",
                                 help='checks if all reference files exist',
                                 action="store_true")
    unit_test_group.add_argument("--update-ref",
                                 help='update all reference files',
                                 action="store_true")
    unit_test_group.add_argument("--modified-models",
                                 help='Regression test only for modified models',
                                 default=False,
                                 action="store_true")
    unit_test_group.add_argument("--validate-html-only", action="store_true")
    unit_test_group.add_argument("--validate-experiment-setup", action="store_true")
    CRED = '\033[91m'  # Color
    CEND = '\033[0m'
    green = "\033[0;32m"

    args = parser.parse_args()  # Parse the arguments
    if platform.system() == "Windows":  # Checks the Operating System, Important for the Python-Dymola Interface
        _setEnvironmentVariables("PATH", os.path.join(os.path.abspath('.'), "Resources", "Library", "win32"))
        sys.path.insert(0, os.path.join('C:\\',
                                        'Program Files',
                                        'Dymola ' + args.dymolaversion,
                                        'Modelica',
                                        'Library',
                                        'python_interface',
                                        'dymola.egg'))
    else:
        _setEnvironmentVariables("LD_LIBRARY_PATH",
                                 os.path.join(os.path.abspath('.'), "Resources", "Library", "linux32") + ":" +
                                 os.path.join(os.path.abspath('.'), "Resources", "Library", "linux64"))
        sys.path.insert(0, os.path.join('opt',
                                        'dymola-' + args.dymolaversion + '-x86_64',
                                        'Modelica',
                                        'Library',
                                        'python_interface',
                                        'dymola.egg'))
    # The path to buildingspy must be added to sys.path to work on Linux.
    # If only added to os.environ, the Python interpreter won't find buildingspy
    sys.path.append(os.path.join(os.path.abspath('.'), "..", "..", "BuildingsPy"))

    from reference_check import Reg_Reference

    # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --validate-html-only
    if args.validate_html_only:  # Validate the html syntax only, and then exit
        ret_val = _validate_html(args.path)
        if ret_val == 1:
            print(f'{CRED}html check failed.{CEND}')
        exit(ret_val)

    # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --validate-experiment-setup
    elif args.validate_experiment_setup:  # Match the mos file parameters with the mo files only, and then exit
        ret_val = _validate_experiment_setup(args.path)
        exit(ret_val)

    # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --coverage-only
    elif args.coverage_only:
        if args.single_package:
            single_package = args.single_package
        else:
            single_package = None
        ret_val = _run_coverage_only(batch=args.batch,
                                     tool=args.tool,
                                     package=single_package,
                                     path=args.path)
        exit(ret_val)

    ref_check = Reg_Reference(package=args.single_package,
                              library=args.library,
                              n_pro=args.number_of_processors,
                              tool=args.tool,
                              batch=args.batch,
                              show_gui=args.show_gui,
                              path=args.path)
    if args.ref_list:
        ref_check._write_reg_list()
        exit(0)
    # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --create-ref
    elif args.create_ref:
        ref_check._create_reference_results()
        exit(1)
    # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --update-ref --single-package
    elif args.update_ref:
        ref_list = ref_check._get_update_ref()
        ref_check._delte_ref_file(ref_list)
        package_list = ref_check._get_update_package(ref_list)
        for package in package_list:
            print(package)
            ret_val = ref_check._update_ref(package)
        exit(0)
    else:
        # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --single-package Airflow --library AixLib --batch -DS 2019
        if args.modified_models is False:
            list_reg_model = Extended_model(package=args.single_package,
                                            library=args.library,
                                            dymolaversion=args.dymolaversion,
                                            path="package.mo")
            list_reg_model._dym_check_lic()
            ret_val = ref_check._check_regression_test(args.single_package)
            exit(ret_val)
        # cd AixLib && python ../bin/02_CITests/UnitTests/reference_check.py --single-package Airflow --library AixLib --batch -DS 2019 -n 2 --modified-model
        if args.modified_models is True:
            ref_check._write_reg_list()
            package = args.single_package[args.single_package.rfind(".") + 1:]
            list_reg_model = Extended_model(package=package,
                                            library=args.library,
                                            dymolaversion=args.dymolaversion,
                                            path="package.mo")
            list_reg_model._dym_check_lic()
            lines = list_reg_model._get_lines()  # string change ref file
            ref_list = list_reg_model._get_ref(lines)  # get reference files from ref file
            mos_list = list_reg_model._get_mos(lines)  # get mos script from ref file
            modelica_list = list_reg_model._get_mo(lines)  # get modelica files from ref file
            mo_list = ref_check._get_ref_model()  # get the regression models from reference file list
            modelica_list = ref_check._compare_reg_model(modelica_list, mo_list)  # filter: get mo_list == modelica_list
            model_list = list_reg_model._get_usedmodel(
                mo_list)  # gives a list of regression models where submodels have been modified
            changed_list = list_reg_model._insert_list(ref_list, mos_list, modelica_list,
                                                       model_list)  # give a list with packages to check
            if len(changed_list) == 0:
                print(f'No models to check and cannot start a regression test')
                retVal = 0
            elif len(changed_list) > 0:
                error_list = []
                print(f'Number of checked packages: {str(len(changed_list))}')
                for package in changed_list:
                    print(f'Check package: {package}')
                    retVal = ref_check._check_regression_test(package)
                    if retVal != 0:
                        error_list.append(package)
                        print(f'{CRED}Regression test for model {package} was not successfull{CEND}')
                    else:
                        print(f'{green} Regression test for model {package} was successful {CEND}')
                if len(error_list) > 0:
                    print(f'{CRED} Regression test failed{CEND}')
                    print(f'The following packages{CRED} failed: {CEND}')
                    for error in error_list:
                        print(f'{CRED}Error:{CEND} {error}')
                    exit(1)
                else:
                    print(f'{green}Regression test was successful {CEND}')
                    exit(0)
