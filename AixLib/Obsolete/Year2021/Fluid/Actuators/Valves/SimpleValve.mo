within AixLib.Obsolete.Year2021.Fluid.Actuators.Valves;
model SimpleValve

  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport;
  parameter Real Kvs = 1.4 "Kv value at full opening (=1)";
  Modelica.Blocks.Interfaces.RealInput opening "valve opening" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 80})));

protected
  Modelica.Units.SI.Density rho "Density of the fluid";
equation
  rho = Medium.density(Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)));
  // Enthalpy flow
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
  //Calculate the pressure drop
  //m_flow = rho * 1/3600 * Kvs * opening * sqrt(p / 100000);    //This is an educational purposes equation, can be used to show the functionality of a valve when the flow direction is correct
  m_flow = rho * 1 / 3600 * Kvs * opening * Modelica.Fluid.Utilities.regRoot2(dp, Modelica.Constants.small, 1e-4, 1e-4);
  //This equation is better suited for stable simulations as it works for both flow directions and is continuous at flow zero
  annotation (
    obsolete = "Obsolete model - Use one of the valves in package AixLib.Fluid.Actuators.Valves.",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(points = {{-78, 50}, {-78, -60}, {82, 50}, {82, -62}, {-78, 50}},
            lineThickness =                                                                                                   1, fillColor = {0, 0, 255},
            fillPattern=FillPattern.Solid,
            pattern = LinePattern.None,
            lineColor = {0, 0, 0})}),
Documentation(revisions="<html><ul>
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
  Model for a simple valve.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Simple valve model which describes the relationship between mass flow
  and pressure drop acoordinh to the Kvs Value.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.HVAC.Radiators.Examples.PumpRadiatorValve\">AixLib.HVAC.Radiators.Examples.PumpRadiatorValve</a>
</p>
</html>"));
end SimpleValve;
