# Libraries
import matplotlib.pyplot as plt
from matplotlib.widgets import CheckButtons
import numpy as np
import sys,difflib
import os 
from git import Repo
from shutil import copyfile
import shutil
import pathlib
import glob
import pandas as pd
import argparse



def read_data(ref_file): ## Read Reference results in AixLib\Resources\ReferenceResults\Dymola\${modelname}.txt
	## Lists
	Value_List= []
	time_List =[]
	X_Axis, Y_Axis = [], []
	## Dictionary
	distriction_values = {}
	distriction_time = {}
	## searches for values and time intervals
	for line in open(ref_file, 'r'):
		if line.find("last-generated=") > -1:
			continue
		if line.find("statistics-simulation=") > -1: 
			continue
		values = (line.split("="))
		if len(values) < 2:
			continue
		legend = values[0]
		numbers = values[1]
		#print(numbers)
		if legend.find("time") > -1 :
			distriction_time[legend] = numbers
			continue
		distriction_values[legend] = numbers
		Value_List.append(legend)
		continue

	for i in Value_List:
		y = distriction_values.get(i)
		y = y.split(",")
		for v in y:
			v = v.replace("[","")
			v = v.replace("]","")
			v = v.replace("\n","")
			v = v.replace("'","")
			v = v.lstrip()
			#v = float(v)
			Y_Axis.append(v)
	
	x = distriction_time.get("time")
	if x is None:
		return distriction_values, distriction_time, Value_List, X_Axis, ref_file
	else:
		x = x.replace("[","")
		x = x.replace("]","")
		x = x.replace("\n","")
		x = x.replace("'","")
		x = x.lstrip()
		x = x.split(",")

	time_end = float((x[len(x)-1]))
	time_beg = float((x[0]))
	time_int = time_end -  time_beg
	if len(Value_List)==0:
		return distriction_values, distriction_time, Value_List, X_Axis, ref_file
	else:
		tim_seq = time_int/ (float(len(Y_Axis))/float(len(Value_List)))

		num_times = time_beg
		times_list = []
		t = ((float(len(Y_Axis))/float(len(Value_List))))
		i = 0
		while (i) < t:
			times_list.append(num_times)
			num_times = num_times + tim_seq
			i = i +1
		X_Axis = times_list

		return  distriction_values, distriction_time, Value_List,X_Axis,ref_file
	
	
	
def func_plot(distriction_values, distriction_time, Value_List,X_Axis,ref_file): # Create plots with matplot
	dia_name = ref_file.replace(".txt","")
	dia_name = dia_name.replace("_",".")
	
	counter = 0
	
	fig, ax = plt.subplots()
	lines_list = []
	for i in Value_List:
		Y_Axis = []
		counter = counter + 1 
		y = distriction_values.get(i)
		y = y.split(",")
		for v in y:
			v = v.replace("[","")
			v = v.replace("]","")
			v = v.replace("\n","")
			v = v.replace("'","")
			v = v.lstrip()
			v = float(v)
			Y_Axis.append(v)
						
		l0, = ax.plot(X_Axis,Y_Axis, visible=False, lw=2, color='k', label=i)
		lines_list.append(l0,)
	lines = []
	for k in lines_list:
		lines.append(k)
	
	
	#check = CheckButtons(rax, Value_List, [False,  True])
	#plt.title(dia_name)
	#plt.xlabel("Time")
	#plt.ylabel(Value_List[0])
	#plt.yticks(Y_Axis)
	#check.on_clicked(func)
	#plt.plot(X_Axis, Y_Axis, marker = 'o', c = 'g')
	  
	#plt.show()
	
	return lines, fig
	


def createFolder(directory):
    try:
        if not os.path.exists(directory):
            os.makedirs(directory)
    except OSError:
        print ('Error: Creating directory. ' +  directory)
        


def func(label): ## For Matplot Plots: Create a Hitbox for different variables
	index = labels.index(label)
	lines[index].set_visible(not lines[index].get_visible())
	plt.draw()


