within AixLib.HVAC.Interfaces;


partial model FourPortMoistAir "Component with four moist air ports"
  Modelica.SIunits.PressureDifference dp[2]
    "Pressure drop between the two ports (= port_a.p - port_b.p)";
  Interfaces.PortMoistAir_a port_1a annotation(Placement(transformation(extent = {{-110, 50}, {-90, 70}})));
  Interfaces.PortMoistAir_b port_1b annotation(Placement(transformation(extent = {{-110, -70}, {-90, -50}})));
  Interfaces.PortMoistAir_a port_2a annotation(Placement(transformation(extent = {{90, -70}, {110, -50}}), iconTransformation(extent = {{90, -70}, {110, -50}})));
  Interfaces.PortMoistAir_b port_2b annotation(Placement(transformation(extent = {{90, 50}, {110, 70}}), iconTransformation(extent = {{90, 50}, {110, 70}})));
equation
  dp[1] = port_1a.p - port_1b.p;
  dp[2] = port_2a.p - port_2b.p;
  annotation(Icon(graphics), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Two Port Model for Moist Air</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end FourPortMoistAir;
