import matplotlib.pyplot as plt
from matplotlib.widgets import CheckButtons
import numpy as np
import sys, difflib
import os
from git import Repo
from shutil import copyfile
import shutil
import pathlib
import glob
import pandas as pd
import argparse

class Plot_Charts(object):

    def __init__(self, package, library):
        self.package = package
        self.library = library
        sys.path.append('bin/CITests')  # Set files for informations, templates and storage locations
        from _config import chart_dir, chart_temp_file, index_temp_file, layout_temp_file, ch_file, new_ref_file, show_ref_file, update_ref_file
        self.new_ref_file = new_ref_file
        self.ch_file = ch_file
        self.chart_temp_file = chart_temp_file  # path for google chart template
        self.index_temp_file = index_temp_file
        self.layout_temp_file = layout_temp_file
        self.f_log = f'{self.library}{os.sep}unitTests-dymola.log'  # path for unitTest-dymola.log, important for errors
        self.csv_file = f'reference.csv'
        self.test_csv = f'test.csv'
        self.show_ref_file = show_ref_file
        self.update_ref_file = update_ref_file
        self.chart_dir = chart_dir  # path for layout index
        self.temp_chart_path = f'{chart_dir}{os.sep}{self.package}'  # path for every single package
        self.funnel_path = f'{self.library}{os.sep}funnel_comp'
        self.ref_path = f'{self.library}{os.sep}Resources{os.sep}ReferenceResults{os.sep}Dymola'
        self.index_html_file = f'{self.temp_chart_path}{os.sep}index.html'
        self.layout_html_file = f'{self.chart_dir}{os.sep}index.html'
        self.green = '\033[0;32m'
        self.CRED = '\033[91m'
        self.CEND = '\033[0m'

    def _read_show_reference(self):
        if os.path.isfile(self.show_ref_file) is False:
            print(f'File {self.show_ref_file} directonary does not exist.')
            exit(0)
        else:
            print(f'Plot results from file {self.show_ref_file}')
        file = open(self.show_ref_file, "r")
        lines = file.readlines()
        ref_list = []
        for line in lines:
            if len(line) == 0:
                continue
            else:
                ref_list.append(f'{self.ref_path}{os.sep}{line.strip()}')
                continue
        file.close()
        if len(ref_list) == 0:
            print(f'No reference files in file {self.show_ref_file}. Please add here your reference files you want to update')
            exit(0)
        return ref_list

    def _prepare_data(self, results):  # prepare data from reference results(.txt)
        distriction_values = results[0]  # Value Number with Legend
        distriction_time = results[1]  # Value time with time sequence
        X_Axis = results[3]  # Number value
        time_list = []
        var_list = []
        value_list = []
        for y in X_Axis:
            time_list.append(y)
        for x in distriction_values:
            t = ((distriction_values[x].split(",")))
            var_list.append(t)
        new = zip(time_list, zip(*var_list))
        result_set = list(new)
        for a in result_set:
            a = str(a)
            a = a.replace("(", "")
            a = a.replace("[", "")
            a = a.replace("]", "")
            a = a.replace(")", "")
            a = a.replace("'", "")
            a = a.replace("\\n", "")
            value_list.append("[" + a + "]")
        value_list = map(str, (value_list))
        return value_list
    #def calculate_time_interval(self):


    def _read_data(self, ref_file):  # Read Reference results in AixLib\Resources\ReferenceResults\Dymola\${modelname}.txt
        legend_List = []
        value_list = []
        distriction_values = {}
        time_interval_list = []
        for line in open(ref_file, 'r'):
            current_value = []
            if line.find("last-generated=") > -1:
                continue
            if line.find("statistics-simulation=") > -1:
                continue
            if line.find("statistics-initialization=") > -1:
                continue
            if line.find("time=") > -1:
                time_int = line.split("=")[1]
                time_int = time_int.split(",")
                continue
            values = line.split("=")
            if len(values) < 2:
                continue
            legend = values[0]
            numbers = values[1]
            time_interval_steps = len(numbers.split(","))
            distriction_values[legend] = numbers
            legend_List.append(legend)
            number = numbers.split(",")
            for n in number:
                value = n.replace("[", "").lstrip()
                value = value.replace("]", "")
                value = float(value)
                current_value.append(value)
            value_list.append(current_value)
            continue
        first_time_interval = float((time_int[0].replace("[", "").lstrip()))
        last_time_interval = float((time_int[len(time_int)-1].replace("]", "").lstrip()))
        time_interval = last_time_interval/time_interval_steps
        time = first_time_interval
        for step in range(1, time_interval_steps+1, 1):
            if time == first_time_interval:
                time_interval_list.append(time)
                time = time + time_interval
            elif step == time_interval_steps:
                time = time + time_interval
                time_interval_list.append(time)
            else:
                time_interval_list.append(time)
                time = time + time_interval
        value_list.insert(0, time_interval_list)
        value_list = list(map(list, zip(*value_list)))
        return value_list, legend_List

    def _get_updated_reference_files(self):
        if os.path.isfile(self.update_ref_file) is False:
            print(f'File {self.update_ref_file} directonary does not exist.')
            exit(0)
        else:
            print(f'Plot results from file {self.update_ref_file}')
        file = open(self.update_ref_file, "r")
        lines = file.readlines()
        ref_list = []
        for line in lines:
            line = line.strip()
            if line.find(".txt") > -1 and line.find("_"):
                ref_list.append(f'{self.ref_path}{os.sep}{line.strip()}')
                continue
        file.close()
        return ref_list

    def _get_new_reference_files(self):
        if os.path.isfile(self.new_ref_file) is False:
            print(f'File {self.new_ref_file} directonary does not exist.')
            exit(0)
        else:
            print(f'Plot results from file {self.new_ref_file}')
        file = open(self.new_ref_file, "r")
        lines = file.readlines()
        ref_list = []
        for line in lines:
            line = line.strip()
            if line.find(".txt") > -1 and line.find("_"):
                ref_list.append(f'{line.strip()}')
                continue
        return ref_list

    def _get_values(self, lines):
        time_list = []
        measure_list = []
        for line in lines:  # searches for values and time intervals
            if line.find("last-generated=") > -1:
                continue
            if line.find("statistics-simulation=") > -1:
                continue
            if line.split("="):
                line = line.replace("[", "")
                line = line.replace("]", "")
                line = line.replace("'", "")
                values = (line.replace("\n", "").split("="))
                if len(values) < 2:
                    continue
                else:
                    legend = values[0]
                    measures = values[1]
                    if legend.find("time") > -1:
                        time_str = f'{legend}:{measures}'
                    else:
                        measure_len = len(measures.split(","))
                        measure_list.append(f'{legend}:{measures}')
        return time_str, measure_list, measure_len

    def _get_time_int(self, time_list, measure_len):

        time_val = time_list.split(":")[1]
        time_beg = time_val.split(",")[0]
        time_end = time_val.split(",")[1]
        time_int = float(time_end) - float(time_beg)
        tim_seq = time_int / float(measure_len)
        time_num = float(time_beg)
        time_list = []
        for time in range(0, measure_len + 1):
            time_list.append(time_num)
            time_num = time_num + tim_seq
        return time_list

    def _createFolder(self, directory):
        try:
            if not os.path.exists(directory):
                os.makedirs(directory)
        except OSError:
            print(f'Error: Creating directory. {directory}')

    def _read_unitTest_numerical_log(self):
        log_file = open(self.f_log, "r")
        lines = log_file.readlines()
        model_list = []
        for line in lines:
            if line.find("*** Warning:") > -1:
                if line.find("*** Warning: Numerical Jacobian in 'RunScript") > -1 and line.find(".mos") > -1:
                    model = line[line.rfind((os.sep)) :line.find(".mos")].lstrip()
                    model_list.append(model)
        return model_list

    def _read_unitTest_log(self):  # Read unitTest_log from regressionTest, write variable and modelname with difference
        log_file = open(self.f_log, "r")
        lines = log_file.readlines()
        model_var_list = []
        for line in lines:
            if line.find("*** Warning:") > -1:
                if line.find(".mat") > -1:
                    model = line[line.find(("Warning:")) + 9:line.find(".mat")]  # modelname
                    var = line[line.find((".mat:")) + 5:line.find("exceeds ")].lstrip()  # variable name
                    model_var_list.append(f'{model}:{var}')
                if line.find("*** Warning: Numerical Jacobian in 'RunScript") > -1 and line.find(".mos") > -1:
                    model = line[line.rfind(os.sep)+1:line.find(".mos")].lstrip()
                    var = ""
                    model_var_list.append(f'{model}:{var}')
                if line.find("*** Warning: Failed to interpret experiment annotation in 'RunScript") > -1 and line.find(".mos") > -1:
                    model = line[line.rfind(os.sep)+1:line.find(".mos")].lstrip()

                    var = ""
                    model_var_list.append(f'{model}:{var}')

        return model_var_list

    def _get_ref_file(self, model):
        for file in os.listdir(self.ref_path):
            if file.find(model) > -1:
                return file
            else:
                continue

    def _sort_mo_var(self, dic):  # Search for variables in referencefiles
        mo_list = []
        var_mod_dic = {}
        for i in dic:
            mo_list.append(i)
        for file in os.listdir(self.ref_path):
            for l in mo_list:
                if file.find(l) > -1:
                    var_mod_dic[self.ref_path + os.sep + file] = dic[l]
        return var_mod_dic

    def _read_csv_funnel(self, url):  # Read the differenz variables from csv_file and test_file
        csv_file = f'{url.strip()}{os.sep}{self.csv_file}'
        test_csv = f'{url.strip()}{os.sep}{self.test_csv}'
        try:
            var_model = pd.read_csv(csv_file)
            var_test = pd.read_csv(test_csv)
            temps = var_model[['x', 'y']]
            d = temps.values.tolist()
            c = temps.columns.tolist()
            test_tmp = var_test[['x', 'y']]
            e = test_tmp.values.tolist()
            e_list = []
            for i in range(0, len(e)):
                e_list.append((e[i][1]))

            result = zip(d, e_list)
            result_set = list(result)
            value_list = []
            for i in result_set:
                i = str(i)
                i = i.replace("(", "")
                i = i.replace("[", "")
                i = i.replace("]", "")
                i = i.replace(")", "")
                value_list.append("[" + i + "]")
            return value_list
        except pd.errors.EmptyDataError:
            print(f'{csv_file} is empty')

    def _check_folder_path(self):
        if os.path.isdir(self.funnel_path) is False:
            print(f'Funnel directonary does not exist.')
        else:
            print(f'Search for results in {self.funnel_path}')
        if os.path.isdir(self.temp_chart_path) is False:
            if os.path.isdir(self.chart_dir) is False:
                os.mkdir(self.chart_dir)
            os.mkdir(self.temp_chart_path)
            print(f'Save plot in {self.temp_chart_path}')
        else:
            print(f'Save plot in {self.temp_chart_path}')

    def _get_var(self, model):
        folder = os.listdir(f'{self.funnel_path}')
        var_list = []
        for ref in folder:
            if ref[:ref.find(".mat")] == model:
                var = ref[ref.rfind(".mat") + 5:]
                var_list.append(var)
        return var_list

    def _get_funnel_model(self, model):
        folder = os.listdir(f'{self.library}{os.sep}funnel_comp')
        funnel_list = []
        for ref in folder:
            if ref.find(model) > -1:
                funnel_list.append(ref)
        return funnel_list

    def _mako_line_html_chart(self, model, var):  # Load and read the templates, write variables in the templates
        from mako.template import Template
        if var == "":
            path_list = os.listdir((f'{self.library}{os.sep}funnel_comp'.strip()))
            for file in path_list:
                if file[:file.find(".mat")] == model:
                    path_name = (f'{self.library}{os.sep}funnel_comp{os.sep}{file}'.strip())
                    var = file[file.find(".mat") + 5:]
                    if os.path.isdir(path_name) is False:
                        print(f'Cant find folder: {self.CRED}{model}{self.CEND} with variable {self.CRED}{var}{self.CEND}')
                    else:
                        print(f'Plot model: {self.green}{model}{self.CEND} with variable:{self.green} {var}{self.CEND}')
                        value = Plot_Charts._read_csv_funnel(self, path_name)
                        mytemplate = Template(filename=self.chart_temp_file)  # Render Template
                        hmtl_chart = mytemplate.render(values=value, var=[f'{var}_ref', var], model=model,
                                                       title=f'{model}.mat_{var}')
                        file_tmp = open(f'{self.temp_chart_path}{os.sep}{model}_{var.strip()}.html', "w")
                        file_tmp.write(hmtl_chart)
                        file_tmp.close()
        else:
            path_name = (f'{self.library}{os.sep}funnel_comp{os.sep}{model}.mat_{var}'.strip())
            if os.path.isdir(path_name) is False:
                print(f'Cant find folder: {self.CRED}{model}{self.CEND} with variable {self.CRED}{var}{self.CEND}')
            else:
                print(f'Plot model: {self.green}{model}{self.CEND} with variable:{self.green} {var}{self.CEND}')
                value = Plot_Charts._read_csv_funnel(self, path_name)
                mytemplate = Template(filename=self.chart_temp_file)  # Render Template
                hmtl_chart = mytemplate.render(values=value, var=[f'{var}_ref', var], model=model,
                                               title=f'{model}.mat_{var}')
                file_tmp = open(f'{self.temp_chart_path}{os.sep}{model}_{var.strip()}.html', "w")
                file_tmp.write(hmtl_chart)
                file_tmp.close()

    def _mako_line_html_new_chart(self, ref_file, value_list, legend_List):  # Load and read the templates, write variables in the templates
        from mako.template import Template
        if os.path.isfile(ref_file) is False:
            print(f'Cant find folder: {self.CRED}{ref_file[ref_file.rfind(os.sep)+1:]}{self.CEND} with variables: {self.CRED}{legend_List}{self.CEND}')
        else:
            print(f'Plot model: {self.green}{ref_file[ref_file.rfind(os.sep)+1:]}{self.CEND} with variables:\n{self.green}{legend_List}{self.CEND}\n')
            mytemplate = Template(filename=self.chart_temp_file)  # Render Template
            hmtl_chart = mytemplate.render(values=value_list, var=legend_List, model=ref_file, title=ref_file)
            file_tmp = open(f'{self.temp_chart_path}{os.sep}{ref_file[ref_file.rfind(os.sep):].replace(".txt", ".html")}', "w")
            file_tmp.write(hmtl_chart)
            file_tmp.close()

    def _mako_line_ref_chart(self, model, var):  # Load and read the templates, write variables in the templates
        from mako.template import Template

        path_name = (f'{self.library}{os.sep}funnel_comp{os.sep}{model}.mat_{var}'.strip())

        folder = os.path.isdir(path_name)
        if folder is False:
            print(f'Cant find folder: {self.CRED}{model}{self.CEND} with variable {self.CRED}{var}{self.CEND}')
        else:
            print(f'Plot model: {self.green}{model}{self.CEND} with variable:{self.green} {var}{self.CEND}')
            value = Plot_Charts._read_csv_funnel(self, path_name)

            mytemplate = Template(filename=self.chart_temp_file)  # Render Template
            hmtl_chart = mytemplate.render(values=value, var=[f'{var}_ref', var], model=model,
                                           title=f'{model}.mat_{var}')
            file_tmp = open(f'{self.temp_chart_path}{os.sep}{model}_{var.strip()}.html', "w")
            file_tmp.write(hmtl_chart)
            file_tmp.close()

    def _create_index_layout(self):  # Create a index layout from a template
        from mako.template import Template
        html_file_list = []
        for file in os.listdir(self.temp_chart_path):
            print(file)
            if file.endswith(".html") and file != "index.html":
                html_file_list.append(file)
        mytemplate = Template(filename=self.index_temp_file)
        if len(html_file_list) == 0:
            print(f'No html files')
            os.rmdir(self.temp_chart_path)
            exit(0)
        else:
            hmtl_chart = mytemplate.render(html_model=html_file_list)
            file_tmp = open(self.index_html_file, "w")
            file_tmp.write(hmtl_chart)
            file_tmp.close()
            print(f'Create html file with reference results.')

    def _create_layout(self):  # Creates a layout index that has all links to the subordinate index files
        package_list = []
        for folder in os.listdir(self.chart_dir):
            if folder == "style.css" or folder == "index.html":
                continue
            else:
                package_list.append(folder)

        from mako.template import Template
        mytemplate = Template(filename=self.layout_temp_file)
        if len(package_list) == 0:
            print(f'No html files')
            exit(0)
        else:
            hmtl_chart = mytemplate.render(single_package=package_list)
            file_tmp = open(self.layout_html_file, "w")
            file_tmp.write(hmtl_chart)
            file_tmp.close()

    def _check_file(self):
        file_check = os.path.isfile(self.f_log)
        if file_check is False:
            print(f'{self.f_log} does not exists.')
            exit(1)
        else:
            print(f'{self.f_log} exists.')

    def _get_lines(self, ref_file):
        ref = open(f'{ref_file}', "r")
        lines = ref.readlines()
        ref.close()
        return lines

    def _get_funnel_comp(self):
        folder = os.listdir(self.funnel_path)
        return folder

