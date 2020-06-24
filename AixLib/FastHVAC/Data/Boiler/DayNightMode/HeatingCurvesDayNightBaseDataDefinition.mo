within AixLib.FastHVAC.Data.Boiler.DayNightMode;
record HeatingCurvesDayNightBaseDataDefinition
  "Base data definition for heating curves for Day and Night"
extends Modelica.Icons.Record;
import SI = Modelica.SIunits;
import SIconv = Modelica.SIunits.Conversions.NonSIunits;

parameter String name "Name of data set";
parameter Real varFlowTempDay[:, :] "Variable flow temperature during day time";
parameter Real varFlowTempNight[:, :]
    "Variable flow temperature during night time (reduced)";

annotation (Documentation(info="<html><h4>
  <font color=\"#008000\">Overview</font>
</h4>
<p>
  Base data defintion for boilers: Heating curves - Tflow = f(Toutside)
  - for night and day modes.
</p>
<h4>
  <font color=\"#008000\">Level of Development</font>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars3.png\" alt=\"\" />
</p>
<h4>
  <font color=\"#008000\">References</font>
</h4>
<p>
  Base data definition for record used with <a href=
  \"HVAC.Components.HeatGenerators.Boiler.BoilerWithController\">HVAC.Components.HeatGenerators.Boiler.BoilerWithController</a>
</p>
</html>",
    revisions="<html><ul>
  <li>
    <i>July 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>Mai 23, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>"),  preferredView="info");
end HeatingCurvesDayNightBaseDataDefinition;
