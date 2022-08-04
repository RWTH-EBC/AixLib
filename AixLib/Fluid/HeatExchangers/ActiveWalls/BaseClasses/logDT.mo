within AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses;
function logDT

  import Modelica.Math.log;

  input Modelica.Units.SI.Temperature Temp_in[3];
  output Modelica.Units.SI.Temperature Temp_out;

algorithm
Temp_out :=(Temp_in[1] - Temp_in[2])/log((Temp_in[1] - Temp_in[3])/(Temp_in[2] -
    Temp_in[3]));

  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>June 15, 2017&#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>November 06, 2014&#160;</i> by Ana Constantin:<br/>
    Added documentation.
  </li>
</ul>
</html>",
      info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Calculation of the logarithmic over temperature.
</p>
</html>"));
end logDT;
