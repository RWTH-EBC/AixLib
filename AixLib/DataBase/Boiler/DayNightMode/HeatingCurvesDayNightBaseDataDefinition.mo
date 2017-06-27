within AixLib.DataBase.Boiler.DayNightMode;
record HeatingCurvesDayNightBaseDataDefinition
  "Base data definition for heating curves for Day and Night"
extends Modelica.Icons.Record;
import SI = Modelica.SIunits;
import SIconv = Modelica.SIunits.Conversions.NonSIunits;

parameter String name "Name of data set";
parameter Real varFlowTempDay[:,:] "Variable flow temperature during day time";
parameter Real varFlowTempNight[:,:]
    "Variable flow temperature during night time (reduced)";

annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>
Base data defintion for boilers: Heating curves -  Tflow = f(Toutside) - for
night and day modes.
</p>
</html>",
    revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with
AixLib</li>
<li><i>July 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation
appropriately</li>
<li><i>Mai 23, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul>
</html>"),  preferredView="info");
end HeatingCurvesDayNightBaseDataDefinition;
