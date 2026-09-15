within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy;
record VCLibStandardPropaneHeaDefCooHEA
  "Map based on VCLib with Standard and Propane for Heating"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy.Generic(
    refrigerant="Propane",
    flowsheet="Standard",
    filename="modelica://hydraulics/Resources/Data/HeatPumps/Heating/Standard_Propane.sdf");
end VCLibStandardPropaneHeaDefCooHEA;
