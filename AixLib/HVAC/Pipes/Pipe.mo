within AixLib.HVAC.Pipes;
model Pipe
  extends Interfaces.TwoPort;
  import Modelica.Math;
  parameter Modelica.SIunits.Length D = 0.05 "Diameter";
  parameter Modelica.SIunits.Length l = 1 "Length";
  parameter Modelica.SIunits.Length e = 2.5e-5 "Roughness";
  parameter Modelica.SIunits.Temperature T0 = baseParameters.T0
    "Initial temperature"                                                             annotation(Dialog(tab = "Initialization"));
  Modelica.SIunits.Temperature T "Temperature inside the CV";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport annotation(Placement(transformation(extent = {{-10, 40}, {10, 60}}), iconTransformation(extent = {{-10, 40}, {10, 60}})));
protected
  Modelica.SIunits.ReynoldsNumber Re(nominal = 1e5) "Reynolds number";
  Real lambda2 "Modified fanning friction factor";
  parameter Modelica.SIunits.Temperature T_ref = baseParameters.T_ref;
  parameter Modelica.SIunits.Mass m = Modelica.Constants.pi * D ^ 2 / 4 * l * rho
    "Mass of the fluid in CV";
  Modelica.SIunits.Energy U(start = m * cp * (T0 - T_ref)) "Internal energy";
  Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a";
  Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b";
equation
  port_a.h_outflow = cp * (T - T_ref);
  port_b.h_outflow = cp * (T - T_ref);
  H_flow_a = port_a.m_flow * actualStream(port_a.h_outflow);
  H_flow_b = port_b.m_flow * actualStream(port_b.h_outflow);
  U = m * cp * (T - T_ref);
  der(U) = heatport.Q_flow + H_flow_a + H_flow_b;
  heatport.T = T;
  lambda2 = abs(dp) * 2 * D ^ 3 * rho / (l * mu * mu);
  Re = -2 * sqrt(lambda2) * Math.log10(2.51 / sqrt(lambda2 + 1e-10) + 0.27 * (e / D));
  m_flow = sign(dp) * Modelica.Constants.pi / 4 * D * mu * Re;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent=  {{-100, 40}, {100, -40}}, lineColor=  {0, 0, 0}, fillColor=  {95, 95, 95}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-100, 30}, {100, -30}}, lineColor=  {0, 0, 0}, fillColor=  {0, 128, 255}, fillPattern=  FillPattern.HorizontalCylinder)}), Documentation(revisions = "<html>
 <p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model of a straight pipe with mass, energy and momentum balances. It provides the complete balance equations for one-dimensional fluid flow.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The model uses a modified friction factor to estimate the Reynolds number. Using Hagen&ndash;Poiseuille equation, the pressure drop and mass flow rate are calculated using the Reynolds number. The model is only valid for turbulent flow.</p>
 <p>For the energy balance, a differential equation is implemented for the whole pipe volume. Temperature of the volume is equal to the temperature at the heat port.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Pipes.Examples.Pipe_Validation\">AixLib.HVAC.Pipes.Examples.Pipe_Validation</a></p>
 </html>"));
end Pipe;

