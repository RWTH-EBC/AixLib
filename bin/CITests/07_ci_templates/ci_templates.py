import pandas as pd
import os
from mako.template import Template
import sys
import argparse
import toml

class CI_yml_templates(object):

    def __init__(self, library, package_list, dymolaversion, wh_library, git_url, wh_path, python_version):
        self.library = library
        self.package_list = package_list
        self.dymolaversion = dymolaversion
        self.wh_library = wh_library
        self.git_url = git_url
        self.wh_path = wh_path
        self.python_version = python_version
        # except commits
        self.update_ref_commit = "ci_update_ref"
        self.show_ref_commit = "ci_show_ref"
        self.dif_ref_commit = "ci_dif_ref"
        self.html_commit = "ci_correct_html"
        self.create_wh_commit = "ci_create_whitelist"
        self.create_html_wh_commit = "ci_create_html_whitelist"
        self.simulate_commit = "ci_simulate"
        self.check_commit = "ci_check"
        self.regression_test_commit = "ci_regression_test"
        self.ci_html_commit = "ci_html"
        self.ci_merge_except_commit = "fix errors manually"
        self.ci_setting_commit = "ci_setting"
        self.bot_merge_commit = "Update WhiteList_CheckModel.txt and HTML_IBPSA_WhiteList.txt"
        self.bot_push_commit = "Automatic push of CI with new regression reference files. Please pull the new files before push again."
        self.bot_create_ref_message = "New reference files were pushed to this branch. The job was successfully and the newly added files are tested in another commit."
        self.bot_update_wh_commit = "Update or created new whitelist. Please pull the new whitelist before push again. [skip ci]"
        self.bot_create_ref_commit = "Automatic push of CI with new regression reference files.Please pull the new files before push again. Plottet Results ${GITLAB_Page}/${TARGET_BRANCH}/plots/"
        self.ci_trigger_ibpsa_commit = "ci_trigger_ibpsa_merge"
        self.except_commit_list = [self.update_ref_commit, self.dif_ref_commit, self.html_commit, self.create_wh_commit,
                                   self.bot_push_commit, self.bot_create_ref_message, self.show_ref_commit, self.regression_test_commit, self.check_commit, self.simulate_commit,
                                   self.create_html_wh_commit, self.ci_html_commit, self.ci_setting_commit]
        # except branches
        if self.wh_library is None:
            self.merge_branch = None
        else:
            self.merge_branch = self.wh_library + "_Merge"

        sys.path.append('bin/CITests')  # files
        from _config import ch_file, wh_file, reg_temp_file, write_temp_file, sim_temp_file, page_temp_file, ibpsa_temp_file, main_temp_file, \
            temp_dir, exit_file, new_ref_file, chart_dir, image_name,  variable_main_list, main_yml_file, stage_list, eof_file, html_temp_file, html_wh_file,\
            style_check_temp_file, setting_file, setting_temp_file
        self.ch_file = ch_file.replace(os.sep, "/")
        self.wh_file = wh_file.replace(os.sep, "/")
        self.eof_file = eof_file.replace(os.sep, "/")
        self.html_wh_file = html_wh_file.replace(os.sep, "/")

        self.reg_temp = reg_temp_file.replace(os.sep, "/")
        self.write_temp = write_temp_file.replace(os.sep, "/")
        self.sim_temp = sim_temp_file.replace(os.sep, "/")
        self.page_temp = page_temp_file.replace(os.sep, "/")
        self.ibpsa_temp = ibpsa_temp_file.replace(os.sep, "/")
        self.main_temp = main_temp_file.replace(os.sep, "/")
        self.temp_dir = temp_dir.replace(os.sep, "/")
        self.exit_file = exit_file.replace(os.sep, "/")
        self.new_ref_file = new_ref_file.replace(os.sep, "/")
        self.chart_dir = chart_dir.replace(os.sep, "/")
        self.html_temp_file = html_temp_file.replace(os.sep, "/")
        self.style_check_temp_file = style_check_temp_file.replace(os.sep, "/")
        self.setting_temp_file = setting_temp_file.replace(os.sep, "/")
        self.main_yml = main_yml_file
        self.setting_file = setting_file

        self.image_name = image_name
        #self.project_name = project_name
        self.variable_main_list = variable_main_list
        self.stage_list = stage_list


    def _write_page_template(self):
        mytemplate = Template(filename=self.page_temp)
        yml_text = mytemplate.render()
        yml_tmp = open(self.page_temp.replace(".txt", ".gitlab-ci.yml"), "w")
        yml_tmp.write(yml_text)
        yml_tmp.close()

    def _write_setting_template(self):
        mytemplate = Template(filename=self.setting_temp_file)
        yml_text = mytemplate.render(GITHUB_PRIVATE_KEY="${GITHUB_PRIVATE_KEY}", GITLAB_USER_EMAIL="${GITLAB_USER_EMAIL}",
                                     GITLAB_USER_NAME="${GITLAB_USER_NAME}", Github_Repository="${Github_Repository}",
                                     ci_setting_commit=self.ci_setting_commit, python_version=self.python_version)
        yml_tmp = open(self.setting_temp_file.replace(".txt", ".gitlab-ci.yml"), "w")
        yml_tmp.write(yml_text)
        yml_tmp.close()

    def _write_html_template(self):
        if self.wh_library is not None:
            merge_branch = "- " + self.merge_branch
            git = f'--git-url {self.git_url} --wh-library {self.wh_library}'
        else:
            git = ""
            merge_branch = ""


        mytemplate = Template(filename=self.html_temp_file)
        yml_text = mytemplate.render(merge_branch=merge_branch,
                                     except_commit_list=self.except_commit_list, GITLAB_USER_NAME="${GITLAB_USER_NAME}",
                                     GITLAB_USER_EMAIL="${GITLAB_USER_EMAIL}", CI_PROJECT_NAME="${CI_PROJECT_NAME}",
                                     Github_Repository="${Github_Repository}", exit_file=self.exit_file,
                                     GITHUB_PRIVATE_KEY="${GITHUB_PRIVATE_KEY}", library=self.library, Newbranch="${Newbranch}",
                                     Target_Branch="${Target_Branch}", Praefix_Branch="${Praefix_Branch}", CI_COMMIT_REF_NAME="${CI_COMMIT_REF_NAME}",
                                     GITHUB_API_TOKEN="${GITHUB_API_TOKEN}", html_commit=self.html_commit, create_html_wh_commit=self.create_html_wh_commit,
                                     html_wh_file=self.html_wh_file, ci_html_commit=self.ci_html_commit, git=git, python_version=self.python_version)
        yml_tmp = open(self.html_temp_file.replace(".txt", ".gitlab-ci.yml"), "w")
        yml_tmp.write(yml_text)
        yml_tmp.close()

    def _write_style_template(self):
        if self.merge_branch is not None:
            merge_branch = "- " + self.merge_branch
        else:
            merge_branch = ""
        mytemplate = Template(filename=self.style_check_temp_file)
        yml_text = mytemplate.render(merge_branch=merge_branch,
                                     except_commit_list=self.except_commit_list, library=self.library, dymolaversion=self.dymolaversion,
                                     ch_file=self.ch_file, python_version=self.python_version)
        yml_tmp = open(self.style_check_temp_file.replace(".txt", ".gitlab-ci.yml"), "w")
        yml_tmp.write(yml_text)
        yml_tmp.close()

    def _write_merge_template(self):
        # output_encoding='utf-8', encoding_errors='replace'
        mytemplate = Template(filename=self.ibpsa_temp  )
        yml_text = mytemplate.render(git_url=self.git_url, merge_branch=self.merge_branch,
                                     dymolaversion=self.dymolaversion,
                                     except_commit_list=self.except_commit_list, GITLAB_USER_NAME="${GITLAB_USER_NAME}",
                                     GITLAB_USER_EMAIL="${GITLAB_USER_EMAIL}", CI_PROJECT_NAME="${CI_PROJECT_NAME}",
                                     Github_Repository="${Github_Repository}", Merge_Branch="${Merge_Branch}",
                                     IBPSA_Repo="${IBPSA_Repo}",
                                     GITHUB_PRIVATE_KEY="${GITHUB_PRIVATE_KEY}", library=self.library,
                                     Target_Branch="${Target_Branch}", wh_library=self.wh_library,
                                     GITHUB_API_TOKEN="${GITHUB_API_TOKEN}", bot_commit=self.bot_merge_commit, ci_merge_except_commit=self.ci_merge_except_commit, python_version=self.python_version,  ci_trigger_ibpsa_commit=self.ci_trigger_ibpsa_commit)
        yml_tmp = open(self.ibpsa_temp.replace(".txt", ".gitlab-ci.yml"), "w")

        #yml_tmp.write(yml_text.replace("\n", ""))
        yml_tmp.write(yml_text)

        yml_tmp.close()

    def _write_regression_template(self):
        if self.merge_branch is not None:
            merge_branch = "- " + self.merge_branch
        else:
            merge_branch = ""

        mytemplate = Template(filename=self.reg_temp)
        yml_text = mytemplate.render(library=self.library, lib_package="${lib_package}",
                                     dymolaversion=self.dymolaversion,
                                     except_commit_list=self.except_commit_list, package_list=self.package_list,
                                     update_commit=self.update_ref_commit, merge_branch=merge_branch,
                                     TARGET_BRANCH="${TARGET_BRANCH}", GITLAB_Page="${GITLAB_Page}",
                                     GITHUB_API_TOKEN="${GITHUB_API_TOKEN}", Github_Repository="${Github_Repository}",
                                     GITLAB_USER_NAME="${GITLAB_USER_NAME}", GITLAB_USER_EMAIL="${GITLAB_USER_EMAIL}",
                                     CI_PROJECT_NAME="${CI_PROJECT_NAME}", exit_file=self.exit_file,
                                     ch_file=self.ch_file, bot_create_ref_message=self.bot_create_ref_message,
                                     bot_create_ref_commit=self.bot_create_ref_commit, new_ref_file=self.new_ref_file,
                                     chart_dir=self.chart_dir, GITHUB_PRIVATE_KEY="${GITHUB_PRIVATE_KEY}", show_ref_commit=self.show_ref_commit, update_ref_commit=self.update_ref_commit,
                                     regression_test_commit=self.regression_test_commit, eof_file=self.eof_file, python_version=self.python_version)
        yml_tmp = open(self.reg_temp.replace(".txt", ".gitlab-ci.yml"), "w")
        yml_tmp.write(yml_text)
        yml_tmp.close()

    def _write_check_template(self):
        if self.wh_library is not None:
            wh_library = self.wh_library
            filterflag = "--filterwhitelist"
            wh_flag = "--wh-library " + self.wh_library
            merge_branch = "- " + self.wh_library + "_Merge"
            if self.wh_path is not None:
                wh_path = "--wh-path " + self.wh_path
                git_url = ""
            elif self.git_url is not None:
                git_url = "--git-url " + self.git_url
                wh_path = ""
            else:
                wh_path = ""
                git_url = ""
        else:
            wh_library = self.library
            wh_flag = ""
            git_url = ""
            filterflag = ""
            wh_path = ""
            merge_branch = ""
        mytemplate = Template(filename=self.write_temp)
        yml_text = mytemplate.render(package_list=self.package_list, library=self.library, lib_package="${lib_package}",
                                     dymolaversion=self.dymolaversion, package_name="${package_name}", wh_flag=wh_flag,
                                     filterflag=filterflag, except_commit_list=self.except_commit_list,
                                     merge_branch=merge_branch, wh_commit=self.create_wh_commit,
                                     wh_library=wh_library, wh_path=wh_path, git_url=git_url,
                                     wh_file=self.wh_file, ch_file=self.ch_file,
                                     bot_update_wh_commit=self.bot_update_wh_commit,
                                     TARGET_BRANCH="$CI_COMMIT_REF_NAME", GITHUB_PRIVATE_KEY="${GITHUB_PRIVATE_KEY}",
                                     GITLAB_USER_NAME="${GITLAB_USER_NAME}", GITLAB_USER_EMAIL="${GITLAB_USER_EMAIL}",
                                     Github_Repository="${Github_Repository}", CI_PROJECT_NAME="${CI_PROJECT_NAME}",
                                     exit_file=self.exit_file, check_commit=self.check_commit, python_version=self.python_version)
        yml_tmp = open(self.write_temp.replace(".txt", ".gitlab-ci.yml"), "w")
        yml_tmp.write(yml_text)
        yml_tmp.close()

    def _write_simulate_template(self):
        if self.wh_library is not None:
            filterflag = "--filterwhitelist"
            wh_flag = "--wh-library " + self.wh_library
            merge_branch = "- " + self.merge_branch
        else:
            merge_branch = ""
            filterflag = ""
            wh_flag = ""
        mytemplate = Template(filename=self.sim_temp)
        yml_text = mytemplate.render(package_list=self.package_list, library=self.library, lib_package="${lib_package}",
                                     dymolaversion=self.dymolaversion, package_name="${package_name}", wh_flag=wh_flag,
                                     filterflag=filterflag, except_commit_list=self.except_commit_list,
                                     merge_branch=merge_branch, git_url=self.git_url,
                                     wh_commit=self.create_wh_commit, wh_library=self.wh_library, ch_file=self.ch_file, simulate_commit=self.simulate_commit, python_version=self.python_version)
        yml_tmp = open(self.sim_temp.replace(".txt", ".gitlab-ci.yml"), "w")
        yml_tmp.write(yml_text)
        yml_tmp.close()

    def _write_main_yml(self, image_name, stage_list, variable_list,  file_list):
        mytemplate = Template(filename=self.main_temp)
        yml_text = mytemplate.render(image_name=image_name, stage_list=stage_list, variable_list=variable_list,
                                     file_list=file_list)
        yml_tmp = open(self.main_yml, "w")
        yml_tmp.write(yml_text)
        yml_tmp.close()

    def _get_variables(self):
        variable_list = self.variable_main_list
        return variable_list

    def _get_image_name(self):
        image_name = self.image_name
        return image_name

    def _get_yml_templates(self):
        file_list = []
        for subdir, dirs, files in os.walk(self.temp_dir):
            for file in files:
                filepath = subdir + os.sep + file
                if filepath.endswith(".yml") and file != ".gitlab-ci.yml":
                    filepath = filepath.replace(os.sep, "/")
                    file_list.append(filepath)
        if len(file_list) == 0:
            print(f'No templates')
            exit(1)
        return file_list

    def _get_stages(self, file_list):
        stage_list = []
        for file in file_list:
            infile = open(file, "r")
            lines = infile.readlines()
            stage_content = False
            for line in lines:
                line = line.strip()
                if len(line.strip()) == 0:
                    continue
                elif line.find("stages:") > -1:
                    stage_content = True
                elif line.find(":") > -1 and line.find("stages:") == -1:
                    stage_content = False
                elif stage_content is True:
                    line = line.replace("-", "")
                    line = line.replace(" ", "")
                    stage_list.append(line)
                else:
                    continue
        if len(stage_list) == 0:
            print(f'No stages')
            exit(1)
        stage_list = list(set(stage_list))
        new_list = []
        for stage in self.stage_list:
            for st in stage_list:
                if stage == st:
                    new_list.append(stage)
        return new_list

    def _write_settings(self, image_name, stage_list, variable_list,  file_list, config_list, git_url):  # write CI setting
        mytemplate = Template(filename=self.setting_file)
        yml_text = mytemplate.render(library=self.library, wh_library=self.wh_library, dymolaversion=self.dymolaversion,
                                     package_list=self.package_list, stage_list=stage_list, merge_branch=self.merge_branch,
                                     image_name=image_name, variable_main_list=variable_list,
                                     except_commit_list=self.except_commit_list, file_list=file_list, config_list=config_list, git_url=git_url, wh_path=self.wh_path,
                                     python_version=self.python_version)
        yml_tmp = open(self.setting_file.replace("_template.txt", ".toml"), "w")
        yml_tmp.write(yml_text)
        yml_tmp.close()


