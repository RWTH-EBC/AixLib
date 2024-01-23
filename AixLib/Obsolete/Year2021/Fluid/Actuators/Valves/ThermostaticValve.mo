within AixLib.Obsolete.Year2021.Fluid.Actuators.Valves;
model ThermostaticValve

  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport;
  parameter Real Kvs = 1.4 "Kv value at full opening (=1)" annotation(Dialog(group = "Valve"));
  parameter Real Kv_setT = 0.8
    "Kv value when set temperature = measured temperature"                            annotation(Dialog(group = "Thermostatic head"));
  parameter Real P = 2 "Deviation of P-controller when valve is closed" annotation(Dialog(group = "Thermostatic head"));
  parameter Real Influence_PressureDrop = 0.14
    "influence of the pressure drop in K"                                            annotation(Dialog(group = "Thermostatic head"));
  parameter Real leakageOpening = 0.0001
    "may be useful for simulation stability. Always check the influence it has on your results";
  //Variable
  Real opening "valve opening";
  Real TempDiff "Difference between measured temperature and set temperature";
  Real Influence_PressureDrop_inK "Influence of pressure drop in Kelvin.";
  Modelica.Blocks.Interfaces.RealInput T_room "temperature in room" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-64, 98})));
  Modelica.Blocks.Interfaces.RealInput T_setRoom "set temperature in room" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {56, 98})));
protected
  Modelica.Units.SI.Density rho "Density of the fluid";
equation
  rho = Medium.density(Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)));
  // Enthalpie flow
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
  //Calculate the pressure drop
  m_flow = rho * 1 / 3600 * Kvs * opening * Modelica.Fluid.Utilities.regRoot2(dp, Modelica.Constants.small, 1e-4, 1e-4);
  //original equation valve
  //calculate the influence of the pressure drop
  Influence_PressureDrop_inK = Influence_PressureDrop * (dp / 100000 - 0.1) / 0.5;
  //calculate the measured temperature difference
  TempDiff = T_room - T_setRoom - Influence_PressureDrop_inK;
  //Calculating the valve opening depending on the temperature deviation
  if TempDiff > P * (1- leakageOpening * Kvs / Kv_setT) then
    opening = leakageOpening;
  else
    opening = min(1, (P - TempDiff) * (Kv_setT / Kvs) / P);
  end if;
  annotation (
    obsolete = "Obsolete model - Use one of the valves in package AixLib.Fluid.Actuators.Valves.",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(points = {{-78, 50}, {-78, -60}, {82, 50}, {82, -62}, {-78, 50}},
            lineThickness =                                                                                                   1, fillColor = {0, 0, 255},
            fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0, 0, 0})}), Documentation(revisions="<html><ul>
  <li>
    <i>November 2014&#160;</i> by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class
  </li>
  <li>
    <i>November 13, 2013&#160;</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a simple thermostatic valve.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Development of SimpleValve by incorporating the behaviour of a
  thermostatic head as a P controller with a maximum deviation of
  <i>P</i> and an influence of the pressure drop on the sensed
  temperature.
</p>
<p>
  It is possible to not close the valve completely by allowing for some
  minimal leakage. Use this option carefully and always
  check&#160;the&#160;influence&#160;it&#160;might have
  on&#160;your&#160;results.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.HVAC.Radiators.Examples.PumpRadiatorThermostaticValve\">AixLib.HVAC.Radiators.Examples.PumpRadiatorThermostaticValve</a>
</p>
</html>"));
end ThermostaticValve;
