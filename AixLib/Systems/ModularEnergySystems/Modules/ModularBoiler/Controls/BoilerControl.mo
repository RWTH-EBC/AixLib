within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Controls;
model BoilerControl "Master controller that holds all other controls"

  //Nominal
    parameter Modelica.Units.SI.Temperature dtWaterNom "Constant output value"
    annotation (Dialog(group="Nominal Condition"));
  parameter Modelica.Units.SI.Temperature TReturnNom=323.15
    "Nominal return temperature" annotation (Dialog(group="Nominal Condition"));

  // PLR Flow Control
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio" annotation (Dialog(group="Flow Temperature Control"));
  parameter Real kPLR=1 "Gain of controller"  annotation (Dialog(group="Flow Temperature Control"));
  parameter Modelica.Units.SI.Time TiPLR=10 "Time constant of Integrator block"  annotation (Dialog(group="Flow Temperature Control"));

  // Heating Curve
  parameter Boolean TFlowByHeaCur=false "Use heating curve to set flow temperature" annotation (Dialog(group="Heating Curve"));
  parameter Boolean use_tableData=true
    "Choose between tables or function to calculate TSet" annotation (Dialog(group="Heating Curve"));
  replaceable function HeatingCurveFunction =
      AixLib.Controls.SetPoints.Functions.HeatingCurveFunction annotation (
      choicesAllMatching=true, Dialog(group="Heating Curve"));
  parameter Real declination=1 annotation (Dialog(group="Heating Curve"));
  parameter Real day_hour=6 annotation (Dialog(group="Heating Curve"));
  parameter Real night_hour=22 annotation (Dialog(group="Heating Curve"));
  parameter Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017
    "Enumeration for choosing how reference time (time = 0) should be defined. Used for heating curve" annotation (Dialog(group="Heating Curve"));
  parameter Modelica.Units.SI.ThermodynamicTemperature TOffset=273.15
    "Offset to heating curve temperature" annotation (Dialog(group="Heating Curve"));

  // Feedback Control

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

  PLRMinCheck pLRMinCheck(final PLRMin=PLRMin)
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  SafetyControl safteyControl(
    final TFlowMax=TFlowMax,
    final TRetMin=TRetMin,
    final time_minOff=time_minOff,
    final time_minOn=time_minOn)
    annotation (Placement(transformation(extent={{-20,36},{0,56}})));
  AixLib.Controls.Interfaces.BoilerControlBus
                              boilerControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  heatingCurve heatingCurveControl1(
    redeclare final function HeatingCurveFunction = HeatingCurveFunction,
    final use_tableData=use_tableData,
    final declination=declination,
    final day_hour=day_hour,
    final night_hour=night_hour,
    final zerTim=zerTim,
    final TOffset=TOffset)          if TFlowByHeaCur
    annotation (Placement(transformation(extent={{-76,70},{-56,90}})));
  FeedbackControl feedbackControl(
    final TReturnNom=TReturnNom,
    final k=kFeedBack,
    final Ti=TiFeedBack,
    final yMax=yMaxFeedBack,
    final yMin=yMinFeedBack)
    annotation (Placement(transformation(extent={{-76,-46},{-56,-26}})));
  InternalPLRControl internalPLRControl(
    final k=kPLR,
    final Ti=TiPLR,
    final yMax=1,
    final yMin=PLRMin)
    annotation (Placement(transformation(extent={{-20,6},{0,26}})));

equation
  connect(boilerControlBus.isOn, safteyControl.isOnSet) annotation (Line(
      points={{0,100},{0,100},{-38,100},{-38,50.4},{-20,50.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TAmbient, heatingCurveControl1.TAmb) annotation (
      Line(
      points={{0,100},{0,100},{-100,100},{-100,80},{-76,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatingCurveControl1.TFlowSet, internalPLRControl.TFlowSet)
    annotation (Line(
      points={{-55,80},{-50,80},{-50,16},{-22,16}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(safteyControl.isOn, pLRMinCheck.isOn) annotation (Line(points={{0.4,46},
          {40,46},{40,4.2},{46,4.2}},
                                  color={255,0,255}));
  connect(internalPLRControl.PLRset, pLRMinCheck.PLRSet) annotation (Line(
        points={{1,16},{38,16},{38,-0.6},{46,-0.6}},
                                                 color={0,0,127}));
  if not TFlowByHeaCur then
    connect(boilerControlBus.TSupSet, internalPLRControl.TFlowSet)
      annotation (Line(
        points={{0,100},{-100,100},{-100,16},{-22,16}},
        color={255,204,51},
        thickness=0.5,
        pattern=LinePattern.Dash), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  end if;
  connect(boilerControlBus.TRetMea, safteyControl.TRetMea) annotation (Line(
      points={{0,100},{-38,100},{-38,42},{-22,42},{-22,41.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TRetMea, feedbackControl.TReturnMea) annotation (
      Line(
      points={{0,100},{-100,100},{-100,-36},{-76.2,-36}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pLRMinCheck.PLR, boilerControlBus.FirRatSet) annotation (Line(
        points={{66.2,4},{76,4},{76,100},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pLRMinCheck.mFlowRel, boilerControlBus.yPumSet) annotation (
      Line(points={{67,-4},{76,-4},{76,100},{0,100}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(feedbackControl.yValve, boilerControlBus.yValSet) annotation (
      Line(points={{-55,-36},{76,-36},{76,100},{0,100}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.TSupMea, safteyControl.TFlowMea) annotation (
      Line(
      points={{0,100},{-38,100},{-38,46},{-22,46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TSupMea, internalPLRControl.TFlowMea)
    annotation (Line(
      points={{0,100},{-38,100},{-38,10.8},{-22,10.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end BoilerControl;
