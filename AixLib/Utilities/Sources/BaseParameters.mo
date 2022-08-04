within AixLib.Utilities.Sources;
model BaseParameters
  parameter Modelica.Units.SI.AbsolutePressure p_ambient=101325
    "Default ambient pressure" annotation (Dialog(group="Environment"));
  parameter Modelica.Units.SI.Temperature T_ambient=293.15
    "Default ambient temperature" annotation (Dialog(group="Environment"));
  parameter Modelica.Units.SI.Acceleration g=9.81 "Gravity"
    annotation (Dialog(group="Environment"));
  parameter Modelica.Units.SI.DynamicViscosity mu_Water=1e-3
    "Dynamic viscosity of water"
    annotation (Dialog(tab="Substance Properties", group="Water"));
  parameter Modelica.Units.SI.Density rho_Water=995.586 "Density of the fluid"
    annotation (Dialog(tab="Substance Properties", group="Water"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_Water=4184
    "Specific heat capacity of water"
    annotation (Dialog(tab="Substance Properties", group="Water"));
  parameter Modelica.Units.SI.ThermalConductivity lambda_Water=0.6
    "Thermal conductivity of water"
    annotation (Dialog(tab="Substance Properties", group="Water"));
  parameter Modelica.Units.SI.MolarMass M_Steam=0.01801 "Molar Mass of Steam"
    annotation (Dialog(tab="Substance Properties", group="Steam"));
  parameter Modelica.Units.SI.SpecificEnthalpy r_Steam=2500000
    "Specific enthalpy of vaporisation for water/steam"
    annotation (Dialog(tab="Substance Properties", group="Steam"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_Steam=1868
    "Specific heat capacity of Steam"
    annotation (Dialog(tab="Substance Properties", group="Steam"));
  parameter Modelica.Units.SI.MolarMass M_Air=0.02897 "Molar Mass of Dry Air"
    annotation (Dialog(tab="Substance Properties", group="Air"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_Air=1005
    "Specific heat capacity of Dry Air"
    annotation (Dialog(tab="Substance Properties", group="Air"));
  parameter Modelica.Units.SI.Temperature T_ref=273.15
    "Reference temperature at zero enthalpy"
    annotation (Dialog(tab="Substance Properties", group="Reference"));
  parameter Modelica.Units.SI.Temperature T0=T_ambient "Initial temperature"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean calcMFlow = true "Calculate m_flow from p" annotation(Dialog(group = "Assumptions"));
  annotation(defaultComponentName = "baseParameters", defaultComponentPrefixes = "inner", Icon(graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, lineColor = {0, 0, 255}, textString = "%name"), Line(points = {{-86, -30}, {82, -30}}, color = {0, 0, 0}), Line(points = {{-82, -68}, {-52, -30}}, color = {0, 0, 0}), Line(points = {{-48, -68}, {-18, -30}}, color = {0, 0, 0}), Line(points = {{-14, -68}, {16, -30}}, color = {0, 0, 0}), Line(points = {{22, -68}, {52, -30}}, color = {0, 0, 0}), Line(points = {{74, 56}, {74, 14}}, color = {0, 0, 0}), Polygon(points = {{60, 14}, {88, 14}, {74, -18}, {60, 14}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{16, 20}, {60, -18}}, lineColor = {0, 0, 0}, textString = "g"), Text(extent = {{-94, 94}, {92, 66}}, lineColor = {0, 0, 0}, textString = "Base Parameters"), Line(points = {{-82, 14}, {-42, -20}, {2, 30}}, color = {0, 0, 0}, thickness = 0.5), Ellipse(extent = {{-10, 40}, {12, 18}}, pattern = LinePattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid)}));
end BaseParameters;
