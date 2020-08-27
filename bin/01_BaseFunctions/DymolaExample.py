import platform

from dymola.dymola_interface import DymolaInterface
from dymola.dymola_exception import DymolaException

osString = platform.system()
isWindows = osString.startswith("Win")

dymola = None
try:
    # Instantiate the Dymola interface and start Dymola
    dymola = DymolaInterface()

    # Call a function in Dymola and check its return value
    result = dymola.simulateModel("Modelica.Mechanics.Rotational.Examples.CoupledClutches")
    if not result:
        print("Simulation failed. Below is the translation log.")
        log = dymola.getLastErrorLog()
        print(log)
        exit(1)

    dymola.plot(["J1.w", "J2.w", "J3.w", "J4.w"])
    if (isWindows):
        plotPath = "C:/temp/plot.png"
    else:
        plotPath = "/tmp/plot.png";
    dymola.ExportPlotAsImage(plotPath)
    print("OK")
except DymolaException as ex:
    print(("Error: " + str(ex)))
finally:
    if dymola is not None:
        dymola.close()
        dymola = None
