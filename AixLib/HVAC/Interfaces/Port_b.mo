within AixLib.HVAC.Interfaces;
connector Port_b
  Modelica.SIunits.Pressure p "Pressure at the port";
  flow Modelica.SIunits.MassFlowRate m_flow "Mass flowing into the port";
  stream Modelica.SIunits.SpecificEnthalpy h_outflow
    "Specific enthalpy close to the connection point if m_flow < 0";
  annotation(defaultComponentName = "port_b", Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, fillColor = {85, 85, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-30, 30}, {30, -30}}, lineColor = {0, 127, 255}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{-150, 110}, {150, 50}}, textString = "%name")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 127, 255}, fillColor = {0, 127, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {85, 85, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 127, 255}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid)}), Documentation(revisions = "<html>
 <p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
 </html>", info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>Interface for quasi one-dimensional fluid flow in a hydraulic component. Only for fluid with constant properties.</p>
 <p>Pressure, mass flow and enthalpy flow are transported in this interface.</p>
 </html>"));
end Port_b;

