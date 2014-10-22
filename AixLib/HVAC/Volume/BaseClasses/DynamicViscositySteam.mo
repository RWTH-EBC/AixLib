within AixLib.HVAC.Volume.BaseClasses;
function DynamicViscositySteam
import degc = Modelica.SIunits.Conversions.to_degC;
input Modelica.SIunits.Temperature T "Temperature of Steam";

output Modelica.SIunits.DynamicViscosity   DynamicViscosity
    "Saturation Pressure of Steam";

algorithm
  DynamicViscosity :=  9.1435e-6 + 2.81979e-8 * degc(T) + 4.486993e-11 * degc(T)^2 - 4.928814e-14 * degc(T)^3;
annotation (
Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Function to calculate Dynamic viscosity of Steam.</p>
<p>Equation according to Bernd Gl&uuml;ck &ndash; Zustands- und Stoffwerte, ISBN: 3-345-00487-9:</p>
<pre>   DynamicViscosity =  9.1435e-6 + 2.81979e-8 * T + 4.486993e-11 * T^2 - 4.928814e-14 * T^3;</pre>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
end DynamicViscositySteam;
