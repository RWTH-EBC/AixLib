within AixLib.Building.Benchmark.Test;
model Boiler_Benchmark "Boiler with internal and external control"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(pressureDrop(
        a=paramBoiler.pressureDrop), vol(V=paramBoiler.volume));

  parameter AixLib.DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
    paramBoiler
    "Parameters for Boiler"
    annotation (Dialog(tab = "General", group = "Boiler type"),
    choicesAllMatching = true);
  parameter Real KR=1
    "Gain of Boiler heater"
    annotation (Dialog(tab = "General", group = "Boiler type"));
  parameter Modelica.SIunits.Time TN=0.1
    "Time Constant of boiler heater (T>0 required)"
    annotation (Dialog(tab = "General", group = "Boiler type"));
  parameter Modelica.SIunits.Time riseTime=30
    "Rise/Fall time for step input(T>0 required)"
    annotation (Dialog(tab = "General", group = "Boiler type"));
  parameter Real declination=1.1
    "Declination";
  Modelica.Blocks.Interfaces.BooleanInput isOn
    "Switches Controler on and off"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={30,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-90})));
  Modelica.Blocks.Interfaces.RealInput TSet(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Ambient air temperature" annotation (Placement(
        transformation(extent={{-100,40},{-60,80}}), iconTransformation(extent={
            {-80,60},{-60,80}})));

  Fluid.BoilerCHP.BaseClasses.Controllers.InternalControl internalControl(
    final paramBoiler=paramBoiler,
    final KR=KR,
    final TN=TN,
    final riseTime=riseTime) "Internal control"
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));

  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=true,
    uLow=237.15 + 85,
    uHigh=273.15 + 99)
    annotation (Placement(transformation(extent={{36,12},{16,32}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{-8,12},{-28,32}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
    annotation (Placement(transformation(extent={{24,54},{4,74}})));
equation
  connect(senTCold.T, internalControl.TFlowCold) annotation (Line(points={{-70,
          -69},{-70,-69},{-70,-20},{-80,-20},{-80,-1.625},{-70.075,-1.625}},
        color={0,0,127}));
  connect(senTHot.T, internalControl.TFlowHot) annotation (Line(points={{40,-69},
          {40,-18},{-82,-18},{-82,1.6},{-70,1.6}}, color={0,0,127}));
  connect(senMasFlo.m_flow, internalControl.mFlow) annotation (Line(points={{70,-69},
          {70,-69},{70,-22},{-78,-22},{-78,-4.925},{-70.075,-4.925}},
        color={0,0,127}));
  connect(TSet, internalControl.Tflow_set) annotation (Line(points={{-80,60},{-54,
          60},{-54,24},{-62.0375,24},{-62.0375,10.1125}}, color={0,0,127}));
  connect(internalControl.QflowHeater, heater.Q_flow) annotation (Line(points={
          {-49.95,3.9},{-36,3.9},{-36,-32},{-60,-32},{-60,-40}}, color={0,0,127}));
  connect(hysteresis.y, logicalSwitch.u2)
    annotation (Line(points={{15,22},{-6,22}}, color={255,0,255}));
  connect(hysteresis.u, internalControl.TFlowHot) annotation (Line(points={{38,
          22},{48,22},{48,-18},{-82,-18},{-82,1.6},{-70,1.6}}, color={0,0,127}));
  connect(logicalSwitch.y, internalControl.isOn) annotation (Line(points={{-29,
          22},{-57.525,22},{-57.525,10.275}}, color={255,0,255}));
  connect(isOn, logicalSwitch.u3) annotation (Line(points={{30,100},{30,46},{6,
          46},{6,14},{-6,14}}, color={255,0,255}));
  connect(booleanExpression.y, logicalSwitch.u1) annotation (Line(points={{3,64},
          {-2,64},{-2,30},{-6,30}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-18.5,-23.5},{-26.5,-7.5},{-4.5,36.5},{3.5,10.5},{25.5,14.5},
              {15.5,-27.5},{-2.5,-23.5},{-8.5,-23.5},{-18.5,-23.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-16.5,-21.5},{-6.5,-1.5},{19.5,-21.5},{-6.5,-21.5},{-16.5,-21.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26.5,-21.5},{27.5,-29.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A boiler model consisting of the internal boiler controler and a replaceable
outer controler.
This controler can be chosen to provide the boiler temperature setpoint based on
the chosen conditions
such as ambient air temperature, etc.
</p>
</html>",
        revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with
AixLib</li>
<li><i>January 09, 2006&nbsp;</i> by Peter Matthes:<br/>V0.1: Initial
configuration.</li>
<li><i>December 4, 2014&nbsp;</i> by Ana Constantin:<br/>Removed cardinality
equations for boolean inputs</li>
<li><i>November 28, 2014&nbsp;</i> by Roozbeh Sangi:<br/>Output for heat flow
added.</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation
appropriately</li>
<li><i>April 20, 2012&nbsp;</i> by Ana Constanting:<br/>Implemented</li>
</ul>
</html>"));
end Boiler_Benchmark;
