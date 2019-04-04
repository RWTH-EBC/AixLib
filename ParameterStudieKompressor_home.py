# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import os

# Import dymola package
from dymola.dymola_interface import DymolaInterface

# Start the interface
dymola = DymolaInterface()

# Location of your local AixLib clone
dir_aixlib = 'C:/Users/Stephan-ZenBook/sciebo/Masterarbeit/Kompressor/AixLib'
dir_compresssor = 'C:/Users/Stephan-ZenBook/sciebo/Masterarbeit/Kompressor/PhysicalCompressors'

# Location where to store the results
dir_result = 'C:/Users/Stephan-ZenBook/sciebo/Masterarbeit/Kompressor/results'

# Open AixLib
dymola.openModel(path=os.path.join(dir_aixlib, 'package.mo'))
dymola.openModel(path=os.path.join(dir_compresssor, 'package.mo'))

# Translate any model you'd like to simulate
dymola.translateModel('PhysicalCompressors.Example.ReciprocatingCompressor2')

# Simulate the model
output = dymola.simulateExtendedModel(
    problem='PhysicalCompressors.Example.ReciprocatingCompressor2',
    startTime=0.0,
    stopTime=2,
    outputInterval=20000,
    method="Euler",
    tolerance=1e-5,
    resultFile=os.path.join(dir_result, 'demo_results'),
    finalNames=['ReciprocatingCompressor2.Test' ],
)

dymola.close()
print(output)