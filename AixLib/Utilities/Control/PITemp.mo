within AixLib.Utilities.Control;

model PITemp "PI Controler that can switch the output range of the controler"
  Modelica.Blocks.Interfaces.RealInput soll annotation(Placement(transformation(origin = {-80, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm1 annotation(Placement(transformation(extent = {{-70, -100}, {-50, -80}}, rotation = 0), iconTransformation(extent = {{-70, -100}, {-50, -80}})));
  parameter Real h = 1 "upper limit controler output" annotation(Dialog(group = "Control"));
  parameter Real l = 0 "lower limit of controler output" annotation(Dialog(group = "Control"));
  parameter Real KR = 1 "Gain" annotation(Dialog(group = "Control"));
  parameter Modelica.SIunits.Time TN = 1 "Time Constant (T>0 required)" annotation(Dialog(group = "Control"));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{80, -10}, {100, 10}}, rotation = 0), iconTransformation(extent = {{80, -10}, {100, 10}})));
  parameter Modelica.Blocks.Interfaces.BooleanInput RangeSwitch = false "Switch controler output range" annotation(Placement(transformation(origin = {80, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 270), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {80, 90})));
  Modelica.Blocks.Interfaces.BooleanInput onOff "Switches Controler on and off" annotation(Placement(transformation(extent = {{-120, -80}, {-80, -40}}, rotation = 0), iconTransformation(extent = {{-100, -60}, {-80, -40}})));
  Modelica.Blocks.Logical.Switch switch1 annotation(Placement(transformation(extent = {{-40, 6}, {-20, -14}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation(Placement(transformation(extent = {{56, -18}, {76, 2}}, rotation = 0)));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(rising = 0, falling = 60) annotation(Placement(transformation(extent = {{-40, -60}, {-20, -40}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(Placement(transformation(extent = {{26, -34}, {46, -54}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PI(k = KR, yMax = if RangeSwitch then -l else h, yMin = if RangeSwitch then -h else l, controllerType = Modelica.Blocks.Types.SimpleController.PI, Ti = TN, Td = 0.1) annotation(Placement(transformation(extent = {{-18, 30}, {2, 50}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(Placement(transformation(origin = {-60, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(onOff, switch1.u2) annotation(Line(points = {{-100, -60}, {-80, -60}, {-80, -4}, {-42, -4}}, color = {255, 0, 255}));
  connect(switch2.y, y) annotation(Line(points = {{77, -8}, {79.5, -8}, {79.5, 0}, {90, 0}}, color = {0, 0, 127}));
  connect(onOff, switch2.u2) annotation(Line(points = {{-100, -60}, {-80, -60}, {-80, -30}, {-16, -30}, {-16, -12}, {30, -12}, {30, -8}, {54, -8}}, color = {255, 0, 255}));
  connect(onOff, triggeredTrapezoid.u) annotation(Line(points = {{-100, -60}, {-80, -60}, {-80, -30}, {-50, -30}, {-50, -50}, {-42, -50}}, color = {255, 0, 255}));
  connect(triggeredTrapezoid.y, product.u1) annotation(Line(points = {{-19, -50}, {24, -50}}, color = {0, 0, 127}));
  connect(product.y, switch2.u3) annotation(Line(points = {{47, -44}, {50, -44}, {50, -16}, {54, -16}}, color = {0, 0, 127}));
  connect(switch1.y, PI.u_m) annotation(Line(points = {{-19, -4}, {-8, -4}, {-8, 28}}, color = {0, 0, 127}));
  connect(PI.y, switch2.u1) annotation(Line(points = {{3, 40}, {24, 40}, {24, 0}, {54, 0}}, color = {0, 0, 127}));
  connect(PI.y, product.u2) annotation(Line(points = {{3, 40}, {14, 40}, {14, -38}, {24, -38}}, color = {0, 0, 127}));
  connect(soll, PI.u_s) annotation(Line(points = {{-80, 90}, {-80, 40}, {-20, 40}}, color = {0, 0, 127}));
  connect(soll, switch1.u3) annotation(Line(points = {{-80, 90}, {-80, 6}, {-42, 6}, {-42, 4}}, color = {0, 0, 127}));
  connect(temperatureSensor.port, Therm1) annotation(Line(points = {{-60, -80}, {-60, -90}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(temperatureSensor.T, switch1.u1) annotation(Line(points = {{-60, -60}, {-60, -12}, {-42, -12}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(graphics), Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>
 Based on a model by Alexander Hoh with some modifications and the Modelica-Standard PI controller. If set to &QUOT;on&QUOT; it will controll the thermal port temperature to the target value (soll). If set to &QUOT;off&QUOT; the controller error will become zero and therefore the current output level of the PI controller will remain constant. When this switching occurs the TriggeredTrapezoid will level the current controller output down to zero in a selectable period of time. 
 </p>
 <p><h4><font color=\"#008000\">Level of Development</font></h4></p>
 <p><img src=\"modelica://AixLib/Images/stars2.png\"/></p>
 </html>", revisions = "<html>
 <ul>
 <li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li>
          by Peter Matthes:<br>
          implemented</li>
 </ul>
 </html> "), Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170}, fillPattern = FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}));
end PITemp;