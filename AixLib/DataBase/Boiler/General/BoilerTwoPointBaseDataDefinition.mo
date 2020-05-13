within AixLib.DataBase.Boiler.General;
record BoilerTwoPointBaseDataDefinition
  "Basic data for boiler with two point characteristic"
  extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;

  parameter String name
    "Name of boiler";
  parameter SI.Volume volume
    "Water volume of boiler";
  parameter Real pressureDrop
    "Pressure drop coefficient, delta_p[Pa] = PD*Q_flow[m^3/s]^2";
  parameter SI.Power Q_nom
    "Nominal heat power / thermal load, refering to net (inferior) calorific value";
  parameter SI.Power Q_min
    "Minimal heat power / thermal load, refering to net (inferior) calorific value";
  parameter Real[:,2] eta "Normal supply level";
  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>
Data set definition for real boilers. The Boiler has a two point (on/off)
characteristic.
</p>
</html>", revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with
AixLib</li>
<li><i>June 19, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation
appropriately, renamed model</li>
<li><i>June 23, 2006&nbsp;</i>by Ana Constantin:<br/>expanded.</li>
</ul>
</html>"),    preferredView="info");
end BoilerTwoPointBaseDataDefinition;
