within AixLib.FastHVAC.Data.Boiler.General;
record BoilerTwoPointBaseDataDefinition
  "Basic data for boiler with two point characteristic"
  extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;
  import SIconv = Modelica.SIunits.Conversions.NonSIunits;

  parameter String name "Name of Boiler";
  parameter SI.Volume volume "Water volume of Boiler";
  parameter Real PressureDrop
    "Pressure drop coefficient, delta_p[Pa] = PD*Q_flow[m^3/s]^2";
  parameter SI.Power Q_nom
    "nominal heat power / thermal load, refering to net (inferior) calorific value";
  parameter SI.Power Q_min
    "minimal heat power / thermal load, refering to net (inferior) calorific value";
  parameter Real[:,2] eta "normal supply level";
  annotation (Documentation(info="<html><h4>
  <font color=\"green\">Overview</font>
</h4>
<p>
  Data set definition for real boilers. The Boiler has a two point (on/off) characteristic.
</p>
<h4>
  <font color=\"green\">Level of Development</font>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars3.png\">
</p>
<h4>
  <font color=\"green\">References</font>
</h4>
<p>
  Base data definition for record used with <a href=\"HVAC.Components.HeatGenerators.Boiler.BoilerWithController\">HVAC.Components.HeatGenerators.Boiler.BoilerWithController</a>
</p>
</html>", revisions="<html>
<ul>
  <li><i>June 19, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, renamed model</li>
  <li><i>June 23, 2006&nbsp;</i>
         by Ana Constantin:<br>
         expanded.</li>
</ul>
</html>"),    preferredView="info");
end BoilerTwoPointBaseDataDefinition;
