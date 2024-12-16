within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy;
record VCLibStandardR410A
  "Map based on VCLib with Standard and R410A"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy.Generic(
    refrigerant="R410A",
    flowsheet="Standard",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/VCLibMap/Standard_R410A.sdf");
end VCLibStandardR410A;
