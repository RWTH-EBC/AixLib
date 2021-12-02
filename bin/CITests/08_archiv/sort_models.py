import os
import sys


class git_models(object):

	def __init__(self, file_type):
		self.file_type = file_type
		
	def sort_mo_models(self):
		list_path = 'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt' 
		#print(list_path)
		changed_models = open(list_path, "r")
		modelica_models = [] 
		Lines =  changed_models.readlines()
		for i in Lines:
			
			if i.rfind(".mo")>-1:
				#define modelica models
				model_number = i.rfind(" ")
				model_name = i[model_number:]
				model_name = model_name.lstrip()
				#model_name = model_name.replace(os.sep,".")
				model_name = model_name.replace('/',".")
				model_name = model_name[:model_name.rfind(".mo")]
				modelica_models.append(model_name)
				continue
			else:
				continue
		print(modelica_models)
		return modelica_models

if  __name__ == '__main__':
	# Import git_model class
	from sort_models import git_models
	list_mo_models = git_models(".mo")
	list_mo_models.sort_mo_models()
	