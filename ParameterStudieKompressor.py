# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import os
import numpy
# Import dymola package
from dymola.dymola_interface import DymolaInterface
#from numba import autojit, prange
# Start the interface
dymola = DymolaInterface()

#used Refrigerant
ref = 'R410A'

# Location of your local AixLib clone
dir_aixlib = 'D:\Stephan\Sciebo\Masterarbeit\AixLib\AixLib'
dir_compresssor = 'D:\Stephan\Sciebo\Masterarbeit\Kompressor\PhysicalCompressors' 

# Location where to store the results
dir_result = 'D:\Stephan\Sciebo\Masterarbeit\Kompressor\Parameterstudie\Simulationsergebnisse\R410A_30Hz'

# Open AixLib
dymola.openModel(path=os.path.join(dir_aixlib, 'package.mo'))
dymola.openModel(path=os.path.join(dir_compresssor, 'package.mo'))
modelname = 'PhysicalCompressors.ReciprocatingCompressor.Example.ReciprocatingCompressor_' + str(ref)

#Condenser in
p_start = 10e5 
p_end = 50e5
step = 1e5
con_in = numpy.arange(p_start,p_end+1,step)
#Evaporator out
p_evap = 4e5
T_evap = 290.15
#Speed
omega = 188.5

for i in range(0,con_in.size):
    parameter ='(Condenser_in.p =' + str(con_in[i]) + ',Evaporator_out.p =' + str(p_evap) + ',Evaporator_out.T =' + str(T_evap) +  ',constantSpeed.w_fixed =' + str(omega) + ')'
    model = modelname + parameter
    name_result = str(ref) + '_pCon'  + str(con_in[i])
# Translate any model you'd like to simulate
    dymola.translateModel(model)

# Simulate the model
    output1 = dymola.simulateExtendedModel(
                problem=model,
                startTime=0.0,
                stopTime=20,
                outputInterval=0.001,
                method="Dassl",
                tolerance=1e-5,
                resultFile=os.path.join(dir_result, name_result + 'Dassl'),
                finalNames=['ReciprocatingCompressor2' ])
        
#    output2 = dymola.simulateExtendedModel(
#                problem=model,
#                startTime=0.0,
#                stopTime=20,
#                outputInterval=0.001,
#                method="Euler",
#                tolerance=1e-5,
#                resultFile=os.path.join(dir_result, name_result + 'Euler'),
#                finalNames=['ReciprocatingCompressor2' ])

    
    print(output1[0])
#    print(output2[0])
    print('Done until p=' + str(con_in[i]))
    
dymola.close()