within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model PITempOpe "PI controller"

  Modelica.Blocks.Interfaces.RealInput setPoint annotation (Placement(
        transformation(
        origin={-80,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  parameter Boolean powerLimitOrUnlimited = false "true if power limited or false if only temperature set point is used" annotation(choices(choice =  false
        "Unlimited",choice = true "System has a limited power output",radioButtons = true));
  parameter Real h = 1 "upper limit controller output" annotation(Dialog(group = "Control"));
  parameter Real l = 0 "lower limit of controller output" annotation(Dialog(group = "Control"));
  parameter Real KR = 1 "Gain" annotation(Dialog(group = "Control"));
  parameter Modelica.SIunits.Time TN = 1 "Time Constant (T>0 required)" annotation(Dialog(group = "Control"));
  parameter Real p = 0 "Power" annotation(Dialog(group = "Control"));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent={{90,-10},
            {110,10}}),                                                                                         iconTransformation(extent={{90,-10},
            {110,10}})));
  parameter Boolean rangeSwitch = false "Switch controller output range";
  Modelica.Blocks.Interfaces.BooleanInput onOff "Switches Controller on and off" annotation(Placement(transformation(extent = {{-120, -80}, {-80, -40}}), iconTransformation(extent = {{-100, -60}, {-80, -40}})));
  Modelica.Blocks.Logical.Switch switch2 annotation(Placement(transformation(extent={{18,-10},
            {38,10}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(rising = 0, falling = 60) annotation(Placement(transformation(extent={{-50,-60},
            {-30,-40}})));
  Modelica.Blocks.Math.Product product annotation(Placement(transformation(extent={{-16,-26},
            {4,-46}})));
  Modelica.Blocks.Continuous.LimPID PI(k = KR, yMax = if rangeSwitch then -l else h, yMin = if rangeSwitch then -h else l, controllerType = Modelica.Blocks.Types.SimpleController.PI, Ti = TN, Td = 0.1) annotation(Placement(transformation(extent={{-28,30},
            {-8,50}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-64,8},{-44,28}})));
  Modelica.Blocks.Interfaces.RealInput TOpe "Input for operative temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-100})));
equation
  connect(onOff, switch2.u2) annotation(Line(points={{-100,-60},{-78,-60},{-78,-18},
          {-26,-18},{-26,0},{16,0}},                                                                                                                color = {255, 0, 255}));
  connect(onOff, triggeredTrapezoid.u) annotation(Line(points={{-100,-60},{-78,-60},
          {-78,-32},{-54,-32},{-54,-50},{-52,-50}},                                                                                        color = {255, 0, 255}));
  connect(triggeredTrapezoid.y, product.u1) annotation(Line(points={{-29,-50},{-20,
          -50},{-20,-42},{-18,-42}},                                                          color = {0, 0, 127}));
  connect(product.y, switch2.u3) annotation(Line(points={{5,-36},{16,-36},{16,-8}},                     color = {0, 0, 127}));
  connect(PI.y, switch2.u1) annotation(Line(points={{-7,40},{-2,40},{-2,8},{16,8}},         color = {0, 0, 127}));
  connect(PI.y, product.u2) annotation(Line(points={{-7,40},{-6,40},{-6,-6},{-18,
          -6},{-18,-30}},                                                                       color = {0, 0, 127}));
  connect(setPoint, PI.u_s)
    annotation (Line(points={{-80,90},{-80,40},{-30,40}}, color={0,0,127}));
  connect(onOff, switch1.u2) annotation (Line(points={{-100,-60},{-78,-60},{-78,18},
          {-66,18}},     color={255,0,255}));
  connect(switch1.y, PI.u_m)
    annotation (Line(points={{-43,18},{-18,18},{-18,28}},
                                                        color={0,0,127}));
  connect(setPoint, switch1.u3)
    annotation (Line(points={{-80,90},{-80,10},{-66,10}}, color={0,0,127}));
  connect(TOpe, switch1.u1)
    annotation (Line(points={{-60,-100},{-60,-48},{-72,-48},{-72,26},{-66,26}},
                                                            color={0,0,127}));
  connect(y, y) annotation (Line(points={{100,0},{100,0}}, color={0,0,127}));
  connect(switch2.y, y)
    annotation (Line(points={{39,0},{100,0}}, color={0,0,127}));
  annotation (Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
Basic structure adopted from <a href=\"AixLib.Controls.Continuous.PITemp\">AixLib.Controls.Continuous.PITemp</a>. Excerpt from the corresponding documentation:
</p>
<p>
<i>
  Based on a model by Alexander Hoh with some modifications and the
  Modelica-Standard PI controller. If set to \"on\" it will control the
  thermal port temperature to the target value (soll). If set to \"off\"
  the controller error will become zero and therefore the current
  output level of the PI controller will remain constant. When this
  switching occurs the TriggeredTrapezoid will level the current
  controller output down to zero in a selectable period of time.
</i>
</p>
<p>
Unlike the original model, this model uses the operative temperature as a measurement input signal. 
</p>
</html> ",
        revisions="<html><ul>
  <li>
  <i>March, 2021&#160;</i> by Christian Wenzel:<br/>
    First implementation
  </li>
</ul>
</html>"), Icon(graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}));
end PITempOpe;
