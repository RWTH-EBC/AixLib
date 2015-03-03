within AixLib.HVAC.HeatExchanger;
partial model RecuperatorNoMediumVarcp
  "recuperator model with selectable flow arrangement and variable cp for integration with media model."
  parameter Integer flowType = 3 "Flow type" annotation(choices(choice = 1 "counter", choice = 2 "co", choice = 3 "cross", radioButtons = true));
  parameter Modelica.SIunits.Temperature T1in0 = 273.15 + 5
    "Medium 1 inlet temperature at design point";
  parameter Modelica.SIunits.Temperature T1out0 = 295.495
    "Medium 1 inlet temperature at design point";
  parameter Modelica.SIunits.Temperature T2in0 = 273.15 + 26
    "Medium 2 inlet temperature at design point";
  parameter Modelica.SIunits.Temperature T2out0 = 282.0586
    "Medium 2 inlet temperature at design point";
  parameter Modelica.SIunits.MassFlowRate m_flow10 = 0.079866
    "mass flow rate at design point";
  parameter Modelica.SIunits.MassFlowRate m_flow20 = 0.079883
    "mass flow rate at design point";
  final parameter Modelica.SIunits.ThermalConductance C10 = m_flow10 * 1011
    "Heat capacity flow rate of medium 1 at design point";
  final parameter Modelica.SIunits.ThermalConductance C20 = m_flow20 * 1011
    "Heat capacity flow rate of medium 2 at design point";
  final parameter Real epsilon0 = C10 / min(C10, C20) * (T1out0 - T1in0) / (T2in0 - T1in0)
    "Heat exchanger characterisic in design point";
  final parameter Real Z0 = min(C10, C20) / max(C10, C20)
    "heat capacity flow ratio";
  parameter Real expo = 0.78
    "exponent. h = 7.2 * v^0.78 [W/(m2.K)]. 5 <= v <= 30 m/s. See Jurges 1924.";
  final parameter Real r = (m_flow10 * (T1in0 + T1out0) / 2 / (m_flow20 * (T2in0 + T2out0) / 2)) ^ expo
    "(hA)10/(hA)20 ";
  Real NTU0(start = 4.57158) "Number of transfer units at design point";
  discrete Modelica.SIunits.ThermalConductance UA0
    "U * A value at design condition";
  Real NTU(nominal = 4.57158) "Number of transfer units";
  Real epsilon(nominal = epsilon0, start = epsilon0)
    "Heat exchanger characteristic";
  Real Z "Ratio of heat capacity flow rates";
  Modelica.SIunits.Power Q "transfered thermal power";
  Modelica.SIunits.ThermalConductance UA "U * A value";
  Modelica.SIunits.ThermalConductance C1 "Heat capacity flow rate of medium 1";
  Modelica.SIunits.ThermalConductance C2 "Heat capacity flow rate of medium 2";
  Modelica.SIunits.Temperature T1in(nominal = T1in0) "standard: colder medium";
  Modelica.SIunits.Temperature T1out(nominal = T1out0);
  Modelica.SIunits.Temperature T2in(nominal = T2in0) "standard: warmer medium";
  Modelica.SIunits.Temperature T2out(nominal = T2out0);
  Modelica.SIunits.MassFlowRate m1in(nominal = m_flow10);
  Modelica.SIunits.MassFlowRate m2in(nominal = m_flow20);
  Modelica.SIunits.SpecificHeatCapacity cp1(min = 900, max = 1300, start = 1011, nominal = 1011)
    "Specific heat capacity of medium 1. Will be provided by media model";
  Modelica.SIunits.SpecificHeatCapacity cp2(min = 900, max = 1300, start = 1011, nominal = 1011)
    "Specific heat capacity of medium 2. Will be provided by media model";
