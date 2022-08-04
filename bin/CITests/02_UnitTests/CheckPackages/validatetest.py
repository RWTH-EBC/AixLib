import multiprocessing
import argparse
import os
import sys
import platform
from git import Repo
import time
import glob
from natsort import natsorted


class Git_Repository_Clone(object):
    def __init__(self, repo_dir, git_url):
        self.repo_dir = repo_dir
        self.git_url = git_url

    def _clone_repository(self):  # pull git repo
        if os.path.exists(self.repo_dir):
            print(f'IBPSA folder exists already!')
        else:
            print(f'Clone IBPSA Repo')
            Repo.clone_from(self.git_url, self.repo_dir)


class ValidateTest(object):
    """Class to Check Packages and run CheckModel Tests"""
    """Import Python Libraries"""

    def __init__(self, package, n_pro, show_gui, simulate_examples, ch_models, mo_library, wh_library,
                 filter_wh):
        self.package = package
        self.mo_library = mo_library
        self.lib_path = f'{self.mo_library}{os.sep}package.mo'
        self.root_package = f'{self.mo_library}{os.sep}{self.package}'
        self.n_pro = n_pro
        self.show_gui = show_gui
        self.simulate_ex = simulate_examples
        self.ch_models = ch_models
        self.wh_library = wh_library
        self.filter_wh = filter_wh

        sys.path.append('bin/CITests')
        from _config import ch_file, wh_file
        self.ch_file = ch_file
        self.wh_file = wh_file
        self.err_log = f'{self.mo_library}{os.sep}{self.mo_library}.{self.package}-errorlog.txt'

        self.CRED = '\033[91m'  # Colors
        self.CEND = '\033[0m'
        self.green = "\033[0;32m"

        from dymola.dymola_interface import DymolaInterface  # Load modelica python interface
        from dymola.dymola_exception import DymolaException
        print(f'1: Starting Dymola instance')
        if platform.system() == "Windows":
            dymola = DymolaInterface()
        else:
            dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
        self.dymola = dymola
        self.dymola_exception = DymolaException()
        self.dymola.ExecuteCommand(
            "Advanced.TranslationInCommandLog:=true;")  # Writes all information in the log file, not only the


    def _dym_check_lic(self):  # check dymola license
        dym_sta_lic_available = self.dymola.ExecuteCommand('RequestOption("Standard");')
        lic_counter = 0
        while dym_sta_lic_available is False:
            print(f'{self.CRED} No Dymola License is available {self.CEND} \n Check Dymola license after 180.0 seconds')
            self.dymola.close()
            time.sleep(180.0)
            dym_sta_lic_available = self.dymola.ExecuteCommand('RequestOption("Standard");')
            lic_counter += 1
            if lic_counter > 10:
                if dym_sta_lic_available is False:
                    print(f'There are currently no available Dymola licenses available. Please try again later.')
                    self.dymola.close()
                    exit(1)
        print(f'2: Using Dymola port {str(self.dymola._portnumber)} \n {self.green} Dymola License is available {self.CEND}')


    def _checkmodel(self, model_list):  # Check models and return a Error Log, if the check failed
        print(f'Library path: {self.lib_path}')
        pack_check = self.dymola.openModel(self.lib_path)
        if pack_check is True:
            print(f'Found {self.mo_library} library and start checkmodel tests. \nCheck package {self.package} \n')
        elif pack_check is False:
            print(f'Library path is wrong. Please check path of {self.mo_library} library path.')
            exit(1)
        #library_check = self.dymola.openModel("../../../../../library/Modelica 4.0.0/package.mo")  # Load modelica library MSL 4.0.0
        # self.dymola.ExecuteCommand("DefaultModelicaVersion('4.0.0', true);")
        #if library_check is False:
        #    print("Failed to load Modelica library 4.0.0")
        #    exit(1)
        #if library_check is True:
        #    print("Load Modelica library 4.0.0 successful")
        #self.dymola.ExecuteCommand('DymolaCommands.Others.DefaultModelicaVersion("4.0.0", true);')
        error_model = []
        error_message = []
        for model in model_list:
            result = self.dymola.checkModel(model)
            if result is True:
                print(f'\n {self.green} Successful: {self.CEND} {model} \n')
                continue
            if result is False:
                print(f'Check for Model {model}{self.CRED} failed!{self.CEND}\n\n{self.CRED}Error:{self.CEND} {model}\nSecond Check Test for model {model}')
                sec_result = self.dymola.checkModel(model)
                if sec_result is True:
                    print(f'\n {self.green} Successful: {self.CEND} {model} \n')
                    continue
                if sec_result is False:
                    print(f'\n   {self.CRED}  Error:   {self.CEND}  {model}  \n')
                    log = self.dymola.getLastError()
                    error_model.append(model)
                    error_message.append(log)
                    print(f'{log}')
                    continue
        self.dymola.savelog(self.mo_library + "." + self.package + "-log.txt")
        self.dymola.close()
        return error_model, error_message


    def _sim_examples(self, example_list):  # Simulate examples or validations
        pack_check = self.dymola.openModel(self.lib_path)
        if pack_check is True:
            print(f'Found {self.mo_library} Library and start check model test.\nCheck Package {self.package} \n')
        elif pack_check is False:
            print(f'Library path is wrong. Please check the path of {self.mo_library} library path.')
            exit(1)
        error_model = []
        error_message = []
        if len(example_list) == 0:
            print(f'{self.CRED}Error:{self.CEND} Found no examples')
            exit(0)
        for example in example_list:
            print(f'Simulate model: {example}')
            result = self.dymola.checkModel(example, simulate=True)
            if result is True:
                print(f'\n {self.green}Successful:{self.CEND} {example}\n')
            if result is False:
                print(f'Simulate model {example} {self.CRED} failed! {self.CEND} \n Second check test for model {example}')
                sec_result = self.dymola.checkModel(example, simulate=True)
                if sec_result is True:
                    print(f'\n {self.green} Successful: {self.CEND} {example} \n')
                if sec_result is False:
                    print(f'\n {self.CRED} Error: {self.CEND} {example}\n')
                    log = self.dymola.getLastError()
                    print(f'{log}')
                    error_model.append(example)
                    error_message.append(log)
        self.dymola.savelog(self.mo_library + "." + self.package + "-log.txt")
        self.dymola.close()
        return error_model, error_message


    def _write_errorlog(self, error_model,
                        error_message):  # Write a Error log with all models, that don´t pass the check
        error_log = open(self.err_log, "w")
        for model, message in zip(error_model, error_message):
            error_log.write(f'\n \n Error in model:  {model} \n')
            error_log.write(str(message))
        error_log.close()

    def _get_model(self):  # list all models in package
        model_list = []
        for subdir, dirs, files in os.walk(self.root_package):
            for file in files:
                filepath = subdir + os.sep + file
                if filepath.endswith(".mo") and file != "package.mo":
                    model = filepath.replace(os.sep, ".")
                    model = model[model.rfind(self.mo_library):model.rfind(".mo")]
                    model_list.append(model)
        return model_list

    def _get_ch_models(self):
        changed_models = open(self.ch_file, "r", encoding='utf8')
        modelica_models = []
        lines = changed_models.readlines()
        for line in lines:
            if line.rfind(".mo") > -1 and line.find("package") == -1:
                if line.find(f'{self.mo_library}{os.sep}{self.package}') > -1 and line.find("ReferenceResults") == -1:
                    model = line.lstrip()
                    model = model.strip()
                    model = model.replace("\n", "")
                    model_name = model[model.rfind(self.mo_library):model.rfind('.mo')]
                    model_name = model_name.replace(os.sep, ".")
                    model_name = model_name.replace('/', ".")
                    model_name = model_name.replace('.mo', "")
                    modelica_models.append(model_name)
                    continue
        changed_models.close()
        return modelica_models

    def _get_examples(self):  # list all examples in package
        example_list = []
        for subdir, dirs, files in os.walk(self.root_package):
            for file in files:
                filepath = subdir + os.sep + file
                if filepath.endswith(".mo") and file != "package.mo":
                    ex_file = open(filepath, "r", encoding='utf8', errors='ignore')
                    lines = ex_file.readlines()
                    for line in lines:
                        if line.find("extends") > -1 and line.find("Modelica.Icons.Example") > -1:
                            example = filepath.replace(os.sep, ".")
                            example = example[example.rfind(self.mo_library):example.rfind(".mo")]
                            example_list.append(example)
                            break
                    ex_file.close()
        return example_list

    def _get_ch_examples(self):  # list all changed examples in package
        changed_models = open(self.ch_file, "r", encoding='utf8',
                              errors='ignore')
        example_list = []
        lines = changed_models.readlines()
        for line in lines:
            if line.rfind(".mo") > -1 and line.find("package") == -1:
                if line.find(f'{self.mo_library}{os.sep}{self.package}') > -1 and line.find("ReferenceResults") == -1:
                    model = line.lstrip()
                    model = model.strip()
                    model = model.replace("\n", "")
                    model_name = model[model.rfind(self.mo_library):]
                    ex_file = open(model_name, "r", encoding='utf8', errors='ignore')
                    ex_lines = ex_file.readlines()
                    for ex_line in ex_lines:
                        if ex_line.find("extends") > -1 and ex_line.find("Modelica.Icons.Example") > -1:
                            example = model_name.replace(os.sep, ".")
                            example = example.replace('/', ".")
                            example = example.replace('.mo', "")
                            example_list.append(example)
                            break
                    ex_file.close()
        changed_models.close()
        return example_list

    def _filter_wh_models(self, models, wh_list):
        wh_list_mo = []
        for element in models:
            for subelement in wh_list:
                if element == subelement:
                    wh_list_mo.append(element)
        wh_list_mo = list(set(wh_list_mo))
        for example in wh_list_mo:
            models.remove(example)
        return models

    def _get_wh_models(self):  # Return a List with all models from the Whitelist
        wh_file = open(self.wh_file, "r")
        lines = wh_file.readlines()
        wh_list_models = []
        for line in lines:
            if line.find(f'{self.wh_library}.{self.package}') > -1:
                model = line.lstrip()
                model = model.strip()
                model = model.replace("\n", "")
                print(f'Dont test IBPSA model: {model}. Model is on the whitelist')
                wh_list_models.append(model.replace(self.wh_library, self.mo_library))
            elif line.find(f'{self.mo_library}.{self.package}') > -1:
                model = line.lstrip()
                model = model.strip()
                model = model.replace("\n", "")
                print(f'Dont test AixLib model: {model}. Model is on the whitelist')
                wh_list_models.append(model)
        wh_file.close()
        return wh_list_models

    def _check_result(self, error_model):
        if len(error_model) == 0:
            print(f'Test was {self.green}Successful!{self.CEND}')
            exit(0)
        if len(error_model) > 0:
            print(f'Test {self.CRED}failed!{self.CEND}')
            for model in error_model:
                print(f'{self.CRED}Error:{self.CEND} Check Model {model}')
            exit(1)
        if error_model is None:
            exit(1)


