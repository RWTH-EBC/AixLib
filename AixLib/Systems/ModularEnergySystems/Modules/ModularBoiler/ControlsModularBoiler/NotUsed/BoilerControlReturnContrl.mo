within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ControlsModularBoiler.NotUsed;
model BoilerControlReturnContrl
  "Master controller that holds all other controls"
  // PLR Flow Control
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio" annotation (Dialog(group="Flow Temperature Control"));
  parameter Real kPLR=1 "Gain of controller"  annotation (Dialog(group="Flow Temperature Control"));
  parameter Modelica.Units.SI.Time TiPLR=10 "Time constant of Integrator block"  annotation (Dialog(group="Flow Temperature Control"));
  parameter Real yMaxPLR=1.0 "Upper limit of output"  annotation (Dialog(group="Flow Temperature Control"));
  parameter Real yMinPLR=0 "Lower limit of output"  annotation (Dialog(group="Flow Temperature Control"));

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
  parameter Modelica.Units.SI.Temperature TReturnNom=323.15
    "Nominal return temperature" annotation (Dialog(group="Feedback Return Control"));
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

  parameter Modelica.Units.SI.MassFlowRate m_flowRelMin=0.05 "Minimal relative 
    massflowrate for pump control"  annotation (Dialog(group="Pump Control"));

  NotUsed.InternalPumpControl internalPumpControl(final PLRMin=PLRMin)
    annotation (Placement(transformation(extent={{-20,-26},{0,-6}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{100,48},{120,68}}),
        iconTransformation(extent={{92,30},{112,50}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
    annotation (Placement(transformation(extent={{100,14},{120,34}})));
  PLRMinCheck pLRMinCheck(final PLRMin=PLRMin, final m_flowRelMin=m_flowRelMin)
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  SafetyControl safteyControl(
    final TFlowMax=TFlowMax,
    final TRetMin=TRetMin,
    final time_minOff=time_minOff,
    final time_minOn=time_minOn)
    annotation (Placement(transformation(extent={{-20,36},{0,56}})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  heatingCurve heatingCurveControl1(
    redeclare final function HeatingCurveFunction = HeatingCurveFunction,
    final use_tableData=use_tableData,
    final declination=declination,
    final day_hour=day_hour,
    final night_hour=night_hour,
    final zerTim=zerTim,
    final TOffset=TOffset)          if TFlowByHeaCur
    annotation (Placement(transformation(extent={{-92,22},{-72,42}})));
  FeedbackControl feedbackControl(
    final TReturnNom=TReturnNom,
    final k=kFeedBack,
    final Ti=TiFeedBack,
    final yMax=yMaxFeedBack,
    final yMin=yMinFeedBack)
    annotation (Placement(transformation(extent={{-76,-46},{-56,-26}})));
  Modelica.Blocks.Interfaces.RealOutput yValveFeedback
    "Position of feedback valve [0,1]"
    annotation (Placement(transformation(extent={{100,-34},{120,-14}})));
  InternalPLRControlDT
                     internalPLRControlDT(
    final k=kPLR,
    final Ti=TiPLR,
    final yMax=yMaxPLR,
    final yMin=yMinPLR)
    annotation (Placement(transformation(extent={{-16,10},{4,30}})));

  Modelica.Blocks.Sources.Constant TRetSet(k=273.15 + 60)
    annotation (Placement(transformation(extent={{-70,-8},{-50,12}})));
equation
  connect(pLRMinCheck.PLR, PLRset) annotation (Line(points={{86.2,4},{88,4},{88,
          58},{110,58}}, color={0,0,127}));
  connect(pLRMinCheck.mFlowRel, mFlowRel) annotation (Line(points={{87,-4},{92,-4},
          {92,24},{110,24}}, color={0,0,127}));
  connect(boilerControlBus.isOn, safteyControl.isOnSet) annotation (Line(
      points={{0.05,100.05},{0.05,100},{-38,100},{-38,50.4},{-20,50.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TAmbient, heatingCurveControl1.TAmb) annotation (
      Line(
      points={{0.05,100.05},{0.05,100},{-100,100},{-100,32},{-92,32}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(feedbackControl.yValve, yValveFeedback) annotation (Line(points={{-55,
          -36},{94,-36},{94,-24},{110,-24}}, color={0,0,127}));
  connect(heatingCurveControl1.TFlowSet, internalPLRControlDT.TFlowSet)
    annotation (Line(
      points={{-71,32},{-50,32},{-50,22},{-18,22}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(safteyControl.isOn, pLRMinCheck.isOn) annotation (Line(points={{0.4,46},
          {36,46},{36,4.2},{66,4.2}},
                                  color={255,0,255}));
  connect(internalPLRControlDT.PLRset, pLRMinCheck.PLRSet) annotation (Line(
        points={{5,20},{16,20},{16,-0.6},{66,-0.6}}, color={0,0,127}));
  connect(internalPumpControl.mFlowRel, pLRMinCheck.mFlowRelSet) annotation (
      Line(points={{1,-16},{16,-16},{16,-6},{66,-6},{66,-5.4}}, color={0,0,127}));
  if not TFlowByHeaCur then
    connect(boilerControlBus.TFlowSet, internalPLRControlDT.TFlowSet)
      annotation (Line(
        points={{0.05,100.05},{-100,100.05},{-100,22},{-18,22}},
        color={255,204,51},
        thickness=0.5,
        pattern=LinePattern.Dash), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  end if;
  connect(boilerControlBus.TFlowMea, safteyControl.TFlowMea) annotation (Line(
      points={{0.05,100.05},{-38,100.05},{-38,46},{-22,46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TRetMea, safteyControl.TRetMea) annotation (Line(
      points={{0.05,100.05},{-38,100.05},{-38,42},{-22,42},{-22,41.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TFlowMea, internalPLRControlDT.TFlowMea)
    annotation (Line(
      points={{0.05,100.05},{-40,100.05},{-40,14.8},{-18,14.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TRetMea, feedbackControl.TReturnMea) annotation (
      Line(
      points={{0.05,100.05},{-100,100.05},{-100,-36},{-76.2,-36}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TRetMea, internalPumpControl.TFlowMea) annotation (
     Line(
      points={{0.05,100.05},{-48,100.05},{-48,100},{-100,100},{-100,-21.6},{
          -22,-21.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TRetSet.y, internalPumpControl.TFlowSet) annotation (Line(points={{
          -49,2},{-42,2},{-42,-16},{-22,-16}}, color={0,0,127}));
  connect(TRetSet.y, internalPLRControlDT.TRetSet) annotation (Line(points={{
          -49,2},{-36,2},{-36,18.4},{-18,18.4}}, color={0,0,127}));
  connect(boilerControlBus.TRetMea, internalPLRControlDT.TReturnMea)
    annotation (Line(
      points={{0.05,100.05},{-22,100.05},{-22,98},{-36,98},{-36,11.8},{-18,
          11.8}},
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
end BoilerControlReturnContrl;
