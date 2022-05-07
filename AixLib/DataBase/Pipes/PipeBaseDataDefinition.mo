within AixLib.DataBase.Pipes;
record PipeBaseDataDefinition
  "Base data definition of parameter values for pipes"
  extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;

  // Constant chemical values assumed
  parameter SI.Diameter d_i "Inner pipe diameter";
  parameter SI.Diameter d_o "Outer pipe diameter";
  parameter SI.Density d "Density of pipe material";
  parameter SI.ThermalConductivity lambda
    "Thermal conductivity of pipe material";
  parameter SI.SpecificHeatCapacity c "Heat capacity of pipe material";

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Base data definition for pipes
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add comments and fix documentation
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Sebastian Stinner:<br/>
    Transferred to AixLib
  </li>
  <li>
    <i>July 9, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end PipeBaseDataDefinition;
