# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import os
import numpy
#import multiprocessing
import multiprocessing as mp
# Import dymola package
from dymola.dymola_interface import DymolaInterface
#from numba import autojit, prange
# Start the interface
dymola = DymolaInterface()

# Location of your local AixLib clone
dir_aixlib = 'D:\Stephan\Sciebo\Masterarbeit\AixLib\AixLib'
dir_compresssor = 'D:\Stephan\Sciebo\Masterarbeit\Kompressor\PhysicalCompressors'

# Location where to store the results
dir_result = 'D:\Stephan\Sciebo\Masterarbeit\Kompressor\Parameterstudie\Simulationsergebnisse\R744'

# Open AixLib
dymola.openModel(path=os.path.join(dir_aixlib, 'package.mo'))
dymola.openModel(path=os.path.join(dir_compresssor, 'package.mo'))
modelname = 'PhysicalCompressors.Example.ReciprocatingCompressor_R134a'

#Condenser in
p_start = 5e5 
p_end = 10e5
step = 5e4
con_in = numpy.arange(p_start,p_end+1,step)

def parsim(con_in):
#Evaporator out
    p_evap = 2.93e5
    T_evap = 290.15


    parameter ='(Condenser_in.p =' + str(con_in) + ',Evaporator_out.p =' + str(p_evap) + ',Evaporator_out.T =' + str(T_evap) + ')'
    model = modelname + parameter
    name_result = 'R744_pCon'  + str(con_in)
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
    print('Done until p=' + str(con_in))
    return output1

#Def parpool
pool = mp.Pool(processes=4)
results = pool.map(parsim, range(0,con_in.size))
    
dymola.close()