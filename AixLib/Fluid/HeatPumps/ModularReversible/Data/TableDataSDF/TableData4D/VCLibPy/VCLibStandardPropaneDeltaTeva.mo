within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4D.VCLibPy;
record VCLibStandardPropaneDeltaTeva
  "Map based on VCLib with Standard ref cycle and Propane and evaporator delta T variation"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4D.VCLibPy.Generic(
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    refrigerant="Propane",
    flowsheet="Standard",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/VCLibMap/4Ddata/Standard_Propane_dTeva.sdf");
end VCLibStandardPropaneDeltaTeva;
