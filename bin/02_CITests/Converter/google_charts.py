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
import gviz_api
from matplotlib.pyplot import figure
import mpld3
# get datas and create a line chart


def read_data():
	ref_file = "bin"+os.sep+"02_CITests"+os.sep+"Converter"+os.sep+"IBPSA_Airflow_Multizone_Examples_CO2TransportStep.txt"
	Entire = 0
	## Lists
	Value_List= []
	time_List =[]
	X_Axis, Y_Axis = [], []
	## Dictionary
	distriction_values = {}
	distriction_time = {}
	for line in open(ref_file, 'r'):
		if line.find("last-generated=") > -1:
			continue
		if line.find("statistics-simulation=") > -1: 
			continue
		values = (line.split("="))
		if len(values) < 2:
			continue
		legend = values[0]
		#print(legend)
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
			v = float(v)
			Y_Axis.append(v)
	
	x = distriction_time.get("time")
	x = x.replace("[","")
	x = x.replace("]","")
	x = x.replace("\n","")		
	x = x.replace("'","")
	x = x.lstrip()
	x = x.split(",")
	
	time_end = float((x[len(x)-1]))
	time_beg = float((x[0]))
	time_int = time_end -  time_beg
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
	
	
	
def func_plot(distriction_values, distriction_time, Value_List,X_Axis,ref_file):
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
	
def write_data_rows():
	
	print("testq")
	for i, j in zip((1,2,3), (4,5,6)):
		print (i, j)

def _CloneRepository():
	git_url = "https://github.com/ibpsa/modelica-ibpsa.git"
	repo_dir = "modelica-ibpsa"
	if os.path.exists(repo_dir):
		print("IBPSA folder exists already!")
	else:
		print("Clone IBPSA Repo")
		repo = Repo.clone_from(git_url, repo_dir)


def createFolder(directory):
    try:
        if not os.path.exists(directory):
            os.makedirs(directory)
    except OSError:
        print ('Error: Creating directory. ' +  directory)
        

def diff_ref(path_aix,path_ibpsa,path_diff,path_new):
	aix_ref_files = os.listdir(path_aix) 
	ibpsa_ref_files = os.listdir(path_ibpsa) 
	ibpsa_list = []
	## Give double reference files
	for i in ibpsa_ref_files:
		i = i.replace("IBPSA","AixLib")
		ibpsa_list.append(i)
	
	set1 = set(aix_ref_files)
	set2 = set(ibpsa_list)
	set3 = set1.intersection(set2)
	list3 = list(set3)
	
	for f in list3:
		aix_ref = f
		ibpsa_ref = f.replace("AixLib","IBPSA")
		
		aix_ref = path_aix+os.sep+ aix_ref
		ibpsa_ref = path_ibpsa+os.sep+ibpsa_ref
		result = path_diff +os.sep+f
		
		
		outputFile = open(result,"w")
		inputFile1 = open(aix_ref,"r")
		inputFile2 = open(ibpsa_ref,"r")
		
		line1 = inputFile1.readline()
		line2 = inputFile2.readline()
		
		while line1 != "" or line2 != "":
			if line1 != line2:
				outputFile.write("AixLib: "+line1)
				outputFile.write("IBPSA: "+line2+"\n")
				
			line1 = inputFile1.readline()
			line2 = inputFile2.readline()	
		inputFile1.close()
		inputFile2.close()
		outputFile.close()

	for root,dirs,files in os.walk(path_diff):  
		for name in files:  
			filename = os.path.join(root,name)  
			if os.stat(filename).st_size == 0:  
				os.remove(filename)
	
	
	diff_ref = os.listdir(path_diff)
	new_ref =(set1^set2)&set2
	
	for i in new_ref:
		i = i.replace("AixLib","IBPSA")
		source = path_ibpsa+os.sep+i
		shutil.copy2(source,path_new)
		
		
	new_ref =os.listdir(path_new)
	return diff_ref, new_ref
	
def get_lines(filename):
    f = open(filename,"r")
    lines = f.readline()
    f.close
    return lines


def add_new_ref(diff_ref,new_ref,path_aix,path_ibpsa,path_new,path_diff):
	new_ref_list = []
	for i in new_ref:
		source = path_new+os.sep+i
		ibp = path_new+os.sep+i.replace("IBPSA","AixLib")
		file = pathlib.Path(ibp)
		
		if file.exists ():
			new_ref_list.append(file)
			continue
		
		if i.find("IBPSA")> -1 :
			i = i.replace("IBPSA","AixLib")
			i = path_new+os.sep+i
			os.rename(source, i)
		else:
			i = path_new+os.sep+i
		new_ref_list.append(i)
	
	## Copy New Files
	for i in new_ref_list:
		path = path_aix
		shutil.copy2(i,path)
	
	for i in diff_ref:
		path = path_aix
		i = i.replace("AixLib","IBPSA")
		source = path_ibpsa+os.sep+i
		target = path+os.sep+i.replace("IBPSA","AixLib")
		shutil.copy2(source,target)
		
	
