import os
import sys 
import shutil
import glob
import argparse
from natsort import natsorted

def copy_mos(ibpsa_dir, dst):
	''' Copy the ConvertIBPSA mos Script '''
	if os.path.isdir(dst):
		pass
	else:
		os.mkdir(dst)
	mos_file_list = (glob.glob(ibpsa_dir))
	if len(mos_file_list) == 0:
		print("Cant find a Conversion Script in IBPSA Repo")
		exit(0)
	l_ibpsa_conv = natsorted(mos_file_list)[(-1)]
	l_ibpsa_conv = l_ibpsa_conv.replace("/", os.sep)
	l_ibpsa_conv = l_ibpsa_conv.replace("\\", os.sep)
	print(f'Latest IBPSA Conversion script: {l_ibpsa_conv}')
	shutil.copy(l_ibpsa_conv, dst)
	return l_ibpsa_conv
	

# Read the last aixlib conversion mos script
def read_aixlib_convert(aixlib_dir):
	filelist = (glob.glob(aixlib_dir+os.sep+"*.mos"))
	if len(filelist) == 0:
		print("Cant find a Conversion Script in IBPSA Repo")
		exit(0)
	l_aixlib_conv = natsorted(filelist)[(-1)]
	l_aixlib_conv = l_aixlib_conv.replace("/", os.sep)
	l_aixlib_conv = l_aixlib_conv.replace("\\", os.sep)
	print(f'Latest AixLib Conversion script: {l_aixlib_conv}')
	return l_aixlib_conv


def create_convert_aixlib(l_ibpsa_conv, dst, l_aixlib_conv):  # change the paths in the script from IBPSA.Package.model -> AixLib.Package.model
	conv_number = l_aixlib_conv[l_aixlib_conv.find("ConvertAixLib_from_")+19:l_aixlib_conv.rfind(".mos")]
	print(f'Latest conversion number: {conv_number}')  # FROM 1.0.1_ TO _1.0.2
	old_from_numb = conv_number[:conv_number.find("_to_")]
	old_to_numb = conv_number[conv_number.find("_to_") + 4:]  # Update TO Number 1.0.2 old_to_numb == new_from_numb
	first_numb = old_to_numb[:old_to_numb.find(".")]
	sec_numb = int(old_to_numb[old_to_numb.find(".")+1:old_to_numb.rfind(".")]) + 1
	new_to_numb = f'{first_numb}.{sec_numb}.0'
	#print(f'New TO_NUMBER: {new_to_numb}')  # 1.1.0

	new_conv_number = str(old_to_numb)+"_to_"+str(new_to_numb)  # write new conversion number
	#print(f'New conversion number: {new_conv_number}')  # 1.0.2_to_1.1.0

	file_new_conv = f'{dst}{os.sep}ConvertAixLib_from_{new_conv_number}.mos'
	#print(f'New conversion script: {file_new_conv}')  # Convertmos\ConvertAixLib_from_1.0.2_to_1.1.0.mos

	ibpsa_file = open(l_ibpsa_conv, "r")
	aixlib_file = open(file_new_conv, "w+")

	for line in ibpsa_file:
		if line.find("Conversion script for IBPSA library") > -1:
			aixlib_file.write(line)
		elif line.find("IBPSA") > - 1:
			aixlib_file.write(line.replace("IBPSA", "AixLib"))
		else:
			aixlib_file.write(line)
	ibpsa_file.close()
	aixlib_file.close()
	return file_new_conv, old_to_numb, old_from_numb, new_to_numb

def copy_aixlib_mos(file_new_conv,aixlib_dir, dst):
	new_conversion_script = shutil.copy(file_new_conv, aixlib_dir)
	shutil.rmtree(dst)
	return new_conversion_script

