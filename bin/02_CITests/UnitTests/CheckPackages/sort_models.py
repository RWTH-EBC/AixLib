import os
import sys

import codecs

class git_models(object):

	def __init__(self, file_type,package,list_path):
		self.file_type = file_type
		self.package = package
		self.list_path = list_path
	
	def sort_mos_script(self):
		#list_path = ".."+os.sep+'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt' 
		changed_models = codecs.open(self.list_path, "r", encoding='utf8')
		mos_scripts = [] 
		Lines =  changed_models.readlines()
		Line= str(Lines)
		Line = Line.split(":")
		for i in Line:
			if i.rfind(".mos")> -1:
				
				if i.rfind("Scripts")>-1:
					#define modelica models
					i = i.replace("/",".")
					i = i.replace(os.sep,".")
					i = i.replace("..",".")
					i = i.replace("Dymola","AixLib")
					model_number = i.rfind(self.package)
					if i.find(".package") > -1:
						continue
					if model_number > -1:
						model_name = i[model_number:]
						model_name = model_name.lstrip()
						model_name = model_name.replace(os.sep,".")
						model_name = model_name[:model_name.rfind(".mos")]
						model_name = model_name.replace("..",".")
						mos_scripts.append(model_name)
						#print(mos_scripts)
						continue
					else:
						continue
				else:
					continue
			changed_models.close()
		return mos_scripts
	
	def sort_reference_txt(self):
		#list_path = ".."+os.sep+'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt' 
		changed_models = codecs.open(self.list_path, "r", encoding='utf8')
		reference_files = [] 
		Lines =  changed_models.readlines()
		Line= str(Lines)
		Line = Line.split(":")
		package = self.package.replace(".","_")
		for i in Line:
			if i.rfind(".txt")> -1:
				if i.rfind("ReferenceResults")>-1:
					#define modelica models
					i = i.replace("/",".")
					i = i.replace(os.sep,".")
					i = i.replace("..",".")
					model_number = i.rfind(package)
					if i.find(".package") > -1:
						continue
					if model_number > -1:
						model_name = i[model_number:]
						model_name = model_name.lstrip()
						model_name = model_name.replace(os.sep,".")
						model_name = model_name[:model_name.rfind(".txt")]
						model_name = model_name.replace("..",".")
						model_name = model_name.replace("_",".")
						reference_files.append(model_name)
						continue
					else:
						continue
				else:
					continue
			changed_models.close()
		return reference_files
	
	def sort_mo_models(self):
		#list_path = ".."+os.sep+'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt' 
		changed_models = codecs.open(self.list_path, "r", encoding='utf8')
		modelica_models = [] 
		Lines =  changed_models.readlines()
		Line= str(Lines)
		Line = Line.split(":")
		for i in Line:
			if i.rfind(".mo")> -1:
				#define modelica models
				i = i.replace("/",".")
				i = i.replace(os.sep,".")
				i = i.replace("..",".")
				model_number = i.rfind(self.package)
				if i.find(".package") > -1:
					continue
				if model_number > -1:
					model_name = i[model_number:]
					model_name = model_name.lstrip()
					model_name = model_name.replace(os.sep,".")
					model_name = model_name[:model_name.rfind(".mo")]
					model_name = model_name.replace("..",".")
					modelica_models.append(model_name)
					continue
				else:
					continue
			else:
				continue
		changed_models.close()
		return modelica_models

if  __name__ == '__main__':
	# Import git_model class
	#list_path = ".."+os.sep+'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt'
	list_path = 'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt'
	
	from sort_models import git_models
	list_mo_models = git_models(".mo","AixLib.Utilities",list_path)
	list_mo_models.sort_mo_models()
	