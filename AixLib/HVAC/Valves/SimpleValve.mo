within AixLib.HVAC.Valves;


model SimpleValve
  extends AixLib.HVAC.Interfaces.TwoPort;
  parameter Real Kvs = 1.4 "Kv value at full opening (=1)";
  Modelica.Blocks.Interfaces.RealInput opening "valve opening" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 80})));
equation
  // Enthalpie flow
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
  //Calculate the pressure drop
  //m_flow = rho * 1/3600 * Kvs * opening * sqrt(p / 100000);    //This is educational purposes equatioan, can be used to show the functionality of a valve when the flow direction is correct
  m_flow = rho * 1 / 3600 * Kvs * opening * Modelica.Fluid.Utilities.regRoot2(dp, Modelica.Constants.small, 1e-4, 1e-4);
  //This equation is better suited for stable simulations as it works for both flow directions and is continuous at flow zero
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(points = {{-78, 50}, {-78, -60}, {82, 50}, {82, -62}, {-78, 50}},
            lineThickness =                                                                                                    1, smooth = Smooth.None, fillColor = {0, 0, 255},
            fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None, lineColor = {0, 0, 0})}), Diagram(graphics), Documentation(revisions = "<html>
 <p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a simple valve. </p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Simple valve model which describes the relationship between mass flow and pressure drop acoordinh to the Kvs Value.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Radiators.Examples.PumpRadiatorValve\">AixLib.HVAC.Radiators.Examples.PumpRadiatorValve</a></p>
 </html>"));
end SimpleValve;
