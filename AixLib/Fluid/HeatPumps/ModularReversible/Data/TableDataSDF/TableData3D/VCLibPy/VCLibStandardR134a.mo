within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy;
record VCLibStandardR134a
  "Map based on VCLib with Standard and R134a"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy.Generic(
    refrigerant="R134a",
    flowsheet="Standard",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/VCLibMap/Standard_R134a.sdf");
end VCLibStandardR134a;
