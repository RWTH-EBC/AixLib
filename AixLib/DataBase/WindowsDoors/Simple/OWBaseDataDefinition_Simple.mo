within AixLib.DataBase.WindowsDoors.Simple;
record OWBaseDataDefinition_Simple
  "Outer window base definition for simple model"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw = 2.875
    "Thermal transmission coefficient of whole window: glass + frame";
  parameter Real g = 0.8 "coefficient of solar energy transmission";
  parameter Modelica.SIunits.Emissivity Emissivity = 0.84 "Material emissivity";
  parameter Real frameFraction = 0.2
    "frame fraction from total fenestration area";
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Base data definition for simple windows.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record to be used in model <a href=
  \"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a>
</p>
<ul>
  <li>
    <i>September 11, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end OWBaseDataDefinition_Simple;
