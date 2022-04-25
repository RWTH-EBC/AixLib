within AixLib.DataBase.WindowsDoors.Simple;
record OWBaseDataDefinition_Simple
  "Window base definition"
  extends Modelica.Icons.Record;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer Uw
    "Thermal transmission coefficient of whole window: glass + frame";
  parameter Real frameFraction(min=0.0, max=1.0) = 0.2
    "frame fraction from total fenestration area";
  parameter Real g = 0.7 "coefficient of solar energy transmission";
  annotation(Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Base data definition for simple windows.
</p>
<p>
  Parameter <code>g</code> might be irrelevant, depening on calculation
  model used from <a href=
  \"AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain\">
  AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain</a>.
</p>
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<p>
  Base data definition for record to be used in model <a href=
  \"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a>
</p>
<ul>
  <li>July 22, 2020, by Philipp Mehrfeld:<br/>
    Deleted Emissivity, which is part of panes record.
  </li>
  <li>
    <i>September 11, 2013:</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end OWBaseDataDefinition_Simple;
