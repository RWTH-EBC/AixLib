within AixLib.Systems.ModularEnergySystems.ControlUnity;
model deviceStatusDelay
    extends Modelica.Blocks.Icons.DiscreteBlock;

  parameter Modelica.SIunits.Time time_minOff = 900
    "Time after which the device can be turned on again";
  parameter Modelica.SIunits.Time time_minOn = 900
    "Time after which the device can be turned off again";
  parameter Boolean use_safetyShutoff = false
    "Set true, to enable an additional boolean input to perform manual shutoffs for security reasons without messing up the timer" annotation (
        choices(checkBox=true));
  Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop
    annotation (Placement(transformation(extent={{-28,40},{-8,60}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{4,46},{24,66}})));
  Modelica.Blocks.Logical.Change change_input
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-16})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch_hold
    annotation (Placement(transformation(extent={{60,-42},{80,-22}})));
  Modelica.Blocks.Logical.Pre pre_onHold annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={20,-20})));
  Modelica.Blocks.Logical.Pre pre_hold annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,0})));
  Modelica.Blocks.Logical.Pre pre_reset annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={16,18})));
  Modelica.Blocks.Logical.Change change_output
    annotation (Placement(transformation(extent={{-90,56},{-70,76}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-58,56},{-38,76}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch_onOffTimer
    annotation (Placement(transformation(extent={{66,46},{86,66}})));
  Modelica.Blocks.Logical.GreaterThreshold minOff(threshold=time_minOff)
    annotation (Placement(transformation(extent={{34,30},{54,50}})));
  Modelica.Blocks.Logical.GreaterThreshold minOn(threshold=time_minOn)
    annotation (Placement(transformation(extent={{34,62},{54,82}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-48,34})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{60,-82},{80,-62}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Modelica.Blocks.Interfaces.BooleanInput
                                       u "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Connector of Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput u_safety if use_safetyShutoff
    "set true, to force shutoff and hold until false"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression if not
    use_safetyShutoff
    annotation (Placement(transformation(extent={{-120,-66},{-100,-46}})));
equation
  connect(rSFlipFlop.Q,timer. u)
    annotation (Line(points={{-7,56},{2,56}}, color={255,0,255}));
  connect(u,change_input. u) annotation (Line(points={{-120,0},{-96,0},{-96,-40},
          {-80,-40},{-80,-28}},
                     color={255,0,255}));
  connect(u,logicalSwitch_hold. u3) annotation (Line(points={{-120,0},{-96,0},{
          -96,-40},{58,-40}}, color={255,0,255}));
  connect(rSFlipFlop.Q,pre_onHold. u) annotation (Line(points={{-7,56},{-4,56},
          {-4,-20},{8,-20}}, color={255,0,255}));
  connect(pre_hold.y,logicalSwitch_hold. u1) annotation (Line(points={{59,0},{
          50,0},{50,-24},{58,-24}}, color={255,0,255}));
  connect(pre_onHold.y,logicalSwitch_hold. u2) annotation (Line(points={{31,-20},
          {40,-20},{40,-32},{58,-32}}, color={255,0,255}));
  connect(or1.y,rSFlipFlop. S) annotation (Line(points={{-37,66},{-34,66},{-34,
          56},{-30,56}},   color={255,0,255}));
  connect(or1.u1,change_output. y)
    annotation (Line(points={{-60,66},{-69,66}}, color={255,0,255}));
  connect(minOff.y,logicalSwitch_onOffTimer. u3) annotation (Line(points={{55,40},
          {58,40},{58,48},{64,48}},     color={255,0,255}));
  connect(minOn.y,logicalSwitch_onOffTimer. u1) annotation (Line(points={{55,72},
          {58,72},{58,64},{64,64}}, color={255,0,255}));
  connect(timer.y,minOn. u) annotation (Line(points={{25,56},{28,56},{28,72},{
          32,72}}, color={0,0,127}));
  connect(timer.y,minOff. u) annotation (Line(points={{25,56},{28,56},{28,40},{
          32,40}}, color={0,0,127}));
  connect(logicalSwitch_onOffTimer.y,pre_reset. u) annotation (Line(points={{87,56},
          {90,56},{90,18},{28,18}},     color={255,0,255}));
  connect(and1.y,y)  annotation (Line(points={{81,-72},{96,-72},{96,0},{110,0}},
        color={255,0,255}));
  connect(and1.y,logicalSwitch_onOffTimer. u2) annotation (Line(points={{81,-72},
          {96,-72},{96,90},{60,90},{60,56},{64,56}}, color={255,0,255}));
  connect(logicalSwitch_hold.y,and1. u1) annotation (Line(points={{81,-32},{88,
          -32},{88,-52},{50,-52},{50,-72},{58,-72}}, color={255,0,255}));
  connect(and1.y,pre_hold. u) annotation (Line(points={{81,-72},{96,-72},{96,0},
          {82,0}}, color={255,0,255}));
  connect(u_safety,not1. u)
    annotation (Line(points={{-120,-80},{-92,-80}},color={255,0,255}));
  connect(not1.y,and1. u2)
    annotation (Line(points={{-69,-80},{58,-80}},color={255,0,255}));
  connect(and1.y,change_output. u) annotation (Line(points={{81,-72},{96,-72},{
          96,90},{-96,90},{-96,66},{-92,66}}, color={255,0,255}));
  connect(rSFlipFlop.R,or2. y) annotation (Line(points={{-30,44},{-34,44},{-34,
          34},{-37,34}}, color={255,0,255}));
  connect(pre_reset.y,or2. u1) annotation (Line(points={{5,18},{-64,18},{-64,34},
          {-60,34}}, color={255,0,255}));
  connect(change_output.y,or2. u2) annotation (Line(points={{-69,66},{-64,66},{
          -64,42},{-60,42}}, color={255,0,255}));
  connect(or1.u2, and2.y) annotation (Line(points={{-60,58},{-68,58},{-68,50},{
          -80,50},{-80,41}}, color={255,0,255}));
  connect(not1.y, and2.u2) annotation (Line(points={{-69,-80},{-60,-80},{-60,0},
          {-72,0},{-72,18}}, color={255,0,255}));
  connect(change_input.y, and2.u1)
    annotation (Line(points={{-80,-5},{-80,18}}, color={255,0,255}));
  connect(booleanExpression.y, not1.u) annotation (Line(points={{-99,-56},{-96,
          -56},{-96,-80},{-92,-80}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The model makes sure that an on signal is only passed through if the device was on for a given time <span style=\"font-family: Courier New;\">thresholdTimer</span> asdf</p>
<p><br>When the input signal is set to true the given <span style=\"font-family: Courier New;\">thresholdTimer</span>  starts counting. After the moment when <span style=\"font-family: Courier New;\">thresholdTimer</span> is exceeded the output signal can switch to false but will stay true until the input value is set to false again. Then again the timer start to count and the output won&apos;t change to true until the timer is finished again.</p>
</html>", revisions="<html>
<ul>
<li>
October 10, 2019, by David Jansen:<br/>
Implemented model
</ul>
</html>"));
end deviceStatusDelay;
