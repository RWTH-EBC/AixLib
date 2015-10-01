within AixLib.HVAC.HumidifierAndDehumidifier;


model CoolerDehumidifier "Dehumidifier through cooling"
  extends Interfaces.TwoPortMoistAirFluidprops;
  outer BaseParameters baseParameters "System properties";
  Modelica.SIunits.Pressure p_Saturation_CoolSurface
    "Saturation Pressure of Steam at Sensor";
  Real X_Saturation_CoolSurface(min = 0)
    "saturation mass fractions of water to dry air m_w/m_a in Sensor";
  Real Massflow_waterOut "dehumidified water flow";
  Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
  Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";
  Modelica.Blocks.Interfaces.RealInput BypassFactor annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {46, 100}), iconTransformation(extent = {{-14, -14}, {14, 14}}, rotation = 270, origin = {-60, 94})));
  Modelica.Blocks.Interfaces.RealInput CoolSurfaceTemperature annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-66, 100}), iconTransformation(extent = {{-14, -14}, {14, 14}}, rotation = 270, origin = {52, 94})));
equation
  // No pressure loss
  dp = 0;
  // Calculate saturation mass fraction at cooling temperature
  p_Saturation_CoolSurface = AixLib.HVAC.Volume.BaseClasses.SaturationPressureSteam(CoolSurfaceTemperature);
  X_Saturation_CoolSurface = M_Steam / M_Air * p_Saturation_CoolSurface / (portMoistAir_a.p - p_Saturation_CoolSurface);
  // Mass balance air
  0 = portMoistAir_a.m_flow + portMoistAir_b.m_flow;
  // Mass balance water
  portMoistAir_b.X_outflow = inStream(portMoistAir_a.X_outflow) * BypassFactor + X_Saturation_CoolSurface * (1 - BypassFactor);
  portMoistAir_a.X_outflow = inStream(portMoistAir_b.X_outflow) * BypassFactor + X_Saturation_CoolSurface * (1 - BypassFactor);
  Massflow_waterOut = (actualStream(portMoistAir_a.X_outflow) - actualStream(portMoistAir_b.X_outflow)) / abs(portMoistAir_a.m_flow);
  //Energy balance
  portMoistAir_b.h_outflow = inStream(portMoistAir_a.h_outflow) * BypassFactor + (1 - BypassFactor) * (cp_Air * (CoolSurfaceTemperature - T_ref) + X_Saturation_CoolSurface * (cp_Steam * (CoolSurfaceTemperature - T_ref) + r_Steam));
  portMoistAir_a.h_outflow = inStream(portMoistAir_b.h_outflow) * BypassFactor + (1 - BypassFactor) * (cp_Air * (CoolSurfaceTemperature - T_ref) + X_Saturation_CoolSurface * (cp_Steam * (CoolSurfaceTemperature - T_ref) + r_Steam));
  //Calculate help variables
  H_flow_b = portMoistAir_b.m_flow * actualStream(portMoistAir_b.h_outflow);
  H_flow_a = portMoistAir_a.m_flow * actualStream(portMoistAir_a.h_outflow);
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent=  {{-80, 80}, {80, -80}}, fillColor=  {85, 170, 255}, fillPattern=  FillPattern.HorizontalCylinder, pattern=  LinePattern.Solid, lineColor=  {0, 0, 0}), Line(points=  {{-50, -56}, {-50, -34}}, color=  {0, 0, 0}, pattern=  LinePattern.Dash), Line(points=  {{-20, -56}, {-20, -34}}, color=  {0, 0, 0}, pattern=  LinePattern.Dash), Line(points=  {{12, -56}, {12, -34}}, color=  {0, 0, 0}, pattern=  LinePattern.Dash), Line(points=  {{46, -56}, {46, -34}}, color=  {0, 0, 0}, pattern=  LinePattern.Dash)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a cooling dehumidfier.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Model inputs: temperature of cooling temperature and bypass factor.</p>
 <p>Model functions in both directions as a dehumidifier.</p>
 <p>Assumption: Model does not check to see if the water fraction dropped under 0.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.HumidifierAndDehumidifier.Examples.CoolerDehumidifier\">AixLib.HVAC.HumidifierAndDehumidifier.Examples.CoolerDehumidifier</a></p>
 </html>", revisions = "<html>
 <p>21.01.2014, by <i>Ana Constantin</i>: implemented</p>
 </html>"));
end CoolerDehumidifier;