def _get_package(library):
    for subdir, dirs, files in os.walk(library):
        return dirs


def _config_test():
    config_list = []
    response = input(f'Config template: check html Syntax in models? (y/n) ')
    if response == "y":
        print(f'Create html template')
        config_list.append("html")
    response = input(f'Config template: check style of models? (y/n) ')
    if response == "y":
        print(f'Create style template')
        config_list.append("style")
    response = input(f'Config template: check models? (y/n) ')
    if response == "y":
        print(f'Create check template')
        config_list.append("check")
    response = input(f'Config template: simulate examples? (y/n) ')
    if response == "y":
        print(f'Create simulate template')
        config_list.append("simulate")
    response = input(f'Config template: regression test? (y/n) ')
    if response == "y":
        print(f'Create regression template')
        config_list.append("regression")
    response = input(f'Config template: Merge Update? (y/n) ')
    if response == "y":
        print(f'Create merge template')
        config_list.append("Merge")
    return config_list

def _config_settings_check():
    library = input(f'Which library should be tested? (e.g. AixLib)')
    print(f'Setting library: {library}')
    package_list = _get_package(library)
    package_list_final = []
    for package in package_list:
        response = input(f'Test package {package}? (y/n) ')
        if response == "y":
            package_list_final.append(package)
            continue
    print(f'Setting packages: {package_list_final}')
    dymolaversion = input(f'Give the dymolaversion (e.g. 2020): ')
    print(f'Setting dymola version: {dymolaversion}')
    python_version = input(f'Give the python version in your image (e.g. python36): ')
    print(f'Setting python version: {python_version}')
    response = input(
        f'Create whitelist? Useful if your own library has been assembled from other libraries. A whitelist is created, where faulty models from the foreign library are no longer tested in the future and are filtered out. (y/n)  ')
    if response == "y":
        wh_config = True
        while wh_config is True:
            wh_library = input(f'What library models should on whitelist: Give the name of the library: ')
            print(f'Setting whitelist library: {wh_library}')

            response = input(f'If the foreign library is local on the PC? (y/n) ')
            if response == "y":
                wh_path = input(f'Specify the local path of the library (eg. D:\..path..\AixLib) ')
                print(f'path of library: {wh_path}')
                git_url = None
            else:
                git_url = input(f'Give the url of the library repository (eg. "https://github.com/ibpsa/modelica-ibpsa.git"):  ')
                print(f'Setting git_url: {git_url}')
                wh_path = None

            response = input(f'Are settings okay(y/n)? ')
            if response == "y":
                wh_config = False
                return library, package_list_final, dymolaversion, wh_library, git_url, wh_path, python_version
    wh_library = None
    git_url = None
    wh_path = None
    return library, package_list_final, dymolaversion, wh_library, git_url, wh_path, python_version


