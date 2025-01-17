within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy;
record VCLibStandardPropane
  "Map based on VCLib with Standard and Propane"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy.Generic(
    refrigerant="Propane",
    flowsheet="Standard",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/VCLibMap/Standard_Propane.sdf");
end VCLibStandardPropane;
