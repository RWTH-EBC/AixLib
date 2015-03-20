within AixLib.HVAC.Interfaces;
connector PortMoistAir_a
  Modelica.SIunits.Pressure p "Pressure at the port";
  flow Modelica.SIunits.MassFlowRate m_flow
    "Massflow of Dry Air flowing into the port";
  stream Modelica.SIunits.SpecificEnthalpy h_outflow
    "Specific enthalpy (in kJ / kg_dry-air) close to the connection point, when the mass flow flows OUT of the port";
  stream Real X_outflow(min = 0)
    "mass fractions of water to dry air m_w/m_a close to the connection point, when the mass flow flows OUT of the port";
  annotation(defaultComponentName = "portMoistAir_a", Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, fillColor = {170, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{-150, 110}, {150, 50}}, textString = "%name")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 127, 255}, fillColor = {0, 127, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {170, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Port Model for Moist Air</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end PortMoistAir_a;
