within AixLib.HVAC.Volume;

model Volume "Model of a fluid volume with heat port"
  parameter Modelica.SIunits.Volume V = 0.01 "Volume in m3";
  Modelica.SIunits.Temperature T "Temperature inside the CV in K";
  outer BaseParameters baseParameters "System properties";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));
  Interfaces.Port_a port_a annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Interfaces.Port_b port_b annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
protected
  parameter Modelica.SIunits.DynamicViscosity mu = baseParameters.mu_Water "Dynamic viscosity";
  parameter Modelica.SIunits.Density rho = baseParameters.rho_Water "Density of the fluid";
  parameter Modelica.SIunits.SpecificHeatCapacity cp = baseParameters.cp_Water "Specific heat capacity";
  parameter Modelica.SIunits.Temperature T0 = baseParameters.T0 "Initial temperature in K";
  parameter Modelica.SIunits.Temperature T_ref = baseParameters.T_ref "Reference temperature in K";
  parameter Modelica.SIunits.Mass m = V * rho "Mass of the fluid inside the volume in kg";
  Modelica.SIunits.Energy U(start = m * cp * (T0 - T_ref)) "Internal energy in J";
  Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
  Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";
equation
  port_a.p = port_b.p;
  //no pressure difference between the two ports
  port_a.h_outflow = cp * (T - T_ref);
  port_b.h_outflow = cp * (T - T_ref);
  H_flow_a = port_a.m_flow * actualStream(port_a.h_outflow);
  H_flow_b = port_b.m_flow * actualStream(port_b.h_outflow);
  U = m * cp * (T - T_ref);
  der(U) = heatPort.Q_flow + H_flow_a + H_flow_b;
  // Dynamic energy balance
  heatPort.T = T;
  0 = port_a.m_flow + port_b.m_flow;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillPattern = FillPattern.Sphere, fillColor = {85, 170, 255})}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This model represents a simple fluid volume with two fluid ports and one heat port. It has no pressure difference between the two fluid ports. </p>
 <p>The model uses the same energy balance as the pipe model.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst</a></p>
 </html>", revisions = "<html>
 <p>02.10.2013, Marcus Fuchs</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end Volume;