equation
  when initial() then
    UA0 = NTU0 * min(C10, C20);
  end when;
  if flowType == 1 then
    NTU0 = if abs(1 - Z0) < Modelica.Constants.eps then epsilon0 / (1 - epsilon0) else 1 / (Z0 - 1) * log((1 - epsilon0) / (1 - epsilon0 * Z0))
      "counter-current flow";
  elseif flowType == 2 then
    NTU0 = -log((-epsilon0) - epsilon0 * Z0 + 1) / (Z0 + 1) "co-current flow";
  else
    exp((exp(-NTU0 ^ 0.78 * Z0) - 1) / (Z0 * NTU0 ^ (-0.22))) = 1 - epsilon0
      "cross flow (no explicit formula available)";
  end if;
  UA = UA0 * (1 + r) / ((m_flow10 * T1in0 / abs(m1in * T1in)) ^ expo + r * (m_flow20 * T2in0 / abs(m2in * T2in)) ^ expo);
  C1 = m1in * cp1;
  C2 = m2in * cp2;
  Z = min(C1, C2) / max(C1, C2);
  NTU = UA / min(C1, C2);
  if flowType == 1 then
    epsilon = if abs(1 - Z) < Modelica.Constants.eps then 1 / (1 + 1 / NTU) else (1 - exp(-NTU * (1 - Z))) / (1 - Z * exp(-NTU * (1 - Z)))
      "counter-current flow";
  elseif flowType == 2 then
    epsilon = (1 - exp(-NTU * (1 + Z))) / (1 + Z) "co-current flow";
  else
    epsilon = 1 - exp((exp(-NTU * Z * NTU ^ (-0.22)) - 1) / (Z * NTU ^ (-0.22)))
      "cross flow";
  end if;
  T1out = T1in + epsilon * min(C1, C2) / C1 * (T2in - T1in);
  Q = C1 * (T1out - T1in);
  T2out = T2in - Q / C2;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points=  {{-80, 80}, {-80, -80}, {80, 80}, {-80, 80}}, lineColor=  {175, 175, 175}, smooth=  Smooth.None, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid), Polygon(points=  {{-80, -80}, {80, -80}, {80, 80}, {-80, -80}}, lineColor=  {175, 175, 175}, smooth=  Smooth.None, fillColor=  {85, 170, 255}, fillPattern=  FillPattern.Solid), Text(extent=  {{-80, 80}, {80, -80}}, lineColor=  {0, 0, 0}, textString=  "%flowType%")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This model will be used as computational core of the heat exchanger model with a medium model. The difference to <a href=\"modelica://AixLib.HVAC.HeatExchanger.RecuperatorNoMedium\">RecuperatorNoMedium</a> is that the specific heat capacities are variable here and the input and output connectors have been replaced by normal variables with the correct unit.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The design point has been increased to a larger mass flow rate.</p>
 <p><br/><b><font style=\"color: #008000; \">References</font></b> </p>
 <table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
 <td><p>[Wetter1999]</p></td>
 <td><p>Wetter, M.: Simulation Model -- Air-to-Air Plate Heat Exchanger, Techreport, <i>Ernest Orlando Lawrence Berkeley National Laboratory, Berkeley, CA (US), </i><b>1999</b>, URL: <a href=\"http://simulationresearch.lbl.gov/dirpubs/42354.pdf\">http://simulationresearch.lbl.gov/dirpubs/42354.pdf</a></p></td>
 </tr>
 <tr>
 <td><p>[Jurges1924]</p></td>
 <td><p>Jurges, W.: Gesundheitsingenieur, Nr. 19. (1) <b>1924</b></p></td>
 </tr>
 <tr>
 <td><p>[McAdams1954]</p></td>
 <td><p>McAdams, W. H.: Heat Transmission, 3rd ed., McGraw-Hill, <i>New York</i> <b>1954</b></p></td>
 </tr>
 </table>
 </html>", revisions = "<html>
 <p>10.01.2014, Peter Matthes</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end RecuperatorNoMediumVarcp;

