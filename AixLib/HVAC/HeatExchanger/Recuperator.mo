within AixLib.HVAC.HeatExchanger;

model Recuperator "recuperator model with selectable flow arrangement"
  extends Interfaces.FourPortMoistAir;
  outer BaseParameters baseParameters "System properties";
  // Pressure loss
  parameter Modelica.SIunits.Area Aflow[2] = {0.193 * 0.300 / 2, 0.193 * 0.300 / 2} "flow area for media";
  parameter Real zeta[2](each min = 0) = {2 * 130 / 1.225 / (400 / 3600 / Aflow[1]) ^ 2, 2 * 130 / 1.225 / (400 / 3600 / Aflow[2]) ^ 2} "pressure loss coefficients";
  extends RecuperatorNoMediumVarcp;
  Volume.VolumeMoistAir volume1(useTstart = false, V = 1e-4) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-40, 0})));
  Sensors.PropertySensorMoistAir sensor1 annotation(Placement(transformation(extent = {{-84, 50}, {-64, 70}})));
  Sensors.PropertySensorMoistAir sensor2 annotation(Placement(transformation(extent = {{84, -70}, {64, -50}})));
  Volume.VolumeMoistAir volume2(useTstart = false, V = 1e-4) annotation(Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 270, origin = {40, 0})));
  BaseClasses.SimpleHeatTransfer simpleHeatTransfer annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 0})));
  Ductwork.PressureLoss pressureLoss1(D = 2 * sqrt(Aflow[1] / Modelica.Constants.pi), zeta = zeta[1]) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-40, 40})));
  Ductwork.PressureLoss pressureLoss2(D = 2 * sqrt(Aflow[2] / Modelica.Constants.pi), zeta = zeta[2]) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {40, -40})));
  Sensors.PropertySensorMoistAir sensor3 annotation(Placement(transformation(extent = {{60, 50}, {80, 70}})));
equation
  m1in = port_1a.m_flow "reverse flow not handled yet";
  m2in = port_2a.m_flow;
  T1in = sensor1.Temperature "medium temperature";
  T2in = sensor2.Temperature "medium temperature";
  // T2out = sensor3.Temperature;
  cp1 = baseParameters.cp_Air "constant property";
  cp2 = baseParameters.cp_Air;
  simpleHeatTransfer.Q = Q;
  connect(port_1a, sensor1.portMoistAir_a) annotation(Line(points = {{-100, 60}, {-84, 60}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(port_2a, sensor2.portMoistAir_a) annotation(Line(points = {{100, -60}, {84, -60}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volume1.portMoistAir_b, port_1b) annotation(Line(points = {{-40, -10}, {-40, -60}, {-100, -60}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(sensor1.portMoistAir_b, pressureLoss1.portMoistAir_a) annotation(Line(points = {{-64, 60}, {-40, 60}, {-40, 50}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pressureLoss1.portMoistAir_b, volume1.portMoistAir_a) annotation(Line(points = {{-40, 30}, {-40, 10}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(sensor2.portMoistAir_b, pressureLoss2.portMoistAir_a) annotation(Line(points = {{64, -60}, {40, -60}, {40, -50}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pressureLoss2.portMoistAir_b, volume2.portMoistAir_a) annotation(Line(points = {{40, -30}, {40, -10}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volume2.portMoistAir_b, sensor3.portMoistAir_a) annotation(Line(points = {{40, 10}, {40, 60}, {60, 60}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(sensor3.portMoistAir_b, port_2b) annotation(Line(points = {{80, 60}, {100, 60}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volume2.heatPort, simpleHeatTransfer.port_a) annotation(Line(points = {{30, 0}, {10, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(simpleHeatTransfer.port_b, volume1.heatPort) annotation(Line(points = {{-10, 0}, {-30, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-80, 80}, {-80, -80}, {80, 80}, {-80, 80}}, lineColor = {175, 175, 175}, smooth = Smooth.None, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{-80, -80}, {80, -80}, {80, 80}, {-80, -80}}, lineColor = {175, 175, 175}, smooth = Smooth.None, fillColor = {255, 85, 85}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(revisions = "<html>
 <p>12.01.2014, Peter Matthes</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This model extends <a href=\"AixLib.HVAC.HeatExchanger.RecuperatorNoMediumVarcp\">RecuperatorNoMediumVarcp</a> as computational core (heat exchange model). </p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The hydraulic components are taken from other packages to facilitate heat exchange (<a href=\"Volume.VolumeMoistAir\">Volume.VolumeMoistAir</a>), sensors for medium temperature (<a href=\"Sensors.PropertySensorMoistAir\">Sensors.PropertySensorMoistAir</a>) and pressure loss (<a href=\"Ductwork.PressureLoss\">Ductwork.PressureLoss</a>). The necessary inputs for the heat exchange model will be taken from the medium components. The heat transfer from one medium to the other will be calculated by the heat exchange model. The heat flow occurs through the <a href=\"HeatExchanger.BaseClasses.SimpleHeatTransfer\">HeatExchanger.BaseClasses.SimpleHeatTransfer</a> model.</p>
 <p><b><font style=\"color: #008000; \">References</font></b> </p>
 <table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
 <td><p>[Wetter1999]</p></td>
 <td><p>Wetter, M.: Simulation Model -- Air-to-Air Plate Heat Exchanger, Techreport, <i>Ernest Orlando Lawrence Berkeley National Laboratory, Berkeley, CA (US), </i><b>1999</b>, URL: <a href=\"http://simulationresearch.lbl.gov/dirpubs/42354.pdf\">http://simulationresearch.lbl.gov/dirpubs/42354.pdf</a></p></td>
 </tr>
 <tr>
 <td><p>[Jurges1924]</p></td>
 <td><p>Jurges, W.: Gesundheitsingenieur, Nr. 19. (1) <b>1924</b></p></td>
 </tr>
 <tr>
 <td><p>[McAdams1954]</p></td>
 <td><p>McAdams, W. H.: Heat Transmission, 3rd ed., McGraw-Hill, <i>New York</i> <b>1954</b></p><h4><span style=\"color:#008000\">Example Results</span></h4><p><a href=\"modelica://AixLib.HVAC.HeatExchanger.Examples.Medium\">AixLib.HVAC.HeatExchanger.Examples.Medium</a> </p></td>
 </tr>
 </table>
 </html>"));
end Recuperator;