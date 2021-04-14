import os
import sys

import codecs

class git_models(object):

	def __init__(self, file_type,package):
		self.file_type = file_type
		self.package = package
		
	def sort_mo_models(self):
		list_path = 'bin'+os.sep+'03_WhiteLists'+os.sep+'changedmodels.txt' 
		#print(list_path)
		changed_models = codecs.open(list_path, "r", encoding='utf8')
		modelica_models = [] 
		Lines =  changed_models.readlines()
		Line= str(Lines)
		Line = Line.split(":")
		for i in Line:
			if i.rfind(".mos")>-1:
				continue
			if i.rfind(".mo")> -1:
				#define modelica models
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
	from sort_models import git_models
	list_mo_models = git_models(".mo","AixLib")
	list_mo_models.sort_mo_models()
	