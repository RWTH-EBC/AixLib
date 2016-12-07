within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model ExternalControl_nightDayHC
  "with night and day modes, both with heating curves"
  extends PartialExternalControl;

  //Parameters
  parameter
    AixLib.DataBase.Boiler.DayNightMode.HeatingCurvesDayNightBaseDataDefinition
    paramHC=
      AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10()
         "Parameters for heating curve"
    annotation (Dialog(group="Heating curves"), choicesAllMatching=true);

  parameter Real declination = 1.1 "Declination" annotation (Dialog( group= "Heating curves"));

  parameter Modelica.SIunits.TemperatureDifference Tdelta_Max = 2
    "difference from set flow temperature over which boiler stops" annotation ( Dialog(group = "OnOff"));
    parameter Modelica.SIunits.TemperatureDifference Tdelta_Min= 2
    "difference from set flow temperature under which boiler starts"                                                                 annotation ( Dialog(group = "OnOff"));

    parameter Modelica.SIunits.Time Fb = 3600
    "Period of time for increased set temperature"                                           annotation ( Dialog(group = "Day/Night Mode"));
    parameter Real FA = 0.2 "Increment for increased set temperature" annotation ( Dialog(group = "Day/Night Mode"));

protected
  Modelica.Blocks.Tables.CombiTable2D FlowTempNight(table=paramHC.varFlowTempNight)
    "Table for setting the flow temperature during night according to the outside temperature"
    annotation (Placement(transformation(extent={{-49.5,49.5},{-31.5,67.5}})));
  Modelica.Blocks.Tables.CombiTable2D FlowTempDay(table=paramHC.varFlowTempDay)
    "Table for setting the flow temperature druing day according to the outside temperature"
    annotation (Placement(transformation(extent={{-49.5,22.5},{-31.5,40.5}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC
    annotation (Placement(transformation(extent={{-3.75,-3.75},{3.75,3.75}},
        rotation=90,
        origin={-66.75,-8.25})));
public
  Modelica.Blocks.Logical.Switch switchDayNight
    annotation (Placement(transformation(extent={{-19.5,39},{-3,55.5}})));
protected
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{66,45},{72,51}})));

public
  ControllerOnOff                                    controlerOnOff
    annotation (Placement(transformation(
        extent={{9.75,-9.75},{-9.75,9.75}},
        rotation=90,
        origin={-17.25,-35.25})));
protected
  Modelica.Blocks.Logical.GreaterThreshold Higher(threshold=Tdelta_Max)
                                 annotation (Placement(transformation(
          extent={{34.5,-27},{19.5,-12}})));
  Modelica.Blocks.Logical.LessThreshold Lower(threshold=-Tdelta_Min)
                                 annotation (Placement(transformation(
          extent={{36,-76.5},{21,-61.5}})));
protected
  Modelica.Blocks.Math.Feedback Difference
                                         annotation (Placement(
        transformation(extent={{78,-54},{64.5,-40.5}})));

public
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{-19.5,67.5},{-9,78}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=Fb)
    annotation (Placement(transformation(extent={{0,67.5},{10.5,78}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{13.5,79.5},{24,90}})));
public
  Modelica.Blocks.Logical.Switch switchIncreasedSetTemp
    annotation (Placement(transformation(extent={{30,39},{46.5,55.5}})));
  Modelica.Blocks.Math.Gain Increase(k=1 + FA)
    annotation (Placement(transformation(extent={{7.5,49.5},{18,60}})));
  Modelica.Blocks.Math.Gain NoIncrease(k=1)
    annotation (Placement(transformation(extent={{7.5,34.5},{18,45}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-19.5,81},{-9,91.5}})));
  Modelica.Blocks.Sources.Constant Declination(k=declination)
    annotation (Placement(transformation(extent={{-84,48},{-76.5,55.5}})));
