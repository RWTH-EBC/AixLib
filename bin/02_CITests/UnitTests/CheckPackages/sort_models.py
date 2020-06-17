import os
import sys

import codecs

class git_models(object):

	def __init__(self, file_type,package,list_path):
		self.file_type = file_type
		self.package = package
		self.list_path = list_path
		
	def sort_mo_models(self):
		#list_path = ".."+os.sep+'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt' 
		#print(list_path)
		changed_models = codecs.open(self.list_path, "r", encoding='utf8')
		modelica_models = [] 
		Lines =  changed_models.readlines()
		Line= str(Lines)
		Line = Line.split(":")
		for i in Line:
			if i.rfind(".mo")> -1:
				#define modelica models
				i = i.replace(os.sep,".")
				model_number = i.rfind(self.package)
				model_name = i[model_number:]
				model_name = model_name.lstrip()
				model_name = model_name.replace(os.sep,".")
				model_name = model_name[:model_name.rfind(".mo")]
				model_name = model_name.replace("..",".")
				modelica_models.append(model_name)
				continue
			else:
				continue
		changed_models.close()
		if len(modelica_models) == 0:
			print("No Models to check")
			exit(0)
		return modelica_models

if  __name__ == '__main__':
	# Import git_model class
	list_path = ".."+os.sep+'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt'
	from sort_models import git_models
	list_mo_models = git_models(".mo","AixLib",list_path)
	list_mo_models.sort_mo_models()
	