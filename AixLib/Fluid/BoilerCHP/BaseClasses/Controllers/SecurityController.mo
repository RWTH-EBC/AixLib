within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model SecurityController "CHP On/Off controller"
  parameter Modelica.Units.SI.Temperature maxTFlow "max flow temperature e.g. to prevent boiling water";
  parameter Modelica.Units.SI.Temperature maxTReturn
    "Maximum return temperature";
  parameter Modelica.Units.SI.ThermodynamicTemperature minDeltaT
    "Minimum flow and return temperature difference";
  parameter Modelica.Units.SI.ThermodynamicTemperature TFlowRange
    "Range of the flow temperature";
  parameter Modelica.Units.SI.Time delayTime
    "On/Off delay time";
  parameter Boolean initialOutput=false
    "Initial output";
  parameter Real delayUnit
    "Delay unit";
  parameter Real minCapacity
    "Minimum allowable working capacity in percent";
  parameter Modelica.Units.SI.Temperature T_flowMax "max allowed flow temperature";
  parameter Modelica.Units.SI.TemperatureDifference T_flowMaxBandwith "Bandwith set on top of max allowed flow temperature";
  Modelica.Blocks.Interfaces.RealInput flowTemp(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Flow temperature"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}},
        rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Signal if controller is on or off"
    annotation (Placement(transformation(extent={{100,0},{120,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput externalOn
    "False for shut down"
    annotation (Placement(transformation(
        origin={60,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Blocks.Logical.OnOffController onOffController(final bandwidth=
        T_flowMaxBandwith, pre_y_start=false) "Security on off controller"
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}},
                   rotation=0)));
  Modelica.Blocks.Discrete.UnitDelay unitDelay(final samplePeriod=delayUnit)
    "Last value"
    annotation (Placement(transformation(extent={{-74,-60},{-66,-52}})));
  Modelica.Blocks.MathBoolean.And and1(nu=1) annotation (Placement(
        transformation(extent={{16,-10},{24,10}}, rotation=0)));
  Modelica.Blocks.Logical.GreaterThreshold
                                        greaterThreshold(
    final threshold=minCapacity)
    annotation (Placement(transformation(extent={{-32,-60},{-24,-52}},
                                                                  rotation=
          0)));
  Modelica.Blocks.MathBoolean.OnDelay onDelay(
    final delayTime=delayTime)
    "On delay"
    annotation (Placement(transformation(extent={{36,62},{44,70}})));
  Modelica.Blocks.MathBoolean.OnDelay offDelay(
    final delayTime=delayTime)
    "On delay"
    annotation (Placement(transformation(extent={{36,-54},{44,-46}})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(
    final delayTime=delayTime)
    "Fixed delay"
    annotation (Placement(transformation(extent={{-52,-60},{-44,-52}})));

  Modelica.Blocks.Sources.Constant              const(k=T_flowMax +
        T_flowMaxBandwith/2)
    "Emergency measure"
    annotation (Placement(transformation(extent={{-78,-2},{-62,14}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput CurrentCapacity
    "Input for the currently used capacity of the CHP" annotation (Placement(
        transformation(extent={{-140,-76},{-100,-36}}, rotation=0)));
  Modelica.Blocks.MathBoolean.Not not1 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={76,-36})));
  Modelica.Blocks.MathBoolean.Not not2 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={28,-38})));
  Modelica.Blocks.Logical.And Off annotation (Placement(transformation(extent={
            {58,-18},{72,-4}}, rotation=0)));
  Modelica.Blocks.Logical.And On
    annotation (Placement(transformation(extent={{58,2},{72,16}}, rotation=0)));
  Modelica.Blocks.Logical.Pre not3(pre_u_start=false) annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={34,-82})));
initial equation
  pre(y)=initialOutput;

equation
  connect(unitDelay.y, fixedDelay.u) annotation (Line(
      points={{-65.6,-56},{-52.8,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fixedDelay.y, greaterThreshold.u) annotation (Line(
      points={{-43.6,-56},{-32.8,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, onOffController.reference)
    annotation (Line(points={{-61.2,6},{-46,6}}, color={0,0,127}));
  connect(flowTemp, onOffController.u) annotation (Line(points={{-120,60},{-94,
          60},{-94,-6},{-46,-6}}, color={0,0,127}));
  connect(CurrentCapacity, unitDelay.u)
    annotation (Line(points={{-120,-56},{-74.8,-56}}, color={0,0,127}));
  connect(and1.y, onDelay.u) annotation (Line(points={{24.6,0},{32,0},{32,66},{
          34.4,66}}, color={255,0,255}));
  connect(offDelay.u, not2.y) annotation (Line(points={{34.4,-50},{28,-50},{28,
          -42.8}}, color={255,0,255}));
  connect(offDelay.y, not1.u) annotation (Line(points={{44.8,-50},{76,-50},{76,
          -41.6}}, color={255,0,255}));
  connect(externalOn, and1.u[1]) annotation (Line(points={{60,120},{60,86},{10,
          86},{10,5.5},{16,5.5},{16,0}}, color={255,0,255}));
  connect(onDelay.y, Off.u2) annotation (Line(points={{44.8,66},{48,66},{48,
          -16.6},{56.6,-16.6}}, color={255,0,255}));
  connect(and1.y, On.u1) annotation (Line(points={{24.6,0},{48,0},{48,9},{56.6,
          9}}, color={255,0,255}));
  connect(not2.y, Off.u1) annotation (Line(points={{28,-42.8},{34,-42.8},{34,
          -18},{44,-18},{44,-11},{56.6,-11}}, color={255,0,255}));
  connect(y, not3.u) annotation (Line(points={{110,10},{106,10},{106,-82},{38.8,
          -82}}, color={255,0,255}));
  connect(offDelay.y, On.u2) annotation (Line(points={{44.8,-50},{48,-50},{48,
          3.4},{56.6,3.4}}, color={255,0,255}));
  connect(not3.y, not2.u) annotation (Line(points={{29.6,-82},{6,-82},{6,-24},{
          28,-24},{28,-32.4}}, color={255,0,255}));
  annotation (Diagram(graphics={
      Rectangle(
        extent={{26,20},{80,-20}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-82,64},{-12,-36}},
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
        extent={{-14,-60},{20,-64}},
        lineColor={95,95,95},
        lineThickness=0.5,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        textString=
               "OFF Delay"),
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
end SecurityController;
