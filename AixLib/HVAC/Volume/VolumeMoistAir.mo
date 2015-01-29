within AixLib.HVAC.Volume;
model VolumeMoistAir "Model of a moist Air volume with heat port"
  extends Interfaces.TwoPortMoistAir;
  import Modelica.Constants.R;
  outer BaseParameters baseParameters "System properties";
  parameter Modelica.SIunits.Volume V = 0.01 "Volume in m3";
  Modelica.SIunits.Temperature T(start = T0, nominal = T0)
    "Temperature inside the CV in K";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));
  // PARAMETERS FOR LIQUID WATER:
  parameter Modelica.SIunits.Temperature T0 = baseParameters.T0
    "Initial temperature in K";
  parameter Modelica.SIunits.Temperature T_ref = baseParameters.T_ref
    "Reference temperature in K";
  Modelica.SIunits.Pressure p "Pressure in CV";
  Modelica.SIunits.Pressure p_Steam "Pressure of Steam in CV";
  Modelica.SIunits.Pressure p_Air "Pressure of Air in CV";
  Modelica.SIunits.Pressure p_Saturation
    "Saturation Pressure of Steam in Air in CV";
  Modelica.SIunits.Density rho_MoistAir "Density of Moist Air";
  Modelica.SIunits.Density rho_Air(start = 1) "Density of Dry Air";
  Modelica.SIunits.Density rho_Steam(start = 1) "Density of Steam";
  Modelica.SIunits.Energy U "Internal energy in J";
  Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
  Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";
  Modelica.SIunits.MassFlowRate mX_flow_a "Mass Flow of Water at Port a";
  Modelica.SIunits.MassFlowRate mX_flow_b "Mass Flow of Water at Port b";
  Modelica.SIunits.Mass mX "Mass of Water in CV";
  Real X(min = 0)
    "mass fractions of water (liquid and steam) to dry air m_w/m_a in CV";
  Real X_Steam(min = 0) "mass fractions of steam to dry air m_w/m_a in CV";
  Real X_Water(min = 0)
    "mass fractions of liquid water to dry air m_w/m_a in CV";
  Real X_Saturation(min = 0)
    "saturation mass fractions of water to dry air m_w/m_a in CV";
  parameter Boolean useTstart = true
    "true if volume temperature should be initialized";
protected
  parameter Modelica.SIunits.Density rho_Water = baseParameters.rho_Water
    "Density of water";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_Water = baseParameters.cp_Water
    "Specific heat capacity";
  // PARAMETERS FOR STEAM:
  parameter Modelica.SIunits.MolarMass M_Steam = baseParameters.M_Steam
    "Molar Mass of Steam";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_Steam = baseParameters.cp_Steam
    "Specific heat capacity of Steam";
  parameter Modelica.SIunits.SpecificEnthalpy r_Steam = baseParameters.r_Steam
    "Specific enthalpy of vapoisation";
  // PARAMETERS FOR AIR:
  parameter Modelica.SIunits.MolarMass M_Air = baseParameters.M_Air
    "Molar Mass of Dry Air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_Air = baseParameters.cp_Air
    "Specific heat capacity of Dry Air";
  // REF AND INITIAL TEMPERATURE
initial equation
  if useTstart then
    T = T0;
  end if;
  X = 0.005;
equation
  assert(T >= 273.15 and T <= 373.15, "
  Temperature T is not in the allowed range
  273.15 K <= (T =" + String(T) + " K) <= 373.15 K
  required from used moist air medium model.", level=  AssertionLevel.warning);
  // Pressure
  portMoistAir_a.p = portMoistAir_b.p;
  p = portMoistAir_a.p;
  p = p_Steam + p_Air;
  p_Steam = R / M_Steam * rho_Steam * T;
  p_Air = R / M_Air * rho_Air * T;
  p_Saturation = BaseClasses.SaturationPressureSteam(T);
  // Storage of Air Mass
  der(rho_Air) * V = portMoistAir_a.m_flow + portMoistAir_b.m_flow;
  rho_MoistAir = rho_Air * (1 + X_Steam + X_Water);
  // X
  X_Steam = rho_Steam / rho_Air;
  X_Saturation = M_Steam / M_Air * p_Saturation / (p - p_Saturation);
  X_Steam = min(X_Saturation, X);
  X_Water = max(X - X_Saturation, 0);
  // WATER MASS BALANCE
  portMoistAir_a.X_outflow = X;
  portMoistAir_b.X_outflow = X;
  // ENTHALPY
  portMoistAir_a.h_outflow = cp_Air * (T - T_ref) + X_Steam * (r_Steam + cp_Steam * (T - T_ref)) + X_Water * cp_Water * (T - T_ref);
  portMoistAir_b.h_outflow = cp_Air * (T - T_ref) + X_Steam * (r_Steam + cp_Steam * (T - T_ref)) + X_Water * cp_Water * (T - T_ref);
  H_flow_a = portMoistAir_a.m_flow * actualStream(portMoistAir_a.h_outflow);
  H_flow_b = portMoistAir_b.m_flow * actualStream(portMoistAir_b.h_outflow);
  U = V * rho_Air * (cp_Air * (T - T_ref) + X_Steam * (r_Steam + cp_Steam * (T - T_ref)) + X_Water * cp_Water * (T - T_ref));
  der(U) = heatPort.Q_flow + H_flow_a + H_flow_b;
  // Dynamic energy balance
  mX_flow_a = portMoistAir_a.m_flow * actualStream(portMoistAir_a.X_outflow)
    "water mass flow";
  mX_flow_b = portMoistAir_b.m_flow * actualStream(portMoistAir_b.X_outflow)
    "water mass flow";
  mX = V * rho_Air * X;
  der(mX) = mX_flow_a + mX_flow_b;
  heatPort.T = T;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {170, 255, 255},
            fillPattern =                                                                                                    FillPattern.Sphere, fillColor = {170, 255, 255})}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Volume Model for Moist Air without any pressure difference. </p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Includes storage of mass and energy. c_p is constant for every substance. Volume is also Constant. </p>
 <p>The Volume of liquid Water does not influence the pressure calculation, because it is assumed to be very small.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer\">AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer</a></p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end VolumeMoistAir;

