within AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls;
model BoilerControl "Master controller that holds all other controls"

  //Nominal
    parameter Modelica.Units.SI.Temperature dtWaterNom "Constant output value"
    annotation (Dialog(group="Nominal Condition"));
  parameter Modelica.Units.SI.Temperature TRetNom=323.15
    "Nominal return temperature" annotation (Dialog(group="Nominal Condition"));

  // Firing Rate Flow Control
  parameter Real FirRatMin=0.15 "Minimal firing rate"  annotation (Dialog(group="Flow Temperature Control"));
  parameter Real kFloTem=1 "Gain of controller"
                                              annotation (Dialog(group=
          "Flow Temperature Control"));
  parameter Modelica.Units.SI.Time TiFloTem=10
    "Time constant of Integrator block"                                          annotation (Dialog(group=
          "Flow Temperature Control"));

  // Heating Curve
  parameter Boolean TFlowByHeaCur=false "Use heating curve to set flow temperature" annotation (Dialog(group="Heating Curve"));
  parameter Boolean use_tableData=true
    "Choose between tables or function to calculate TSet" annotation (Dialog(group="Heating Curve"));
  replaceable function heaCurFun =
      AixLib.Controls.SetPoints.Functions.HeatingCurveFunction annotation (
      choicesAllMatching=true, Dialog(group="Heating Curve"));
  parameter Real dec=1 "Declination of heating curve" annotation (Dialog(group="Heating Curve"));
  parameter Real dayHou=6 "Hour of day at which day mode is enabled" annotation (Dialog(group="Heating Curve"));
  parameter Real nigHou=22 "Hour of day at which night mode is enabled"   annotation (Dialog(group="Heating Curve"));
  parameter AixLib.Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017
    "Enumeration for choosing how reference time (time = 0) should be defined. Used for heating curve" annotation (Dialog(group="Heating Curve"));
  parameter Modelica.Units.SI.ThermodynamicTemperature TOffset=0
    "Offset to heating curve temperature" annotation (Dialog(group="Heating Curve"));

  // Feedback Control
  parameter Boolean hasFeedback=true  "circuit has Feedback"     annotation (choices(checkBox=true), Dialog(descriptionLabel=true, group="Feedback"));
  parameter Real kFeedBack=1 "Gain of controller"
                                          annotation (Dialog(group="Feedback Return Control"));
  parameter Modelica.Units.SI.Time TiFeedBack=0.5
    "Time constant of Integrator block" annotation (Dialog(group=
          "Feedback Return Control"));
  parameter Real yMaxFeedBack=0.99 "Upper limit of output"
   annotation (Dialog(group="Feedback Return Control"));
  parameter Real yMinFeedBack=0 "Lower limit of output"
   annotation (Dialog(group="Feedback Return Control"));

  // Safety Control
  parameter Modelica.Units.SI.Temperature TRetMin=313.15
    "Minimum return temperature, at which the system is shut down"
                                                                  annotation (Dialog(group="Safety Control"));
  parameter Modelica.Units.SI.Time time_minOff=900
    "Time after which the device can be turned on again" annotation (Dialog(group="Safety Control"));
  parameter Modelica.Units.SI.Temperature TFlowMax=378.15
    "Maximum flow temperature, at which the system is shut down" annotation (Dialog(group="Safety Control"));
  parameter Modelica.Units.SI.Time time_minOn=900
    "Time after which the device can be turned off again" annotation (Dialog(group="Safety Control"));
  // Pump Control

  AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.FirRatMinCheck firRatMinChe(final FirRatMin=FirRatMin)
    "Check to prevent firing rate going below minimal firing rate"
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  SafetyControl safCtr(
    final TFlowMax=TFlowMax,
    final TRetMin=TRetMin,
    final time_minOff=time_minOff,
    final time_minOn=time_minOn) "Saftey control for the boiler"
    annotation (Placement(transformation(extent={{-20,36},{0,56}})));
  AixLib.Controls.Interfaces.BoilerControlBus boiBus "Boiler signal bus"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.FeedbackControl fdbCtrl(
    TRetNom=TRetNom,
    final k=kFeedBack,
    final Ti=TiFeedBack,
    final yMax=yMaxFeedBack,
    final yMin=yMinFeedBack) if hasFeedback
    "Controler for return temperature control with feedback loop if enabled"
    annotation (Placement(transformation(extent={{-74,-88},{-54,-68}})));
  AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.InternalFirRatControl intlFirRatCtr(
    final k=kFloTem,
    final Ti=TiFloTem,
    final yMax=1,
    final yMin=FirRatMin) "Simple control with flow temperature PID control"
    annotation (Placement(transformation(extent={{-20,6},{0,26}})));
  AixLib.Controls.SetPoints.HeatingCurve heaCur(
    final TOffset=TOffset,
    final use_dynTRoom=false,
    final zerTim=zerTim,
    final day_hour=dayHou,
    final night_hour=nigHou,
    final heatingCurveRecord=
        AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10(),
    final declination=dec,
    redeclare function HeatingCurveFunction = heaCurFun,
    final use_tableData=use_tableData,
    final TRoom_nominal=293.15) if TFlowByHeaCur
    annotation (Placement(transformation(extent={{-74,-50},{-54,-30}})));