def _delte_yml_files(temp_dir):
    for subdir, dirs, files in os.walk(temp_dir):
        for file in files:
            filepath = subdir + os.sep + file
            if filepath.endswith(".yml") and file != ".gitlab-ci.yml":
                os.remove(filepath)


def _read_setting_file():
    setting_file = f'bin{os.sep}Setting{os.sep}CI_setting.toml'
    data = toml.load(setting_file)
    return data

def _read_library(data):
    library = data["library"]
    library = library["library_name"]
    print(f'Setting library: {library}')
    return library

def _read_wh_library(data):
    wh_library = data["whitelist_library"]
    wh_library = wh_library["wh_library_name"]
    print(f'Setting whitelist_library: {wh_library}')
    return wh_library

def _read_package_list(data):
    packagelist = data["Package"]
    packagelist = packagelist["packagelist"]
    print(f'Setting packagelist: {packagelist}')
    return packagelist

def _read_dymolaversion(data):
    dymolaversion = data["dymola_version"]
    dymolaversion = dymolaversion["dymolaversion"]
    print(f'Setting dymolaversion: {dymolaversion}')
    return dymolaversion

def _read_pythonversion(data):
    pythonversion = data["python_version"]
    pythonversion = pythonversion["python_version"]
    print(f'Setting python version: {pythonversion}')
    return pythonversion


