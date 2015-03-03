within AixLib.HVAC.Interfaces;
partial model TwoPortMoistAirFluidprops
  "Base class for Moist Air with all fluid properties at port a"
  extends Interfaces.TwoPortMoistAir;
  import Modelica.Constants.R;
  outer BaseParameters baseParameters "System properties";
  // PARAMETERS FOR WATER:
  parameter Modelica.SIunits.Temperature T_ref = baseParameters.T_ref
    "Reference temperature in K";
  Modelica.SIunits.Temperature T "Temperature close to the sensor in K";
  Modelica.SIunits.Pressure p "Pressure at Sensor";
  Modelica.SIunits.Pressure p_Steam "Pressure of Steam at Sensor";
  Modelica.SIunits.Pressure p_Air "Pressure of Air at Sensor";
  Modelica.SIunits.Pressure p_Saturation
    "Saturation Pressure of Steam at Sensor";
  Modelica.SIunits.Density rho_MoistAir(start = 1) "Density of Moist Air";
  Modelica.SIunits.Density rho_Air(start = 1) "Density of Dry Air";
  Modelica.SIunits.Density rho_Steam(start = 1) "Density of Steam";
  Real X(min = 0)
    "mass fractions of water (liquid and steam) to dry air m_w/m_a in Sensor";
  Real X_Steam(min = 0) "mass fractions of steam to dry air m_w/m_a in Sensor";
  Real X_Water(min = 0)
    "mass fractions of liquid water to dry air m_w/m_a in Sensor";
  Real X_Saturation(min = 0)
    "saturation mass fractions of water to dry air m_w/m_a in Sensor";
  Modelica.SIunits.DynamicViscosity dynamicViscosity
    "dynamic viscosity of moist air";
protected
  parameter Modelica.SIunits.SpecificHeatCapacity cp_Water = baseParameters.cp_Water
    "Specific heat capacity of liquid water";
  // PARAMETERS FOR STEAM:
  parameter Modelica.SIunits.MolarMass M_Steam = baseParameters.M_Steam
    "Molar Mass of Steam";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_Steam = baseParameters.cp_Steam
    "Specific heat capacity of Steam";
  parameter Modelica.SIunits.SpecificEnthalpy r_Steam = baseParameters.r_Steam
    "Specific enthalpy of vaporisation";
  // PARAMETERS FOR DRY AIR:
  parameter Modelica.SIunits.MolarMass M_Air = baseParameters.M_Air
    "Molar Mass of Dry Air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_Air = baseParameters.cp_Air
    "Specific heat capacity of Dry Air";
equation
  // Pressure
  p = portMoistAir_a.p;
  p = p_Steam + p_Air;
  p_Steam = R / M_Steam * rho_Steam * T;
  p_Air = R / M_Air * rho_Air * T;
  p_Saturation = HVAC.Volume.BaseClasses.SaturationPressureSteam(T);
  rho_MoistAir = rho_Air * (1 + X_Steam + X_Water);
  // X
  X_Steam = rho_Steam / rho_Air;
  X_Saturation = M_Steam / M_Air * p_Saturation / (p - p_Saturation);
  X_Steam = min(X_Saturation, X);
  X_Water = max(X - X_Saturation, 0);
  // ENTHALPY
  actualStream(portMoistAir_a.h_outflow) = cp_Air * (T - T_ref) + X_Steam * (r_Steam + cp_Steam * (T - T_ref)) + X_Water * cp_Water * (T - T_ref);
  X = actualStream(portMoistAir_a.X_outflow);
  dynamicViscosity = HVAC.Volume.BaseClasses.DynamicViscosityMoistAir(T, X_Steam);
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Two Port Model for Moist Air with fluid propoerties at port a</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end TwoPortMoistAirFluidprops;