class Create_whitelist(object):

    def __init__(self, library, wh_lib):
        self.library = library
        self.wh_lib = wh_lib
        self.wh_lib_path = f'{self.wh_lib}{os.sep}{self.wh_lib}{os.sep}package.mo'

        sys.path.append('bin/CITests')
        from _config import ch_file, wh_file, exit_file
        self.ch_file = ch_file
        self.wh_file = wh_file
        self.exit_file = exit_file

        self.CRED = '\033[91m'  # Colors
        self.CEND = '\033[0m'
        self.green = '\033[0;32m'
        from dymola.dymola_interface import DymolaInterface  # Load modelica python interface
        from dymola.dymola_exception import DymolaException
        print(f'1: Starting Dymola instance')
        if platform.system() == "Windows":
            dymola = DymolaInterface()
        else:
            dymola = DymolaInterface(dymolapath="/usr/local/bin/dymola")
        self.dymola = dymola
        self.dymola_exception = DymolaException()
        self.dymola.ExecuteCommand(
            "Advanced.TranslationInCommandLog:=true;")  # ## Writes all information in the log file, not only the

    def read_script_version(self):
        aixlib_dir = f'{self.library}{os.sep}Resources{os.sep}Scripts'
        filelist = (glob.glob(aixlib_dir + os.sep + "*.mos"))
        if len(filelist) == 0:
            print("Cant find a Conversion Script in IBPSA Repo")
            exit(0)
        l_aixlib_conv = natsorted(filelist)[(-1)]
        l_aixlib_conv = l_aixlib_conv.split(os.sep)
        version = (l_aixlib_conv[len(l_aixlib_conv) - 1])
        print(f'Latest {self.library} version: {version}')
        return version

    def _check_fileexist(self):
        if os.path.exists(self.wh_file):
            print(f'Whitelist does exist. Update the whitelist under {self.wh_file}')
        else:
            print(f' Whitelist does not exist. Create a new one under {self.wh_file}')
            file = open(self.wh_file, "w+")
            file.close()

    def _check_whitelist(self,
                         version):  # Write a new Whitelist with all models in IBPSA Library of those models who have not passed the Check Test
        vfile = open(self.wh_file, "r")  # Read the last version of whitelist
        lines = vfile.readlines()
        version_check = False
        for line in lines:
            line = line.strip()
            if line.strip("\n") == version.strip("\n"):
                print(f'Whitelist is on version {version}. The Whitelist is already up to date')
                version_check = True
        vfile.close()
        return version_check

    def _get_wh_model(self, wh_path):
        model_list = []
        for subdir, dirs, files in os.walk(wh_path):
            for file in files:
                filepath = subdir + os.sep + file
                if filepath.endswith(".mo") and file != "package.mo":
                    model = filepath.replace(os.sep, ".")
                    model = model[model.rfind(self.wh_lib):model.rfind(".mo")]
                    model_list.append(model)
        if len(model_list) == 0:
            print(f'No Models')
            exit(1)
        return model_list

    def _dym_check_lic(self):  # check dymola license
        dym_sta_lic_available = self.dymola.ExecuteCommand('RequestOption("Standard");')
        lic_counter = 0
        while dym_sta_lic_available is False:
            print(f'{self.CRED} No Dymola License is available {self.CEND} \n Check Dymola license after 180.0 seconds')
            self.dymola.close()
            time.sleep(180.0)
            dym_sta_lic_available = self.dymola.ExecuteCommand('RequestOption("Standard");')
            lic_counter += 1
            if lic_counter > 10:
                if dym_sta_lic_available is False:
                    print(f'There are currently no available Dymola licenses available. Please try again later.')
                    self.dymola.close()
                    exit(1)
        print(f'2: Using Dymola port {str(self.dymola._portnumber)}\n{self.green}Dymola License is available{self.CEND}')


    def _check_wh_model(self, model_list):  # check models for creating whitelist
        package_check = self.dymola.openModel(self.wh_lib_path)
        if package_check is True:
            print(f'Found {self.wh_lib} Library and check models in library {self.wh_lib} \n')
        elif package_check is False:
            print(f'Library path is wrong. Please check path of {self.wh_lib} library path.')
            exit(1)
        error_model = []
        error_message = []
        for model in model_list:
            result = self.dymola.checkModel(model)
            if result is True:
                print(f'\n{self.green}Successful:{self.CEND} {model}\n')
                continue
            if result is False:
                print(f'\n{self.CRED}Error:{self.CEND} {model}\n')
                log = self.dymola.getLastError()
                print(f'{log}')
                error_model.append(model)
                error_message.append(log)
                continue
        self.dymola.savelog(f'{self.wh_lib}-log.txt')
        self.dymola.close()
        return error_model, error_message
        #return error_model

    def _write_exit_log(self, version_check):  # write entry in exit file
        exit = open(self.exit_file, "w")
        if version_check is False:
            exit.write(f'FAIL')
        else:
            exit.write(f'successful')
        exit.close()


    def _write_whitelist(self, error_model_list, version):  # write a new whitelist
        wh_file = open(self.wh_file, "w")
        wh_file.write(f'\n{version} \n \n')
        for model in error_model_list:
            wh_file.write(f'\n{model} \n \n')
        print(f'New whitelist was created with the version {version}')
        wh_file.close()


