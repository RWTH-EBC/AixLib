within AixLib.HVAC.Volume.BaseClasses;

function DynamicViscosityMoistAir
  input Modelica.SIunits.Temperature T "Temperature of Steam";
  input Real X_Steam "mass fractions of steam to dry air m_s/m_a";
  output Modelica.SIunits.DynamicViscosity DynamicViscosity "Saturation Pressure of Steam";
algorithm
  DynamicViscosity := X_Steam / (1 + X_Steam) * DynamicViscositySteam(T) + 1 / (1 + X_Steam) * DynamicViscosityAir(T);
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Function to calculate Dynamic viscosity of moist Air.</p>
 <p>Equation according to Bernd Gl&uuml;ck &ndash; Zustands- und Stoffwerte, ISBN: 3-345-00487-9:</p>
 <pre>  DynamicViscosityMoistAir =  X_Steam / (1 + X_Steam) * DynamicViscositySteam + 1 / (1 + X_Steam) * DynamicViscosityAir</pre>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end DynamicViscosityMoistAir;