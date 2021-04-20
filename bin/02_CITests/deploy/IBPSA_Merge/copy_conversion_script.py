import os
import sys 
import shutil
import glob
import argparse

def copy_mos(ibpsa_dir,dst):
	#IBPSA/Resources/Scripts/Dymola/ConvertIBPSA_from_3.0_to_4.0.mos
	# D:\01_Arbeit\04_Github\01_GitLabCI\master\GitLabCI\IBPSA\IBPSA\Resources\Scripts\Dymola
	#D:\01_Arbeit\04_Github\01_GitLabCI\master\GitLabCI
	''' Copy the ConvertIBPSA mos Script'''
	if  os.path.isdir(dst) :
		pass
	else:
		os.mkdir(dst)
	#for file in glob(ibpsa_dir):
	file = (glob.glob(ibpsa_dir))
	# Look which ConvertScript is the latest
	if len(file)==0:
		print("Cant find a Conversion Script in IBPSA Repo")
		exit(0)
	
	if len(file)>1:
		list = []
		for i in file:
			i = i.replace(".mos","")
			list.append(i)
		
		data = (sorted(list, key=lambda x: float(x[x.find("_to_")+4:])))
		data = (data[len(data)-1])
		i = data+".mos"
		data = data.split(os.sep)
		data = data[len(data)-1]
		data = dst +os.sep+ data+".mos"
		
		shutil.copy(i,dst)
	if len(file) == 1:
		for i in file:
			shutil.copy(i, dst)
		file = file[len(file)-1]
		data = file.split(os.sep)
		data = data[len(data)-1]
		data = dst +os.sep+ data
		
	
	return data 
	
	
	'''for root, subdirs, files in os.walk('D:\\01_Arbeit\\04_Github\\01_GitLabCI\\master'):
		
		for d in subdirs:
			if d == "IBPSA":
				print(root)
				print(files)
	'''			
# Read the last aixlib mos sciprt
def read_aixlib_convert(aixlib_dir):
	filelist = (glob.glob(aixlib_dir+os.sep+"*.mos"))
	list = []
	for i in filelist:
		i = i.replace(".mos","")
		list.append(i)
		
	
	data = (sorted(list, key=lambda x: float(x[x.find("_to_0")+6:])))
	data = (data[len(data)-1])
	
	d = data[data.find("_to_0")+6:data.rfind(".")]
	last_conv_list = []
	for i in list:
		num = i[i.find("_to_0")+6:i.rfind(".")]
		if num == str(d):
			last_conv_list.append(i)
			continue
	data = (sorted(last_conv_list, key=lambda x: int(x[x.rfind(".")+1:])))
	data = (data[len(data)-1])
	data = data.split(os.sep)
	data = (data[len(data)-1])+".mos"
	return data
	
#  change the paths in the script from IBPSA.Package.model -> AixLib.Package.model
def create_convert_aixlib(data,dst,l_conv_aix,comp):
	if comp is False:
		print("The latest conversion script is up to date from the IBPSA")
	if comp is True:
		conv_number =  l_conv_aix[l_conv_aix.find("ConvertAixLib_from_")+19:l_conv_aix.rfind(".mos")]
		# Update FROM Number
		
		from_numb = str("0.")+((conv_number[conv_number.find("_to_0")+6:]))   
		
		# Update TO Number
		to_numb = int((conv_number[conv_number.find("_to_0")+6:conv_number.rfind(".")])) + 1   
		to_numb = "0."+str(to_numb)+"." + str(0)
		new_conv_number = str(from_numb)+"_to_"+str(to_numb)
		file_new_conv = "ConvertAixLib_from_"+new_conv_number+".mos"
		
		aixlib_mos = dst+os.sep+file_new_conv
		f = open(data, "r")
		r = open(aixlib_mos,"w+")
		for line in f:
			if line.find("from:") > -1 and line.find(" Version") > -1 :
				r.write("//  from: Version " + from_numb + "\n")
				continue
			if line.find("to") > -1 and line.find(" Version") > -1 :
				r.write("//  to:   Version " + to_numb+ "\n")
				continue
			else:
				r.write(line.replace("IBPSA","AixLib"))
		f.close()
		r.close()
		return aixlib_mos
# D:\01_Arbeit\04_Github\01_GitLabCI\master\GitLabCI\AixLib\Resources\Scripts
def copy_aixlib_mos(aixlib_mos,aixlib_dir,dst):
	shutil.copy(aixlib_mos, aixlib_dir)
	shutil.rmtree(dst)
