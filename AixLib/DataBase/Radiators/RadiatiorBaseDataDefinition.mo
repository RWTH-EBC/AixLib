within AixLib.DataBase.Radiators;
record RadiatiorBaseDataDefinition "Base Data Definition for Radiators"
      extends Modelica.Icons.Record;
  parameter Real NominalPower
    "Nominal power of radiator at nominal temperatures in W ";
  parameter Modelica.SIunits.Temperature T_flow_nom( displayUnit = "degC")
    "Nominal temperatures T_flow according to DIN-EN 442. in degC";
  parameter Modelica.SIunits.Temperature T_return_nom( displayUnit = "degC")
    "Nominal temperatures T_return according to DIN-EN 442.in deg C";
  parameter Modelica.SIunits.Temperature T_room_nom( displayUnit = "degC")
    "Nominal temperatures T_room according to DIN-EN 442. in deg C";

  parameter Real Exponent=1.29 annotation (Dialog(group="Geometry"));
  parameter Real VolumeWater(unit="l") "Water volume inside radiator in l";
  parameter Real MassSteel(unit="kg") "Material mass of radiator in kg";
  parameter Real RadPercent "Percent of radiative heat";

  parameter Modelica.SIunits.Length length "Length of radiator in m";
  parameter Modelica.SIunits.Height height "Height of radiator in m";

  annotation (Documentation(revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Record for a radiator.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The record contains information about the:</p>
<ul>
<li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
<li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
<li>Exponent</li>
<li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
<li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
<li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
<li>Length of radiator in m</li>
<li>Height of radiator in m</li>
</ul>
<p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
</html>"));
end RadiatiorBaseDataDefinition;
