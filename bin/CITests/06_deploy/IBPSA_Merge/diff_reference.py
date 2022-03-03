
import numpy as np
import sys, difflib
import os 
from git import Repo
from shutil import copyfile
import shutil
import pathlib
import glob






class Return_diff_files(object):

	def __init__(self, library, wh_library):
		self.library = library
		self.wh_library = wh_library

		sys.path.append('bin/CITests')
		from _config import ref_file_dir, new_ref_file, resource_dir, artifacts_dir
		self.artifacts_dir = artifacts_dir
		self.ref_file_dir = ref_file_dir
		self.new_ref_file = new_ref_file
		self.resource_dir = resource_dir
		self.path_lib_script = f'{self.library}{os.sep}{self.resource_dir}'
		self.path_wh_lib_script = f'modelica-ibpsa{os.sep}{self.wh_library}{os.sep}{self.resource_dir}'

		self.diff_ref_dir = f'{self.artifacts_dir}{os.sep}diff_ref'
		self.diff_mos_dir = f'{self.artifacts_dir}{os.sep}diff_mos'
		self.new_mos_dir = f'{self.artifacts_dir}{os.sep}new_mos'

	def _CloneRepository(self):
		git_url = "https://github.com/ibpsa/modelica-ibpsa.git"
		repo_dir = "modelica-ibpsa"
		if os.path.exists(repo_dir):
			print(f'{self.wh_library} folder exists already!')
		else:
			print(f'Clone {self.wh_library} Repository.')
			repo = Repo.clone_from(git_url, repo_dir)

	def _diff_mos(self):
		lib_mos_list = glob.glob(f'{self.path_lib_script}{os.sep}**/*.mos', recursive=True)
		wh_mos_list = glob.glob(f'{self.path_wh_lib_script}{os.sep}**/*.mos', recursive=True)
		wh_lib_list = []
		lib_list = []
		for wh_mos in wh_mos_list:  # Give double mos files
			wh_lib_list.append(wh_mos.split(os.sep)[-1])
		for lib_mos in lib_mos_list:
			lib_list.append(lib_mos.split(os.sep)[-1])
		set_lib = set(lib_list)
		set_wh_lib = set(wh_lib_list)
		inter_set = set_lib.intersection(set_wh_lib)
		mos_list = list(inter_set)
		for mos in mos_list:
			lib_list = glob.glob(f'{self.path_lib_script}{os.sep}**/*{os.sep}{mos}', recursive=True)
			wh_lib_list = glob.glob(f'{self.path_wh_lib_script}{os.sep}**/*{os.sep}{mos}', recursive=True)
			for lib_mos in lib_list:
				ibpsa = f'modelica-ibpsa{os.sep}{lib_mos.replace(self.library, self.wh_library)}'
				result = f'{self.diff_mos_dir}{os.sep}{lib_mos}'
				result = result.replace(self.path_lib_script, "")
				#createFolder(result[:result.rfind(os.sep)])
				output_file = open(result, "w")
				input_lib_file = open(aix, "r")
				input_wh_lib_file = open(ibpsa, "r")
				lib_line = input_lib_file.readline()
				wh_lib_line = (input_wh_lib_file.readline()).replace(self.wh_library, self.library)
				while lib_line != "" or wh_lib_line != "":
					if lib_line != wh_lib_line:
						output_file.write(f'{self.library}: {lib_line}')
						output_file.write(f'{self.wh_library: {wh_lib_line}}\n')
					line1 = inputFile1.readline()
					line3 = inputFile2.readline()
				input_lib_file.close()
				input_wh_lib_file.close()
				output_file.close()
				if os.stat(result).st_size == 0:
					os.remove(result)

		new_ref_list =(set_lib ^ set_wh_lib) & inter_set
		new_mos_list = []
		for ref in new_ref_list:
			if ref.find("ConvertIBPSA") > -1:
				continue
			else:
				ibpsa = glob.glob(self.path_wh_lib_script+os.sep+'**/*'+os.sep+i, recursive=True)
				new_mos_list.append(ibpsa)
				source = self.new_mos_dir +os.sep+i
				for l in ibpsa:
					shutil.copy2(l,source)


	def _diff_ref(self, path_aix, path_ibpsa, path_diff, path_new):
		aix_ref_files = os.listdir(path_aix)
		ibpsa_ref_files = os.listdir(path_ibpsa)
		ibpsa_list = []
		for i in ibpsa_ref_files:  # Give double reference files
			i = i.replace(self.wh_library, self.library)
			ibpsa_list.append(i)
		set1 = set(aix_ref_files)
		set2 = set(ibpsa_list)
		set3 = set1.intersection(set2)
		list3 = list(set3)
		for f in list3:
			aix_ref = f
			ibpsa_ref = f.replace(self.library, self.wh_library)
			aix_ref = path_aix+os.sep+ aix_ref
			ibpsa_ref = path_ibpsa+os.sep+ibpsa_ref
			result = path_diff +os.sep+f
			outputFile = open(result, "w")
			inputFile1 = open(aix_ref, "r")
			inputFile2 = open(ibpsa_ref, "r")
			line1 = inputFile1.readline()
			line2 = inputFile2.readline()
			while line1 != "" or line2 != "":
				if line1 != line2:
					outputFile.write(f'{self.library}: {line1}')
					outputFile.write(f'{self.wh_library}: {line2} \n')
				line1 = inputFile1.readline()
				line2 = inputFile2.readline()
			inputFile1.close()
			inputFile2.close()
			outputFile.close()
		for root, dirs, files in os.walk(path_diff):
			for name in files:
				filename = os.path.join(root,name)
				if os.stat(filename).st_size == 0:
					os.remove(filename)
		diff_ref = os.listdir(path_diff)
		new_ref =(set1^set2)&set2
		for i in new_ref:
			i = i.replace(self.library, self.wh_library)
			source = path_ibpsa+os.sep+i
			shutil.copy2(source, path_new)
		new_ref =os.listdir(path_new)
		return diff_ref, new_ref

	def _add_new_ref(self, diff_ref,new_ref,path_aix,path_ibpsa,path_new,path_diff):
		new_ref_list = []
		for i in new_ref:
			source = path_new+os.sep+i
			ibp = path_new+os.sep+i.replace(self.wh_library, self.library)
			file = pathlib.Path(ibp)
			if file.exists():
				new_ref_list.append(file)
				continue
			if i.find(self.wh_library) > -1 :
				i = i.replace(self.wh_library, self.library)
				i = path_new+os.sep+i
				os.rename(source, i)
			else:
				i = path_new+os.sep+i
			new_ref_list.append(i)
		for i in new_ref_list:  # Copy New Files
			path = path_aix
			shutil.copy2(i, path)
		for i in diff_ref:
			path = path_aix
			i = i.replace(self.library, self.wh_library)
			source = path_ibpsa+os.sep+i
			target = path+os.sep+i.replace(self.wh_library, self.library)
			shutil.copy2(source, target)


if __name__ == '__main__':
	createFolder(path_new_mos)
	_CloneRepository()
	results = diff_ref(path_aix, path_ibpsa, path_diff, path_new)
	diff_ref = results[0]
	new_ref = results[1]
	add_new_ref(diff_ref, new_ref, path_aix, path_ibpsa, path_new, path_diff)
	mos_results = diff_mos(path_aix_mos, path_ibpsa_mos, path_diff_mos, path_new_mos)
	removeRoot = True
	removeEmptyFolders(path_diff_mos, removeRoot)
