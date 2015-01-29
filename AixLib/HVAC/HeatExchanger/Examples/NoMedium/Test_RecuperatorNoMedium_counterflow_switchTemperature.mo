within AixLib.HVAC.HeatExchanger.Examples.NoMedium;
model Test_RecuperatorNoMedium_counterflow_switchTemperature
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp m2flow(duration = 1, startTime = 1.5, offset = recuperatorNoMedium3.m_flow20, height = 0) annotation(Placement(transformation(extent = {{-72, 0}, {-52, 20}})));
  Modelica.Blocks.Sources.Ramp m1flow(duration = 1, offset = recuperatorNoMedium3.m_flow10, startTime = 0, height = 0) annotation(Placement(transformation(extent = {{66, -20}, {46, 0}})));
  Modelica.Blocks.Sources.Ramp T1in(duration = 1, offset = recuperatorNoMedium3.T1in0, height = recuperatorNoMedium3.T2in0 - recuperatorNoMedium3.T1in0, startTime = 0.5) annotation(Placement(transformation(extent = {{66, 10}, {46, 30}})));
  Modelica.Blocks.Sources.Ramp T2in(duration = 1, offset = recuperatorNoMedium3.T2in0, height = recuperatorNoMedium3.T1in0 - recuperatorNoMedium3.T2in0, startTime = 2) annotation(Placement(transformation(extent = {{-72, -30}, {-52, -10}})));
  RecuperatorNoMedium recuperatorNoMedium3(T1in0 = 273.15 + 5, T2in0 = 273.15 + 26, T1out0 = 273.15 + 22.76911287, m_flow10 = 0.0532444444444444, m_flow20 = 0.0532542382284563, NTU0(start = 5.280922181), expo = 0.55, flowType = 3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp T1out_ideal(duration = 1, offset = 22.76911287 + 273.15, startTime = 1.5, height = 21.44346553 - 22.76911287) annotation(Placement(transformation(extent = {{-10, -58}, {10, -38}})));
  Modelica.Blocks.Math.Add subtract(k2 = -1) annotation(Placement(transformation(extent = {{22, -50}, {32, -40}})));
  Modelica.Blocks.Math.Division division annotation(Placement(transformation(extent = {{44, -50}, {54, -40}})));
  Modelica.Blocks.Sources.Ramp T2out_ideal(duration = 1, offset = 8.47730010108955 + 273.15, startTime = 1.5, height = 9.790807952 - 8.47730010108955) annotation(Placement(transformation(extent = {{10, 40}, {-10, 60}})));
  Modelica.Blocks.Math.Add subtract2(k1 = -1) annotation(Placement(transformation(extent = {{-22, 42}, {-32, 52}})));
  Modelica.Blocks.Math.Division division2 annotation(Placement(transformation(extent = {{-42, 42}, {-52, 52}})));
equation
  connect(m1flow.y, recuperatorNoMedium3.m1in) annotation(Line(points = {{45, -10}, {26, -10}, {26, 4}, {10, 4}}, color = {128, 0, 255}, smooth = Smooth.None));
  connect(T1in.y, recuperatorNoMedium3.T1in) annotation(Line(points = {{45, 20}, {28, 20}, {28, 8}, {10, 8}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(T2in.y, recuperatorNoMedium3.T2in) annotation(Line(points = {{-51, -20}, {-30, -20}, {-30, -8}, {-10, -8}}, color = {255, 85, 85}, smooth = Smooth.None));
  connect(m2flow.y, recuperatorNoMedium3.m2in) annotation(Line(points = {{-51, 10}, {-32, 10}, {-32, -4}, {-10, -4}}, color = {0, 128, 255}, smooth = Smooth.None));
  connect(recuperatorNoMedium3.T1out, subtract.u1) annotation(Line(points = {{10, -6}, {16, -6}, {16, -42}, {21, -42}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(T1out_ideal.y, subtract.u2) annotation(Line(points = {{11, -48}, {21, -48}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(subtract.y, division.u1) annotation(Line(points = {{32.5, -45}, {37.25, -45}, {37.25, -42}, {43, -42}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(T1out_ideal.y, division.u2) annotation(Line(points = {{11, -48}, {16, -48}, {16, -56}, {38, -56}, {38, -48}, {43, -48}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(T2out_ideal.y, subtract2.u1) annotation(Line(points = {{-11, 50}, {-21, 50}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(recuperatorNoMedium3.T2out, subtract2.u2) annotation(Line(points = {{-10, 8}, {-16, 8}, {-16, 44}, {-21, 44}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(T2out_ideal.y, division2.u2) annotation(Line(points = {{-11, 50}, {-16, 50}, {-16, 60}, {-36, 60}, {-36, 44}, {-41, 44}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(subtract2.y, division2.u1) annotation(Line(points = {{-32.5, 47}, {-38.25, 47}, {-38.25, 50}, {-41, 50}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Text(extent = {{30, -74}, {98, -96}}, lineColor = {135, 135, 135}, textString = "1: counter-current flow
 2: co-current flow
 3: cross flow", horizontalAlignment = TextAlignment.Left)}), experiment(StopTime = 3.5), __Dymola_experimentSetupOutput, Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Test the model with the extreme case of temperature difference between the media becomes zero. This kind of test is important for dynamic simulations to understand how the model can be used or improved. No temeprature difference seems to be no problem for the model (in contrast to the case where the mass flow rate will go to zero).</p>
 </html>"));
end Test_RecuperatorNoMedium_counterflow_switchTemperature;