def _setEnvironmentVariables(var, value):  # Add to the environment variable 'var' the value 'value'
    import os
    import platform
    if var in os.environ:
        if platform.system() == "Windows":
            os.environ[var] = value + ";" + os.environ[var]
        else:
            os.environ[var] = value + ":" + os.environ[var]
    else:
        os.environ[var] = value


def check_model_workflow():
    if args.single_package is None:
        print(f'{CRED}Error:{CEND} Package is missing!')
        exit(1)
    if args.library is None:
        print(f'{CRED}Error:{CEND} Library is missing!')
        exit(1)
    print(f'Setting: Package {args.single_package}')
    print(f'Setting: library {args.library}')
    CheckModelTest._dym_check_lic()
    if args.changedmodels is True:  # Test only changed or new models
        print(f'Test only changed or new models')
        model_list = CheckModelTest._get_ch_models()
        if len(model_list) == 0:
            print(f'No changed models in Package: {args.single_package}')
            exit(0)
    elif args.filterwhitelist is True:  # Filter model on whitelist
        if args.wh_library is None:
            print(f'{CRED}Error:{CEND} WhiteList Library is missing!')
            exit(1)
        print(f'Setting: Whitelist library {args.wh_library}')
        wh_list = CheckModelTest._get_wh_models()
        models = CheckModelTest._get_model()
        model_list = CheckModelTest._filter_wh_models(models, wh_list)
    else:  # Check all models in package
        model_list = CheckModelTest._get_model()
        if len(model_list) == 0:
            print(f'No models in package {args.single_package}')
            exit(1)
    result = CheckModelTest._checkmodel(model_list)
    error_model = result[0]
    error_message = result[1]
    CheckModelTest._write_errorlog(error_model, error_message)
    CheckModelTest._check_result(error_model)


