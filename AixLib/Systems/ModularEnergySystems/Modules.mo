within AixLib.Systems.ModularEnergySystems;
package Modules
  extends Modelica.Icons.VariantsPackage;

  package ModularBoiler

    model ModularBoiler
      "Modular Boiler Model - With pump and feedback - Simple PLR regulation"
        extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
        redeclare package Medium = MediumWater,
        final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));

      parameter Boolean m_flowVar=false "Use variable water massflow"
        annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

      parameter Boolean Advanced=false "dTWater is constant for different PLR"
        annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
      parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
        annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));

      parameter Modelica.Units.SI.Temperature TStart=293.15 "T start"
        annotation (Dialog(tab="Advanced"));
      parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
        "Start value of pressure"
        annotation (Dialog(tab="Advanced", group="Initialization"));

      // System Parameters
      parameter Boolean hasFeedback=true  "circuit has Feedback"     annotation (choices(checkBox=true), Dialog(descriptionLabel=true, group="System setup"));
      parameter Boolean Pump=true "Model includes a pump"
        annotation (choices(checkBox=true), Dialog(descriptionLabel=true, group="System setup"));
      parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Thermal dimension power"
        annotation (Dialog(group="System setup"));
      parameter Real PLRMin=0.15 "Minimal Part Load Ratio" annotation(Dialog(group="System setup"));
      package MediumWater = AixLib.Media.Water "Boiler Medium" annotation(Dialog(group="System setup"));

      // Nominal parameters
        parameter Modelica.Units.SI.Temperature TRetNom=308.15
        "Return temperature TCold"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
        annotation (Dialog(group="Nominal condition"));

      // Safety Control
      parameter Modelica.Units.SI.Temperature TFlowMax=363.15
        "Maximal temperature to force shutdown" annotation(Dialog(tab="Control", group="Safety"));
      parameter Modelica.Units.SI.Temperature TRetMin=313.15
        "Minimum return temperature, at which the system is shut down" annotation(Dialog(tab="Control", group="Safety"));
      parameter Modelica.Units.SI.Time time_minOff=900
        "Time after which the device can be turned on again" annotation(Dialog(tab="Control", group="Safety"));
      parameter Modelica.Units.SI.Time time_minOn=900
        "Time after which the device can be turned off again" annotation(Dialog(tab="Control", group="Safety"));

      // Heating Curve
      parameter Boolean use_HeaCur=false
        "Use heating curve to set flow temperature" annotation(Dialog(tab="Control", group="Heating Curve"), choices(checkBox = true));
      parameter Boolean use_tableData=true
        "Choose between tables or function to calculate TSet" annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
      replaceable function HeatingCurveFunction =
          AixLib.Controls.SetPoints.Functions.HeatingCurveFunction annotation (
          choicesAllMatching=true, Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
      parameter Real declination=1 annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
      parameter Real day_hour=6 annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
      parameter Real night_hour=22 annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
      parameter Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017
        "Enumeration for choosing how reference time (time = 0) should be defined. Used for heating curve" annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
      parameter Modelica.Units.SI.ThermodynamicTemperature TOffset=273.15
        "Offset to heating curve temperature" annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));

      // PLR Flow temperature control
      parameter Real kPLR=0.05 "Gain of controller" annotation (Dialog(tab="Control", group = "Flow temperature"));
      parameter Modelica.Units.SI.Time TiPLR=10 "Time constant of Integrator block" annotation (Dialog(tab="Control", group = "Flow temperature"));

      // Feedback
      parameter Real kFeedBack=1 "Gain of controller" annotation (Dialog(enable=hasFeedback, tab="Control", group = "Feedback"));
      parameter Modelica.Units.SI.Time TiFeedBack=0.5
        "Time constant of Integrator block" annotation (Dialog(enable=hasFeedback, tab="Control", group = "Feedback"));
      parameter Real yMaxFeedBack=0.99 "Upper limit of output" annotation (Dialog(enable=hasFeedback, tab="Control", group = "Feedback"));
      parameter Real yMinFeedBack=0.01 "Lower limit of output" annotation (Dialog(enable=hasFeedback, tab="Control", group = "Feedback"));
      parameter Modelica.Units.SI.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system"
        annotation (Dialog(enable = hasFeedback, group="Feedback"));

      Fluid.BoilerCHP.BoilerGeneric boilerGeneric(
        allowFlowReversal=allowFlowReversal,
        final T_start=TStart,
        final QNom=QNom,
        TSupNom=TSupNom,
        final TRetNom=TRetNom)
        annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
      AixLib.Fluid.Sensors.TemperatureTwoPort senTSup(
        redeclare final package Medium = Medium,
        final m_flow_nominal=m_flow_nominal,
        final initType=Modelica.Blocks.Types.Init.InitialState,
        final T_start=TStart,
        final transferHeat=false,
        final allowFlowReversal=allowFlowReversal,
        final m_flow_small=0.001)
        "Temperature sensor of hot side of heat generator (supply)" annotation (
         Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={60,0})));
      AixLib.Fluid.Sensors.TemperatureTwoPort senTRet(
        redeclare final package Medium = Medium,
        final m_flow_nominal=m_flow_nominal,
        final initType=Modelica.Blocks.Types.Init.InitialState,
        final T_start=TStart,
        final transferHeat=false,
        final allowFlowReversal=allowFlowReversal,
        final m_flow_small=0.001)
        "Temperature sensor of cold side of heat generator (supply)" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-60,0})));

      AixLib.Fluid.Movers.SpeedControlled_y pump(
        redeclare final package Medium = Medium,
        final allowFlowReversal=allowFlowReversal,
        final m_flow_small=0.001,
        final per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={
                dp_nominal/0.8,dp_nominal,0})),
        final addPowerToMedium=false) if Pump "Boiler Pump"
        annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));

      Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
        redeclare final package Medium = Medium,
        use_inputFilter=false,
        final m_flow_nominal= m_flow_nominal,
        final dpValve_nominal=dp_Valve,
        final dpFixed_nominal={0,0})           if hasFeedback
        annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));

      AixLib.Controls.Interfaces.BoilerControlBus
                                  boilerControlBus
        annotation (Placement(transformation(extent={{-10,88},{10,108}})));

      Controls.BoilerControl boilerControl(
        dtWaterNom=dTWaterNom,
        final PLRMin=PLRMin,
        kPLR=kPLR,
        TiPLR=TiPLR,
        final TFlowByHeaCur=use_HeaCur,
        final use_tableData=use_tableData,
        redeclare final function HeatingCurveFunction = HeatingCurveFunction,
        final declination=declination,
        final day_hour=day_hour,
        final night_hour=night_hour,
        final zerTim=zerTim,
        final TOffset=TOffset,
        final TReturnNom=TRetNom,
        final kFeedBack=kFeedBack,
        final TiFeedBack=TiFeedBack,
        final yMaxFeedBack=yMaxFeedBack,
        final yMinFeedBack=yMinFeedBack,
        final TRetMin=TRetMin,
        final time_minOff=time_minOff,
        final TFlowMax=TFlowMax,
        final time_minOn=time_minOn) "Central control unit of boiler"
        annotation (Placement(transformation(extent={{-96,58},{-62,92}})));

      parameter Modelica.Units.SI.Temperature TSupNom=353.15
        "Design supply temperature";
    protected
        parameter Modelica.Units.SI.PressureDifference dp_nominal = dp_nominal_boiler + dp_Valve;
      parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
      parameter Modelica.Units.SI.PressureDifference dp_nominal_boiler=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
      parameter Modelica.Units.SI.SpecificHeatCapacity cp_medium = Medium.cp_const;

    equation
      if not Pump then
        connect(senTRet.port_b, boilerGeneric.port_a);
      else
        connect(pump.port_b, boilerGeneric.port_a)
          annotation (Line(points={{-26,0},{-8,0}}, color={0,127,255}));
        connect(senTRet.port_b, pump.port_a)
          annotation (Line(points={{-50,0},{-46,0}}, color={0,127,255}));
      end if;

      connect(senTSup.port_b, port_b)
        annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
      connect(senTSup.port_a, boilerGeneric.port_b)
        annotation (Line(points={{50,0},{12,0}}, color={0,127,255}));

      if hasFeedback then
        connect(port_a, val.port_1)
          annotation (Line(points={{-100,0},{-94,0}}, color={0,127,255},
            pattern=LinePattern.Dash));
        connect(val.port_2, senTRet.port_a) annotation (Line(
            points={{-74,0},{-70,0}},
            color={0,127,255},
            pattern=LinePattern.Dash));
        connect(port_b, val.port_3)
          annotation (Line(points={{100,0},{100,-40},{-84,-40},{-84,-10}},
                          color={0,127,255},
            pattern=LinePattern.Dash));
      else
        connect(port_a, senTRet.port_a);
      end if;

      connect(boilerGeneric.boilerControlBus, boilerControlBus) annotation (
          Line(
          points={{2,10},{2,82},{0,82},{0,98}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(boilerControlBus.yValSet, val.y) annotation (Line(
          points={{0,98},{0,44},{-84,44},{-84,12}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(boilerControlBus.yPumSet, pump.y) annotation (Line(
          points={{0,98},{0,44},{-36,44},{-36,12}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(boilerControl.boilerControlBus, boilerControlBus) annotation (
          Line(
          points={{-79,92},{0,92},{0,98}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
        annotation (Dialog(group = "Feedback"), choices(checkBox = true),
                  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.Dash),
            Line(
              points={{-94,0},{96,0}},
              color={0,127,255},
              thickness=0.5),
            Polygon(
              points={{-80,-10},{-80,10},{-60,0},{-80,-10}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid, visible=hasFeedback),
            Polygon(
              points={{10,-10},{-10,-10},{0,10},{10,-10}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={-60,-10},
              rotation=0, visible=hasFeedback),
            Polygon(
              points={{-40,-10},{-40,10},{-60,0},{-40,-10}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid, visible=hasFeedback),
            Ellipse(
              extent={{-26,20},{14,-20}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid, visible=hasPump),
            Line(
              points={{-6,20},{14,0},{-6,-20}},
              color={135,135,135},
              thickness=0.5, visible=hasPump),
            Rectangle(
              extent={{36,20},{72,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{42,10},{64,-12}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{58,-10},{60,-6},{60,-2},{58,2},{56,4},{54,4},{52,2},{54,0},{54,
                  -4},{52,-6},{50,-8},{50,-10},{54,-10},{58,-10}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={244,125,35},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{50,-10},{58,-12}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{82,2},{86,-2}},
              lineColor={0,128,255},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid, visible=hasFeedback),
            Line(
              points={{-60,-20},{-60,-60}},
              color={0,128,255},
              thickness=0.5, visible=hasFeedback),
            Line(
              points={{-60,-60},{84,-60}},
              color={0,128,255},
              thickness=0.5, visible=hasFeedback),
            Line(
              points={{84,-2},{84,-60}},
              color={0,128,255},
              thickness=0.5, visible=hasFeedback)}),                                      Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ModularBoiler;

    package Controls "Holds controls for the ModularBoiler"
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
        Modelica.Blocks.Sources.RealExpression realExpression1(y=PLRMin)
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
        DeviceStatusDelay deviceStatusDelay
          annotation (Placement(transformation(extent={{68,-2},{88,18}})));
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
        connect(isOnSet, deviceStatusDelay.u) annotation (Line(points={{-100,44},{60,
                44},{60,8},{66,8}}, color={255,0,255}));
        connect(deviceStatusDelay.y, isOn) annotation (Line(points={{89,8},{98,8},{98,
                0},{104,0}}, color={255,0,255}));
        connect(greater.y, deviceStatusDelay.u_safety)
          annotation (Line(points={{-27,0},{66,0}}, color={255,0,255}));
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
</html>"),       Icon(graphics={
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

      model DeviceStatusDelay
          extends Modelica.Blocks.Icons.DiscreteBlock;

        parameter Modelica.Units.SI.Time time_minOff = 900
          "Time after which the device can be turned on again";
        parameter Modelica.Units.SI.Time time_minOn = 900
          "Time after which the device can be turned off again";
        parameter Boolean use_safetyShutoff = false
          "Set true, to enable an additional boolean input to perform manual shutoffs for security reasons without messing up the timer" annotation (
              choices(checkBox=true));
        Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop
          annotation (Placement(transformation(extent={{-28,40},{-8,60}})));
        Modelica.Blocks.Logical.Timer timer
          annotation (Placement(transformation(extent={{4,46},{24,66}})));
        Modelica.Blocks.Logical.Change change_input
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,-16})));
        Modelica.Blocks.Logical.LogicalSwitch logicalSwitch_hold
          annotation (Placement(transformation(extent={{60,-42},{80,-22}})));
        Modelica.Blocks.Logical.Pre pre_onHold annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={20,-20})));
        Modelica.Blocks.Logical.Pre pre_hold annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={70,0})));
        Modelica.Blocks.Logical.Pre pre_reset annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={16,18})));
        Modelica.Blocks.Logical.Change change_output
          annotation (Placement(transformation(extent={{-90,56},{-70,76}})));
        Modelica.Blocks.Logical.Or or1
          annotation (Placement(transformation(extent={{-58,56},{-38,76}})));
        Modelica.Blocks.Logical.LogicalSwitch logicalSwitch_onOffTimer
          annotation (Placement(transformation(extent={{66,46},{86,66}})));
        Modelica.Blocks.Logical.GreaterThreshold minOff(threshold=time_minOff)
          annotation (Placement(transformation(extent={{34,30},{54,50}})));
        Modelica.Blocks.Logical.GreaterThreshold minOn(threshold=time_minOn)
          annotation (Placement(transformation(extent={{34,62},{54,82}})));
        Modelica.Blocks.Logical.Or or2
          annotation (Placement(transformation(extent={{-10,10},{10,-10}},
              rotation=0,
              origin={-48,34})));
        Modelica.Blocks.Logical.And and1
          annotation (Placement(transformation(extent={{60,-82},{80,-62}})));
        Modelica.Blocks.Logical.Not not1
          annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
        Modelica.Blocks.Logical.And and2
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,30})));
        Modelica.Blocks.Interfaces.BooleanInput
                                             u "Connector of Boolean input signal"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput y
          "Connector of Boolean output signal"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput u_safety if use_safetyShutoff
          "set true, to force shutoff and hold until false"
          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression if not
          use_safetyShutoff
          annotation (Placement(transformation(extent={{-120,-66},{-100,-46}})));
      equation
        connect(rSFlipFlop.Q,timer. u)
          annotation (Line(points={{-7,56},{2,56}}, color={255,0,255}));
        connect(u,change_input. u) annotation (Line(points={{-120,0},{-96,0},{-96,-40},
                {-80,-40},{-80,-28}},
                           color={255,0,255}));
        connect(u,logicalSwitch_hold. u3) annotation (Line(points={{-120,0},{-96,0},{
                -96,-40},{58,-40}}, color={255,0,255}));
        connect(rSFlipFlop.Q,pre_onHold. u) annotation (Line(points={{-7,56},{-4,56},
                {-4,-20},{8,-20}}, color={255,0,255}));
        connect(pre_hold.y,logicalSwitch_hold. u1) annotation (Line(points={{59,0},{
                50,0},{50,-24},{58,-24}}, color={255,0,255}));
        connect(pre_onHold.y,logicalSwitch_hold. u2) annotation (Line(points={{31,-20},
                {40,-20},{40,-32},{58,-32}}, color={255,0,255}));
        connect(or1.y,rSFlipFlop. S) annotation (Line(points={{-37,66},{-34,66},{-34,
                56},{-30,56}},   color={255,0,255}));
        connect(or1.u1,change_output. y)
          annotation (Line(points={{-60,66},{-69,66}}, color={255,0,255}));
        connect(minOff.y,logicalSwitch_onOffTimer. u3) annotation (Line(points={{55,40},
                {58,40},{58,48},{64,48}},     color={255,0,255}));
        connect(minOn.y,logicalSwitch_onOffTimer. u1) annotation (Line(points={{55,72},
                {58,72},{58,64},{64,64}}, color={255,0,255}));
        connect(timer.y,minOn. u) annotation (Line(points={{25,56},{28,56},{28,72},{
                32,72}}, color={0,0,127}));
        connect(timer.y,minOff. u) annotation (Line(points={{25,56},{28,56},{28,40},{
                32,40}}, color={0,0,127}));
        connect(logicalSwitch_onOffTimer.y,pre_reset. u) annotation (Line(points={{87,56},
                {90,56},{90,18},{28,18}},     color={255,0,255}));
        connect(and1.y,y)  annotation (Line(points={{81,-72},{96,-72},{96,0},{110,0}},
              color={255,0,255}));
        connect(and1.y,logicalSwitch_onOffTimer. u2) annotation (Line(points={{81,-72},
                {96,-72},{96,90},{60,90},{60,56},{64,56}}, color={255,0,255}));
        connect(logicalSwitch_hold.y,and1. u1) annotation (Line(points={{81,-32},{88,
                -32},{88,-52},{50,-52},{50,-72},{58,-72}}, color={255,0,255}));
        connect(and1.y,pre_hold. u) annotation (Line(points={{81,-72},{96,-72},{96,0},
                {82,0}}, color={255,0,255}));
        connect(u_safety,not1. u)
          annotation (Line(points={{-120,-80},{-92,-80}},color={255,0,255}));
        connect(not1.y,and1. u2)
          annotation (Line(points={{-69,-80},{58,-80}},color={255,0,255}));
        connect(and1.y,change_output. u) annotation (Line(points={{81,-72},{96,-72},{
                96,90},{-96,90},{-96,66},{-92,66}}, color={255,0,255}));
        connect(rSFlipFlop.R,or2. y) annotation (Line(points={{-30,44},{-34,44},{-34,
                34},{-37,34}}, color={255,0,255}));
        connect(pre_reset.y,or2. u1) annotation (Line(points={{5,18},{-64,18},{-64,34},
                {-60,34}}, color={255,0,255}));
        connect(change_output.y,or2. u2) annotation (Line(points={{-69,66},{-64,66},{
                -64,42},{-60,42}}, color={255,0,255}));
        connect(or1.u2, and2.y) annotation (Line(points={{-60,58},{-68,58},{-68,50},{
                -80,50},{-80,41}}, color={255,0,255}));
        connect(not1.y, and2.u2) annotation (Line(points={{-69,-80},{-60,-80},{-60,0},
                {-72,0},{-72,18}}, color={255,0,255}));
        connect(change_input.y, and2.u1)
          annotation (Line(points={{-80,-5},{-80,18}}, color={255,0,255}));
        connect(booleanExpression.y, not1.u) annotation (Line(points={{-99,-56},{-96,
                -56},{-96,-80},{-92,-80}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html><p>
  The model makes sure that an on signal is only passed through if the
  device was on for a given time <span style=
  \"font-family: Courier New;\">thresholdTimer</span> asdf
</p>
<p>
  <br/>
  When the input signal is set to true the given <span style=
  \"font-family: Courier New;\">thresholdTimer</span> starts counting.
  After the moment when <span style=
  \"font-family: Courier New;\">thresholdTimer</span> is exceeded the
  output signal can switch to false but will stay true until the input
  value is set to false again. Then again the timer start to count and
  the output won't change to true until the timer is finished again.
</p>
</html>",       revisions="<html>
<ul>
  <li>October 10, 2019, by David Jansen:<br/>
    Implemented model
  </li>
</ul>
</html>"));
      end DeviceStatusDelay;
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
    end Controls;

    package Example
    extends Modelica.Icons.ExamplesPackage;
      model ModularBoilerSimple
        "Example for ModularBoiler - With Pump and simple Pump regulation"
        extends Modelica.Icons.Example;
        parameter Integer k=2 "number of consumers";
        package MediumWater = AixLib.Media.Water;

        ModularBoiler modularBoiler(
          QNom=50000,
          m_flowVar=false,
          TStart=353.15,
          hasFeedback=true,
          dp_Valve=10000,
          use_HeaCur=false,
          redeclare package Medium = MediumWater,
          Advanced=false)
          annotation (Placement(transformation(extent={{-34,-30},{26,30}})));
        Fluid.Sources.Boundary_pT bou(
          use_T_in=false,
          redeclare package Medium = MediumWater,
          T=293.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{-96,-14},{-72,10}})));
        AixLib.Controls.Interfaces.BoilerControlBus
                                    boilerControlBus
          annotation (Placement(transformation(extent={{-10,52},{10,72}})));
        Modelica.Blocks.Sources.Constant TFlowSet(k=273 + 80) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-86,40})));
        Modelica.Blocks.Sources.BooleanConstant isOnSet(k=true) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-88,76})));
        Fluid.MixingVolumes.MixingVolume vol(
          redeclare package Medium = AixLib.Media.Water,
          T_start=323.15,
          m_flow_nominal=modularBoiler.m_flow_nominal,
          V=0.1,
          nPorts=2) annotation (Placement(transformation(extent={{64,0},{84,20}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{28,42},{48,62}})));
        Modelica.Blocks.Sources.Sine sine(
          amplitude=-5000,
          f=4/86400,
          offset=-25000)
          annotation (Placement(transformation(extent={{18,76},{38,96}})));
      equation
        connect(boilerControlBus, modularBoiler.boilerControlBus) annotation (Line(
            points={{0,62},{0,29.4},{-4,29.4}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(bou.ports[1], modularBoiler.port_a) annotation (Line(points={{-72,-2},
                {-70,-2},{-70,0},{-34,0}}, color={0,127,255}));
        connect(isOnSet.y, boilerControlBus.isOn) annotation (Line(points={{-77,76},
                {0,76},{0,62}},         color={255,0,255}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(modularBoiler.port_b, vol.ports[1]) annotation (Line(points={{26,0},{
                38,0},{38,-6},{73,-6},{73,0}}, color={0,127,255}));
        connect(vol.ports[2], modularBoiler.port_a) annotation (Line(points={{75,0},{
                62,0},{62,-82},{-34,-82},{-34,0}}, color={0,127,255}));
        connect(prescribedHeatFlow.port, vol.heatPort) annotation (Line(points={{48,
                52},{62,52},{62,46},{64,46},{64,10}}, color={191,0,0}));
        connect(sine.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{39,86},{
                20,86},{20,52},{28,52}}, color={0,0,127}));
        connect(TFlowSet.y, boilerControlBus.TSupSet) annotation (Line(points={
                {-75,40},{0,40},{0,62}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
      annotation (
          experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
      end ModularBoilerSimple;

    end Example;

  end ModularBoiler;

end Modules;