def removeEmptyFolders(path, removeRoot=True):
  #'Function to remove empty folders'
  if not os.path.isdir(path):
    return

  # remove empty subfolders
  files = os.listdir(path)
  if len(files):
    for f in files:
      fullpath = os.path.join(path, f)
      if os.path.isdir(fullpath):
        os.rmdir(fullpath)

  # if folder empty, delete it
  files = os.listdir(path)
  if len(files) == 0 and removeRoot:
    #print("Removing empty folder: "+ path)
    os.rmdir(path)

def usageString():
  'Return usage string to be output in error cases'
  return 'Usage: %s directory [removeRoot]' % sys.argv[0]



def read_unitTest_log(f_log): ## Read unitTest_log from regressionTest, write variable and modelname with difference
	path = "AixLib"+os.sep+"funnel_comp"
	log = open(f_log,"r")
	lines = log.readlines()
	var_dic = {}
	var_list = []
	path_list = []
	for i in lines:

		if  i.find("*** Warning:") >-1 :
			if i.find(".mat")> -1 :
				model = (i[i.find(("Warning:"))+9:i.find(".mat")])
				var = (i[i.find((".mat:"))+5:i.find("exceeds ")])
				var = var.lstrip()
				var_dic[model] = var 
				path_list.append(path+os.sep+model+".mat_"+var)
				var_list.append(var)
				#print(i[i.find(("*** Warning"):i.find(".mat"))])

	return var_dic, path_list, var_list
	
def sort_mo_var(dic): ## Search for variables in referencefiles
	ref_path = "AixLib"+os.sep+"Resources"+os.sep+"ReferenceResults"+os.sep+"Dymola"
	mo_list = []
	var_mod_dic = {}

	for i in dic:
		mo_list.append(i)
	for file in os.listdir(ref_path):
		for l in mo_list:
			if file.find(l)>-1:
				var_mod_dic[ref_path+os.sep+file] = dic[l]
	return  var_mod_dic

def read_csv_funnel(url,csv_file, test_csv): ## Read the differenz variables from csv_file and test_file
	# Parameter
	csv_file = url.strip()+os.sep+csv_file
	test_csv = url.strip()+os.sep+test_csv
	try:
		var_model = pd.read_csv(csv_file)
		var_test = pd.read_csv(test_csv)
		temps = var_model[['x','y']]
		d = temps.values.tolist()
		c = temps.columns.tolist()
		test_tmp = var_test[['x','y']]
		e = test_tmp.values.tolist()
		e_list = []
		for i in range(0,len(e)):
			e_list.append((e[i][1]))

		result = zip(d,e_list)
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
		print(csv_file + "is empty")


def mako_line_html_chart(data,temp,temp_chart,f_log,csv_file,test_csv): # Load and read the templates , write variables in the templates
	from mako.template import Template
	green = "\033[0;32m"
	CRED = '\033[91m'
	CEND = '\033[0m'
	if os.path.isdir(temp_chart) is False:
		os.mkdir(temp_chart)

	for i in data[0]:
		model_name = i
		path_name = "AixLib"+os.sep+"funnel_comp"+os.sep+i+".mat_"+data[0][i]
		title = i+".mat_"+data[0][i]
		var = data[0][i]
		var_list = []
		path_name = path_name.strip()

		folder = os.path.isdir(path_name)
		if folder is False:
			print("Cant find folder: " + CRED + model_name + CEND + " with Variable "+CRED+data[0][i]+CEND)
			continue
		else:
			print("Print model: " + green + model_name + CEND + " with Variable: " + green + var + CEND)
			value = read_csv_funnel(path_name, csv_file, test_csv)

			# Render Template

			mytemplate = Template(filename=temp)
			var_list.append(var.strip() + "_ref")
			var_list.append(var)

			# values = value : variable numbers/Reference results
			# var = var_list : legend variables
			# model = model_name : model name
			# title = path_name : folder name

			hmtl_chart = mytemplate.render(values=value, var=var_list, model=model_name, title=title)
			html = temp_chart + os.sep + model_name + "_" + var.strip() + ".html"
			file_tmp = open(html, "w")
			file_tmp.write(hmtl_chart)
			file_tmp.close()
