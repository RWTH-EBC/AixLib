within AixLib.Fluid.Solar.Thermal.BaseClasses;
model SolarThermalEfficiency
  "Calculates the efficiency of a solar thermal collector"
  import AixLib;
  parameter AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition Collector = AixLib.DataBase.SolarThermal.SimpleAbsorber()
    "Properties of Solar Thermal Collector"                                                                                                     annotation(choicesAllMatching = true);
  Modelica.Blocks.Interfaces.RealInput T_air "Air temperature in K" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-50, 106})));
  Modelica.Blocks.Interfaces.RealInput G "Solar irradiation in W/m2" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {10, 106})));
  Modelica.Blocks.Interfaces.RealInput T_col "Collector temperature in K" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-50, -106})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow
    "Useful heat flow from solar collector in W/m2"                                            annotation(Placement(transformation(extent = {{98, -10}, {118, 10}})));
protected
  Real eta "Efficiency of solar thermal collector";
  Modelica.SIunits.TemperatureDifference dT
    "Temperature difference between collector and air in K";
equation
  dT = T_col - T_air;
  eta = Collector.eta_zero - Collector.c1 * dT / G - Collector.c2 * dT * dT / G;
  Q_flow = G * eta;
  annotation (Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Model for the efficiency of a solar thermal collector. Inputs are outdoor
 air temperature, fluid temperature and solar irradiation. Based on these values
 and the collector properties from database, this model calculates the heat flow
 to the fluid circuit. We assume that the fluid temperature is equal to the
 collector temperature.</p>
 </html>", revisions="<html>
 <p>15.12.2016, Moritz Lauster: moved</p>
 <p>19.11.2013, Marcus Fuchs: implemented</p>
 </html>"));
end SolarThermalEfficiency;
