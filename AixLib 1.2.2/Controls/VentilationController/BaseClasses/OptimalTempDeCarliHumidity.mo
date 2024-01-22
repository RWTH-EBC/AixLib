within AixLib.Controls.VentilationController.BaseClasses;
model OptimalTempDeCarliHumidity
  "optimal operative Temperature according to Fanger and deCarli model including humidity evaluation"

  import Modelica.Units.Conversions.from_degC;
  import Modelica.Units.Conversions.to_degC;

  extends Modelica.Blocks.Interfaces.MIMO(nin=2, nout=3);
  //  u is 1. ambient temperature and 2. relative humidity; y is Min and max temperatures according to input temperature
  parameter Modelica.Units.SI.TemperatureDifference cat=2
    "offset for quality category. cat I: 1 K, cat. II: 2 K, cat. III: 3 K.";
  Modelica.Units.SI.ThermodynamicTemperature Topt;
protected
  parameter Modelica.Units.SI.Temperature Tclomax=from_degC(0)
    "mean outdoor air temperature when max clo value of 1.0 will be reached";
  parameter Modelica.Units.SI.Temperature Tclomin=from_degC(27.778)
    "mean outdoor air temperature when min clo value of 0.5 will be reached";

equation
  if u[1] <= Tclomax then
    Topt =from_degC(AixLib.Utilities.Math.Functions.polynomial(to_degC(Tclomax),
      AixLib.Controls.VentilationController.BaseClasses.coefficients(u[2])))
      "minimum optimal temperature";
  elseif u[1] >= Tclomin then
    Topt =from_degC(AixLib.Utilities.Math.Functions.polynomial(to_degC(Tclomin),
      AixLib.Controls.VentilationController.BaseClasses.coefficients(u[2])))
      "const. Temp. above 0.5 clo limit";
  else
    Topt =from_degC(AixLib.Utilities.Math.Functions.polynomial(to_degC(u[1]),
      AixLib.Controls.VentilationController.BaseClasses.coefficients(u[2])));
  end if;
  y = {Topt - cat,Topt + cat,Topt} "min, max, opt";

  annotation (Diagram(graphics), Documentation(info="<html><p>
  u:
</p>
<ol>
  <li>ambient&#160;temperature&#160;and
  </li>
  <li>relative&#160;humidity
  </li>
</ol>
<p>
  y:
</p>
<ol>
  <li>Tmin
  </li>
  <li>Tmax
  </li>
  <li>Topt
  </li>
</ol>
<ul>
  <li>
    <i>April, 2016&#160;</i> by Peter Remmen:<br/>
    Moved from Utilities to Controls
  </li>
</ul>
<ul>
  <li>
    <i>October, 2015&#160;</i> by Moritz Lauster:<br/>
    Adapted and moved to AixLib
  </li>
</ul>
<ul>
  <li>
    <i>May, 2008&#160;</i> by Peter Matthes:<br/>
    Implemented
  </li>
</ul>
</html>"));
end OptimalTempDeCarliHumidity;