#def delte_ibpsa_dir():
	
	'''
	for i in new_ref:
		#i = i.replace("IBPSA","AixLib")
		new_ref_list.append(i)
	for k in diff_ref:
		#k = i.replace("AixLib","IBPSA")
		new_ref_list.append(k)
	#print(new_ref_list)
	
	# Delte AixLib Reference Files
	for l in diff_ref:
		file = path_aix+os.sep+l
		os.remove(file) 
	# Add new and updated reference files
	#for 
	#shutil.copy2(source,path_new)'''
		
def func(label):
	index = labels.index(label)
	lines[index].set_visible(not lines[index].get_visible())
	plt.draw()

def diff_mos(path_aix_mos,path_ibpsa_mos,path_diff_mos,path_new_mos):
	
	aix_mos_files = glob.glob(path_aix_mos+os.sep+'**/*.mos',recursive=True)
	ibpsa_mos_files = glob.glob(path_ibpsa_mos+os.sep+'**/*.mos',recursive=True)
	
	ibpsa_list = []
	aixlib_list = []
	## Give double mos files
	for i in ibpsa_mos_files:
		ibpsa_list.append(i.split(os.sep)[-1])
	for i in aix_mos_files:
		aixlib_list.append(i.split(os.sep)[-1])
	
	
	set1 = set(aixlib_list)
	set2 = set(ibpsa_list)
	set3 = set1.intersection(set2)
	list3 = list(set3)
	for i in list3:
		aixlib = glob.glob(path_aix_mos+os.sep+'**/*'+os.sep+i,recursive=True)
		ibpsa = glob.glob(path_ibpsa_mos+os.sep+'**/*'+os.sep+i,recursive=True)
		for l in aixlib:
			aix = l
			ibpsa = "modelica-ibpsa"+os.sep+l.replace("AixLib","IBPSA")
			result = path_diff_mos +os.sep+l
			result = (result.replace(os.sep+"AixLib"+os.sep+"Resources"+os.sep+"Scripts"+os.sep+"Dymola",""))
			createFolder(result[:result.rfind(os.sep)])
		
			outputFile = open(result,"w")
			inputFile1 = open(aix,"r")
			inputFile2 = open(ibpsa,"r")
			
			line1 = inputFile1.readline()
			line2 = inputFile2.readline()
			line3 = line2.replace("IBPSA","AixLib")
			while line1 != "" or line3 != "":
				if line1 != line3:
					outputFile.write("AixLib: "+line1)
					outputFile.write("IBPSA: "+line2+"\n")
					
				line1 = inputFile1.readline()
				line3 = inputFile2.readline()	
			inputFile1.close()
			inputFile2.close()
			outputFile.close()
			#print(result)
			if os.stat(result).st_size == 0:  
				os.remove(result)
			
	new_ref =(set1^set2)&set2
	new_mos_list = []
	for i in new_ref:
		if i.find("ConvertIBPSA") > -1 :
			continue
		else:
			ibpsa = glob.glob(path_ibpsa_mos+os.sep+'**/*'+os.sep+i,recursive=True)
			new_mos_list.append(ibpsa)
			source = path_new_mos+os.sep+i
			for l in ibpsa:
				shutil.copy2(l,source)
	
	
	

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
        removeEmptyFolders(fullpath)

  # if folder empty, delete it
  files = os.listdir(path)
  if len(files) == 0 and removeRoot:
    #print("Removing empty folder: "+ path)
    os.rmdir(path)

def usageString():
  'Return usage string to be output in error cases'
  return 'Usage: %s directory [removeRoot]' % sys.argv[0]




def main():
	# Creating the data
	description = {"name": ("string", "Name"),
					 "salary": ("number", "Salary"),
					 "full_time": ("boolean", "Full Time Employee")}
	data = [{"name": "Mike", "salary": (10000, "$10,000"), "full_time": True},
			  {"name": "Jim", "salary": (800, "$800"), "full_time": False},
			  {"name": "Alice", "salary": (12500, "$12,500"), "full_time": True},
			  {"name": "Bob", "salary": (7000, "$7,000"), "full_time": True}]

	# Loading it into gviz_api.DataTable
	data_table = gviz_api.DataTable(description)
	data_table.LoadData(data)

	# Create a JavaScript code string.
	jscode = data_table.ToJSCode("jscode_data",
								   columns_order=("name", "salary", "full_time"),
								   order_by="salary")
	# Create a JSON string.
	json = data_table.ToJSon(columns_order=("name", "salary", "full_time"),
							   order_by="salary")

	# Put the JS code and JSON string into the template.
	#print("Content-type: text/html")
	  
	#print( page_template % vars())
	ref_file = "bin"+os.sep+"02_CITests"+os.sep+"Converter"+os.sep+"index.html"
	file = open(ref_file,"w")
	file.write(page_template % vars())

