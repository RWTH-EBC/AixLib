within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model SecurityControllerNew "CHP On/Off controller"
  parameter Modelica.SIunits.Temperature maxTFlow "max flow temperature e.g. to prevent boiling water";
  parameter Modelica.SIunits.Temperature maxTReturn
    "Maximum return temperature";
  parameter Modelica.SIunits.ThermodynamicTemperature minDeltaT
    "Minimum flow and return temperature difference";
  parameter Modelica.SIunits.ThermodynamicTemperature TFlowRange
    "Range of the flow temperature";
  parameter Modelica.SIunits.Time delayTime
    "On/Off delay time";
  parameter Boolean initialOutput=false
    "Initial output";
  parameter Real delayUnit
    "Delay unit";
  parameter Real minCapacity
    "Minimum allowable working capacity in percent";
  parameter Modelica.SIunits.Temperature T_flowMax "max allowed flow temperature";
  parameter Modelica.SIunits.TemperatureDifference T_flowMaxBandwith "Bandwith set on top of max allowed flow temperature";
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Signal if controller is on or off"
    annotation (Placement(transformation(extent={{100,0},{120,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput externalOn "Input from Contoller"
    annotation (Placement(transformation(
        origin={-120,0},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.MathBoolean.OnDelay onDelay(
    final delayTime=delayTime)
    "On delay"
    annotation (Placement(transformation(extent={{36,62},{44,70}})));
  Modelica.Blocks.MathBoolean.OnDelay offDelay(
    final delayTime=delayTime)
    "On delay"
    annotation (Placement(transformation(extent={{36,-54},{44,-46}})));

  Modelica.Blocks.MathBoolean.Not not1 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={76,-36})));
  Modelica.Blocks.MathBoolean.Not not2 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={8,-52})));
  Modelica.Blocks.Logical.And Off annotation (Placement(transformation(extent={
            {58,-18},{72,-4}}, rotation=0)));
  Modelica.Blocks.Logical.And On
    annotation (Placement(transformation(extent={{58,2},{72,16}}, rotation=0)));
  Modelica.Blocks.Logical.Pre not3(pre_u_start=false) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-36,-98})));
  Modelica.Blocks.Interfaces.BooleanInput StatusOn "Real status off CHP"
    annotation (Placement(transformation(
        origin={-120,-54},
        extent={{-20,-20},{20,20}},
        rotation=0)));
initial equation
  pre(y)=initialOutput;

equation
  connect(offDelay.u, not2.y) annotation (Line(points={{34.4,-50},{12.8,-50},{
          12.8,-52}}, color={255,0,255}));
  connect(offDelay.y, not1.u) annotation (Line(points={{44.8,-50},{76,-50},{76,
          -41.6}}, color={255,0,255}));
  connect(onDelay.y, Off.u2) annotation (Line(points={{44.8,66},{48,66},{48,
          -16.6},{56.6,-16.6}}, color={255,0,255}));
  connect(not2.y, Off.u1) annotation (Line(points={{12.8,-52},{34,-52},{34,-18},
          {44,-18},{44,-11},{56.6,-11}}, color={255,0,255}));
  connect(offDelay.y, On.u2) annotation (Line(points={{44.8,-50},{48,-50},{48,
          3.4},{56.6,3.4}}, color={255,0,255}));
  connect(StatusOn, not2.u) annotation (Line(points={{-120,-54},{2.4,-54},{2.4,
          -52}}, color={255,0,255}));
  annotation (Diagram(graphics={
      Rectangle(
        extent={{26,20},{80,-20}},
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
end SecurityControllerNew;