def _read_stages(data):
    stages = data["stages"]
    stages = stages["stagelist"]
    print(f'Setting stages: {stages}')
    return stages

def _read_merge_branch(data):
    Merge_Branch = data["Merge_Branch"]
    Merge_Branch = Merge_Branch["merge_branch"]
    print(f'Setting merge branch: {Merge_Branch}')
    return Merge_Branch

def _read_image_name(data):
    image_name = data["image_name"]
    image_name = image_name["image"]
    print(f'Setting image: {image_name}')
    return image_name

def _read_variable_list(data):
    variable_list = data["variable_list"]
    variable_list = variable_list["variablelist"]
    print(f'Setting variables: {variable_list}')
    return variable_list

def _read_ci_commands(data):
    ci_commit_commands = data["ci_commit_commands"]
    ci_commit_commands = ci_commit_commands["commitlist"]
    print(f'Setting ci commands: {ci_commit_commands}')
    return ci_commit_commands

def _read_file_list(data):
    file_list = data["File_list"]
    file_list = file_list["filelist"]
    print(f'Setting yaml file list: {file_list}')
    return file_list

def _read_config_list(data):
    config_list = data["config_list"]
    config_list = config_list["configlist"]
    print(f'Setting config list: {config_list}')
    return config_list

def _read_git_url(data):
    git_url = data["git_url"]
    giturl = git_url["giturl"]
    print(f'Setting git whitelist url: {giturl}')
    return giturl