def sim_example_workflow():
    if args.single_package is None:
        print(f'{CRED}Error:{CEND} Package is missing!')
        exit(1)
    if args.library is None:
        print(f'{CRED}Error:{CEND} Library is missing!')
        exit(1)
    print(f'Setting: Package {args.single_package}')
    print(f'Setting: library {args.library}')
    CheckModelTest._dym_check_lic()
    print(f'Simulate examples and validations')
    if args.changedmodels is True:
        print(f'Test only changed or new models')
        example_list = CheckModelTest._get_ch_examples()
        if len(example_list) == 0:
            print(f'No changed models in Package: {args.single_package}')
            exit(0)
    elif args.filterwhitelist is True:
        if args.wh_library is None:
            print(f'{CRED}Error:{CEND} Library is missing!')
            exit(1)
        print(f'Setting: Whitelist library {args.wh_library}')
        wh_list = CheckModelTest._get_wh_models()
        models = CheckModelTest._get_examples()
        example_list = CheckModelTest._filter_wh_models(models, wh_list)
    else:
        example_list = CheckModelTest._get_examples()
        if len(example_list) == 0:
            print(f'No models in package {args.single_package}')
            exit(1)
    result = CheckModelTest._sim_examples(example_list)
    error_model = result[0]
    error_message = result[1]
    CheckModelTest._write_errorlog(error_model, error_message)
    CheckModelTest._check_result(error_model)


