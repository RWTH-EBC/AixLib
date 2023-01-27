within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
package ControlsModularBoiler "Holds controls for the ModularBoiler"
  extends Modelica.Icons.Package;

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
    parameter Real yMaxPLR=1.0
     "Upper limit of output"  annotation (Dialog(group="Flow Temperature Control"));
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



    Modelica.Blocks.Interfaces.RealOutput PLRset
      annotation (Placement(transformation(extent={{100,48},{120,68}}),
          iconTransformation(extent={{92,30},{112,50}})));
    Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
      annotation (Placement(transformation(extent={{100,14},{120,34}})));
    PLRMinCheck pLRMinCheck(final PLRMin=PLRMin)
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
      annotation (Placement(transformation(extent={{-76,70},{-56,90}})));
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
    InternalPLRControl internalPLRControl(
      final k=kPLR,
      final Ti=TiPLR,
      final yMax=yMaxPLR,
      final yMin=yMinPLR)
      annotation (Placement(transformation(extent={{-20,6},{0,26}})));

    Modelica.Blocks.Interfaces.RealOutput dTWaterNom(unit="K")
      "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-72},{120,-52}})));
  protected
    Modelica.Blocks.Sources.Constant const(final k=dtWaterNom)
      annotation (Placement(transformation(extent={{62,-72},{82,-52}})));
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
        points={{0.05,100.05},{0.05,100},{-100,100},{-100,80},{-76,80}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(feedbackControl.yValve, yValveFeedback) annotation (Line(points={{-55,
            -36},{94,-36},{94,-24},{110,-24}}, color={0,0,127}));
    connect(heatingCurveControl1.TFlowSet, internalPLRControl.TFlowSet)
      annotation (Line(
        points={{-55,80},{-50,80},{-50,16},{-22,16}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(safteyControl.isOn, pLRMinCheck.isOn) annotation (Line(points={{0.4,46},
            {36,46},{36,4.2},{66,4.2}},
                                    color={255,0,255}));
    connect(internalPLRControl.PLRset, pLRMinCheck.PLRSet) annotation (Line(
          points={{1,16},{16,16},{16,-0.6},{66,-0.6}},
                                                   color={0,0,127}));
    if not TFlowByHeaCur then
      connect(boilerControlBus.TFlowSet, internalPLRControl.TFlowSet) annotation (
        Line(
        points={{0.05,100.05},{-100,100.05},{-100,16},{-22,16}},
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
    connect(boilerControlBus.TFlowMea, internalPLRControl.TFlowMea) annotation (
        Line(
        points={{0.05,100.05},{-40,100.05},{-40,10.8},{-22,10.8}},
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
    connect(const.y, dTWaterNom)
      annotation (Line(points={{83,-62},{110,-62}}, color={0,0,127}));
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

  model InternalPumpControl

    parameter Real PLRMin=0.15 "Minimal Part Load Ratio";


    Modelica.Blocks.Continuous.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.01,
      Ti=10,
      yMax=1,
      yMin=0.05,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
              annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput TFlowMea(unit="K")
      "Measured flow temperature of boiler"
      annotation (Placement(transformation(extent={{-140,-76},{-100,-36}})));
    Modelica.Blocks.Interfaces.RealInput TFlowSet(unit="K")
      "Set flow temperature of boiler"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Sources.Constant const(k=1)
      annotation (Placement(transformation(extent={{30,-12},{50,8}})));
  equation
    connect(TFlowSet, PID.u_s)
      annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
    connect(TFlowMea, PID.u_m) annotation (Line(points={{-120,-56},{-40,-56},{
            -40,-12}}, color={0,0,127}));
    connect(const.y, mFlowRel) annotation (Line(points={{51,-2},{96,-2},{96,0},
            {110,0}}, color={0,0,127}));
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
            textString="%name")}),                                 Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html><p>
  Boiler control unit, which estimates the relative water mass flow and
  chooses the right water temperature difference.
</p>
</html>"));
  end InternalPumpControl;

  model PLRMinCheck

      parameter Real PLRMin=0.15 "Minimal Part Load Ratio";
      parameter Modelica.Units.SI.MassFlowRate m_flowRelMin=0.05 "Minimal relative 
    massflowrate for pump control";
    Modelica.Blocks.Interfaces.RealInput PLRSet "Setvalue of PLR "
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
          iconTransformation(extent={{-120,-26},{-80,14}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold
                                          greaterEqualThreshold(
                                                         final threshold=PLRMin)
      annotation (Placement(transformation(extent={{-66,-8},{-50,8}})));
    Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Modelica.Blocks.Interfaces.RealOutput PLR annotation (Placement(
          transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={
              {92,30},{112,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression1
      annotation (Placement(transformation(extent={{2,12},{22,32}})));
    Modelica.Blocks.Logical.Switch switch4
      annotation (Placement(transformation(extent={{40,26},{60,46}})));
    Modelica.Blocks.Interfaces.BooleanInput isOn
      "Set value for boiler on/off status"
      annotation (Placement(transformation(extent={{-120,22},{-80,62}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-30,-2},{-10,18}})));
    Modelica.Blocks.Sources.Constant constPump(k=1)
      annotation (Placement(transformation(extent={{66,-50},{86,-30}})));
  equation
    connect(PLRSet, greaterEqualThreshold.u)
      annotation (Line(points={{-100,0},{-67.6,0}}, color={0,0,127}));
    connect(switch4.y, PLR) annotation (Line(points={{61,36},{72,36},{72,0},{110,0}},
          color={0,0,127}));
    connect(isOn, and1.u1)
      annotation (Line(points={{-100,42},{-32,42},{-32,8}}, color={255,0,255}));
    connect(greaterEqualThreshold.y, and1.u2)
      annotation (Line(points={{-49.2,0},{-32,0}}, color={255,0,255}));
    connect(realExpression1.y, switch4.u3) annotation (Line(points={{23,22},{30,22},
            {30,28},{38,28}}, color={0,0,127}));
    connect(PLRSet, switch4.u1) annotation (Line(points={{-100,0},{-74,0},{-74,
            44},{38,44}},
                      color={0,0,127}));
    connect(and1.y, switch4.u2) annotation (Line(points={{-9,8},{-6,8},{-6,36},{38,
            36}}, color={255,0,255}));
    connect(constPump.y, mFlowRel) annotation (Line(points={{87,-40},{100,-40},
            {100,-40},{110,-40}}, color={0,0,127}));
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
  end PLRMinCheck;

  model SafetyControl
    parameter Modelica.Units.SI.Temperature TFlowMax=378.15 "Maximum flow temperature, at which the system is shut down";
    parameter Modelica.Units.SI.Temperature TRetMin=313.15 "Minimum return temperature, at which the system is shut down";

    Modelica.Blocks.Sources.RealExpression TFlowMaxExp(final y=TFlowMax)
      annotation (Placement(transformation(extent={{-96,-30},{-76,-10}})));
    Modelica.Blocks.Interfaces.RealInput TFlowMea(unit="K")
      "Measured flow temperature of boiler"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput isOn
      "Set value for on/off status of boiler after emergency check"
      annotation (Placement(transformation(extent={{94,-10},{114,10}})));
    Modelica.Blocks.Interfaces.BooleanInput isOnSet
      "Set value for on off status of boiler"
      annotation (Placement(transformation(extent={{-120,24},{-80,64}})));

    Control.HierarchicalControl_ModularBoiler.ManualControl_ModularBoiler.deviceStatusDelay
      deviceStatusDelay1(
      final time_minOff=time_minOff,
      final time_minOn=time_minOn,
      use_safetyShutoff=true)
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Logical.Greater greater
      annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
    Modelica.Blocks.Interfaces.RealInput TRetMea(unit="K")
      "Measured return temperature of boiler"
      annotation (Placement(transformation(extent={{-140,-62},{-100,-22}})));
    Modelica.Blocks.Sources.RealExpression TRetMinExp(final y=TRetMin)
      annotation (Placement(transformation(extent={{-96,-72},{-76,-52}})));
    Modelica.Blocks.Logical.Less    less
      annotation (Placement(transformation(extent={{-48,-52},{-28,-32}})));
    parameter Modelica.Units.SI.Time time_minOff=900
      "Time after which the device can be turned on again";
    parameter Modelica.Units.SI.Time time_minOn=900
      "Time after which the device can be turned off again";
  equation

     ///Assertion
    assert(
      TFlowMea < TFlowMax,
      "Maximum boiler temperature has been exceeded",
      AssertionLevel.warning);
    assert(
      TRetMea > TRetMin,
      "Maximum boiler temperature has been exceeded",
      AssertionLevel.warning);
    connect(TFlowMea, greater.u1)
      annotation (Line(points={{-120,0},{-50,0}}, color={0,0,127}));
    connect(TFlowMaxExp.y, greater.u2)
      annotation (Line(points={{-75,-20},{-50,-20},{-50,-8}}, color={0,0,127}));
    connect(TRetMinExp.y, less.u2) annotation (Line(points={{-75,-62},{-58,-62},{-58,
            -50},{-50,-50}}, color={0,0,127}));
    connect(TRetMea, less.u1)
      annotation (Line(points={{-120,-42},{-50,-42}}, color={0,0,127}));
    connect(isOnSet, deviceStatusDelay1.u) annotation (Line(points={{-100,44},{52,
            44},{52,0},{58,0}}, color={255,0,255}));
    connect(deviceStatusDelay1.y, isOn)
      annotation (Line(points={{81,0},{104,0}}, color={255,0,255}));
    connect(greater.y, deviceStatusDelay1.u_safety) annotation (Line(points={{
            -27,0},{50,0},{50,-8},{58,-8}}, color={255,0,255}));
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
            textString="%name")}),                                 Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SafetyControl;

  model heatingCurve
    "Flow temperature control (power control) with heating curve"

     //Heating Curve
   replaceable function HeatingCurveFunction =
        AixLib.Controls.SetPoints.Functions.HeatingCurveFunction constrainedby
      AixLib.Controls.SetPoints.Functions.PartialBaseFct annotation (Dialog(group="Heating Curve"));
   parameter Boolean use_tableData=true "Choose between tables or function to calculate TSet" annotation (Dialog(group="Heating Curve"));
   parameter Real declination=1 annotation (Dialog(group="Heating Curve"));
   parameter Real day_hour=6 annotation (Dialog(group="Heating Curve"));
   parameter Real night_hour=22 annotation (Dialog(group="Heating Curve"));
   parameter AixLib.Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017
      "Enumeration for choosing how reference time (time = 0) should be defined. Used for heating curve" annotation (Dialog(group="Heating Curve"));
   parameter Modelica.Units.SI.ThermodynamicTemperature TOffset=273.15
      "Offset to heating curve temperature" annotation (Dialog(group="Heating Curve"));

   AixLib.Controls.SetPoints.HeatingCurve heatingCurve(
      final TOffset=TOffset,
      final use_dynTRoom=false,
      final zerTim=zerTim,
      final day_hour=day_hour,
      final night_hour=night_hour,
      final heatingCurveRecord=
          AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10(),
      final declination=declination,
      redeclare function HeatingCurveFunction = HeatingCurveFunction,
      final use_tableData=use_tableData,
      final TRoom_nominal=293.15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

   Modelica.Blocks.Interfaces.RealInput TAmb(unit="K")
      "Measured ambient temperature for heating curve"
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));

    Modelica.Blocks.Interfaces.RealOutput TFlowSet(unit="K")
      "Set flow temperature calculated by heating curve"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation

    connect(TAmb, heatingCurve.T_oda)
      annotation (Line(points={{-100,0},{-12,0}}, color={0,0,127}));
    connect(heatingCurve.TSet, TFlowSet)
      annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
    annotation (Documentation(info="<html><p>
  Ambient temperature guided flow temperature control for heat
  generators. The temperature control can be switched on and off via
  the isOn input from the outside. A heating curve model is used to
  determine the required flow temperature depending on the ambient
  temperature. The associated data are recorded in a table and the
  values are determined by means of interpolation. Furthermore, the
  model has a day and night mode, in which the set temperatures differ
  at the same ambient temperature. The PI-Controller was set for this
  application.
</p>
<h4>
  Important parameters
</h4>
<ul>
  <li>declination: The user can choose the steepness of the curve. The
  higher the parameter, the higher the determined
  </li>
</ul>
</html>"),   Icon(graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid),
                              Text(
            extent={{-90,36},{110,-8}},
            lineColor={0,0,127},
            pattern=LinePattern.Dash,
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end heatingCurve;

  model FeedbackControl "Controller for return feedback mixing"
  protected
    Modelica.Blocks.Sources.RealExpression TSetReturn(final y=TReturnNom)
      annotation (Placement(transformation(extent={{-76,12},{-56,32}})));
  public
    Modelica.Blocks.Continuous.LimPID PIValve(
      final controllerType=Modelica.Blocks.Types.SimpleController.PI,
      final k=k,
      final Ti=Ti,
      final yMax=yMax,
      final yMin=yMin,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=yMin)
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-2,0})));
    Modelica.Blocks.Interfaces.RealOutput yValve "Position of feedback valve"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={110,0})));
    Modelica.Blocks.Interfaces.RealInput TReturnMea(unit="K")
      "Measured return temperature"
      annotation (Placement(transformation(extent={{-122,-20},{-82,20}})));
    Modelica.Blocks.Math.Gain gain1(final k=-1)
      annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={-30,22})));
    Modelica.Blocks.Math.Gain gain2(final k=-1)
      annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={-68,-34})));
    parameter Modelica.Units.SI.Temperature TReturnNom=323.15 "Nominal return temperature" annotation (Dialog(group="Feedback Return Control"));
    parameter Real k=1 "Gain of controller" annotation (Dialog(group="Feedback Return Control"));
    parameter Modelica.Units.SI.Time Ti=0.5 "Time constant of Integrator block" annotation (Dialog(group="Feedback Return Control"));
    parameter Real yMax=0.99 "Upper limit of output" annotation (Dialog(group="Feedback Return Control"));
    parameter Real yMin=0 "Lower limit of output" annotation (Dialog(group="Feedback Return Control"));
  equation
    connect(PIValve.y, yValve) annotation (Line(points={{9,-8.88178e-16},{9,0},{110,
            0}}, color={0,0,127}));
    connect(TReturnMea, gain2.u)
      annotation (Line(points={{-102,0},{-75.2,0},{-75.2,-34}},
                                                            color={0,0,127}));
    connect(gain2.y, PIValve.u_m)
      annotation (Line(points={{-61.4,-34},{-2,-34},{-2,-12}}, color={0,0,127}));
    connect(gain1.y, PIValve.u_s) annotation (Line(points={{-23.4,22},{-16,22},{-16,
            6},{-20,6},{-20,1.9984e-15},{-14,1.9984e-15}}, color={0,0,127}));
    connect(TSetReturn.y, gain1.u)
      annotation (Line(points={{-55,22},{-37.2,22}}, color={0,0,127}));
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
  end FeedbackControl;

  model ManualControl
    "This model offers the choice between intern and extern control"
    parameter Real PLRMin=0.15;
    parameter Boolean manualTimeDelay=false "If true, the user can set a time during which the heat genearator is switched on independently of the internal control";
    parameter Modelica.Units.SI.Time time_minOff=900
      "Time after which the device can be turned on again";
    parameter Modelica.Units.SI.Time time_minOn=900
      "Time after which the device can be turned off again";

    Modelica.Blocks.Interfaces.BooleanInput isOn "On/off value of boiler"
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    Control.HierarchicalControl_ModularBoiler.ManualControl_ModularBoiler.deviceStatusDelay
      deviceStatusDelay1(final time_minOff=time_minOff, final time_minOn=
          time_minOn)
      annotation (Placement(transformation(extent={{-48,12},{-28,32}})));
    Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
      annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(
      final y=manualTimeDelay)
      annotation (Placement(transformation(extent={{-14,18},{6,38}})));
    Modelica.Blocks.Interfaces.RealInput PLRPreCtrl
      "Set value for PLR before control"
      annotation (Placement(transformation(extent={{-122,56},{-82,96}})));
    Modelica.Blocks.Logical.LogicalSwitch logicalSwitch1
      annotation (Placement(transformation(extent={{26,-10},{46,10}})));
    Modelica.Blocks.Interfaces.RealOutput PLRAftCtrl
      annotation (Placement(transformation(extent={{90,58},{110,78}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{0,58},{20,78}})));
    Modelica.Blocks.Sources.RealExpression realExpression
      annotation (Placement(transformation(extent={{-32,50},{-12,70}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(
      final threshold=PLRMin)
      annotation (Placement(transformation(extent={{-80,42},{-64,58}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(final y=1)
      annotation (Placement(transformation(extent={{-34,66},{-14,86}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{46,58},{66,78}})));

  equation
    connect(isOn, logicalSwitch.u2)
      annotation (Line(points={{-100,0},{-18,0}}, color={255,0,255}));
    connect(isOn, logicalSwitch.u3) annotation (Line(points={{-100,0},{-44,0},{
            -44,-8},{-18,-8}}, color={255,0,255}));
    connect(deviceStatusDelay1.y, logicalSwitch.u1)
      annotation (Line(points={{-27,
            22},{-24,22},{-24,8},{-18,8}}, color={255,0,255}));
    connect(logicalSwitch.y, logicalSwitch1.u1)
      annotation (Line(points={{5,0},{12,0},{12,8},{24,8}}, color={255,0,255}));
    connect(isOn, logicalSwitch1.u3) annotation (Line(points={{-100,0},{-44,0},
            {-44,-16},{14,-16},{14,-8},{24,-8}}, color={255,0,255}));
    connect(booleanExpression.y, logicalSwitch1.u2)
      annotation (Line(points={{7,
            28},{16,28},{16,0},{24,0}}, color={255,0,255}));
    connect(PLRPreCtrl, greaterEqualThreshold.u) annotation (Line(points={{-102,
            76},{-84,76},{-84,50},{-81.6,50}}, color={0,0,127}));
    connect(greaterEqualThreshold.y, deviceStatusDelay1.u)
      annotation (Line(
          points={{-63.2,50},{-56,50},{-56,22},{-50,22}}, color={255,0,255}));
    connect(switch1.u3, realExpression.y)
      annotation (Line(points={{-2,60},{-11,60}}, color={0,0,127}));
    connect(switch1.u1, realExpression1.y)
      annotation (Line(points={{-2,76},{-13,76}}, color={0,0,127}));
    connect(logicalSwitch1.y, switch1.u2)
      annotation (Line(points={{47,0},{54,0},
            {54,50},{-6,50},{-6,68},{-2,68}}, color={255,0,255}));
    connect(booleanExpression.y, switch2.u2)
      annotation (Line(points={{7,28},{34,
            28},{34,68},{44,68}}, color={255,0,255}));
    connect(PLRPreCtrl, switch2.u3) annotation (Line(points={{-102,76},{-46,76},
            {-46,44},{40,44},{40,60},{44,60}}, color={0,0,127}));
    connect(switch1.y, switch2.u1)
      annotation (Line(points={{21,68},{32,68},{32,
            76},{44,76}}, color={0,0,127}));
    connect(switch2.y, PLRAftCtrl)
      annotation (Line(points={{67,68},{100,68}}, color={0,0,127}));

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html><p>
  With this model, the switch between internal and external control
  takes place. In addition, this model implements the function of
  manually specifying a fixed operating time for the heat generator
  from the outside.
</p>
</html>"));
  end ManualControl;

  model InternalPLRControl
    "Simple control with flow temperature PID control if no other signal provided"
   // PI Control
   parameter Real k=1 "Gain of controller" annotation (Dialog(group="Flow Temperature PI"));
   parameter Modelica.Units.SI.Time Ti=10 "Time constant of Integrator block" annotation (Dialog(group="Flow Temperature PI"));
   parameter Real yMax=1.0 "Upper limit of output" annotation (Dialog(group="Flow Temperature PI"));
   Modelica.Blocks.Interfaces.RealInput TFlowMea(unit="K") annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-120,-52})));
   Modelica.Blocks.Continuous.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      final k=k,
      final Ti=Ti,
      yMax=yMax,
      yMin=yMin)
              "PI Controller for controlling the valve position"
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
   Modelica.Blocks.Interfaces.RealOutput PLRset
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput TFlowSet(unit="K")
      "Set value for flow temperature"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    parameter Real yMin=0 "Lower limit of output";
  equation
    connect(TFlowMea,PID. u_m) annotation (Line(points={{-120,-52},{0,-52},{0,-12}},
                   color={0,0,127}));
    connect(PID.y,PLRset)
      annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
    connect(PID.u_s, TFlowSet)
      annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
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
  end InternalPLRControl;

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
    massflowrate for pump control"    annotation (Dialog(group="Pump Control"));

    InternalPumpControl internalPumpControl(final PLRMin=PLRMin)
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

  model InternalPLRControlDT
    "Simple control with flow temperature PID control if no other signal provided"
   // PI Control
   parameter Real k=1 "Gain of controller" annotation (Dialog(group="Flow Temperature PI"));
   parameter Modelica.Units.SI.Time Ti=10 "Time constant of Integrator block" annotation (Dialog(group="Flow Temperature PI"));
   parameter Real yMax=1.0 "Upper limit of output" annotation (Dialog(group="Flow Temperature PI"));
   Modelica.Blocks.Interfaces.RealInput TFlowMea(unit="K") annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-120,-52})));
   Modelica.Blocks.Continuous.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      final k=k,
      final Ti=Ti,
      yMax=yMax,
      yMin=yMin)
              "PI Controller for controlling the valve position"
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
   Modelica.Blocks.Interfaces.RealOutput PLRset
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput TFlowSet(unit="K")
      "Set value for flow temperature"
      annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
    parameter Real yMin=0 "Lower limit of output";
   Modelica.Blocks.Interfaces.RealInput TReturnMea(unit="K")
      "Current return temperature" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-120,-82})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{-58,-70},{-38,-50}})));
    Modelica.Blocks.Interfaces.RealInput TRetSet(unit="K")
      "Set value for flow temperature"
      annotation (Placement(transformation(extent={{-140,-36},{-100,4}})));
    Modelica.Blocks.Math.Add add1(k2=-1)
      annotation (Placement(transformation(extent={{-66,-12},{-46,8}})));
  equation
    connect(PID.y,PLRset)
      annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
    connect(TFlowMea, add.u1) annotation (Line(points={{-120,-52},{-118,-52},{
            -118,-54},{-60,-54}}, color={0,0,127}));
    connect(TReturnMea, add.u2) annotation (Line(points={{-120,-82},{-66,-82},{
            -66,-66},{-60,-66}}, color={0,0,127}));
    connect(add.y, PID.u_m) annotation (Line(points={{-37,-60},{-22,-60},{-22,
            -58},{0,-58},{0,-12}}, color={0,0,127}));
    connect(TFlowSet, add1.u1) annotation (Line(points={{-120,20},{-74,20},{-74,
            4},{-68,4}}, color={0,0,127}));
    connect(TRetSet, add1.u2) annotation (Line(points={{-120,-16},{-76,-16},{
            -76,-8},{-68,-8}}, color={0,0,127}));
    connect(add1.y, PID.u_s) annotation (Line(points={{-45,-2},{-42,-2},{-42,0},
            {-12,0}}, color={0,0,127}));
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
  end InternalPLRControlDT;

  model BoilerControlPumpVar "Master controller that holds all other controls"
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
    massflowrate for pump control"    annotation (Dialog(group="Pump Control"));

    InternalPumpControl internalPumpControl(final PLRMin=PLRMin)
      annotation (Placement(transformation(extent={{-20,-26},{0,-6}})));
    Modelica.Blocks.Interfaces.RealOutput PLRset
      annotation (Placement(transformation(extent={{100,48},{120,68}}),
          iconTransformation(extent={{92,30},{112,50}})));
    Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
      annotation (Placement(transformation(extent={{100,14},{120,34}})));
    PLRMinCheckPumpVar
                pLRMinCheckPumpVar(
                            final PLRMin=PLRMin, final m_flowRelMin=m_flowRelMin)
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
      annotation (Placement(transformation(extent={{-76,70},{-56,90}})));
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
    InternalPLRControl internalPLRControl(
      final k=kPLR,
      final Ti=TiPLR,
      final yMax=yMaxPLR,
      final yMin=yMinPLR)
      annotation (Placement(transformation(extent={{-20,6},{0,26}})));

  equation
    connect(pLRMinCheckPumpVar.PLR, PLRset) annotation (Line(points={{86.2,4},{
            88,4},{88,58},{110,58}}, color={0,0,127}));
    connect(pLRMinCheckPumpVar.mFlowRel, mFlowRel) annotation (Line(points={{87,
            -4},{92,-4},{92,24},{110,24}}, color={0,0,127}));
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
        points={{0.05,100.05},{0.05,100},{-100,100},{-100,80},{-76,80}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(feedbackControl.yValve, yValveFeedback) annotation (Line(points={{-55,
            -36},{94,-36},{94,-24},{110,-24}}, color={0,0,127}));
    connect(heatingCurveControl1.TFlowSet, internalPumpControl.TFlowSet)
      annotation (Line(
        points={{-55,80},{-50,80},{-50,-16},{-22,-16}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(heatingCurveControl1.TFlowSet, internalPLRControl.TFlowSet)
      annotation (Line(
        points={{-55,80},{-50,80},{-50,16},{-22,16}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(safteyControl.isOn, pLRMinCheckPumpVar.isOn) annotation (Line(
          points={{0.4,46},{36,46},{36,4.2},{66,4.2}}, color={255,0,255}));
    connect(internalPLRControl.PLRset, pLRMinCheckPumpVar.PLRSet) annotation (
        Line(points={{1,16},{16,16},{16,-0.6},{66,-0.6}}, color={0,0,127}));
    connect(internalPumpControl.mFlowRel, pLRMinCheckPumpVar.mFlowRelSet)
      annotation (Line(points={{1,-16},{16,-16},{16,-6},{66,-6},{66,-5.4}},
          color={0,0,127}));
    if not TFlowByHeaCur then
      connect(boilerControlBus.TFlowSet, internalPLRControl.TFlowSet) annotation (
        Line(
        points={{0.05,100.05},{-100,100.05},{-100,16},{-22,16}},
        color={255,204,51},
        thickness=0.5,
        pattern=LinePattern.Dash), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
      connect(boilerControlBus.TFlowSet, internalPumpControl.TFlowSet)
        annotation (Line(
          points={{0.05,100.05},{-100,100.05},{-100,-16},{-22,-16}},
          color={255,204,51},
          thickness=0.5,
          pattern=LinePattern.Dash), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
    end if;
    connect(boilerControlBus.TFlowMea, internalPumpControl.TFlowMea)
      annotation (Line(
        points={{0.05,100.05},{-40,100.05},{-40,-21.6},{-22,-21.6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
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
    connect(boilerControlBus.TFlowMea, internalPLRControl.TFlowMea) annotation (
       Line(
        points={{0.05,100.05},{-40,100.05},{-40,10.8},{-22,10.8}},
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
  end BoilerControlPumpVar;

  model PLRMinCheckPumpVar

      parameter Real PLRMin=0.15 "Minimal Part Load Ratio";
      parameter Modelica.Units.SI.MassFlowRate m_flowRelMin=0.05 "Minimal relative 
    massflowrate for pump control";
    Modelica.Blocks.Interfaces.RealInput PLRSet "Setvalue of PLR "
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
          iconTransformation(extent={{-120,-26},{-80,14}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold
                                          greaterEqualThreshold(
                                                         final threshold=PLRMin)
      annotation (Placement(transformation(extent={{-66,-8},{-50,8}})));
    Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Modelica.Blocks.Interfaces.RealInput mFlowRelSet
      "Setvalue of relative mass flow for pump " annotation (Placement(
          transformation(extent={{-120,-54},{-80,-14}}), iconTransformation(
            extent={{-120,-74},{-80,-34}})));
    Modelica.Blocks.Interfaces.RealOutput PLR annotation (Placement(
          transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={
              {92,30},{112,50}})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{40,-48},{60,-28}})));
    Modelica.Blocks.Sources.RealExpression realExpression(final y=m_flowRelMin)
      annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression1
      annotation (Placement(transformation(extent={{2,12},{22,32}})));
    Modelica.Blocks.Logical.Switch switch4
      annotation (Placement(transformation(extent={{40,26},{60,46}})));
    Modelica.Blocks.Interfaces.BooleanInput isOn
      "Set value for boiler on/off status"
      annotation (Placement(transformation(extent={{-120,22},{-80,62}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-30,-2},{-10,18}})));
  equation
    connect(PLRSet, greaterEqualThreshold.u)
      annotation (Line(points={{-100,0},{-67.6,0}}, color={0,0,127}));
    connect(switch4.y, PLR) annotation (Line(points={{61,36},{72,36},{72,0},{110,0}},
          color={0,0,127}));
    connect(isOn, and1.u1)
      annotation (Line(points={{-100,42},{-32,42},{-32,8}}, color={255,0,255}));
    connect(greaterEqualThreshold.y, and1.u2)
      annotation (Line(points={{-49.2,0},{-32,0}}, color={255,0,255}));
    connect(realExpression.y, switch3.u3)
      annotation (Line(points={{21,-50},{38,-50},{38,-46}}, color={0,0,127}));
    connect(mFlowRelSet, switch3.u1) annotation (Line(points={{-100,-34},{30,-34},
            {30,-30},{38,-30}}, color={0,0,127}));
    connect(realExpression1.y, switch4.u3) annotation (Line(points={{23,22},{30,22},
            {30,28},{38,28}}, color={0,0,127}));
    connect(PLRSet, switch4.u1) annotation (Line(points={{-100,0},{-74,0},{-74,
            44},{38,44}},
                      color={0,0,127}));
    connect(and1.y, switch4.u2) annotation (Line(points={{-9,8},{-6,8},{-6,36},{38,
            36}}, color={255,0,255}));
    connect(and1.y, switch3.u2) annotation (Line(points={{-9,8},{-6,8},{-6,-38},{38,
            -38}}, color={255,0,255}));
    connect(mFlowRelSet, mFlowRel) annotation (Line(points={{-100,-34},{110,-34},
            {110,-40}}, color={0,0,127}));
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
  end PLRMinCheckPumpVar;
  annotation (Icon(graphics={
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
      Rectangle(
        origin={0,35.149},
        fillColor={255,255,255},
        extent={{-30.0,-20.1488},{30.0,20.1488}}),
      Rectangle(
        origin={0,-34.851},
        fillColor={255,255,255},
        extent={{-30.0,-20.1488},{30.0,20.1488}}),
      Line(
        origin={-51.25,0},
        points={{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),
      Polygon(
        origin={-40,35},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
      Line(
        origin={51.25,0},
        points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),
      Polygon(
        origin={40,-35},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}));
end ControlsModularBoiler;
