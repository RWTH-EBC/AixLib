within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model DelayedOnOffController "CHP On/Off controller"

  parameter Modelica.Units.SI.Temperature maxTReturn
    "Maximum return temperature";
  parameter Modelica.Units.SI.ThermodynamicTemperature minDeltaT
    "Minimum flow and return temperature difference";
  parameter Modelica.Units.SI.ThermodynamicTemperature TFlowRange
    "Range of the flow temperature";
  parameter Modelica.Units.SI.Time delayTime "On/Off delay time";
  parameter Boolean initialOutput=false
    "Initial output";
  parameter Real delayUnit
    "Delay unit";
  parameter Real minCapacity
    "Minimum allowable working capacity in percent";
  Modelica.Blocks.Interfaces.RealInput flowTemp(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Flow temperature"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput returnTemp(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Return temperature"
    annotation (Placement(transformation(
      origin={0,-120},
      extent={{-20,-20},{20,20}},
      rotation=90)));
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Signal if controller is on or off"
    annotation (Placement(transformation(extent={{100,-10},{120,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput controllerOutput
    "Controller output"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput minCapacity_in
    "Minimal capacity"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput externalOn
    "False for shut down"
    annotation (Placement(transformation(
        origin={60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealInput flowTemp_setpoint(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Flow temperature setpoint"
    annotation (Placement(transformation(
      origin={-60,120},
      extent={{-20,-20},{20,20}},
      rotation=270)));
  Modelica.Blocks.Logical.And and1 annotation (Placement(transformation(
        extent={{-22,16},{-8,30}}, rotation=0)));
  Modelica.Blocks.Logical.Pre pre2 annotation (Placement(transformation(
        extent={{-48,-12},{-34,0}}, rotation=0)));
  Modelica.Blocks.Logical.OnOffController onOffController(
    final bandwidth=minDeltaT)
    "OnOff controller"
    annotation (Placement(transformation(extent={{-76,-16},{
          -56,4}}, rotation=0)));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(
    threshold=TFlowRange)
    "Maximum allowable flow temperature variation"
    annotation (Placement(transformation(extent={{-50,38},{-34,54}},
        rotation=0)));
  Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(
        extent={{4,-14},{12,-2}}, rotation=0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(
    threshold=maxTReturn)
    "Max return temperature limit"
    annotation (Placement(transformation(
      origin={0,-50},
      extent={{-8,-8},{8,8}},
      rotation=90)));
  Modelica.Blocks.Discrete.UnitDelay unitDelay(final samplePeriod=delayUnit)
    "Last value"
    annotation (Placement(transformation(extent={{32,-14},{40,-6}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(
      origin={-68,60},
      extent={{-8,-8},{8,8}},
      rotation=270)));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(
      origin={44,51},
      extent={{-5,-6},{5,6}},
      rotation=90)));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(
      origin={62,51},
      extent={{-5,-6},{5,6}},
      rotation=270)));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{72,12},{78,-12}},
        rotation=0)));
  Modelica.Blocks.Logical.Not not3
    annotation (Placement(transformation(extent={{38,86},{26,96}}, rotation=
         0)));
  Modelica.Blocks.Logical.Or or3 annotation (Placement(transformation(
        extent={{16,-10},{24,10}}, rotation=0)));
  Modelica.Blocks.Logical.LessThreshold lessThreshold1(
    final threshold=minCapacity)
    annotation (Placement(transformation(extent={{52,-4},{60,4}}, rotation=
          0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(
    threshold=130 + 273.15)
    "Emergency measure"
    annotation (Placement(transformation(extent={{-78,-88},{-62,-72}},
        rotation=0)));
  Modelica.Blocks.Logical.Or or4 annotation (Placement(transformation(
        extent={{88,-6},{96,6}}, rotation=0)));
  Modelica.Blocks.MathBoolean.OnDelay onDelay(
    final delayTime=delayTime)
    "On delay"
    annotation (Placement(transformation(extent={{50,62},{58,70}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay1(
    final delayTime=delayTime)
    "On delay"
    annotation (Placement(transformation(extent={{50,-52},{58,-44}})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(
    final delayTime=delayTime)
    "Fixed delay"
    annotation (Placement(transformation(extent={{48,-18},{56,-10}})));

initial equation
  pre(y)=initialOutput;

equation
  connect(onOffController.y, pre2.u) annotation (Line(
    points={{-55,-6},{-49.4,-6}},
    color={255,0,255},
    smooth=Smooth.None));
  connect(feedback.u2,flowTemp)  annotation (Line(
    points={{-74.4,60},{-120,60}},
    color={0,0,127},
    smooth=Smooth.None));
  connect(pre2.y, and1.u2) annotation (Line(
    points={{-33.3,-6},{-26,-6},{-26,17.4},{-23.4,17.4}},
    color={255,0,255},
    smooth=Smooth.None));
  connect(lessThreshold.y, and1.u1) annotation (Line(
    points={{-33.2,46},{-26,46},{-26,23},{-23.4,23}},
    color={255,0,255},
    smooth=Smooth.None));
  connect(feedback.y, lessThreshold.u) annotation (Line(
    points={{-68,52.8},{-68,46},{-51.6,46}},
    color={0,0,127},
    smooth=Smooth.None));
  connect(and1.y, or1.u1) annotation (Line(
    points={{-7.3,23},{0,23},{0,-8},{3.2,-8}},
    color={255,0,255},
    smooth=Smooth.None));
  connect(onOffController.u,controllerOutput)  annotation (Line(
    points={{-78,-12},{-88,-12},{-88,-60},{-120,-60}},
    color={0,0,127},
    smooth=Smooth.None));
  connect(onOffController.reference,minCapacity_in)  annotation (Line(
    points={{-78,0},{-120,0}},
    color={0,0,127},
    smooth=Smooth.None));
  connect(or1.u2, greaterThreshold.y) annotation (Line(
    points={{3.2,-12.8},{5.38845e-016,-12.8},{5.38845e-016,-41.2}},
    color={255,0,255},
    smooth=Smooth.None));
  connect(externalOn, not3.u) annotation (Line(
      points={{60,120},{60,91},{39.2,91}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(flowTemp_setpoint, feedback.u1) annotation (Line(
    points={{-60,120},{-60,88},{-68,88},{-68,66.4}},
    color={0,0,127},
    smooth=Smooth.None));
  connect(or3.u2, or1.y) annotation (Line(
    points={{15.2,-8},{12.4,-8}},
    color={255,0,255},
    smooth=Smooth.None));
  connect(not3.y, or3.u1) annotation (Line(
    points={{25.4,91},{12,91},{12,0},{15.2,0}},
    color={255,0,255},
    smooth=Smooth.None));
  connect(or3.y, not1.u) annotation (Line(
    points={{24.4,0},{44,0},{44,45}},
    color={255,0,255},
    smooth=Smooth.None));
  connect(greaterThreshold.u,returnTemp)  annotation (Line(
    points={{-5.8783e-016,-59.6},{-5.8783e-016,-78},{0,-78},{0,-120}},
    color={0,0,127},
    smooth=Smooth.None));
  connect(greaterEqualThreshold.u,flowTemp)  annotation (Line(
    points={{-79.6,-80},{-90,-80},{-90,60},{-120,60}},
    color={0,0,127},
    smooth=Smooth.None));
  connect(greaterEqualThreshold.y, or4.u2) annotation (Line(
    points={{-61.2,-80},{84,-80},{84,-4.8},{87.2,-4.8}},
    color={255,0,255},
    smooth=Smooth.None));
  connect(logicalSwitch.y, or4.u1) annotation (Line(
      points={{78.3,0},{87.2,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(unitDelay.u,controllerOutput)   annotation (Line(
      points={{31.2,-10},{28,-10},{28,-22},{-88,-22},{-88,-60},{-120,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lessThreshold1.y, logicalSwitch.u2) annotation (Line(
      points={{60.4,0},{71.4,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(onDelay.u, not1.y) annotation (Line(
      points={{48.4,66},{44,66},{44,56.5}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(onDelay.y, not2.u) annotation (Line(
      points={{58.8,66},{62,66},{62,57}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(onDelay1.u, or3.y) annotation (Line(
      points={{48.4,-48},{44,-48},{44,0},{24.4,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(onDelay1.y, logicalSwitch.u1) annotation (Line(
      points={{58.8,-48},{62,-48},{62,-9.6},{71.4,-9.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not2.y, logicalSwitch.u3) annotation (Line(
      points={{62,45.5},{62,9.6},{71.4,9.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or4.y, y) annotation (Line(
      points={{96.4,0},{110,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(unitDelay.y, fixedDelay.u) annotation (Line(
      points={{40.4,-10},{44,-10},{44,-14},{47.2,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fixedDelay.y, lessThreshold1.u) annotation (Line(
      points={{56.4,-14},{51.2,-14},{51.2,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics={
      Rectangle(
        extent={{26,20},{80,-20}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-86,74},{-28,22}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-86,18},{-28,-20}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{26,-28},{80,-66}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{26,84},{80,28}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{22,82},{50,78}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        textString=
               "ON Delay"),
      Text(
        extent={{20,-60},{54,-64}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        textString=
               "OFF Delay"),
      Text(
        extent={{-90,16},{-34,12}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        textString=
               "Capacity Limit - only OFF cmd"),
      Text(
        extent={{-86,32},{-44,28}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        textString=
               "FlowTemp Variation Limit"),
      Text(
        extent={{-92,28},{-52,24}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        textString=
               "- only ON cmd"),
      Text(
        extent={{36,18},{70,14}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        textString=
               "Delay Switch")}),      Icon(graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={95,95,95},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-68,-6},{76,-40}},
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
          textString="Controller"),
      Text(
        extent={{-48,36},{52,-8}},
        lineColor={0,0,0},
        lineThickness=1,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        textString=
               "On/Off")}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This is model is the decision maker in the CHP model. According to
  different conditions and timings it decides if the CHP can be turned
  on or off.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following control decisions are implemented:
</p>
<ul>
  <li>Switch On when the flow temperature is lower than a setpoint.
  </li>
  <li>Switch Off when the CHP should work in a range lower than its
  minimum allowable capacity.
  </li>
  <li>Allow the CHP to be switched On only if it was Off for more than
  a certain amount of time (delay) or it was On beforehand.
  </li>
  <li>Allow the CHP to be switched Off only if it was On for more than
  a certain amount of time (delay) or it was Off beforehand.
  </li>
  <li>Emergency measures such as maximum allowable flow and return
  temperatures are implemented.
  </li>
</ul>
</html>",
revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Pooyan Jahangiri:<br/>
    Variable names updated and merged with AixLib
  </li>
  <li>
    <i>January 23, 2014&#160;</i> by Pooyan Jahangiri:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>January 31, 2011</i> by Pooyan Jahangiri:<br/>
    Implemented
  </li>
</ul>
</html>"));
end DelayedOnOffController;