def compare_conversions(data,aixlib_dir,l_conv_aix):
	ipbsa_conv = data
	aix_conv = aixlib_dir+os.sep+l_conv_aix
	f = open(ipbsa_conv, "r")
	r = open(aix_conv,"r")
	IBPSA = f.readlines()
	aixlib = r.readlines()
	f.close()
	r.close()
	x = 0
	list = []
	if len(IBPSA) == len(aixlib):
		for i in IBPSA:
			i = i.replace("IBPSA","AixLib")
			if i.find("from:") > -1 and i.find(" Version") > -1 :
				x = x+1
				continue
			
			if i.find("to") > -1 and i.find(" Version") > -1 :
				x = x+1
				continue
			if i != aixlib[x]: 
				list.append(i)
				x = x+1
				continue
				
			x = x+1
	else:
		list.append(x)
	
	if len(list)>0:
		return True
	if len(list)==0:
		return False
def add_conv_to_package(aixlib_mos,aixlib_dir):
	file = open("AixLib"+os.sep+"package.mo", "r")
	list = []
	counter = 0
	number = aixlib_mos[aixlib_mos.find("_to_")+4:aixlib_mos.find(".mos")]
	#print(number)
	#ConvertAixLib_from_0.11.0_to_0.12.0.mos")),
	aixlib_mos = aixlib_mos[aixlib_mos.find("ConvertAixLib"):]
	for line in file:
		
		if line.find("conversion(from(") > -1:
			list.append(line)
			counter = 1
			continue	
		if line.find('.mos")),') >-1 and counter == 1:
			ent = line.replace('.mos")),','.mos",')
			list.append(ent)
			version = '    version="'+number+'", script="modelica://'+aixlib_dir.replace(os.sep,"/")+'/' +aixlib_mos +'")),\n'
			print(version)
			list.append(version)
			counter = 0
			continue
		else: 
			list.append(line)
			continue
	for i in list:
		print(i)
	file.close()
	pack =  open("AixLib"+os.sep+"package.mo", "w")
	for i in list:
		pack.write(i)
	pack.close()
if  __name__ == '__main__':
	#aixlib_dir = "D:\\01_Arbeit\\04_Github\\01_GitLabCI\\master\\GitLabCI\\AixLib\\Resources\\Scripts"
	#ibpsa_dir = 'D:\\01_Arbeit\\04_Github\\01_GitLabCI\\master\\GitLabCI\\modelica-ibpsa\\IBPSA\\Resources\\Scripts\\Dymola\\ConvertIBPSA_*'
	#dst = "D:\\01_Arbeit\\04_Github\\01_GitLabCI\\master\\GitLabCI\\Convertmos"
	
	parser = argparse.ArgumentParser(description = "Set Github Environment Variables")
	check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
	check_test_group.add_argument("-dst", "--dst", default ="Convertmos", help="temp folder")
	check_test_group.add_argument("-ad", "--aixlib-dir", default="AixLib\\Resources\\Scripts", help="path to the aixlib scripts" )
	check_test_group.add_argument('-id',"--ibpsa-dir",default='modelica-ibpsa\\IBPSA\\Resources\\Scripts\\Dymola\\ConvertIBPSA_*', help="path to the ibpsa scripts")
	
	# Parse the arguments
	args = parser.parse_args()
	
	dst = args.dst
	aixlib_dir = args.aixlib_dir
	ibpsa_dir = args.ibpsa_dir
	
	data = copy_mos(ibpsa_dir,dst)
	l_conv_aix = read_aixlib_convert(aixlib_dir)
	comp = compare_conversions(data,aixlib_dir,l_conv_aix)
	aixlib_mos = create_convert_aixlib(data,dst,l_conv_aix,comp)
	if aixlib_mos is None:
		print("please check when the last merge took place")
		shutil.rmtree(dst)
	else:	
		copy_aixlib_mos(aixlib_mos,aixlib_dir,dst)
		add_conv_to_package(aixlib_mos,aixlib_dir)
		print("New Aixlib Conversion skrip was created")
	
	#aixlib_mos = "ConvertAixLib_from_0.11.0_to_0.12.0.mos"
	#aixlib_dir = "D:\01_Arbeit\04_Github\01_GitLabCI\IBPSA_Merge\GitLabCI\AixLib\Resources\Scripts"
	#aixlib_dir = "AixLib\Resources\Scripts"
	
	#add_conv_to_package(aixlib_mos,aixlib_dir)