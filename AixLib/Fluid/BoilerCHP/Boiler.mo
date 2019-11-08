within AixLib.Fluid.BoilerCHP;
model Boiler "Boiler with internal and external control"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(pressureDrop(
        a=paramBoiler.pressureDrop), vol(V=paramBoiler.volume));

  parameter AixLib.DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
    paramBoiler
    "Parameters for Boiler"
    annotation (Dialog(tab = "General", group = "Boiler type"),
    choicesAllMatching = true);
  parameter
    AixLib.DataBase.Boiler.DayNightMode.HeatingCurvesDayNightBaseDataDefinition
    paramHC
    "Parameters for heating curve"
    annotation (Dialog(group="Heating curves"), choicesAllMatching=true);
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
    "Declination"
    annotation(Dialog(tab="External Control"));
  parameter Modelica.SIunits.TemperatureDifference Tdelta_Max=2
    "Difference from set flow temperature over which boiler stops"
    annotation(Dialog(tab="External Control"));
  parameter Modelica.SIunits.TemperatureDifference Tdelta_Min=2
    "Difference from set flow temperature under which boiler starts"
    annotation(Dialog(tab="External Control"));
  parameter Modelica.SIunits.Time Fb=3600
    "Period of time for increased set temperature"
    annotation(Dialog(tab="External Control"));
  parameter Real FA=0.2 "Increment for increased set temperature"
    annotation(Dialog(tab="External Control"));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    "Switches Controler on and off"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={30,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-90})));
  Modelica.Blocks.Interfaces.RealInput TAmbient(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Ambient air temperature"
    annotation (Placement(
        transformation(extent={{-100,40},{-60,80}}), iconTransformation(extent=
           {{-80,60},{-60,80}})));
   Modelica.Blocks.Interfaces.BooleanInput switchToNightMode
     "Connector of Boolean input signal"
     annotation (Placement(transformation(
     extent={{-100,10},{-60,50}}), iconTransformation(extent={{-80,30},{-60,
     50}})));
  replaceable model ExtControl =
    AixLib.Fluid.BoilerCHP.BaseClasses.Controllers.ExternalControlNightDayHC
     constrainedby
    AixLib.Fluid.BoilerCHP.BaseClasses.Controllers.PartialExternalControl
      "External control"
      annotation (Dialog(tab="External Control"),choicesAllMatching=true);
  BaseClasses.Controllers.InternalControl internalControl(
    final paramBoiler=paramBoiler,
    final KR=KR,
    final TN=TN,
    final riseTime=riseTime)
    "Internal control"
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  ExtControl myExternalControl(
    final paramHC=paramHC,
    final declination=declination,
    final Tdelta_Max=Tdelta_Max,
    final Tdelta_Min=Tdelta_Min,
    final Fb=Fb,
    final FA=FA)
    "External control"
     annotation (Placement(transformation(extent={{-10,38},
            {10,58}})));

equation
  connect(internalControl.QflowHeater, heater.Q_flow) annotation (Line(points={
          {-49.95,3.9},{-40,3.9},{-40,-20},{-60,-20},{-60,-40}}, color={0,0,127}));
  connect(senTCold.T, internalControl.TFlowCold) annotation (Line(points={{-70,
          -69},{-70,-69},{-70,-20},{-80,-20},{-80,-1.625},{-70.075,-1.625}},
        color={0,0,127}));
  connect(senTHot.T, internalControl.TFlowHot) annotation (Line(points={{40,-69},
          {40,-18},{-82,-18},{-82,1.6},{-70,1.6}}, color={0,0,127}));
  connect(senMasFlo.m_flow, internalControl.mFlow) annotation (Line(points={{70,-69},
          {70,-69},{70,-22},{-78,-22},{-78,-4.925},{-70.075,-4.925}},
        color={0,0,127}));
  connect(isOn, myExternalControl.isOn) annotation (Line(points={{30,100},{30,76},
          {-20,76},{-20,50},{-9.9,50},{-9.9,50.25}}, color={255,0,255}));
  connect(senTHot.T, myExternalControl.TFlowIs) annotation (Line(points={{40,-69},
          {40,-69},{40,-18},{6.5,-18},{6.5,38.8}}, color={0,0,127}));
  connect(myExternalControl.isOn_final, internalControl.isOn) annotation (Line(
        points={{10.2,49.8},{20,49.8},{20,20},{-57.525,20},{-57.525,10.275}},
        color={255,0,255}));
  connect(myExternalControl.TFlowSet, internalControl.Tflow_set) annotation (
      Line(points={{10.2,52.8},{18,52.8},{18,22},{-62.0375,22},{-62.0375,
          10.1125}}, color={0,0,127}));
  connect(TAmbient,myExternalControl.TOutside)  annotation (Line(points={{-80,60},
          {-22,60},{-22,44.4},{-9.725,44.4}}, color={0,0,127}));
  connect(myExternalControl.switchToNightMode,switchToNightMode)  annotation (
      Line(points={{-9.95,53.625},{-16.975,53.625},{-16.975,30},{-80,30}},
        color={255,0,255}));
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
<p>A boiler model consisting of the internal boiler controller and a replaceable
outer controller.
This controller can be chosen to provide the boiler temperature setpoint based
on the chosen conditions such as ambient air temperature, etc.
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
<li><i>April 20, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented</li>
</ul>
</html>"));
end Boiler;