equation
  if cardinality(isOn) < 2 then
    isOn = true;
  end if;

  connect(Higher.y, controlerOnOff.T_high)             annotation (Line(
      points={{18.75,-19.5},{6,-19.5},{6,-39.735},{-7.5,-39.735}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Lower.y, controlerOnOff.T_low)               annotation (Line(
      points={{20.25,-69},{6,-69},{6,-27.645},{-7.5,-27.645}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Higher.u, Difference.y)      annotation (Line(
      points={{36,-19.5},{63,-19.5},{63,-48},{65.175,-48},{65.175,-47.25}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(timer.y, lessEqualThreshold.u) annotation (Line(
      points={{-8.475,72.75},{-4.2375,72.75},{-4.2375,72.75},{-1.05,72.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lessEqualThreshold.y, and1.u2) annotation (Line(
      points={{11.025,72.75},{12.45,72.75},{12.45,80.55}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(switchDayNight.y, Increase.u) annotation (Line(
      points={{-2.175,47.25},{3,47.25},{3,54.75},{6.45,54.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Increase.y, switchIncreasedSetTemp.u1) annotation (Line(
      points={{18.525,54.75},{22.0125,54.75},{22.0125,53.85},{28.35,53.85}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switchDayNight.y, NoIncrease.u) annotation (Line(
      points={{-2.175,47.25},{3,47.25},{3,39.75},{6.45,39.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(NoIncrease.y, switchIncreasedSetTemp.u3) annotation (Line(
      points={{18.525,39.75},{24,39.75},{24,42},{28.35,42},{28.35,40.65}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(and1.y, switchIncreasedSetTemp.u2) annotation (Line(
      points={{24.525,84.75},{30,84.75},{30,75},{21,75},{21,47.25},{28.35,47.25}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(switchIncreasedSetTemp.y, from_degC.u) annotation (Line(
      points={{47.325,47.25},{64.9125,47.25},{64.9125,48},{65.4,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(not1.y, timer.u) annotation (Line(
      points={{-8.475,86.25},{-9,79.5},{-27,79.5},{-27,72.75},{-20.55,
          72.75}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(not1.y, and1.u1) annotation (Line(
      points={{-8.475,86.25},{1.7625,86.25},{1.7625,84.75},{12.45,84.75}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(to_degC.y, FlowTempNight.u1) annotation (Line(
      points={{-66.75,-4.125},{-66.75,63.9},{-51.3,63.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(to_degC.y, FlowTempDay.u1) annotation (Line(
      points={{-66.75,-4.125},{-66.75,36.9},{-51.3,36.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Declination.y, FlowTempNight.u2) annotation (Line(
      points={{-76.125,51.75},{-66,51.75},{-66,53.1},{-51.3,53.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Declination.y, FlowTempDay.u2) annotation (Line(
      points={{-76.125,51.75},{-66,51.75},{-66,25.5},{-51.3,25.5},{-51.3,26.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(FlowTempNight.y, switchDayNight.u1) annotation (Line(
      points={{-30.6,58.5},{-25.5,58.5},{-25.5,53.85},{-21.15,53.85}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(FlowTempDay.y, switchDayNight.u3) annotation (Line(
      points={{-30.6,31.5},{-25.5,31.5},{-25.5,40.65},{-21.15,40.65}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Difference.u1, Tflow_is) annotation (Line(
      points={{76.65,-47.25},{81,-47.25},{81,-100.5},{75,-100.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(from_degC.y, Difference.u2) annotation (Line(
      points={{72.3,48},{81,48},{81,-58.5},{70.5,-58.5},{70.5,-52.65},{71.25,
          -52.65}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Difference.y, Lower.u) annotation (Line(
      points={{65.175,-47.25},{65.175,-48},{63,-48},{63,-69},{37.5,-69}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SwitchToNightMode, not1.u) annotation (Line(
      points={{-101.75,49.75},{-87,49.75},{-87,85.5},{-54,85.5},{-54,86.25},{-20.55,
          86.25}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(SwitchToNightMode, switchDayNight.u2) annotation (Line(
      points={{-101.75,49.75},{-87,49.75},{-87,43.5},{-54,43.5},{-54,47.25},{-21.15,
          47.25}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Toutside, to_degC.u) annotation (Line(
      points={{-100,-39},{-67.5,-39},{-67.5,-12.75},{-66.75,-12.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(isOn, controlerOnOff.OnOffExtern) annotation (Line(
      points={{-102.75,18.75},{-58.5,18.75},{-58.5,-12},{-15,-12},{-15,-25.5},{-14.715,
          -25.5}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(controlerOnOff.OnOffFinal, isOn_Final) annotation (Line(
      points={{-14.91,-45.39},{-14.91,-66.945},{-15,-66.945},{-15,-99}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Tflow_set, from_degC.y) annotation (Line(
      points={{102,48},{72.3,48}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5}), graphics={
        Ellipse(
          extent={{4.5,-48},{49.5,-91.5}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{4.5,1.5},{49.5,-43.5}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70.5,102},{102,4.5}},
          fillColor={255,170,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          startAngle=0,
          endAngle=360),
        Text(
          extent={{-31.5,21},{49.5,10.5}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="Day/Night-Mode"),
        Text(
          extent={{10.5,-31.5},{46.5,-37.5}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          textString="Temp too high"),
        Text(
          extent={{12,-81},{45,-87}},
          lineColor={0,127,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="Temp too low"),
        Ellipse(
          extent={{-31.5,97.5},{36,63}},
          lineColor={0,0,255},
          lineThickness=0.5)}),     Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5}), graphics={
                            Rectangle(
          extent={{-84,85.5},{91.5,-82.5}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}),
        Text(
          extent={{-79.5,19.5},{82.5,-4.5}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This is a controller model, modelled after the <a href=\"DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10\">Vitotronic 200</a>. </p>
<p>This model is derived from <a href=\"HVAC.Components.HeatGenerators.Boiler.BaseClasses.Controller\">HVAC.Components.HeatGenerators.Boiler.BaseClasses.Controller</a>.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following control decisions are implemented:</p>
<ul>
<li>Switch on/off when the fluid temperature is under/over the set fluid temperature </li>
<li>Heating curve: fluid temperature depending on the outside temperature</li>
<li>Average outside temperature</li>
<li>Increase the set fluid temperature when going to day mode in order to shorten the heating up period </li>
</ul>
</html>",
revisions="<html>
<p><ul>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with AixLib</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>October 12, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
end ExternalControl_nightDayHC;
