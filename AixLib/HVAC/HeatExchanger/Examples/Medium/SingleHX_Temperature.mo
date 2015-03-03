within AixLib.HVAC.HeatExchanger.Examples.Medium;
model SingleHX_Temperature "Changing outdoor air temperature"
  import Anlagensimulation_WS1314 = AixLib.HVAC;
  extends Modelica.Icons.Example;
  Sources.BoundaryMoistAir_phX Medium1out(use_p_in = false, X = 0, p = 101325) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin = {-60, -20})));
  inner Anlagensimulation_WS1314.BaseParameters baseParameters annotation(Placement(transformation(extent = {{60, 66}, {80, 86}})));
  Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium1in(X = 0, h = 5.03e3, m = 0.07987, use_m_in = false, use_h_in = true) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-60, 20})));
  Anlagensimulation_WS1314.HeatExchanger.Recuperator HX(flowType = 1) annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}})));
  Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium2in(X = 0, h = 26.13e3, use_m_in = false, m = 0.07987) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {62, -20})));
  Sources.BoundaryMoistAir_phX Medium2out(use_p_in = false, X = 0, p = 101325) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {60, 20})));
  Modelica.Blocks.Sources.Ramp Toda(duration = 1, startTime = 1, height = 20e3, offset = 5.03e3)
    "outdoor air temperature"                                                                                              annotation(Placement(transformation(extent = {{-100, 40}, {-80, 60}})));
equation
  connect(Medium2in.portMoistAir_a, HX.port_2a) annotation(Line(points = {{52, -20}, {36, -20}, {36, -12}, {20, -12}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(HX.port_2b, Medium2out.portMoistAir_a) annotation(Line(points = {{20, 12}, {36, 12}, {36, 20}, {50, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Medium1in.portMoistAir_a, HX.port_1a) annotation(Line(points = {{-50, 20}, {-36, 20}, {-36, 12}, {-20, 12}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(HX.port_1b, Medium1out.portMoistAir_a) annotation(Line(points = {{-20, -12}, {-36, -12}, {-36, -20}, {-50, -20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(Toda.y, Medium1in.h_in) annotation(Line(points = {{-79, 50}, {-76, 50}, {-76, 20}, {-72, 20}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>A small example of an heat exchanger with varying temperature of the cold medium.</p>
 </html>", revisions = "<html>
 <p>12.01.2014, Peter Matthes</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), experiment(StopTime = 3), __Dymola_experimentSetupOutput);
end SingleHX_Temperature;