def create_wh_workflow():
    if args.wh_library is None:
        print(f'{CRED}Error:{CEND} Whitelist library is missing!')
        exit(1)
    if args.library is None:
        print(f'{CRED}Error{CEND}: Library is missing!')
        exit(1)
    print(f'Setting: WhiteList library {args.wh_library}')
    print(f'Setting: library {args.library}')
    Whitelist_class = Create_whitelist(library=args.library,
                                       wh_lib=args.wh_library)
    Whitelist_class._check_fileexist()
    version = Whitelist_class.read_script_version()
    version_check = Whitelist_class._check_whitelist(version)
    if version_check is False:
        Whitelist_class._write_exit_log(version_check)
        model_list = []
        if args.repo_dir is None:
            print(f'{CRED}Error:{CEND} Repository directory is missing!')
            exit(1)
        print(f'Setting: Package {args.repo_dir}')
        if args.git_url is None and args.wh_path is None:
            print(f'{CRED}Error:{CEND} git url or whitelist path is missing!')
            exit(1)
        if args.git_url is not None:
            print(f'Setting: whitelist git url library {args.git_url}')
            Git_Class = Git_Repository_Clone(repo_dir=args.repo_dir,
                                             git_url=args.git_url)
            Git_Class._clone_repository()
            model_list = Whitelist_class._get_wh_model(args.repo_dir)
        elif args.wh_path is not None:
            print(f'Setting: whitelist path library {args.wh_path}')
            model_list = Whitelist_class._get_wh_model(args.wh_path)
        print(f'Write new writelist from {args.wh_library} library')
        Whitelist_class._dym_check_lic()
        result = Whitelist_class._check_wh_model(model_list)
        #error_model_list = result[0]
        error_model_list = result
        Whitelist_class._write_whitelist(error_model_list, version)
        exit(0)
    else:
        Whitelist_class._write_exit_log(version_check)
        exit(0)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Check and Validate single Packages")  # Configure the argument parser
    check_test_group = parser.add_argument_group("arguments to run check tests")
    check_test_group.add_argument('-s', "--single-package", metavar="AixLib.Package",
                                  help="Test only the Modelica package AixLib.Package")
    check_test_group.add_argument("-n", "--number-of-processors", type=int, default=multiprocessing.cpu_count(),
                                  help="Maximum number of processors to be used")
    check_test_group.add_argument("--show-gui", help="show the GUI of the simulator", action="store_true")
    check_test_group.add_argument("-WL", "--whitelist",
                                  help="Create a WhiteList of IBPSA Library: y: Create WhiteList, n: Don´t create WhiteList",
                                  action="store_true")
    check_test_group.add_argument("-SE", "--simulateexamples", help="Check and Simulate Examples in the Package",
                                  action="store_true")
    check_test_group.add_argument("-DS", "--dymolaversion", default="2020",
                                  help="Version of Dymola(Give the number e.g. 2020")
    check_test_group.add_argument("-V", "--check-version", default=False, action="store_true")
    check_test_group.add_argument("-CM", "--changedmodels", default=False, action="store_true")
    check_test_group.add_argument("-FW", "--filterwhitelist", default=False, action="store_true")
    check_test_group.add_argument("-L", "--library", default="AixLib", help="Library to test")
    check_test_group.add_argument("-wh-l", "--wh-library", help="Library to test")
    check_test_group.add_argument("--repo-dir", help="Library to test")
    check_test_group.add_argument("--git-url", default="https://github.com/ibpsa/modelica-ibpsa.git", help="url repository")
    check_test_group.add_argument("--wh-path", help="path of white library")
    args = parser.parse_args()  # Parse the arguments
    CRED = '\033[91m'
    CEND = '\033[0m'
    green = "\033[0;32m"

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
    print(f'operating system {platform.system()}')
    sys.path.append(os.path.join(os.path.abspath('.'), "..", "..", "BuildingsPy"))

    from validatetest import ValidateTest


    if args.whitelist is True:  # Write a new WhiteList
        create_wh_workflow()

    CheckModelTest = ValidateTest(package=args.single_package,
                                  n_pro=args.number_of_processors,
                                  show_gui=args.show_gui,
                                  simulate_examples=args.simulateexamples,
                                  ch_models=args.changedmodels,
                                  mo_library=args.library,
                                  wh_library=args.wh_library,
                                  filter_wh=args.filterwhitelist)
    if args.simulateexamples is True:  # Simulate Models
        sim_example_workflow()
    else:  # Check all Models in a Package
        check_model_workflow()