def create_index_layout(temp_chart): ## Create a index layout from a template
	temp = "bin" + os.sep + "02_CITests" + os.sep + "Converter" + os.sep + "01_templates" + os.sep + "index.txt"
	from mako.template import Template
	html_model = []

	for i in (os.listdir(temp_chart)):
		if i.endswith(".html") and i!= "index.html":
			html_model.append(i)
	mytemplate = Template(filename=temp)
	if len(html_model) > 0:
		first_model = html_model[0]
	else:
		print("No html files")
		os.rmdir(temp_chart)
		exit(0)
	hmtl_chart = mytemplate.render(html_model=html_model)
	html = temp_chart + os.sep + "index.html"
	file_tmp = open(html, "w")
	file_tmp.write(hmtl_chart)
	file_tmp.close()

def create_layout(index_path): ## Creates a layout index that has all links to the subordinate index files
	temp = "bin" + os.sep + "02_CITests" + os.sep + "Converter" + os.sep + "01_templates" + os.sep + "layout_index.txt"
	folder = (os.listdir(index_path))
	package_list = []
	for i in folder:
		if i == "style.css" or i == "index.html":
			continue
		else:
			#package_list.append(i+os.sep+"index.html")
			package_list.append(i)

	from mako.template import Template
	mytemplate = Template(filename=temp)
	if len(package_list) == 0:
		print("No html files")
		#os.rmdir(temp_chart)
		exit(0)
	else:
		print(package_list)
		hmtl_chart = mytemplate.render(single_package=package_list)
		html = index_path + os.sep + "index.html"
		file_tmp = open(html, "w")
		file_tmp.write(hmtl_chart)
		file_tmp.close()

