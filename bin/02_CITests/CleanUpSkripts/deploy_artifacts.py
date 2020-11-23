import os
import codecs
import sys
import shutil
def read_artifacts(path):
	artifact = open(path,"r")
	
def sort_mo_models():
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
			if i.find("Resources")> -1:
				if i.rfind(".txt")> -1:
					i = i.lstrip()
					i = i[i.find("Resources"):i.find("txt")+3]
					i = "AixLib"+os.sep+i
					modelica_models.append(i)
					#define modelica models
					#model_number = i.rfind(self.package)
					#model_name = i[model_number:]
					#model_name = model_name.lstrip()
					#model_name = model_name.replace(os.sep,".")
					#model_name = model_name[:model_name.rfind(".mo")]
					#model_name = model_name.replace("..",".")
					#modelica_models.append(i)
					continue
				else:
					continue
		changed_models.close()
		
		#print(modelica_models)
		return modelica_models

	
	
def copy_txt(reffile):
	os.mkdir('Referencefiles')
	for i in reffile:
		refName = i.split(os.sep)
		refName = refName[len(refName)-1]
		#print(refName)
		try:
			shutil.copy(i, 'Referencefiles'+os.sep+refName)
		except FileNotFoundError:
			print("Cant find Referencefiles"+os.sep+refName)
			continue
			
if  __name__ == '__main__':
	try:
		'''parser = argparse.ArgumentParser(description='Run the unit tests or the html validation only.')
		unit_test_group = parser.add_argument_group("arguments to run unit tests")
		unit_test_group.add_argument("-p", "--path",
							default = ".",
							help="Path where top-level package.mo of the library is located")'''
		reffile = sort_mo_models()
		copy_txt(reffile)
	except FileNotFoundError:
		print("Can´t find file!")