def _read_wh_path(data):
    wh_path = data["wh_library_path"]
    wh_path = wh_path["wh_path"]
    print(f'Setting git whitelist url: {wh_path}')
    return wh_path

if __name__ == '__main__':
    # python bin/CITests/07_ci_templates/ci_templates.py
    parser = argparse.ArgumentParser(description="Set Github Environment Variables")  # Configure the argument parser
    check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
    check_test_group.add_argument("--setting", help="Create the CI from file bin\Setting\CI_setting.txt",
                                  action="store_true")
    args = parser.parse_args()  # Parse the arguments

    from ci_templates import CI_yml_templates
    sys.path.append('bin/CITests')
    from _config import setting_file, temp_dir

    _delte_yml_files(temp_dir)
    if args.setting is False:
        config_list = _config_test()
        if len(config_list) == 0:
            exit(0)
        result = _config_settings_check()
        library = result[0]
        package_list = result[1]
        dymolaversion = result[2]
        wh_library = result[3]
        git_url = result[4]
        wh_path = result[5]
        python_version = result[6]
        CI_Class = CI_yml_templates(library, package_list, dymolaversion, wh_library, git_url, wh_path, python_version)
        CI_Class._write_setting_template()
        for temp in config_list:
            if temp == "check":
                CI_Class._write_check_template()
            if temp == "simulate":
                CI_Class._write_simulate_template()
            if temp == "regression":
                CI_Class._write_regression_template()
            if temp == "html":
                CI_Class._write_html_template()
            if temp == "style":
                CI_Class._write_style_template()
            if temp == "Merge" and wh_library is not None:
                CI_Class._write_merge_template()
        CI_Class._write_page_template()
        variable_list = CI_Class._get_variables()
        print(f'Setting variables: {variable_list}')
        image_name = CI_Class._get_image_name()
        print(f'Setting image: {image_name}')
        file_list = CI_Class._get_yml_templates()
        print(f'Setting yml files: {file_list}')
        stage_list = CI_Class._get_stages(file_list)
        print(f'Setting stages: {stage_list}')
        CI_Class._write_main_yml(image_name, stage_list, variable_list, file_list)
        CI_Class._write_settings(image_name, stage_list, variable_list, file_list, config_list, git_url)
        print(f'The CI settings are saved in file {setting_file}')

    if args.setting is True:
        data = _read_setting_file()
        wh_path = _read_wh_path(data)
        if wh_path == "None":
            wh_path = None
        library = _read_library(data)
        wh_library = _read_wh_library(data)
        if wh_library == "None":
            wh_library = None
        package_list = _read_package_list(data)
        dymolaversion = _read_dymolaversion(data)
        python_version = _read_pythonversion(data)
        stage_list = _read_stages(data)
        Merge_Branch = _read_merge_branch(data)
        image_name = _read_image_name(data)
        variable_list = _read_variable_list(data)
        ci_commit_commands = _read_ci_commands(data)
        file_list = _read_file_list(data)
        config_list = _read_config_list(data)
        git_url = _read_git_url(data)
        if git_url == "None":
            git_url = None
        CI_Class = CI_yml_templates(library, package_list, dymolaversion, wh_library, git_url, wh_path, python_version)
        CI_Class._write_setting_template()
        for temp in config_list:
            if temp == "check":
                CI_Class._write_check_template()
            if temp == "simulate":
                CI_Class._write_simulate_template()
            if temp == "regression":
                CI_Class._write_regression_template()
            if temp == "html":
                CI_Class._write_html_template()
            if temp == "style":
                CI_Class._write_style_template()
            if temp == "Merge" and wh_library is not None:
                CI_Class._write_merge_template()
        CI_Class._write_page_template()
        CI_Class._write_main_yml(image_name, stage_list, variable_list, file_list)