equation
  connect(boiBus.isOn, safCtr.isOnSet) annotation (Line(
      points={{0,100},{0,100},{-38,100},{-38,50.4},{-20,50.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(safCtr.isOn, firRatMinChe.isOn) annotation (Line(points={{0.4,46},{40,
          46},{40,4.2},{46,4.2}}, color={255,0,255}));
  connect(intlFirRatCtr.yFirRatSet, firRatMinChe.yFirRatSet)
    annotation (Line(points={{1,16},{38,16},{38,0},{46,0}}, color={0,0,127}));
  if not TFlowByHeaCur then
    connect(boiBus.TSupSet, intlFirRatCtr.TSupSet) annotation (Line(
        points={{0,100},{-100,100},{-100,16},{-22,16}},
        color={255,204,51},
        thickness=0.5,
        pattern=LinePattern.Dash), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  end if;
  connect(boiBus.TRetMea, safCtr.TRetMea) annotation (Line(
      points={{0,100},{-38,100},{-38,42},{-22,42},{-22,41.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boiBus.TRetMea, fdbCtrl.TRetMea) annotation (Line(
      points={{0,100},{-100,100},{-100,-78},{-74.2,-78}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(firRatMinChe.FirRat, boiBus.yFirRatSet) annotation (Line(points={{67,0},
          {76,0},{76,100},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fdbCtrl.yValve, boiBus.yValSet) annotation (Line(
      points={{-53,-78},{100,-78},{100,100},{0,100}},
      color={0,0,127},
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boiBus.TSupMea, safCtr.TSupMea) annotation (Line(
      points={{0,100},{-38,100},{-38,46},{-22,46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boiBus.TSupMea, intlFirRatCtr.TFlowMea) annotation (Line(
      points={{0,100},{-38,100},{-38,10.8},{-22,10.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boiBus.TAmbient, heaCur.T_oda) annotation (Line(
      points={{0,100},{-100,100},{-100,-40},{-76,-40}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heaCur.TSet, intlFirRatCtr.TSupSet) annotation (Line(points={{-53,-40},
          {-40,-40},{-40,16},{-22,16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
                            Text(
          extent={{-102,26},{98,-18}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false),
        graphics={Text(
          extent={{-96,-46},{-10,-60}},
          textColor={28,108,200},
          textString="Optional flow set temperature by heating curve"), Text(
          extent={{-94,-84},{-8,-98}},
          textColor={28,108,200},
          textString="Optional control of return tempature via feedback valve ")}),
    Documentation(info="<html>
Top level model of boiler control that puts the components below together.
</html>", revisions="<html>
<ul>
<li>
<i>June, 2023</i> by Moritz Zuschlag; David Jansen<br/>
    First Implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1147\">#1147</a>)
</li>
</ul>
</html>"));
end BoilerControl;
