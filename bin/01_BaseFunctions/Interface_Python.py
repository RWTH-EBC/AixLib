import os
import sys

# Import dymola package
from dymola.dymola_interface import DymolaInterface

# Start the interface
dymola = DymolaInterface()

# Location of your local AixLib clone
dir_aixlib = /AixLib

# Location where to store the results
dir_result = /Results

# Open AixLib
dymola.openModel(path=os.path.join(dir_aixlib, 'package.mo'))

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