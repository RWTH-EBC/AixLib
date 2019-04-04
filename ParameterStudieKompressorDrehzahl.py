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
ref = 'R32'

# Location of your local AixLib clone
dir_aixlib = 'D:\Stephan\Sciebo\Masterarbeit\AixLib\AixLib'
dir_compresssor = 'D:\Stephan\Sciebo\Masterarbeit\Kompressor\PhysicalCompressors' 

# Location where to store the results
dir_result = 'D:\Stephan\Sciebo\Masterarbeit\Kompressor\Parameterstudie\Simulationsergebnisse\R32_varN'

# Open AixLib
dymola.openModel(path=os.path.join(dir_aixlib, 'package.mo'))
dymola.openModel(path=os.path.join(dir_compresssor, 'package.mo'))
modelname = 'PhysicalCompressors.ReciprocatingCompressor.Example.ReciprocatingCompressor_' + str(ref)

#Condenser in
con_in = 62.93e5

#Evaporator out
p_evap = 8.131e5
T_evap = 290.15
#Speed
omega_start = 100
omega_end = 400
step = 20
omega = numpy.arange(omega_start,omega_end+1,step)
omega = omega[::-1]
for i in range(0,omega.size):
    parameter ='(Condenser_in.p =' + str(con_in) + ',Evaporator_out.p =' + str(p_evap) + ',Evaporator_out.T =' + str(T_evap) +  ',constantSpeed.w_fixed =' + str(omega[i]) + ')'
    model = modelname + parameter
    name_result = str(ref) + '_n'  + str(omega[i]) + 'radpers'
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
    print('Done until p=' + str(omega[i]))
    
dymola.close()