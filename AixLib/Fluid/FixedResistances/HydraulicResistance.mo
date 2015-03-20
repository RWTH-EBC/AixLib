within AixLib.Fluid.FixedResistances;
model HydraulicResistance
  "Simple model for a hydraulic resistance using a pressure loss factor"
  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport;
  parameter Real zeta = 1.0 "Pressure loss factor for flow of port_a -> port_b";
  parameter Modelica.SIunits.Length D = 0.05 "Diameter of component";
protected
  Modelica.SIunits.Density rho "Density of the fluid";
equation
  rho = Medium.density(Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)));
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
  dp = 8 * zeta / (Modelica.Constants.pi ^ 2 * D ^ 4 * rho) * m_flow ^ 2;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(graphics={  Rectangle(extent = {{-80, 46}, {80, -34}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
            fillPattern =                                                                                                    FillPattern.Solid, radius = 45), Text(extent = {{32, 26}, {-30, -10}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
            fillPattern =                                                                                                    FillPattern.Solid, textString = "Zeta")}), Documentation(revisions="<html>
 <p>November 2014, Marcus Fuchs</p>
 <p><ul>
 <li>Changed model to use Annex 60 base class</li>
 </ul></p>
 <p>01.11.2013, by <i>Ana Constantin</i>: implemented</p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Very simple model for a hydraulic resistance with the pressureloss modelled with a pressure loss factor, zeta.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Values for pressure loss factor zeta can be easily found in tables.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop\">AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop</a></p>
 </html>"));
end HydraulicResistance;
