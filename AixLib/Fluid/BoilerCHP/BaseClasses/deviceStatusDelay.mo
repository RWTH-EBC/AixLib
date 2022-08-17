within AixLib.Fluid.BoilerCHP.BaseClasses;
model deviceStatusDelay
    extends Modelica.Blocks.Icons.DiscreteBlock;
  Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop
    annotation (Placement(transformation(extent={{32,-16},{52,4}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{210,12},{230,32}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{-36,-48},{-16,-28}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=
        thresholdTimer)
    annotation (Placement(transformation(extent={{-8,-48},{12,-28}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{242,-4},{262,16}})));

  parameter Modelica.Units.SI.Time thresholdTimer
    "Time after which the device can be turned off again";
  Modelica.Blocks.Interfaces.BooleanInput
                                       u
    annotation (Placement(transformation(extent={{-134,-20},{-94,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{266,-4},{286,16}})));
  Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop1
    annotation (Placement(transformation(extent={{-64,-48},{-44,-28}})));
  Modelica.Blocks.Logical.Pre pre2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-14,-68})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-72,-76},{-92,-56}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-86,-104},{-66,-84}})));
equation
  connect(timer.y, greaterThreshold1.u)
    annotation (Line(points={{-15,-38},{-10,-38}}, color={0,0,127}));
  connect(rSFlipFlop.Q, logicalSwitch.u2)
    annotation (Line(points={{53,0},{108,0},{108,6},{240,6}},
                                                           color={255,0,255}));
  connect(booleanExpression.y, logicalSwitch.u1) annotation (Line(points={{231,22},
          {238,22},{238,14},{240,14}},
                                    color={255,0,255}));
  connect(logicalSwitch.y, y)
    annotation (Line(points={{263,6},{276,6}},color={255,0,255}));
  connect(timer.u, rSFlipFlop1.Q) annotation (Line(points={{-38,-38},{-40,-38},
          {-40,-32},{-43,-32}}, color={255,0,255}));
  connect(greaterThreshold1.y, rSFlipFlop.R)
    annotation (Line(points={{13,-38},{30,-38},{30,-12}}, color={255,0,255}));
  connect(u, rSFlipFlop1.S)
    annotation (Line(points={{-114,0},{-66,0},{-66,-32}}, color={255,0,255}));
  connect(u, rSFlipFlop.S)
    annotation (Line(points={{-114,0},{30,0}}, color={255,0,255}));
  connect(u, logicalSwitch.u3) annotation (Line(points={{-114,0},{18,0},{18,-22},
          {72,-22},{72,-2},{240,-2}}, color={255,0,255}));
  connect(greaterThreshold1.y, pre2.u) annotation (Line(points={{13,-38},{30,
          -38},{30,-68},{-2,-68}}, color={255,0,255}));
  connect(pre2.y, and1.u1) annotation (Line(points={{-25,-68},{-46,-68},{-46,
          -66},{-70,-66}}, color={255,0,255}));
  connect(u, not1.u) annotation (Line(points={{-114,0},{-114,-94},{-88,-94}},
        color={255,0,255}));
  connect(not1.y, and1.u2) annotation (Line(points={{-65,-94},{-56,-94},{-56,
          -74},{-70,-74}}, color={255,0,255}));
  connect(and1.y, rSFlipFlop1.R) annotation (Line(points={{-93,-66},{-100,-66},
          {-100,-44},{-66,-44}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  When the input signal exceeds the given <code>thresholdInput</code>
  value the output will be hold on true independent from the input
  value and the timer starts counting. After the moment when
  <code>thresholdTimer</code> is exceeded the output signal can switch
  to false but will stay true until the input value is greater the
  <code>thresholdInput</code> value.
</p>
</html>", revisions="<html>
<ul>
  <li>October 10, 2019, by David Jansen:<br/>
    Implemented model
  </li>
</ul>
</html>"));
end deviceStatusDelay;
