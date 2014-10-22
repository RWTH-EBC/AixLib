within AixLib.HVAC.HeatExchanger.Examples.NoMedium;

model Test_RecuperatorNoMedium
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp m1flow(duration = 1, offset = 1, startTime = 1.5, height = -0.5) annotation(Placement(transformation(extent = {{-72, 0}, {-52, 20}})));
  Modelica.Blocks.Sources.Ramp m2flow(duration = 1, offset = 1, startTime = 1.5, height = -0.9) annotation(Placement(transformation(extent = {{66, -20}, {46, 0}})));
  Modelica.Blocks.Sources.Ramp T1in(duration = 1, offset = 273.15 + 5, height = 10) annotation(Placement(transformation(extent = {{66, 10}, {46, 30}})));
  Modelica.Blocks.Sources.Ramp T2in(height = 0, duration = 1, offset = 273.15 + 26) annotation(Placement(transformation(extent = {{-72, -30}, {-52, -10}})));
  RecuperatorNoMedium recuperatorNoMedium1(flowType = 1) annotation(Placement(transformation(extent = {{-10, 50}, {10, 70}})));
  RecuperatorNoMedium recuperatorNoMedium2(flowType = 2) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  RecuperatorNoMedium recuperatorNoMedium3(T1in0 = 273.15 + 5, T1out0 = 273.15 + 22.123622, T2in0 = 273.15 + 26, m_flow10 = 0.3, m_flow20 = 0.3, NTU0(start = 4.3815)) annotation(Placement(transformation(extent = {{-10, -70}, {10, -50}})));
equation
  connect(m2flow.y, recuperatorNoMedium3.m1in) annotation(Line(points = {{45, -10}, {26, -10}, {26, -56}, {10, -56}}, color = {128, 0, 255}, smooth = Smooth.None));
  connect(T1in.y, recuperatorNoMedium3.T1in) annotation(Line(points = {{45, 20}, {28, 20}, {28, -52}, {10, -52}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(T2in.y, recuperatorNoMedium3.T2in) annotation(Line(points = {{-51, -20}, {-30, -20}, {-30, -68}, {-10, -68}}, color = {255, 85, 85}, smooth = Smooth.None));
  connect(m1flow.y, recuperatorNoMedium3.m2in) annotation(Line(points = {{-51, 10}, {-32, 10}, {-32, -64}, {-10, -64}}, color = {0, 128, 255}, smooth = Smooth.None));
  connect(T2in.y, recuperatorNoMedium2.T2in) annotation(Line(points = {{-51, -20}, {-30, -20}, {-30, -8}, {-10, -8}}, color = {255, 85, 85}, smooth = Smooth.None));
  connect(m1flow.y, recuperatorNoMedium2.m2in) annotation(Line(points = {{-51, 10}, {-32, 10}, {-32, -4}, {-10, -4}}, color = {0, 128, 255}, smooth = Smooth.None));
  connect(T2in.y, recuperatorNoMedium1.T2in) annotation(Line(points = {{-51, -20}, {-30, -20}, {-30, 52}, {-10, 52}}, color = {255, 85, 85}, smooth = Smooth.None));
  connect(m1flow.y, recuperatorNoMedium1.m2in) annotation(Line(points = {{-51, 10}, {-32, 10}, {-32, 56}, {-10, 56}}, color = {0, 128, 255}, smooth = Smooth.None));
  connect(T1in.y, recuperatorNoMedium2.T1in) annotation(Line(points = {{45, 20}, {28, 20}, {28, 8}, {10, 8}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(m2flow.y, recuperatorNoMedium2.m1in) annotation(Line(points = {{45, -10}, {26, -10}, {26, 4}, {10, 4}}, color = {128, 0, 255}, smooth = Smooth.None));
  connect(T1in.y, recuperatorNoMedium1.T1in) annotation(Line(points = {{45, 20}, {28, 20}, {28, 68}, {10, 68}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(m2flow.y, recuperatorNoMedium1.m1in) annotation(Line(points = {{45, -10}, {26, -10}, {26, 64}, {10, 64}}, color = {128, 0, 255}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{30, -74}, {98, -96}}, lineColor = {135, 135, 135}, textString = "1: counter-current flow
 2: co-current flow
 3: cross flow", horizontalAlignment = TextAlignment.Left)}), experiment(StopTime = 3), __Dymola_experimentSetupOutput, Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Testing each flow arrangement. </p>
 <p>Take care of initial conditions! Parallel flow cannot have an efficiency above 0.5.</p>
 </html>"));
end Test_RecuperatorNoMedium;