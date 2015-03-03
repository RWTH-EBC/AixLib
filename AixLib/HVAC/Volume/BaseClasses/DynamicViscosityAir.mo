within AixLib.HVAC.Volume.BaseClasses;


function DynamicViscosityAir
  import degc = Modelica.SIunits.Conversions.to_degC;
  input Modelica.SIunits.Temperature T "Temperature of Steam";
  output Modelica.SIunits.DynamicViscosity DynamicViscosity
    "Saturation Pressure of Steam";
algorithm
  DynamicViscosity := 1.72436e-5 + 5.04587e-8 * degc(T) - 3.923361e-11 * degc(T) ^ 2 + 4.046118e-14 * degc(T) ^ 3;
  annotation(Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Function to calculate Dynamic viscosity of dry Air. </p>
<p>Equation according to Bernd Glueck &ndash; Zustands- und Stoffwerte, ISBN: 3-345-00487-9: </p>
<p><code>   DynamicViscosity = 1.72436e-5 + 5.04587e-8*T - 3.923361e-11 * T^2 + 4.046118e-14 * T^3;</code> </p>
</html>",  revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end DynamicViscosityAir;
