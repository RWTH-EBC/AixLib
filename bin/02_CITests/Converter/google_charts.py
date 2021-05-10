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
# get datas and create a line chart
def Create_Line_Chart():

	html_chart = open("index.html", "w")
	html_str ="""
	<html>
	  <head>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
		  google.charts.load('current', {'packages':['corechart']});
		  google.charts.setOnLoadCallback(drawChart);

		  function drawChart() {
			var data = google.visualization.arrayToDataTable([
			  ['Year', 'Sales', 'Expenses'],
			  ['2004',  1000,      400],
			  ['2005',  1170,      460],
			  ['2006',  660,       1120],
			  ['2007',  1030,      540]
			]);

			var options = {
			  title: 'Company Performance',
			  curveType: 'function',
			  legend: { position: 'bottom' }
			};

			var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

			chart.draw(data, options);
		  }
		</script>
	  </head>
	  <body>
		<div id="curve_chart" style="width: 900px; height: 500px"></div>
	  </body>
	</html>
	"""
	
	html_chart.write(html_str)
	html_chart.close()

def read_data():
	ref_file = "AixLib_BoundaryConditions_WeatherData_BaseClasses_Examples_CheckRadiation.txt"
	Entire = 0
	## Lists
	Value_List= []
	time_List =[]
	X_Axis, Y_Axis = [], []
	## Dictionary
	distriction_values = {}
	distriction_time = {}
	
	for line in open(ref_file, 'r'):
		#line = line.lstrip()
		if line.find("last-generated=") > -1:
			continue
		if line.find("statistics-simulation=") > -1: 
			continue
		values = (line.split("="))
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
	
	
	#print(distriction_values)
	#print(Value_List)
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
	#print(tim_seq)
	times_list = []
	t = ((float(len(Y_Axis))/float(len(Value_List))))
	i = 0
	while (i) < t:
	#for i in Y_Axis:
		times_list.append(num_times)
		num_times = num_times + tim_seq
		i = i +1
	X_Axis = times_list
	#print(times_list)
	
	
	return  distriction_values, distriction_time, Value_List,X_Axis,ref_file
	
	'''
	for v in x:
		v = v.replace("[","")
		v = v.replace("]","")
		v = v.replace("\n","")
		v = v.replace("'","")
		v = v.lstrip()
		v = float(v)
		X_Axis.append(v)
	print(X_Axis)
	'''
	'''
	dia_name = ref_file.replace(".txt","")
	dia_name = dia_name.replace("_",".")
	plt.title(dia_name)
	plt.xlabel("Time")
	plt.ylabel(Value_List[0])
	#plt.yticks(Y_Axis)
	plt.plot(X_Axis, Y_Axis, marker = 'o', c = 'g')
	  
	plt.show()'''
	
	
	'''
		for i in values:
			list = []
			list = i.split("=")
			if len(list) < 2:
				continue
			legend = list[0]
			#print(legend)
			numbers = list[1]
			#print(numbers)
			count= count +1
			distriction[legend] = numbers
		#print(count)	
		print(distriction)
		#X.append(values[0])
		#Y.append(values[1])
	'''
	#plt.plot(X, Y)
	#plt.show()
	
	
def func_plot(distriction_values, distriction_time, Value_List,X_Axis,ref_file):
	dia_name = ref_file.replace(".txt","")
	dia_name = dia_name.replace("_",".")
	
	
	
	counter = 0
	fig, ax = plt.subplots()
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
						
		l0, = ax.plot(X_Axis,Y_Axis, visible=False, lw=2)
	
	plt.subplots_adjust(left=0.2)
	#print(X_Axis)
	#rax = plt.axes(X_Axis)
	rax = plt.axes([0.05, 0.4, 0.1, 0.15]) 
	check = CheckButtons(rax, Value_List, [False,  True])
	plt.title(dia_name)
	#plt.xlabel("Time")
	#plt.ylabel(Value_List[0])
	#plt.yticks(Y_Axis)
	check.on_clicked(func)

	plt.show()
	
	
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
		#
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
	
def get_lines( filename ):
    f = open( filename, "r" )
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
    if label == '2 Hz':
        l0.set_visible(not l0.get_visible())
    elif label == '4 Hz':
        l1.set_visible(not l1.get_visible())
    elif label == '6 Hz':
        l2.set_visible(not l2.get_visible())
    plt.draw()

#def new_format():
	


if  __name__ == '__main__':
	### Settings
	
	path_aix = "AixLib"+os.sep+"Resources"+os.sep+"ReferenceResults"+os.sep+"Dymola"
	path_ibpsa = "modelica-ibpsa"+os.sep+"IBPSA"+os.sep+"Resources"+os.sep+"ReferenceResults"+os.sep+"Dymola"
	
	path_diff = "bin"+os.sep+"03_WhiteLists"+os.sep+"Ref_list"+os.sep+"diff_ref"
	createFolder(path_diff)
	path_new  = "bin"+os.sep+"03_WhiteLists"+os.sep+"Ref_list"+os.sep+"new_ref"
	createFolder(path_new)
	
	#Create_Line_Chart()
	#read_data()
	#write_data_rows()
	#results = read_data()
	#distriction_values = results[0]
	#distriction_time = results[1]
	#Value_List = results[2]
	#ref_file = results[4]
	#X_Axis = results[3]
	#func_plot(distriction_values, distriction_time, Value_List,X_Axis,ref_file)
	#func_plot.check.on_clicked(func)
	
	#plt.show()
	'''
	
	print(results[0])
	print("\n Abschnitt")
	print(results[1])
	print("\n Abschnitt")
	print(results[2])
	'''
	_CloneRepository()
	results = diff_ref(path_aix,path_ibpsa,path_diff,path_new)
	diff_ref = results[0]
	new_ref = results[1]
	
	add_new_ref(diff_ref,new_ref,path_aix,path_ibpsa,path_new,path_diff)
		
	
	
	