def _delte_folder():
    sys.path.append('bin/CITests')
    from _config import chart_dir
    if os.path.isdir(chart_dir) is False:
        print(f'Directonary {chart_dir} does not exist.')
    else:
        folder_list = os.listdir(chart_dir)
        print(folder_list)
        for folder in folder_list:
            if folder.find(".html") > -1:
                os.remove(f'{chart_dir}{os.sep}{folder}')
                continue
            else:
                shutil.rmtree(f'{chart_dir}{os.sep}{folder}')


if __name__ == '__main__':
    green = "\033[0;32m"  # Set colors
    CRED = '\033[91m'
    CEND = '\033[0m'
    parser = argparse.ArgumentParser(description='Plot diagramms')  # Initialize a Parser
    unit_test_group = parser.add_argument_group("arguments to plot diagrams")

    unit_test_group.add_argument("--line-html",
                                 help='plot a google html chart in line form',
                                 action="store_true")
    unit_test_group.add_argument("--create-layout",
                                 help='plot a google html chart in line form',
                                 action="store_true")
    unit_test_group.add_argument("--line-matplot",
                                 help='plot a google html chart in line form',
                                 action="store_true")
    unit_test_group.add_argument("-m", "--modellist",
                                 metavar="Modelica.Model",
                                 help="Plot this model")
    unit_test_group.add_argument("--new-ref",
                                 help="Plot new models with new created reference files",
                                 action="store_true")
    unit_test_group.add_argument("-pM", "--plotModel",
                                 help="Plot this model",
                                 action="store_true")
    unit_test_group.add_argument("--all-model",
                                 help='Plot all model',
                                 action="store_true")
    unit_test_group.add_argument("-e", "--error",
                                 help='Plot only model with errors',
                                 action="store_true")
    unit_test_group.add_argument("--show-ref",
                                 help='Plot only model with errors',
                                 action="store_true")
    unit_test_group.add_argument("--update-ref",
                                 help='Plot only updated models',
                                 action="store_true")
    unit_test_group.add_argument("--show-package",
                                 help='Plot only updated models',
                                 action="store_true")

    unit_test_group.add_argument('-s', "--single-package",
                                 metavar="Modelica.Package",
                                 help="Test only the Modelica package Modelica.Package")
    unit_test_group.add_argument("-L", "--library", default="AixLib", help="Library to test")
    unit_test_group.add_argument('-fun', "--funnel-comp",
                                 help="Take the datas from funnel_comp",
                                 action="store_true")
    unit_test_group.add_argument('-ref', "--ref-txt",
                                 help="Take the datas from reference datas",
                                 action="store_true")

    args = parser.parse_args()  # Parse the arguments
    from google_charts import Plot_Charts
    charts = Plot_Charts(package=args.single_package, library=args.library)


    if args.library is None:
        print(f'Please set a library (e.g. --library AixLib')
        exit(0)
    else:
        print(f'Setting library: {args.library}')
    if args.single_package is None:
        print(f'Please set a package (e.g. --single-package Airflow)')
        exit(0)
    else:
        print(f'Setting package: {args.single_package}\n')

    if args.line_html is True:  # Create Line chart html
        _delte_folder()
        if args.error is True:  # Plot all data with an error
            charts._check_file()
            model_var_list = charts._read_unitTest_log()
            charts._check_folder_path()
            print(f'Plot line chart with different reference results.\n')
            print(model_var_list)
            for model_var in model_var_list:
                list = model_var.split(":")
                model = list[0]
                var = list[1]
                if args.funnel_comp is True:  # Data from funnel comp
                    charts._mako_line_html_chart(model, var)
                if args.ref_txt is True:  # Data from reference files
                    ref_file = charts._get_ref_file(model)
                    if ref_file is None:
                        print(f'Referencefile for model {model} does not exist.')
                        continue
                    else:
                        lines = charts._get_lines(ref_file)
                        result = charts._get_values(lines)
                        time_list = result[0]
                        measure_list = result[1]
                        measure_len = result[2]
                        time_list = charts._get_time_int(time_list, measure_len)
                        charts._mako_line_ref_chart(model, var)
            charts._create_index_layout()
            charts._create_layout()

        if args.new_ref is True:  # python bin/02_CITests/Converter/google_charts.py --line-html --new-ref --single-package AixLib --library AixLib
            charts._check_folder_path()
            ref_list = charts._get_new_reference_files()
            print(f'\n\n')
            for ref_file in ref_list:
                if os.path.isfile(ref_file) is False:
                    print(f'File {ref_file} does not exist.')
                    continue
                else:
                    print(f'\nCreate plots for reference result {ref_file}')
                    results = charts._read_data(ref_file)
                    value_list = results[0]
                    legend_List = results[1]
                    charts._mako_line_html_new_chart(ref_file, value_list, legend_List)
            charts._create_index_layout()
            charts._create_layout()

        if args.update_ref is True:  # python bin/02_CITests/Converter/google_charts.py --line-html --update-ref --single-package AixLib --library AixLib
            charts._check_folder_path()
            ref_list = charts._get_updated_reference_files()
            print(f'\n\n')
            for ref_file in ref_list:
                if os.path.isfile(ref_file) is False:
                    print(f'File {ref_file} does not exist.')
                    continue
                else:
                    print(f'\nCreate plots for reference result {ref_file}')
                    results = charts._read_data(ref_file)
                    value_list = results[0]
                    legend_List = results[1]
                    charts._mako_line_html_new_chart(ref_file, value_list, legend_List)
            charts._create_index_layout()
            charts._create_layout()

        if args.show_ref is True:  # python bin/02_CITests/Converter/google_charts.py --line-html --show-ref --single-package AixLib --library AixLib
            charts._check_folder_path()
            ref_list = charts._read_show_reference()
            print(f'\n\n')
            for ref_file in ref_list:
                if os.path.isfile(ref_file) is False:
                    print(f'File {ref_file} does not exist.')
                    continue
                else:
                    print(f'\nCreate plots for reference result {ref_file}')
                    results = charts._read_data(ref_file)
                    value_list = results[0]
                    legend_List = results[1]

                    charts._mako_line_html_new_chart(ref_file, value_list, legend_List)
            charts._create_index_layout()
            charts._create_layout()

        if args.show_package is True:  # python bin/02_CITests/Converter/google_charts.py --line-html --show-package --funnel-comp --single-package ThermalZone
            charts._check_folder_path()
            folder = charts._get_funnel_comp()
            for ref in folder:
                model = ref[:ref.find(".mat")]
                var = ref[ref.rfind(".mat") + 5:]
                if args.funnel_comp is True:  # Data from funnel comp
                    charts._mako_line_html_chart(model, var)
            charts._create_index_layout()
            charts._create_layout()
    if args.create_layout is True:
        charts._create_layout()
