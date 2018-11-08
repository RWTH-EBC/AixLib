within AixLib.Controls.Continuous;
model PITempThreshold
  "PI controller that can switch the output range of the controller"

  Modelica.Blocks.Interfaces.RealInput setPoint annotation (Placement(
        transformation(
        origin={-80,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation (
      Placement(transformation(extent={{-70,-100},{-50,-80}}),
        iconTransformation(extent={{-70,-100},{-50,-80}})));
  parameter Real h = 1 "upper limit controller output" annotation(Dialog(group = "Control"));
  parameter Real l = 0 "lower limit of controller output" annotation(Dialog(group = "Control"));
  parameter Real KR = 1 "Gain" annotation(Dialog(group = "Control"));
  parameter Modelica.SIunits.Time TN = 1 "Time Constant (T>0 required)" annotation(Dialog(group = "Control"));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{80, -10}, {100, 10}}), iconTransformation(extent = {{80, -10}, {100, 10}})));
  parameter Boolean rangeSwitch = false "Switch controller output range";
  Modelica.Blocks.Interfaces.BooleanInput onOff "Switches Controler on and off" annotation(Placement(transformation(extent = {{-120, -80}, {-80, -40}}), iconTransformation(extent = {{-100, -60}, {-80, -40}})));
  Modelica.Blocks.Logical.Switch switch1 annotation(Placement(transformation(extent={{-20,10},
            {0,-10}})));
  Modelica.Blocks.Logical.Switch switch2 annotation(Placement(transformation(extent = {{56, -18}, {76, 2}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(rising = 0, falling = 60) annotation(Placement(transformation(extent = {{-40, -60}, {-20, -40}})));
  Modelica.Blocks.Math.Product product annotation(Placement(transformation(extent = {{26, -34}, {46, -54}})));
  Modelica.Blocks.Continuous.LimPID PI(k = KR, yMax = if rangeSwitch then -l else h, yMin = if rangeSwitch then -h else l, controllerType = Modelica.Blocks.Types.SimpleController.PI, Ti = TN, Td = 0.1) annotation(Placement(transformation(extent={{-4,30},
            {16,50}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(Placement(transformation(origin = {-60, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-17,82},{17,114}}),  iconTransformation(
    extent={{-14,84},{14,112}})));
  Modelica.Blocks.Logical.Less less annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-16,60})));
  Modelica.Blocks.Sources.Constant TAirThreshold(k=273.15 + 15)
    annotation (Placement(transformation(extent={{-46,82},{-34,94}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-86,-18},{-66,2}})));
equation
  connect(switch2.y, y) annotation(Line(points = {{77, -8}, {79.5, -8}, {79.5, 0}, {90, 0}}, color = {0, 0, 127}));
  connect(triggeredTrapezoid.y, product.u1) annotation(Line(points = {{-19, -50}, {24, -50}}, color = {0, 0, 127}));
  connect(product.y, switch2.u3) annotation(Line(points = {{47, -44}, {50, -44}, {50, -16}, {54, -16}}, color = {0, 0, 127}));
  connect(switch1.y, PI.u_m) annotation(Line(points={{1,0},{6,0},{6,28}},              color = {0, 0, 127}));
  connect(PI.y, switch2.u1) annotation(Line(points={{17,40},{34,40},{34,0},{54,
          0}},                                                                              color = {0, 0, 127}));
  connect(PI.y, product.u2) annotation(Line(points={{17,40},{20,40},{20,-38},{
          24,-38}},                                                                             color = {0, 0, 127}));
  connect(setPoint, PI.u_s)
    annotation (Line(points={{-80,90},{-80,40},{-6,40}},  color={0,0,127}));
  connect(setPoint, switch1.u3) annotation (Line(points={{-80,90},{-80,8},{-22,
          8}},         color={0,0,127}));
  connect(temperatureSensor.port, heatPort)
    annotation (Line(points={{-60,-80},{-60,-90}}, color={191,0,0}));
  connect(temperatureSensor.T, switch1.u1) annotation(Line(points={{-60,-60},{
          -60,-8},{-22,-8}},                                                                              color = {0, 0, 127}));
  connect(and1.y, switch1.u2) annotation (Line(points={{-65,-8},{-62,-8},{-62,0},
          {-22,0}}, color={255,0,255}));
  connect(and1.y, triggeredTrapezoid.u) annotation (Line(points={{-65,-8},{-62,
          -8},{-62,-50},{-42,-50}}, color={255,0,255}));
  connect(and1.y, switch2.u2) annotation (Line(points={{-65,-8},{-62,-8},{-62,
          -18},{38,-18},{38,-8},{54,-8}}, color={255,0,255}));
  connect(onOff, and1.u2) annotation (Line(points={{-100,-60},{-100,-16},{-88,
          -16}}, color={255,0,255}));
  connect(less.y, and1.u1) annotation (Line(points={{-16,49},{-16,46},{-100,46},
          {-100,-8},{-88,-8}}, color={255,0,255}));
  connect(TAirThreshold.y, less.u2)
    annotation (Line(points={{-33.4,88},{-24,88},{-24,72}}, color={0,0,127}));
  connect(weaBus.TDryBul, less.u1) annotation (Line(
      points={{0,98},{0,82},{-16,82},{-16,72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>
 Based on a model by Alexander Hoh with some modifications and the Modelica-Standard PI controller. If set to &quot;on&quot; it will controll the thermal port temperature to the target value (soll). If set to &quot;off&quot; the controller error will become zero and therefore the current output level of the PI controller will remain constant. When this switching occurs the TriggeredTrapezoid will level the current controller output down to zero in a selectable period of time.
 </p>
 </html>", revisions = "<html>
 <ul>
   <li><i>April, 2016&nbsp;</i>
          by Peter Remmen:<br/>
          Moved from Utilities to Controls</li>
 </ul>
 <ul>
 <li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li>
          by Peter Matthes:<br/>
          implemented</li>
 </ul>
 </html> "), Icon(graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}));
end PITempThreshold;
