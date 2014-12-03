within AixLib.HVAC.HeatExchanger.Examples.Medium;


model DoubleHX_mflow
  "Testing double HX configuration and changing the mass flow rate"
  import Anlagensimulation_WS1314 = AixLib.HVAC;
  extends Modelica.Icons.Example;
  Sources.BoundaryMoistAir_phX Medium1out(use_p_in = false, X = 0, p = 101325, h = 25e3) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin = {-60, -40})));
  inner Anlagensimulation_WS1314.BaseParameters baseParameters annotation(Placement(transformation(extent = {{60, 66}, {80, 86}})));
  Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium1in(m = 0.075, X = 0, use_m_in = true, h = 5.03e3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-60, 20})));
  Anlagensimulation_WS1314.HeatExchanger.Recuperator HX(flowType = 1, pressureLoss1(dp(start = 40)), pressureLoss2(dp(start = 40)), port_2a(m_flow(start = 0.079866)), volume1(T(start = 273.15 + 15), T0 = 273.15 + 15)) annotation(Placement(transformation(extent = {{-16, -4}, {16, 26}})));
  Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium2in(m = 0.075, X = 0, use_m_in = true, h = 26.13e3) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {60, -40})));
  Sources.BoundaryMoistAir_phX Medium2out(use_p_in = false, X = 0, p = 101325, h = 6e3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {60, 20})));
  Modelica.Blocks.Sources.Ramp mflow(duration = 1, startTime = 1, height = 0.01 - HX.m_flow10, offset = HX.m_flow10) annotation(Placement(transformation(extent = {{-100, 40}, {-80, 60}})));
  Anlagensimulation_WS1314.HeatExchanger.Recuperator HX1(flowType = 1, pressureLoss1(dp(start = 40)), pressureLoss2(dp(start = 40)), port_1a(m_flow(start = 0.079866)), volume2(T(start = 273.15 + 16), T0 = 273.15 + 16)) annotation(Placement(transformation(extent = {{-16, -46}, {16, -16}})));
equation
  connect(Medium1in.portMoistAir_a, HX.port_1a) annotation(Line(points = {{-50, 20}, {-16, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(mflow.y, Medium1in.m_in) annotation(Line(points = {{-79, 50}, {-72, 50}, {-72, 28}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(mflow.y, Medium2in.m_in) annotation(Line(points = {{-79, 50}, {72, 50}, {72, -32}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Medium2in.portMoistAir_a, HX1.port_2a) annotation(Line(points = {{50, -40}, {16, -40}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(HX.port_2b, Medium2out.portMoistAir_a) annotation(Line(points = {{16, 20}, {50, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(HX1.port_1b, Medium1out.portMoistAir_a) annotation(Line(points = {{-16, -40}, {-50, -40}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(HX1.port_2b, HX.port_2a) annotation(Line(points = {{16, -22}, {24, -22}, {24, 2}, {16, 2}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(HX.port_1b, HX1.port_1a) annotation(Line(points = {{-16, 2}, {-24, 2}, {-24, -22}, {-16, -22}}, color = {0, 127, 255}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>A small example of two coupled heat exchangers with varying mass flow rate of both media.</p>
 </html>", revisions = "<html>
 <p>12.01.2014, Peter Matthes</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"), experiment(StopTime = 3), __Dymola_experimentSetupOutput);
end DoubleHX_mflow;
