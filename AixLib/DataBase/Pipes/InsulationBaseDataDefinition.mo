within AixLib.DataBase.Pipes;
record InsulationBaseDataDefinition
  "Definition of Parameter Values for insulation records"
    extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;

  // Constant chemical Values assumed
  parameter Real factor
    "Insulation thickness factor (e.g. thickness_iso = 1 x d_o)";
  parameter SI.Density d "Density of pipe material";
  parameter SI.ThermalConductivity lambda
    "Thermal Conductivity of pipe material";
  parameter SI.SpecificHeatCapacity c "Heat capacity of pipe material";

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Base data definition for insulation record </p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>Base data definition for record used with <a href=\"AixLib.Fluid.FixedResistances.Pipe\">AixLib.Fluid.FixedResistances.Pipe</a></p>
</html>",
        revisions="<html>
<ul>
<li><i>April 25, 2017 </i>by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>July 9, 2013&nbsp;</i> by Ole Odendahl:<br/>
Added documentation and formatted appropriately</li>
</ul>
</html>"));
end InsulationBaseDataDefinition;