if  __name__ == '__main__':
	# Set colors
	green = "\033[0;32m"
	CRED = '\033[91m'
	CEND = '\033[0m'

	## Initialize a Parser
	# Set environment variables
	parser = argparse.ArgumentParser(description='Plot diagramms')
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
								metavar = "Modelica.Model",
								help = "Plot this model")

	unit_test_group.add_argument("-pM", "--plotModel",
								 help="Plot this model",
								 action="store_true")
	unit_test_group.add_argument("--all-model",
								 help='Plot all model',
								 action="store_true")


	unit_test_group.add_argument("-e", "--error",
								 help='Plot only model with errors',
								 action="store_true")

	unit_test_group.add_argument('-s', "--single-package",
								 metavar="Modelica.Package",
								 help="Test only the Modelica package Modelica.Package")
	unit_test_group.add_argument('-fun', "--funnel-comp",
								 help="Take the datas from funnel_comp",
								 action = "store_true")
	unit_test_group.add_argument('-ref', "--ref-txt",
								 help="Take the datas from reference datas",
								 action="store_true")
	# Parse the arguments
	args = parser.parse_args()

	# *********************************************************************************************************
	# Set files for informations, templates and storage locations
	csv_file = "reference.csv"
	test_csv = "test.csv"
	temp = "bin" + os.sep + "02_CITests" + os.sep + "Converter" + os.sep + "01_templates" + os.sep + "google_chart.txt" ## path for google chart template

	index_path = "bin" + os.sep + "03_WhiteLists" + os.sep + "charts" ## path for layout index
	f_log = "AixLib" + os.sep + "unitTests-dymola.log" ## path for unitTest-dymola.log, important for errors

	## Create Line chart html
	if args.line_html is True:
		temp_chart = "bin" + os.sep + "03_WhiteLists" + os.sep + "charts" + os.sep + args.single_package # path for every single package

		# Plot all Datas with an error
		if args.error is True:
			file = os.path.isfile(f_log)
			data = read_unitTest_log(f_log)
			if file is False:
				print(f_log+ " does not exists")
				exit(1)
			############################################################
			# Data from funnel comp
			if args.funnel_comp is True:
				print("Plot line Chart")
				print("plot the different reference results")
				mako_line_html_chart(data, temp, temp_chart, f_log, csv_file, test_csv)
				create_index_layout(temp_chart)

				if  len(os.listdir(temp_chart)) == 0 :
					os.rmdir(temp_chart)

			############################################################
			# Data from reference files
			if args.ref_txt is True:

				dic = data[0]
				print(dic)
				file_list = sort_mo_var(dic)

				for i in file_list:
					results = read_data(i)
					var_List = []
					# Variable Name
					var = file_list[i].strip()
					# Model name
					mo = i[i.rfind("_")+1:i.find(".txt")]
					## Value Number with Legend
					distriction_values = results[0]
					var_value = distriction_values[var]
					var_value = (var_value.split(","))
					## Value time with time sequence
					distriction_time = results[1]
					## Legend name
					Value_List = results[2]
					## Reference File
					ref_file = results[4]
					## Number value
					X_Axis = results[3]

					for i in range(0,len(X_Axis)):
						var_val = var_value[i].replace("[","")
						var_val = var_val.replace("]","")
						time = str(X_Axis[i])
						time  = time.replace("[","")
						time = time.replace("]", "")
						var_List.append("["+time + str(", ") + var_val+"]")
						continue
					legend = []
					legend.append(var)
					from mako.template import Template
					mytemplate = Template(filename=temp)
					hmtl_chart = mytemplate.render(values=var_List, var=legend, model=i, title=i)
					html = temp_chart + os.sep + mo + "_" + var.strip() + ".html"
					file_tmp = open(html, "w")
					file_tmp.write(hmtl_chart)
					file_tmp.close()
					create_index_layout(temp_chart)
		# Plot all models with reference datas

		if args.all_model is True:

			if args.funnel_comp is True:
				data = {}
				funnel_path = "AixLib" + os.sep + "funnel_comp"
				funnel_list = (os.listdir(funnel_path))
				path_list = []
				var_list = []
				for i in funnel_list:
					model = i[:i.find(".mat")]
					var = i[i.find(".mat_") + 5:]
					data[model] = var
					path_list.append(funnel_path + os.sep + i)
					var_list.append(var)
				data = data, path_list, var_list
				print("Plot line Chart ")
				print("plot the different reference results of all models")
				mako_line_html_chart(data, temp, temp_chart, f_log, csv_file, test_csv)
				create_index_layout(temp_chart)
			if args.ref_txt is True:
				ref_path = "AixLib" + os.sep + "Resources" + os.sep + "ReferenceResults" + os.sep + "Dymola"
				data = {}
				ref_list = (os.listdir(ref_path))
				for i in ref_list:
					file = ref_path+os.sep+i
					results = read_data(file)
					## Value Number with Legend
					distriction_values = results[0]
					## Value time with time sequence
					distriction_time = results[1]
					## Legend name
					Value_List = results[2]
					## Reference File
					ref_file = results[4]
					## Number value
					X_Axis = results[3]
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
					value_list = map(str,(value_list))
					#variable_list.append
					from mako.template import Template
					mytemplate = Template(filename=temp)
					hmtl_chart = mytemplate.render(values=value_list, var=Value_List, model=ref_file, title=i)
					html = temp_chart + os.sep + i.replace(".txt","") +   ".html"
					file_tmp = open(html, "w")
					file_tmp.write(hmtl_chart)
					file_tmp.close()
					create_index_layout(temp_chart)