if  __name__ == '__main__':
	### Settings
	'''
	path_aix = "AixLib"+os.sep+"Resources"+os.sep+"ReferenceResults"+os.sep+"Dymola"
	path_ibpsa = "modelica-ibpsa"+os.sep+"IBPSA"+os.sep+"Resources"+os.sep+"ReferenceResults"+os.sep+"Dymola"
	
	path_aix_mos = "AixLib"+os.sep+"Resources"+os.sep+"Scripts"+os.sep+"Dymola"
	path_ibpsa_mos = "modelica-ibpsa"+os.sep+"IBPSA"+os.sep+"Resources"+os.sep+"Scripts"+os.sep+"Dymola"
	
	path_diff = "bin"+os.sep+"03_WhiteLists"+os.sep+"Ref_list"+os.sep+"diff_ref"
	createFolder(path_diff)
	path_new  = "bin"+os.sep+"03_WhiteLists"+os.sep+"Ref_list"+os.sep+"new_ref"
	createFolder(path_new)
	
	path_diff_mos = "bin"+os.sep+"03_WhiteLists"+os.sep+"mos_list"+os.sep+"diff_mos"
	createFolder(path_diff_mos)
	path_new_mos  = "bin"+os.sep+"03_WhiteLists"+os.sep+"mos_list"+os.sep+"new_mos"
	createFolder(path_new_mos)
	
	
	_CloneRepository()
	
	results = diff_ref(path_aix,path_ibpsa,path_diff,path_new)
	diff_ref = results[0]
	new_ref = results[1]
	
	add_new_ref(diff_ref,new_ref,path_aix,path_ibpsa,path_new,path_diff)
		
	mos_results = diff_mos(path_aix_mos,path_ibpsa_mos,path_diff_mos,path_new_mos)
	#print(mos_results)
	
	removeRoot = True
	removeEmptyFolders(path_diff_mos, removeRoot)
	
	
	'''
	
	
	#write_data_rows()
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
	

	
	result = func_plot(distriction_values, distriction_time, Value_List,X_Axis,ref_file)
	lines = result[0]
	fig = result[1]
	plt.subplots_adjust(left=0.2)
	rax = plt.axes([0.05, 0.4, 0.1, 0.15]) 
	labels = [str(line.get_label()) for line in lines]
	visibility = [line.get_visible() for line in lines]
	check = CheckButtons(rax, labels, visibility)
	
	#check.on_clicked(func)
	check.on_clicked(func)
	
	t = plt.show()
	#func_plot.check.on_clicked(func)
	#Create_Line_Chart(distriction_values, distriction_time, Value_List,X_Axis,ref_file)
	#mpld3.save_html(fig,'myfig.html')
	
	
	fig = figure()
	ax = fig.gca()
	ax.plot([1,2,3,4])
	#print(type(fig))
	mpld3.save_html(fig,'myfig.html')
	
	
	'''
			
	page_template = """
	<html>
	<head>
	  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
		  google.charts.load('current', {'packages':['line']});
		  google.charts.setOnLoadCallback(drawChart);

		function drawChart() {

		  var data = new google.visualization.DataTable();
		  data.addColumn('number', 'Day');
		  data.addColumn('number', 'Guardians of the Galaxy');
		  data.addColumn('number', 'The Avengers');
		  data.addColumn('number', 'Transformers: Age of Extinction');

		  data.addRows([
			[1,  37.8, 80.8, 41.8],
			[2,  30.9, 69.5, 32.4],
			[3,  25.4,   57, 25.7],
			[4,  11.7, 18.8, 10.5],
			[5,  11.9, 17.6, 10.4],
			[6,   8.8, 13.6,  7.7],
			[7,   7.6, 12.3,  9.6],
			[8,  12.3, 29.2, 10.6],
			[9,  16.9, 42.9, 14.8],
			[10, 12.8, 30.9, 11.6],
			[11,  5.3,  7.9,  4.7],
			[12,  6.6,  8.4,  5.2],
			[13,  4.8,  6.3,  3.6],
			[14,  4.2,  6.2,  3.4]
		  ]);

		  var options = {
			chart: {
			  title: 'Box Office Earnings in First Two Weeks of Opening',
			  subtitle: 'in millions of dollars (USD)'
			},
			width: 900,
			height: 500,
			axes: {
			  x: {
				0: {side: 'bottom'}
			  }
			}
		  };

		  var chart = new google.charts.Line(document.getElementById('line_top_x'));

		  chart.draw(data, google.charts.Line.convertOptions(options));
		}
	  </script>
	</head>
	<body>
	  <div id="line_top_x"></div>
	</body>

	"""
	main()'''
	
	