def compare_conversions(l_ibpsa_conv, l_aixlib_conv):

	result = True
	with open(l_ibpsa_conv) as file_1:
		file_1_text = file_1.readlines()
	with open(l_aixlib_conv) as file_2:
		file_2_text = file_2.readlines()
	for line1, line2 in zip(file_1_text, file_2_text):
		if line1 == line2.replace("AixLib", "IBPSA"):
			continue
		else:
			#print(f'Different Content:\n{l_ibpsa_conv}: {line1}\n{l_aixlib_conv}: {line2} ')
			result = False
	return result


def _read_package():
	file = open(f'AixLib{os.sep}package.mo', "r")
	list = []	
	for line in file:
		if line.find("conversion(from(") > -1:
			list.append(line)
			counter = 1
			continue	
		if line.find('.mos")),') > -1 and counter == 1:
			version_number = line[line.find("_to_")+4:line.find(".mos")]
			return version_number

def add_conv_to_package(l_aixlib_conv, new_conversion_script, old_to_numb, old_from_numb, new_to_numb):
	l_aixlib_conv = l_aixlib_conv.replace('\\','/')
	#print(f'old_to_numb_ {old_to_numb}')
	#print(f'old_from_numb {old_from_numb}')
	#print(f'new_to_numb {new_to_numb}')
	new_conversion_script = new_conversion_script.replace('\\','/')
	file = open(f'AixLib{os.sep}package.mo', "r")
	list = []
	for line in file:
		if line.find("version") == 0 or line.find('script="modelica://') == 0:
			list.append(line)
			continue
		if line.find(f'  version = "{old_to_numb}",') > -1:
			list.append(line.replace(old_to_numb, new_to_numb))
			continue
		if line.find(f'{l_aixlib_conv}') > -1:
			list.append(line.replace(")),", ","))
			list.append(f'    version="{old_to_numb}",\n')
			list.append(f'                      script="modelica://{new_conversion_script}")),\n')
			continue
		else:
			list.append(line)
			continue
	file.close()
	pack = open(f'AixLib{os.sep}package.mo', "w")
	for i in list:
		pack.write(i)
	pack.close()

if  __name__ == '__main__':
	parser = argparse.ArgumentParser(description = "Set Github Environment Variables")
	check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
	check_test_group.add_argument("-dst", "--dst", default ="Convertmos", help="temp folder")
	check_test_group.add_argument("-ad", "--aixlib-dir", default="AixLib\\Resources\\Scripts", help="path to the aixlib scripts" )
	check_test_group.add_argument('-id',"--ibpsa-dir",default='modelica-ibpsa\\IBPSA\\Resources\\Scripts\\Dymola\\ConvertIBPSA_*', help="path to the ibpsa scripts")
	# Parse the arguments
	args = parser.parse_args()
	l_ibpsa_conv = copy_mos(args.ibpsa_dir, args.dst)  # latest conversion script IBPSA
	l_aixlib_conv = read_aixlib_convert(args.aixlib_dir)  # latest conversion Script AixLib
	result = compare_conversions(l_ibpsa_conv, l_aixlib_conv)  # Compare latest aixlib and IBPSA script
	if result is True:
		print(f'The latest aixlib conversion script {l_aixlib_conv} is up to date with IBPSA conversion script {l_ibpsa_conv}')
	if result is False:
		conv_data = create_convert_aixlib(l_ibpsa_conv, args.dst, l_aixlib_conv)
		file_new_conv = conv_data[0]
		old_to_numb = conv_data[1]
		old_from_numb = conv_data[2]
		new_to_numb = conv_data[3]
		if file_new_conv is None:
			print("please check when the last merge took place")
			shutil.rmtree(args.dst)
		else:
			new_conversion_script = copy_aixlib_mos(file_new_conv, args.aixlib_dir, args.dst)
			add_conv_to_package(l_aixlib_conv, new_conversion_script, old_to_numb, old_from_numb, new_to_numb)
			print(f'New Aixlib Conversion skrip was created: {file_new_conv}')