################################################################################
		if args.plotModel is True:
			if os.path.isdir(temp_chart) is False:
				os.makedirs(temp_chart)
			model_list = args.modellist
			print(model_list)
			model_list = model_list.split("\n")
			if args.funnel_comp is True:
				data = {}
				funnel_path = "AixLib" + os.sep + "funnel_comp"
				path_list = []
				var_list = []
				for i in model_list:
					model = i[:i.find(".mat")]
					var = i[i.find(".mat_") + 5:]
					data[model] = var
					path_list.append(funnel_path + os.sep + i)
					var_list.append(var)
				data = data, path_list, var_list
				print("Plot line Chart ")
				print("plot the different reference results of all models")
				mako_line_html_chart(data, temp, temp_chart, f_log, csv_file, test_csv)
				create_index_layout(temp_chart,temp_chart)
			if args.ref_txt is True:
				ref_path = "AixLib" + os.sep + "Resources" + os.sep + "ReferenceResults" + os.sep + "Dymola"
				data = {}
				for i in model_list:
					i = i.lstrip()
					print("Plot for model: "+ i)
					#file = ref_path + os.sep + i+".txt"
					file = i
					results = read_data(i.lstrip())
					## Value Number with Legend
					distriction_values = results[0]
					## Value time with time sequence
					distriction_time = results[1]
					## Legend name
					Value_List = results[2]
					## Reference File
					ref_file = results[4]
					## Number value
					X_Axis = results[3]
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
					from mako.template import Template

					mytemplate = Template(filename=temp)
					hmtl_chart = mytemplate.render(values=value_list, var=Value_List, model=ref_file, title=i)
					i = (i.replace(".txt", ""))
					i = i[i.find("Dymola")+7:]
					html = temp_chart + os.sep + i.replace(".txt", "") + ".html"
					file_tmp = open(html, "w")
					file_tmp.write(hmtl_chart)
					file_tmp.close()
					create_index_layout(temp_chart)



			'''
			if file is False:
				print(f_log + " does not exists")
				exit(1)
			if args.funnel_comp is True:
				print("Plot all model from funnel comp folder ")
				print("plot the different reference results")
				mako_line_html_chart(data, temp, temp_chart, f_log, csv_file, test_csv)
			'''

		'''
		if args.model is True:
			model_list = []
			print("Plot line Chart for model"+model_list)

			results = read_data()
			## Value Number with Legend
			distriction_values = results[0]
			## Value time with time sequence
			distriction_time = results[1]
			## Legend name
			Value_List = results[2]
			## Reference File
			ref_file = results[4]
			## Number value
			X_Axis = results[3]
			print(results)
			data = read_unitTest_log(f_log)
			mako_line_html_chart(data, temp, temp_chart, f_log, csv_file, test_csv)
		'''
		## Plot a Package
		if args.single_package is False:
			data = read_unitTest_log(f_log)
			mako_line_html_chart(data, temp, temp_chart, f_log, csv_file, test_csv)

	# *********************************************************************************************************
	## Create Line matplot chart
	if args.line_matplot is True:
		print("Plot matplot Chart")
		results = read_data()
		## Value Number with Legend
		distriction_values = results[0]
		## Value time with time sequence
		distriction_time = results[1]
		print(distriction_time)
		## Legend name
		Value_List = results[2]
		## Reference File
		ref_file = results[4]
		## Number value
		X_Axis = results[3]
		#print(results)

		result = func_plot(distriction_values, distriction_time, Value_List, X_Axis, ref_file)
		lines = result[0]
		fig = result[1]
		plt.subplots_adjust(left=0.2)
		rax = plt.axes([0.05, 0.4, 0.1, 0.15])
		labels = [str(line.get_label()) for line in lines]
		visibility = [line.get_visible() for line in lines]
		check = CheckButtons(rax, labels, visibility)

		# check.on_clicked(func)
		check.on_clicked(func)
		t = plt.show()
		# func_plot.check.on_clicked(func)
		# Create_Line_Chart(distriction_values, distriction_time, Value_List,X_Axis,ref_file)
		# mpld3.save_html(fig,'myfig.html')

		fig = figure()
		ax = fig.gca()
		ax.plot([1, 2, 3, 4])
		# print(type(fig))
		mpld3.save_html(fig, 'myfig.html')
	if args.create_layout is True:
		create_layout(index_path)