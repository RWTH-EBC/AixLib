within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4D.VCLibPy_dTEva;
record StandardPropane
  "Map based on VCLib with Standard ref cycle and Propane and evaporator delta T variation"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4D.VCLibPy_dTEva.Generic
                                                                                                (
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    refrigerant="Propane",
    flowsheet="Standard",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/VCLibMap/4Ddata/Standard_Propane_dTeva.sdf");
  annotation (Documentation(revisions="<html>
<ul>
<li><i>October 09, 2025</i>, by Hannah Vering:<br>First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1602\">AixLib #1602</a>) </li>
</ul>
</html>"));
end StandardPropane;
