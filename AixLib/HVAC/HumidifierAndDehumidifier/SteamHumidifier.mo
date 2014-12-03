within AixLib.HVAC.HumidifierAndDehumidifier;
model SteamHumidifier "Steam humidifier, with consideration of saturation"
  extends Interfaces.TwoPortMoistAirFluidprops;
  outer BaseParameters baseParameters "System properties";
  Modelica.SIunits.Pressure p_Saturation_portb
    "Saturation Pressure of Steam portb";
  Real X_Saturation_portb(min = 0)
    "saturation mass fractions of water to dry air m_w/m_a at portb";
  Real Massflow_steamOut(start = 0) "steam flow which remains unused";
  Real Massflow_steamUseful "used steam flow";
  Real Dummy_portb_Xout "Xout if all the mass flow is used)";
  Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
  Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";
  Modelica.Blocks.Interfaces.RealInput Massflow_steamIn annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-40, 100}), iconTransformation(extent = {{-14, -14}, {14, 14}}, rotation = 270, origin = {-40, 94})));
  Modelica.Blocks.Interfaces.RealInput Temperature_steamIn annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {34, 100}), iconTransformation(extent = {{-14, -14}, {14, 14}}, rotation = 270, origin = {40, 94})));
equation
  assert(portMoistAir_b.X_outflow < X_Saturation_portb, "
  Oversaturation X_outflow at port_b = " + String(portMoistAir_b.X_outflow) + " while X_saturation at port_b =" + String(X_Saturation_portb) + ".", level=  AssertionLevel.warning);
  assert(inStream(portMoistAir_a.X_outflow) < X_Saturation, "
  Oversaturation X_outflow at port_a = " + String(inStream(portMoistAir_a.X_outflow)) + " while X_saturation at port_a =" + String(X_Saturation) + ".", level=  AssertionLevel.warning);
  // No pressure loss
  dp = 0;
  // Mass balance air
  0 = portMoistAir_a.m_flow + portMoistAir_b.m_flow;
  // Mass balance water
  portMoistAir_b.X_outflow = inStream(portMoistAir_a.X_outflow) + Massflow_steamUseful / portMoistAir_a.m_flow;
  portMoistAir_a.X_outflow = inStream(portMoistAir_b.X_outflow) + Massflow_steamUseful / portMoistAir_b.m_flow;
  //Energy balance
  portMoistAir_b.h_outflow = inStream(portMoistAir_a.h_outflow) + Massflow_steamUseful * (r_Steam + cp_Steam * (Temperature_steamIn - T_ref)) / portMoistAir_a.m_flow;
  portMoistAir_a.h_outflow = inStream(portMoistAir_b.h_outflow) + Massflow_steamUseful * (r_Steam + cp_Steam * (Temperature_steamIn - T_ref)) / portMoistAir_b.m_flow;
  //Calculate help variables
  H_flow_a = portMoistAir_a.m_flow * actualStream(portMoistAir_a.h_outflow);
  H_flow_b = portMoistAir_b.m_flow * actualStream(portMoistAir_b.h_outflow);
  //Saturation pressure and humidity
  p_Saturation_portb = HVAC.Volume.BaseClasses.SaturationPressureSteam(T);
  // because almost isothermal
  X_Saturation_portb = M_Steam / M_Air * p_Saturation / (portMoistAir_b.p - p_Saturation_portb);
  Dummy_portb_Xout = inStream(portMoistAir_a.X_outflow) + Massflow_steamIn / portMoistAir_a.m_flow;
  if Dummy_portb_Xout > X_Saturation_portb then
    Massflow_steamUseful = portMoistAir_a.m_flow * (X_Saturation_portb - inStream(portMoistAir_a.X_outflow));
  else
    Massflow_steamUseful = Massflow_steamIn;
  end if;
  Massflow_steamOut = Massflow_steamIn - Massflow_steamUseful;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent=  {{-80, 80}, {80, -80}}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, pattern=  LinePattern.None), Line(points=  {{-32, 54}, {-64, -48}}, color=  {0, 0, 0}, pattern=  LinePattern.Dot, smooth=  Smooth.None), Line(points=  {{-12, 54}, {-44, -48}}, color=  {0, 0, 0}, pattern=  LinePattern.Dot, smooth=  Smooth.None), Line(points=  {{12, 54}, {-20, -48}}, color=  {0, 0, 0}, pattern=  LinePattern.Dot, smooth=  Smooth.None), Line(points=  {{36, 52}, {4, -50}}, color=  {0, 0, 0}, pattern=  LinePattern.Dot, smooth=  Smooth.None), Line(points=  {{62, 52}, {30, -50}}, color=  {0, 0, 0}, pattern=  LinePattern.Dot, smooth=  Smooth.None), Line(points=  {{-50, 56}, {-20, -44}}, color=  {0, 0, 0}, pattern=  LinePattern.Dot, smooth=  Smooth.None), Line(points=  {{-18, 56}, {12, -44}}, color=  {0, 0, 0}, pattern=  LinePattern.Dot, smooth=  Smooth.None), Line(points=  {{16, 56}, {46, -44}}, color=  {0, 0, 0}, pattern=  LinePattern.Dot, smooth=  Smooth.None)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a steam humidifier.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Model functions in both directions as a humidifier.</p>
 <p>Model inputs: Massflow and temperature for steam.</p>
 <p>Assumptions: all the possible steam is absorbed. Saturation is considered.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.HumidifierAndDehumidifier.SteamHumidifier\">AixLib.HVAC.HumidifierAndDehumidifier.SteamHumidifier</a></p>
 </html>", revisions = "<html>
 <p>21.01.2014, by <i>Ana Constantin</i>: implemented</p>
 </html>"));
end SteamHumidifier;

