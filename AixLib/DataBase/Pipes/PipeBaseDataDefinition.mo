within AixLib.DataBase.Pipes;
record PipeBaseDataDefinition
  "Base data definition of parameter values for pipes"
    extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;

  // Constant chemical Values assumed
  parameter SI.Diameter d_i "Inner pipe diameter";
  parameter SI.Diameter d_o "Outer pipe diameter";
  parameter SI.Density d "Density of pipe material";
  parameter SI.ThermalConductivity lambda
    "Thermal Conductivity of pipe material";
  parameter SI.SpecificHeatCapacity c "Heat capacity of pipe material";

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base data definition for pipes
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definition for record used with <a href=\"HVAC.Components.Pipes.DynamicPipeEBC1\">HVAC.Components.Pipes.DynamicPipeEBC1</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>July 9, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end PipeBaseDataDefinition;
