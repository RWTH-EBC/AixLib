import os
import numpy as np
from pathlib import Path
import linecache


# Import dymola package
#from dymola.dymola_interface import DymolaInterface

# Start the interface



#dymola = DymolaInterface()

# Location of your local AixLib clone


# Location where to store the results
#dir_result = "<path/to/where/you/want/it>"

# Open AixLib
#dymola.openModel(path=os.path.join(dir_aixlib, 'package.mo'))

def set_ExampleModel(dir_aixlib):
	ExampleModel = []
	for root, dirs, files in os.walk(dir_aixlib):
		Model = root.split("\\")
		
		#print(Model)
		#print(Model[len(Model)-2])
		#for file in Path(str(root)).iterdir():
		#print(dirs)
		#print(root)
		if Model[len(Model)-2] == "Examples" :
			for i in range(0,len(files)-1,1):
				if files[i] != "package.mo" and files.suffix =='.mo':
					print(files[i])
					print(root)
				if files[i] == "package":
					continue
				
			RelationModel_Path = root 
			ExampleModel.append(RelationModel_Path)
			
	#print(dir_aixlib)
		
	#print(ExampleModel)
	



def SimulateModel(self,ExampleModel):
	# Translate any model you'd like to simulate
	dymola.translateModel('AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone')

	# Simulate the model
	output = dymola.simulateExtendedModel(
		problem='AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone',
		startTime=0.0,
		stopTime=3.1536e+07,
		outputInterval=3600,
		method="Dassl",
		tolerance=0.0001,
		resultFile=os.path.join(dir_result, 'demo_results'),
		finalNames=['thermalZone.TAir' ],
	)

	dymola.close()

dir_aixlib = r"C:\Users\sven-\Dropbox\EBC\09_Modelica_Library\AixLib"

	
if __name__ == "__main__":   
	set_ExampleModel(dir_aixlib)
	