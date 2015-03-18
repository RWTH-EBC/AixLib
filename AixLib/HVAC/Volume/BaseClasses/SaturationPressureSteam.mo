within AixLib.HVAC.Volume.BaseClasses;
function SaturationPressureSteam
  import degc = Modelica.SIunits.Conversions.to_degC;
  input Modelica.SIunits.Temperature T "Temperature of Steam";
  output Modelica.SIunits.Pressure p_Saturation "Saturation Pressure of Steam";
algorithm
  p_Saturation := 611.657 * exp(17.2799 - 4102.99 / (degc(T) + 237.431));
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Function to calculate Saturation pressure for water / steam according to actual temperature.</p>
 <p>Equation according to Baehr &ndash; Thermodynamik 15. edition, ISBN: 3642241603:</p>
 <pre>   p_saturation = 611.657*e^(17.2799 - 4102.99/(T + 237.431));</pre>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end SaturationPressureSteam;

