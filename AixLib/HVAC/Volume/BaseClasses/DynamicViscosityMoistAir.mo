within AixLib.HVAC.Volume.BaseClasses;


function DynamicViscosityMoistAir
  input Modelica.SIunits.Temperature T "Temperature of Steam";
  input Real X_Steam "mass fractions of steam to dry air m_s/m_a";
  output Modelica.SIunits.DynamicViscosity DynamicViscosity
    "Saturation Pressure of Steam";
algorithm
  DynamicViscosity := X_Steam / (1 + X_Steam) * DynamicViscositySteam(T) + 1 / (1 + X_Steam) * DynamicViscosityAir(T);
  annotation(Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Function to calculate Dynamic viscosity of moist Air. </p>
<p>Equation according to Bernd Glueck &ndash; Zustands- und Stoffwerte, ISBN: 3-345-00487-9: </p>
<p><code>  DynamicViscosityMoistAir =  X_Steam / (1 + X_Steam) * DynamicViscositySteam + 1 / (1 + X_Steam) * DynamicViscosityAir</code> </p>
</html>",  revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end DynamicViscosityMoistAir;
