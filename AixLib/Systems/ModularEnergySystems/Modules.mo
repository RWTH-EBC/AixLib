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
      parameter Real yMaxPLR=1.0 "Upper limit of output" annotation (Dialog(tab="Control", group = "Flow temperature"));
      parameter Real yMinPLR=0 "Lower limit of output" annotation (Dialog(tab="Control", group = "Flow temperature"));

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
        redeclare final package Medium = Medium,
        final m_flow_nominal=m_flow_nominal,
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
        "Temperature sensor of hot side of heat generator (supply)" annotation
        (Placement(transformation(
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
        yMaxPLR=yMaxPLR,
        yMinPLR=yMinPLR,
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
        annotation (Placement(transformation(extent={{-100,66},{-66,100}})));

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

      connect(boilerControlBus, boilerControl.boilerControlBus) annotation (Line(
          points={{0,98},{0,100},{-74,100},{-74,100},{-83,100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(senTSup.T, boilerControlBus.TSupMea) annotation (Line(points={{60,
              11},{64,11},{64,98},{0,98}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(senTRet.T, boilerControlBus.TRetMea) annotation (Line(points={{-60,11},
              {-60,16},{64,16},{64,98},{0,98}},          color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(boilerGeneric.boilerControlBus, boilerControlBus) annotation (
          Line(
          points={{-0.8,10},{-0.8,82},{0,82},{0,98}},
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

    package BaseClasses
    extends Modelica.Icons.BasesPackage;
      partial model Boiler_base
        "Base model for modular boiler - with one output"
        extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
          redeclare package Medium = MediumWater,
          final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));

        package MediumWater = AixLib.Media.Water "Boiler Medium";
        parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
          annotation (Dialog(group="Nominal condition"));
        parameter Modelica.Units.SI.Temperature TRetNom=308.15
          "Return temperature TCold"
          annotation (Dialog(group="Nominal condition"));
        parameter Modelica.Units.SI.Temperature TFlowMax=363.15
          "Maximal temperature to force shutdown";
        parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Thermal dimension power"
          annotation (Dialog(group="Nominal condition"));
        parameter Boolean m_flowVar=false "Use variable water massflow"
          annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
        parameter Boolean Pump=true "Model includes a pump"
          annotation (choices(checkBox=true), Dialog(descriptionLabel=true));
        parameter Boolean Advanced=false "dTWater is constant for different PLR"
          annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
        parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
          annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));
        parameter Real PLRMin=0.15 "Minimal Part Load Ratio";
        parameter Modelica.Units.SI.Temperature TStart=293.15 "T start"
          annotation (Dialog(tab="Advanced"));
        parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
          "Start value of pressure"
          annotation (Dialog(tab="Advanced", group="Initialization"));

        Fluid.BoilerCHP.BoilerNotManufacturer heatGeneratorNoControl(
          final T_start=TStart,
          final dTWaterSet=dTWaterSet,
          final QNom=QNom,
          final PLRMin=PLRMin,
          redeclare final package Medium = Medium,
          final m_flow_nominal=m_flow_nominal,
          final dTWaterNom=dTWaterNom,
          final TRetNom=TRetNom,
          final m_flowVar=m_flowVar)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        inner Modelica.Fluid.System system(final p_start=system.p_ambient)
          annotation (Placement(transformation(extent={{80,80},{100,100}})));
        AixLib.Fluid.Sensors.TemperatureTwoPort senTFlow(
          redeclare final package Medium = Medium,
          final m_flow_nominal=m_flow_nominal,
          final initType=Modelica.Blocks.Types.Init.InitialState,
          final T_start=TStart,
          final transferHeat=false,
          final allowFlowReversal=false,
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
          final allowFlowReversal=false,
          final m_flow_small=0.001)
          "Temperature sensor of cold side of heat generator (supply)" annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-60,0})));

        AixLib.Fluid.Movers.SpeedControlled_y pump(
          redeclare final package Medium = Medium,
          final allowFlowReversal=false,
          final m_flow_small=0.001,
          final per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={
                  dp_nominal/0.8,dp_nominal,0})),
          final addPowerToMedium=false) if Pump "Boiler Pump"
          annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));

      protected
        parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
        parameter Modelica.Units.SI.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
        parameter Modelica.Units.SI.HeatCapacity cp_medium = Medium.cp_const;

      equation

        if not Pump then
          connect(senTRet.port_b, heatGeneratorNoControl.port_a);
        else
          connect(pump.port_b, heatGeneratorNoControl.port_a)
            annotation (Line(points={{-26,0},{-10,0}}, color={0,127,255}));
          connect(senTRet.port_b, pump.port_a)
            annotation (Line(points={{-50,0},{-46,0}}, color={0,127,255}));
        end if;

        connect(senTFlow.port_b, port_b)
          annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
        connect(senTFlow.port_a, heatGeneratorNoControl.port_b)
          annotation (Line(points={{50,0},{10,0}}, color={0,127,255}));

        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                    Rectangle(
                extent={{-60,80},{60,-80}},
                lineColor={0,0,0},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={170,170,255}),
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
          Documentation(info="<html><p>
  A boiler model consisting of physical components. The user has the
  choice to run the model for three different setpoint options:
</p>
<ol>
  <li>Setpoint depends on part load ratio (water mass flow=dimension
  water mass flow; advanced=false & m_flowVar=false)
  </li>
  <li>Setpoint depends on part load ratio and a constant water
  temperature difference which is idependent from part load ratio
  (water mass flow is variable; advanced=false & m_flowVar=true)
  </li>
  <li>Setpoint depends on part load ratio an a variable water
  temperature difference (water mass flow is variable; advanced=true)
  </li>
</ol>
</html>"),experiment(StopTime=10));
      end Boiler_base;
    end BaseClasses;

    package Controls "Holds controls for the ModularBoiler"
      extends Modelica.Icons.Package;

      package NotUsed
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
    massflowrate for pump control"          annotation (Dialog(group="Pump Control"));

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
            redeclare final function HeatingCurveFunction =
                HeatingCurveFunction,
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
    massflowrate for pump control"          annotation (Dialog(group="Pump Control"));

          NotUsed.InternalPumpControl internalPumpControl(final PLRMin=PLRMin)
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
            redeclare final function HeatingCurveFunction =
                HeatingCurveFunction,
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
      end NotUsed;

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
          final yMax=yMaxPLR,
          final yMin=yMinPLR)
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
        connect(boilerControlBus.TSupMea, safteyControl.TFlowMea) annotation (
            Line(
            points={{0,100},{-38,100},{-38,46},{-22,46}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(boilerControlBus.TRetMea, safteyControl.TRetMea) annotation (Line(
            points={{0,100},{-38,100},{-38,42},{-22,42},{-22,41.8}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
        connect(boilerControlBus.TSupMea, internalPLRControl.TFlowMea)
          annotation (Line(
            points={{0,100},{-40,100},{-40,10.8},{-22,10.8}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}},
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
      model ModularBoilerConsumer
        "Example for ModularBoiler - With Pump and simple Pump regulation"
        extends Modelica.Icons.Example;
        parameter Integer nConsumers=2 "number of consumers";
        package MediumWater = AixLib.Media.Water;

        ModularBoiler modularBoiler(
          allowFlowReversal=false,
          TStart=343.15,
          QNom(displayUnit="kW") = 75000,
          m_flowVar=true,
          hasFeedback=true,
          TRetNom=323.15,
          dp_Valve=10000,
          use_HeaCur=false,
          redeclare package Medium = MediumWater,
          Advanced=false)
          annotation (Placement(transformation(extent={{-54,-30},{6,30}})));
        Fluid.Sources.Boundary_pT bou(
          use_T_in=false,
          redeclare package Medium = MediumWater,
          T=293.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{-96,-14},{-72,10}})));
        Interfaces.BoilerControlBus boilerControlBus
          annotation (Placement(transformation(extent={{-10,50},{10,70}})));
        ModularConsumer.ConsumerDistributorModule modularConsumer(
          n_consumers=nConsumers,
          demandType=fill(1, nConsumers),
          TInSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
          TInSet={343.15,333.15},
          hasPump=fill(true, nConsumers),
          hasFeedback=fill(true, nConsumers),
          functionality="Q_flow_fixed",
          Q_flow_fixed(displayUnit="kW") = {15000,19000},
          T_fixed={333.15,333.15},
          TOutSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
          TOutSet={323.15,313.15},
          k_ControlConsumerPump=fill(0.1, nConsumers),
          Ti_ControlConsumerPump=fill(10, nConsumers),
          dp_nominalConPump=fill(0.1, nConsumers),
          capacity=fill(1, nConsumers),
          Q_flow_nom={10000,10000},
          dT_nom={20,20},
          dp_Valve(displayUnit="bar") = fill(0.01, nConsumers),
          k_ControlConsumerValve=fill(0.01, nConsumers),
          Ti_ControlConsumerValve=fill(10, nConsumers),
          allowFlowReversal=true,
          T_start=fill(273.15 + 70, nConsumers))
          annotation (Placement(transformation(extent={{24,-30},{84,30}})));

        Modelica.Blocks.Sources.Constant TFlowSet(k=273.15 + 70)
                                                              annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-86,44})));
        Modelica.Blocks.Sources.BooleanConstant isOnSet(k=true) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-90,90})));
      equation
        connect(boilerControlBus, modularBoiler.boilerControlBus) annotation (Line(
            points={{0,60},{0,38},{-24,38},{-24,29.4}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(modularBoiler.port_b, modularConsumer.port_a)
          annotation (Line(points={{6,0},{24,0}},  color={0,127,255}));
        connect(modularConsumer.port_b, modularBoiler.port_a) annotation (Line(points={{84,0},{
                98,0},{98,-62},{-62,-62},{-62,0},{-54,0}},         color={0,127,255}));
        connect(TFlowSet.y, boilerControlBus.TFlowSet) annotation (Line(points={{-75,44},
                {0.05,44},{0.05,60.05}},                       color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(isOnSet.y, boilerControlBus.isOn) annotation (Line(points={{-79,90},{
                0.05,90},{0.05,60.05}},                       color={255,0,255}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(bou.ports[1], modularBoiler.port_a)
          annotation (Line(points={{-72,-2},{-72,0},{-54,0}}, color={0,127,255}));
      annotation (
          experiment(StopTime=86400));
      end ModularBoilerConsumer;

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
        Interfaces.BoilerControlBus boilerControlBus
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
        connect(TFlowSet.y, boilerControlBus.TFlowSet) annotation (Line(points={{-75,
                40},{0.05,40},{0.05,62.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(isOnSet.y, boilerControlBus.isOn) annotation (Line(points={{-77,76},{
                0.05,76},{0.05,62.05}}, color={255,0,255}), Text(
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
      annotation (
          experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
      end ModularBoilerSimple;

      model ModularBoilerConsumerDynamicDemand
        "Example for ModularBoiler - With Pump and simple Pump regulation"
        extends Modelica.Icons.Example;
        parameter Integer nConsumers=2 "number of consumers";
        package MediumWater = AixLib.Media.Water;

        ModularBoiler modularBoiler(
          allowFlowReversal=false,
          TStart=343.15,
          QNom=40000,
          m_flowVar=true,
          hasFeedback=true,
          TRetNom=323.15,
          dp_Valve=10000,
          use_HeaCur=false,
          redeclare package Medium = MediumWater,
          Advanced=false)
          annotation (Placement(transformation(extent={{-54,-30},{6,30}})));
        Fluid.Sources.Boundary_pT bou(
          use_T_in=false,
          redeclare package Medium = MediumWater,
          T=293.15,
          nPorts=1)
          annotation (Placement(transformation(extent={{-96,-14},{-72,10}})));
        Interfaces.BoilerControlBus boilerControlBus
          annotation (Placement(transformation(extent={{-10,50},{10,70}})));
        ModularConsumer.ConsumerDistributorModule modularConsumer(
          n_consumers=nConsumers,
          demandType=fill(1, nConsumers),
          TInSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
          TInSet={343.15,333.15},
          hasPump={false,true},
          hasFeedback={false,true},
          functionality="Q_flow_input",
          Q_flow_fixed(displayUnit="kW") = {15000,19000},
          T_fixed={333.15,333.15},
          TOutSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
          TOutSet={323.15,313.15},
          k_ControlConsumerPump=fill(0.1, nConsumers),
          Ti_ControlConsumerPump=fill(10, nConsumers),
          dp_nominalConPump=fill(0.1, nConsumers),
          capacity=fill(1, nConsumers),
          Q_flow_nom={10000,7000},
          dT_nom={20,20},
          dp_Valve(displayUnit="bar") = fill(0.01, nConsumers),
          k_ControlConsumerValve=fill(0.01, nConsumers),
          Ti_ControlConsumerValve=fill(10, nConsumers),
          allowFlowReversal=true,
          T_start=fill(273.15 + 70, nConsumers))
          annotation (Placement(transformation(extent={{24,-30},{84,30}})));

        Modelica.Blocks.Sources.Constant TFlowSet(k=273.15 + 70)
                                                              annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-86,44})));
        Modelica.Blocks.Sources.BooleanConstant isOnSet(k=true) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-90,90})));
        Interfaces.ConsumerControlBus consumerControlBus(nConsumers=nConsumers)
          annotation (Placement(transformation(extent={{36,50},{56,70}})));
        Modelica.Blocks.Sources.Sine sineHeatDemand1(
          amplitude=5000,
          f=1/3600,
          offset=5000)
          annotation (Placement(transformation(extent={{12,76},{32,96}})));
        Modelica.Blocks.Sources.Sine sineHeatDemand2(
          amplitude=3000,
          f=1/3600,
          offset=4000,
          startTime=1800)
          annotation (Placement(transformation(extent={{90,76},{70,96}})));
      equation
        connect(boilerControlBus, modularBoiler.boilerControlBus) annotation (Line(
            points={{0,60},{0,38},{-24,38},{-24,29.4}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(modularBoiler.port_b, modularConsumer.port_a)
          annotation (Line(points={{6,0},{24,0}},  color={0,127,255}));
        connect(modularConsumer.port_b, modularBoiler.port_a) annotation (Line(points={{84,0},{
                98,0},{98,-62},{-62,-62},{-62,0},{-54,0}},         color={0,127,255}));
        connect(TFlowSet.y, boilerControlBus.TFlowSet) annotation (Line(points={{-75,44},
                {0.05,44},{0.05,60.05}},                       color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(isOnSet.y, boilerControlBus.isOn) annotation (Line(points={{-79,90},{
                0.05,90},{0.05,60.05}},                       color={255,0,255}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(modularConsumer.consumerControlBus, consumerControlBus) annotation (
            Line(
            points={{54,30},{54,48},{46,48},{46,60}},
            color={255,204,51},
            thickness=0.5));
        connect(bou.ports[1], modularBoiler.port_a)
          annotation (Line(points={{-72,-2},{-72,0},{-54,0}}, color={0,127,255}));
        connect(sineHeatDemand1.y, consumerControlBus.Q_flowSet[1]) annotation (Line(
              points={{33,86},{46.05,86},{46.05,60.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(sineHeatDemand2.y, consumerControlBus.Q_flowSet[2]) annotation (Line(
              points={{69,86},{46.05,86},{46.05,60.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
      annotation (
          experiment(StopTime=86400));
      end ModularBoilerConsumerDynamicDemand;
    end Example;

  end ModularBoiler;

  package ModularConsumer

    model ConsumerDistributorModule
      extends
        AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.BaseClasses.ModularConsumer_base(
                        simpleConsumer(each allowFlowReversal=allowFlowReversal,
                                       final T_start=T_start));
        extends AixLib.Fluid.Interfaces.PartialTwoPort(redeclare package Medium =
            MediumWater);

      Fluid.HeatExchangers.ActiveWalls.Distributor
        distributor(
        redeclare package Medium = Medium,
        final m_flow_nominal = sum(simpleConsumer.m_flow_nominal),
        allowFlowReversal=allowFlowReversal,
        n=n_consumers) annotation (
          Placement(transformation(
            extent={{-24,-24},{24,24}},
            rotation=90,
            origin={6,0})));

      parameter Modelica.Media.Interfaces.Types.Temperature T_start[n_consumers]=fill(Medium.T_default, n_consumers)
        "Start value of temperature";
      Interfaces.ConsumerControlBus consumerControlBus(nConsumers=n_consumers)
                                                       annotation (Placement(
            transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{
                -10,90},{10,110}})));
      Fluid.Sensors.TemperatureTwoPort senTFlow(
        allowFlowReversal=allowFlowReversal,
        redeclare package Medium = Medium,
        m_flow_nominal=sum(simpleConsumer.m_flow_nominal))
                         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-64,-40})));
      Fluid.Sensors.TemperatureTwoPort senTReturn(
        allowFlowReversal=allowFlowReversal,
        redeclare package Medium = Medium,
        m_flow_nominal=sum(simpleConsumer.m_flow_nominal))
                         annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={62,-40})));
    equation

      connect(distributor.flowPorts, simpleConsumer.port_a) annotation (Line(points={{-18,
              1.33227e-15},{-30,1.33227e-15},{-30,-69},{-20,-69}},
                                                    color={0,127,255}));
      connect(distributor.returnPorts, simpleConsumer.port_b) annotation (Line(points={{30.8,
              -1.33227e-15},{42,-1.33227e-15},{42,-69},{18,-69}},
                                                    color={0,127,255}));

      connect(consumerControlBus.TOutSet, simpleConsumer.TOutSet) annotation (Line(
          points={{0.05,100.05},{0,100.05},{0,38},{-58,38},{-58,-80.78},{-21.14,-80.78}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));

      connect(consumerControlBus.TInSet, simpleConsumer.TInSet) annotation (Line(
          points={{0.05,100.05},{0,100.05},{0,38},{-58,38},{-58,-77.36},{-21.14,-77.36}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));

      connect(consumerControlBus.TPrescribedSet, simpleConsumer.TPrescribedSet)
        annotation (Line(
          points={{0.05,100.05},{0,100.05},{0,38},{-58,38},{-58,-52.85},{-21.9,-52.85}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));

      connect(consumerControlBus.Q_flowSet, simpleConsumer.Q_flowSet) annotation (
          Line(
          points={{0.05,100.05},{0.05,38},{-58,38},{-58,-59.12},{-21.52,-59.12}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(consumerControlBus.TOutMea, simpleConsumer.TOutMea) annotation (Line(
          points={{0.05,100.05},{0.05,38},{32,38},{32,-76.22},{20.28,-76.22}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(consumerControlBus.Q_flowMea, simpleConsumer.Q_flowMea) annotation (
          Line(
          points={{0.05,100.05},{0.05,38},{32,38},{32,-79.64},{19.9,-79.64}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(consumerControlBus.TInMea, simpleConsumer.TInMea) annotation (Line(
          points={{0.05,100.05},{0.05,38},{32,38},{32,-73.18},{20.28,-73.18}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(port_a, senTFlow.port_a) annotation (Line(points={{-100,0},{-80,0},{-80,
              -40},{-74,-40}}, color={0,127,255}));
      connect(senTFlow.port_b, distributor.mainFlow) annotation (Line(points={{-54,-40},
              {-6.8,-40},{-6.8,-24}}, color={0,127,255}));
      connect(distributor.mainReturn, senTReturn.port_a)
        annotation (Line(points={{18,-24},{18,-40},{52,-40}}, color={0,127,255}));
      connect(senTReturn.port_b, port_b) annotation (Line(points={{72,-40},{80,-40},
              {80,0},{100,0}}, color={0,127,255}));
      connect(consumerControlBus.TOutDisMea, senTReturn.T) annotation (Line(
          points={{0.05,100.05},{0.05,38},{62,38},{62,-29}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(consumerControlBus.TInDisMea, senTFlow.T) annotation (Line(
          points={{0.05,100.05},{0.05,38},{-64,38},{-64,-29}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
       annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.Dash),
            Polygon(
              points={{80,-240},{120,-255},{80,-270},{80,-240}},
              lineColor={0,128,255},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              visible=not allowFlowReversal),
            Line(
              points={{115,-255},{0,-255}},
              color={0,128,255},
              visible=not allowFlowReversal),
            Polygon(
              points={{80,-294},{120,-309},{80,-324},{80,-294}},
              lineColor={0,128,255},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              visible=not allowFlowReversal),
            Line(
              points={{115,-309},{0,-309}},
              color={0,128,255},
              visible=not allowFlowReversal),
            Rectangle(
              extent={{-70,70},{70,50}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-52,64},{-44,56}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-64,64},{-56,56}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,-40}},
              color={28,108,200},
              thickness=0.5),                Text(
              extent={{-62,-18},{58,-58}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="More than 3 consumers \n Total number of consumers: %n_consumers",
              visible=n_consumers > 3),
            Line(
              points={{-60,56},{-60,20},{-74,20},{-74,0},{-68,0},{-30,0},{-30,20},{-48,
                  20},{-48,56}},
              color={28,108,200},
              thickness=0.5),
                       Ellipse(
              extent={{-68,16},{-38,-14}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-64,12},{-42,-10}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              startAngle=0,
              endAngle=360),                 Text(
              extent={{-80,-6},{-26,-34}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textStyle={TextStyle.Bold},
              fontSize=6,
              textString="CONS. 1"),
            Line(
              points={{-90,0},{-80,0},{-80,60},{-70,60}},
              color={28,108,200},
              thickness=0.5),
            Line(
              points={{90,0},{80,0},{80,60},{70,60}},
              color={28,108,200},
              thickness=0.5),
            Ellipse(
              extent={{-12,64},{-4,56}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              visible=n_consumers>=2),
            Ellipse(
              extent={{0,64},{8,56}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              visible=n_consumers>=2),
            Ellipse(
              extent={{42,64},{50,56}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              visible=n_consumers>=3),
            Ellipse(
              extent={{54,64},{62,56}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              visible=n_consumers>=3),
            Polygon(
              points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={-60,42},
              rotation=180,
                          visible=hasFeedback[1]),
            Polygon(
              points={{3.37834,-3.64874},{3.37834,3.64874},{-3.37834,0},{3.37834,-3.64874}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid, visible=hasFeedback[1],
              origin={-60,36},
              rotation=270),
            Ellipse(
              extent={{-4,4},{4,-4}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid, visible=hasPump[1],
              origin={-74,10},
              rotation=270),
            Line(
              points={{3.83476e-17,1},{4,-3},{1.72997e-15,-7}},
              color={135,135,135},
              thickness=0.5, visible=hasPump[1],
              origin={-71,10},
              rotation=270),
            Line(
              points={{-48,40},{-54,40}},
              color={28,108,200},
              thickness=0.5,visible=hasFeedback[1]),
            Polygon(
              points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={-58,40},
              rotation=90,visible=hasFeedback[1]),
            Line(
              points={{-8,56},{-8,20},{-22,20},{-22,0},{-16,0},{22,0},{22,20},{4,20},
                  {4,56}},
              color={28,108,200},
              thickness=0.5,
              visible=n_consumers >= 2),
            Ellipse(
              extent={{-16,16},{14,-14}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              visible=n_consumers >= 2),
            Ellipse(
              extent={{-12,12},{10,-10}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              startAngle=0,
              endAngle=360,
              visible=n_consumers >= 2),
            Polygon(
              points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={-8,42},
              rotation=180,
              visible=n_consumers>=2 and (if size(hasFeedback,1)>= 2 then hasFeedback[2] else true)),
            Polygon(
              points={{3.37834,-3.64874},{3.37834,3.64874},{-3.37834,0},{3.37834,-3.64874}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              origin={-8,36},
              rotation=270,
              visible=n_consumers>=2 and (if size(hasFeedback,1)>= 2 then hasFeedback[2] else true)),
            Ellipse(
              extent={{-4,4},{4,-4}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={-22,10},
              rotation=270,
              visible=n_consumers >= 2 and (if size(hasPump, 1) >= 2 then hasPump[2]
                   else true)),
            Line(
              points={{3.83476e-17,1},{4,-3},{1.72997e-15,-7}},
              color={135,135,135},
              thickness=0.5,
              origin={-19,10},
              rotation=270,
              visible=n_consumers>=2 and (if size(hasPump,1)>= 2 then hasPump[2] else true)),
            Line(
              points={{4,40},{-2,40}},
              color={28,108,200},
              thickness=0.5,
              visible=n_consumers>=2 and (if size(hasFeedback,1)>= 2 then hasFeedback[2] else true)),
            Polygon(
              points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={-6,40},
              rotation=90,
              visible=n_consumers>=2 and (if size(hasFeedback,1)>= 2 then hasFeedback[2] else true)),
            Line(
              points={{46,56},{46,20},{32,20},{32,0},{38,0},{76,0},{76,20},{58,20},{
                  58,56}},
              color={28,108,200},
              thickness=0.5,
              visible=n_consumers>=3),
            Ellipse(
              extent={{38,16},{68,-14}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              visible=n_consumers>=3),
            Ellipse(
              extent={{42,12},{64,-10}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              startAngle=0,
              endAngle=360,
              visible=n_consumers>=3),
            Polygon(
              points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={46,42},
              rotation=180,
              visible=n_consumers>=3 and (if size(hasFeedback,1)>= 3 then hasFeedback[3] else true)),
            Polygon(
              points={{3.37834,-3.64874},{3.37834,3.64874},{-3.37834,0},{3.37834,-3.64874}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              origin={46,36},
              rotation=270,
              visible=n_consumers>=3 and (if size(hasFeedback,1)>= 3 then hasFeedback[3] else true)),
            Ellipse(
              extent={{-4,4},{4,-4}},
              lineColor={135,135,135},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              visible=n_consumers>=3 and (if size(hasPump,1)>= 3 then hasPump[3] else true),
              origin={32,10},
              rotation=270),
            Line(
              points={{3.83476e-17,1},{4,-3},{1.72997e-15,-7}},
              color={135,135,135},
              thickness=0.5,
              visible=n_consumers>=3 and (if size(hasPump,1)>= 3 then hasPump[3] else true),
              origin={35,10},
              rotation=270),
            Line(
              points={{58,40},{52,40}},
              color={28,108,200},
              thickness=0.5,
              visible=n_consumers >= 3 and (if size(hasFeedback, 1) >= 3 then
                  hasFeedback[3] else true)),
            Polygon(
              points={{3.45944,-4.54058},{-3.45944,-4.54058},{0,1.62164},{3.45944,-4.54058}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={48,40},
              rotation=90,
              visible=n_consumers>=3 and (if size(hasFeedback,1)>= 3 then hasFeedback[3] else true)),
            Text(
              extent={{-26,-6},{28,-34}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textStyle={TextStyle.Bold},
              fontSize=6,
              textString="CONS. 2",
              visible=n_consumers>=2),
            Text(
              extent={{26,-6},{80,-34}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textStyle={TextStyle.Bold},
              fontSize=6,
              textString="CONS. 3",
              visible=n_consumers>=3)}),
            Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ConsumerDistributorModule;

    package BaseClasses
      extends Modelica.Icons.BasesPackage;

      partial model ModularConsumer_base

        package MediumWater = AixLib.Media.Water;
        // Consumer Design
        parameter Integer n_consumers=1 "Number of consumers" annotation (Dialog(group = "Consumer Design"));
        parameter String functionality "Choose between different functionalities" annotation (choices(
                    choice="T_fixed",
                    choice="T_input",
                    choice="Q_flow_fixed",
                    choice="Q_flow_input"),Dialog(group = "Consumer Design"));
        parameter Integer demandType[n_consumers]  "Array for each consumer: 1: Heating; -1: Cooling" annotation (Dialog(group = "Consumer Design"));
        parameter Modelica.Units.SI.HeatCapacity capacity[n_consumers]   "Array for each consumer: Capacity of the material" annotation(Dialog(group="Consumer Design"));

        // Nominal conditions
        parameter Modelica.Units.SI.HeatFlowRate Q_flow_fixed[n_consumers] "Prescribed heat flow" annotation(Dialog(enable=functionality=="Q_flow_fixed", group="Nominal conditions (Array - each consumer)"));
        parameter Modelica.Units.SI.Temperature T_fixed[n_consumers] "Prescribed temperature" annotation(Dialog(enable=functionality=="T_fixed",group="Nominal conditions (Array - each consumer)"));
        parameter Modelica.Units.SI.HeatFlowRate Q_flow_nom[n_consumers] "Nominal heat flow" annotation(Dialog(enable=functionality<>"Q_flow_fixed", group="Nominal conditions (Array - each consumer)"));
        parameter Modelica.Units.SI.TemperatureDifference dT_nom[n_consumers]  "nominal temperature difference" annotation(Dialog(group="Nominal conditions (Array - each consumer)"));

        // Feedback
        parameter Boolean hasFeedback[n_consumers]  "if circuit has feedback for temperature control" annotation(Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
        parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TInSetSou                                                                                                                                         "Source for set value for inlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
        parameter Modelica.Units.SI.Temperature TInSet[n_consumers] "Constant set value for inlet temperature" annotation(Dialog(enable=TInSetSou == AixLib.Systems.ModularEnergySystems.Modules.
            ModularConsumer.Types.InputType.Constant, group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
        parameter Real k_ControlConsumerValve[n_consumers] "Gain of controller" annotation(Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
        parameter Modelica.Units.SI.Time Ti_ControlConsumerValve[n_consumers]
          "Time constant of Integrator block" annotation(Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
        parameter Modelica.Units.SI.PressureDifference dp_Valve[n_consumers]
          "Pressure Difference set in regulating valve for pressure equalization in heating system" annotation(Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));

        // Pump
        parameter Boolean hasPump[n_consumers] "circuit has Pump" annotation(Dialog(group="Return Temperature Control (Pump) (Array - each consumer)"));
        parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TOutSetSou "Source for set value for outlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Return Temperature Control (Pump) (Array - each consumer)"));
        parameter Modelica.Units.SI.Temperature TOutSet[n_consumers] "Constant set value for outlet temperature" annotation(Dialog(enable=TOutSetSou == AixLib.Systems.ModularEnergySystems.Modules.
            ModularConsumer.Types.InputType.Constant, group="Return Temperature Control (Pump) (Array - each consumer)"));
        parameter Real k_ControlConsumerPump[n_consumers](min=Modelica.Constants.small) "Gain of controller"
          annotation (Dialog(group = "Return Temperature Control (Pump) (Array - each consumer)"));
        parameter Modelica.Units.SI.Time Ti_ControlConsumerPump[n_consumers](min=Modelica.Constants.small) "Time constant of Integrator block"
          annotation (Dialog(group = "Return Temperature Control (Pump) (Array - each consumer)"));
        parameter Modelica.Units.SI.PressureDifference dp_nominalConPump[n_consumers]
          "Pressure increase of pump at nominal conditions for the individual consumers" annotation(Dialog(group="Return Temperature Control (Pump) (Array - each consumer)"));

        AixLib.Systems.HydraulicModules.SimpleConsumer simpleConsumer[n_consumers](
          final dp_Valve=dp_Valve,
          each final dpFixed_nominal={0,0},
          k_ControlConsumerPump=k_ControlConsumerPump,
          Ti_ControlConsumerPump=Ti_ControlConsumerPump,
          final k_ControlConsumerValve=k_ControlConsumerValve,
          final Ti_ControlConsumerValve=Ti_ControlConsumerValve,
          each TInSetSou=TInSetSou,
          TInSetValue=TInSet,
          each TOutSetSou=TOutSetSou,
          TOutSetValue=TOutSet,
          redeclare each final package Medium = MediumWater,
          each final functionality=functionality,
          final demandType=demandType,
          final hasPump=hasPump,
          final hasFeedback=hasFeedback,
          final dp_nominalPumpConsumer=dp_nominalConPump,
          final Q_flow_fixed=Q_flow_fixed,
          final T_fixed=T_fixed,
          final capacity=capacity,
          final Q_flow_nom=Q_flow_nom_inner,
          final dT_nom=dT_nom)
          annotation (Placement(transformation(extent={{-20,-88},{18,-50}})));

      protected
        parameter Modelica.Units.SI.HeatFlowRate Q_flow_nom_inner[n_consumers] = if functionality=="Q_flow_fixed" then Q_flow_fixed else Q_flow_nom "inner parameter to not ask for Q_flow_nom if a fixed heatflow is used";
      equation

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end ModularConsumer_base;

      partial model ModularConsumer_base_backup

        package MediumWater = AixLib.Media.Water;
        // Consumer Design
        parameter Integer n_consumers=1 "Number of consumers" annotation (Dialog(group = "Consumer Design"));
        parameter String functionality "Choose between different functionalities" annotation (choices(
                    choice="T_fixed",
                    choice="T_input",
                    choice="Q_flow_fixed",
                    choice="Q_flow_input"),Dialog(group = "Consumer Design"));
        parameter Integer demandType[n_consumers]  "Array for each consumer: 1: Heating; -1: Cooling" annotation (Dialog(group = "Consumer Design"));
        parameter Modelica.Units.SI.HeatCapacity capacity[n_consumers]   "Array for each consumer: Capacity of the material" annotation(Dialog(group="Consumer Design"));

        // Nominal conditions
        parameter Modelica.Units.SI.HeatFlowRate Q_flow_fixed[n_consumers] "Prescribed heat flow" annotation(Dialog(enable=functionality=="Q_flow_fixed", group="Nominal conditions (Array - each consumer)"));
        parameter Modelica.Units.SI.Temperature T_fixed[n_consumers] "Prescribed temperature" annotation(Dialog(enable=functionality=="T_fixed",group="Nominal conditions (Array - each consumer)"));
        parameter Modelica.Units.SI.HeatFlowRate Q_flow_nom[n_consumers] "Nominal heat flow" annotation(Dialog(enable=functionality<>"Q_flow_fixed", group="Nominal conditions (Array - each consumer)"));
        parameter Modelica.Units.SI.TemperatureDifference dT_nom[n_consumers]  "nominal temperature difference" annotation(Dialog(group="Nominal conditions (Array - each consumer)"));

        // Feedback
        parameter Boolean hasFeedback[n_consumers]  "if circuit has feedback for temperature control" annotation(Dialog(group="Feedback (Array - each consumer)"));
        parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TInSetSou                                                                                                                                         "Source for set value for inlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Feedback (Array - each consumer)"));
        parameter Modelica.Units.SI.Temperature TInSet[n_consumers] "Constant set value for inlet temperature" annotation(Dialog(enable=TInSetSou == AixLib.Systems.ModularEnergySystems.Modules.
            ModularConsumer.Types.InputType.Constant, group="Feedback (Array - each consumer)"));
        parameter Real k_ControlConsumerValve[n_consumers] "Gain of controller" annotation(Dialog(group="Feedback (Array - each consumer)"));
        parameter Modelica.Units.SI.Time Ti_ControlConsumerValve[n_consumers]
          "Time constant of Integrator block" annotation(Dialog(group="Feedback (Array - each consumer)"));
        parameter Modelica.Units.SI.PressureDifference dp_Valve[n_consumers]
          "Pressure Difference set in regulating valve for pressure equalization in heating system" annotation(Dialog(group="Feedback (Array - each consumer)"));

        // Pump
        parameter Boolean hasPump[n_consumers] "circuit has Pump" annotation(Dialog(group="Pump (Array - each consumer)"));
        parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TOutSetSou "Source for set value for outlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Pump (Array - each consumer)"));
        parameter Modelica.Units.SI.Temperature TOutSet[n_consumers] "Constant set value for outlet temperature" annotation(Dialog(enable=TOutSetSou == AixLib.Systems.ModularEnergySystems.Modules.
            ModularConsumer.Types.InputType.Constant, group="Pump (Array - each consumer)"));
        parameter Real k_ControlConsumerPump[n_consumers](min=Modelica.Constants.small) "Gain of controller"
          annotation (Dialog(group = "Pump (Array - each consumer)"));
        parameter Modelica.Units.SI.Time Ti_ControlConsumerPump[n_consumers](min=Modelica.Constants.small) "Time constant of Integrator block"
          annotation (Dialog(group = "Pump (Array - each consumer)"));
        parameter Modelica.Units.SI.PressureDifference dp_nominalConPump[n_consumers]
          "Pressure increase of pump at nominal conditions for the individual consumers" annotation(Dialog(group="Pump (Array - each consumer)"));

        AixLib.Systems.HydraulicModules.SimpleConsumer simpleConsumer[n_consumers](
          final dp_Valve=dp_Valve,
          each final dpFixed_nominal={0,0},
          k_ControlConsumerPump=k_ControlConsumerPump,
          Ti_ControlConsumerPump=Ti_ControlConsumerPump,
          final k_ControlConsumerValve=k_ControlConsumerValve,
          final Ti_ControlConsumerValve=Ti_ControlConsumerValve,
          each TInSetSou=TInSetSou,
          TInSetValue=TInSet,
          each TOutSetSou=TOutSetSou,
          TOutSetValue=TOutSet,
          redeclare each final package Medium = MediumWater,
          each final functionality=functionality,
          final demandType=demandType,
          final hasPump=hasPump,
          final hasFeedback=hasFeedback,
          final dp_nominalPumpConsumer=dp_nominalConPump,
          final Q_flow_fixed=Q_flow_fixed,
          final T_fixed=T_fixed,
          final capacity=capacity,
          final Q_flow_nom=Q_flow_nom_inner,
          final dT_nom=dT_nom)
          annotation (Placement(transformation(extent={{-18,-20},{20,18}})));
        Modelica.Blocks.Interfaces.RealInput T[n_consumers] if functionality == "T_input"
                                               annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={60,120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-60,100})));
        Modelica.Blocks.Interfaces.RealInput Q_flow[n_consumers] if functionality == "Q_flow_input"
                                                    annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-60,120}), iconTransformation(extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-88,100})));
        Modelica.Blocks.Interfaces.RealInput T_Flow[n_consumers] if TInSetSou ==
          AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Continuous
          "Set value for flow temperature of consumers."
          annotation (Placement(
              transformation(
              extent={{-14,-14},{14,14}},
              rotation=0,
              origin={-106,-60}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=0,
              origin={-100,-60})));
        Modelica.Blocks.Interfaces.RealInput T_Return[n_consumers] if TOutSetSou ==
          AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Continuous
          "Set value for return temperature of consumers."
          annotation (Placement(
              transformation(
              extent={{-14,-14},{14,14}},
              rotation=0,
              origin={-106,-80}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=0,
              origin={-100,-90})));
      protected
        parameter Modelica.Units.SI.HeatFlowRate Q_flow_nom_inner[n_consumers] = if functionality=="Q_flow_fixed" then Q_flow_fixed else Q_flow_nom "inner parameter to not ask for Q_flow_nom if a fixed heatflow is used";
      equation

        connect(Q_flow, simpleConsumer.Q_flowSet) annotation (Line(points={{-60,120},
                {-60,80},{-19.52,80},{-19.52,8.88}}, color={0,0,127}));
        connect(T, simpleConsumer.TPrescribedSet) annotation (Line(points={{60,120},{
                60,80},{-19.9,80},{-19.9,15.15}}, color={0,0,127}));
        connect(T_Flow, simpleConsumer.TInSet) annotation (Line(points={{-106,-60},{
                -36,-60},{-36,-9.36},{-19.14,-9.36}}, color={0,0,127}));
        connect(T_Return, simpleConsumer.TOutSet) annotation (Line(points={{-106,-80},
                {-24,-80},{-24,-12.78},{-19.14,-12.78}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end ModularConsumer_base_backup;
    end BaseClasses;

    package Types
        extends Modelica.Icons.TypesPackage;
      type InputType = enumeration(
          Constant "Use constant parameter",
          Continuous "Use continuous, real input") "Input options for consumer 
    temperatures"
        annotation (Documentation(info="<html>
 <p>
 This type allows defining which type of input should be used for consumer 
 set temperatures.
 </p>
 <ol>
 <li>
 a constant set point declared by a parameter,
 </li>
 <li>
 a continuously variable set point.
 </li>
 </ol>
 </html>",    revisions="<html>
 <ul>
 <li>
 January 27, 2023, by David Jansen:<br/>
 First implementation.
 </li>
 </ul>
 </html>"));
    end Types;

    package Examples
      extends Modelica.Icons.ExamplesPackage;
      model ModularConsumer
        extends Modelica.Icons.Example;
        AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.ConsumerDistributorModule
          modularConsumer(
          n_consumers=2,
          demandType={1,1},
          Q_flow_fixed={10000,10000},
          TInSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
          TInSet={343.15,343.15},
          TOutSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
          TOutSet={323.15,323.15},
          hasPump={true,true},
          hasFeedback={true,true},
          functionality="Q_flow_input",
          k_ControlConsumerPump={0.1,0.1},
          Ti_ControlConsumerPump={10,10},
          dp_nominalConPump={10000,10000},
          capacity={1,1},
          Q_flow_nom={10000,10000},
          dT_nom={20,20},
          dp_Valve={1000,1000},
          k_ControlConsumerValve={0.01,0.01},
          Ti_ControlConsumerValve={10,10},
          T_start={333.15,333.15})
          annotation (Placement(transformation(extent={{36,-22},{84,26}})));

        Fluid.Sources.Boundary_pT bou(
          use_T_in=false,
          redeclare package Medium = AixLib.Media.Water,
          nPorts=1)
          annotation (Placement(transformation(extent={{-98,-8},{-74,16}})));
        Fluid.MixingVolumes.MixingVolume volume(
          redeclare package Medium = AixLib.Media.Water,
          T_start=353.15,
          final V=1,
          final m_flow_nominal=1,
          nPorts=3)                                                                                annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-58,14})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
              rotation=270,
              origin={-54,46})));
        Modelica.Blocks.Continuous.LimPID PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=50,
          Ti=20,
          yMax=50000,
          yMin=0,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=PID.yMax/2)
                  annotation (Placement(transformation(extent={{-42,66},{-22,86}})));
        Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
              AixLib.Media.Water, m_flow_nominal=1)
          annotation (Placement(transformation(extent={{-40,-8},{-20,12}})));
        Modelica.Blocks.Sources.Constant TSetGenerator(k=273.15 + 80) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-88,76})));
        Modelica.Blocks.Sources.Sine sineHeatDemand1(
          amplitude=5000,
          f=1/3600,
          offset=5000)
          annotation (Placement(transformation(extent={{6,76},{26,96}})));
        Modelica.Blocks.Sources.Sine sineHeatDemand2(
          amplitude=3000,
          f=1/3600,
          offset=2000,
          startTime=1800)
          annotation (Placement(transformation(extent={{98,68},{78,88}})));
        Interfaces.ConsumerControlBus consumerControlBus(nConsumers=2)
          annotation (Placement(transformation(extent={{44,42},{64,62}})));
      equation
        connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(points={{-54,38},
                {-54,30},{-68,30},{-68,14}},     color={191,0,0}));
        connect(modularConsumer.port_b, volume.ports[1]) annotation (Line(points={{84,2},{
                88,2},{88,-28},{-59.3333,-28},{-59.3333,4}},
              color={0,127,255}));
        connect(bou.ports[1], volume.ports[2]) annotation (Line(points={{-74,4},{-58,
                4}},                       color={0,127,255}));
        connect(PID.y, prescribedHeatFlow.Q_flow)
          annotation (Line(points={{-21,76},{-8,76},{-8,54},{-54,54}},
                                                                color={0,0,127}));
        connect(volume.ports[3], senTem.port_a) annotation (Line(points={{-56.6667,4},
                {-56.6667,2},{-40,2}},                        color={0,127,255}));
        connect(senTem.port_b, modularConsumer.port_a) annotation (Line(points={{-20,2},
                {36,2}},                      color={0,127,255}));
        connect(senTem.T, PID.u_m) annotation (Line(points={{-30,13},{-32,13},{-32,64}},
                               color={0,0,127}));
        connect(TSetGenerator.y, PID.u_s) annotation (Line(points={{-77,76},{-44,76}},
                                         color={0,0,127}));
        connect(sineHeatDemand1.y,consumerControlBus. Q_flowSet[1]) annotation (Line(
              points={{27,86},{54.05,86},{54.05,52.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(sineHeatDemand2.y,consumerControlBus. Q_flowSet[2]) annotation (Line(
              points={{77,78},{54.05,78},{54.05,52.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(consumerControlBus, modularConsumer.consumerControlBus) annotation (
            Line(
            points={{54,52},{54,32},{60,32},{60,26}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,6},{-3,6}},
            horizontalAlignment=TextAlignment.Right));
        annotation (experiment(StopTime=12000, __Dymola_Algorithm="Dassl"));
      end ModularConsumer;

      model ModularConsumerDynamic
        extends Modelica.Icons.Example;
        parameter Integer nConsumers = 2;
        Fluid.Sources.Boundary_pT bou(
          use_T_in=false,
          redeclare package Medium = AixLib.Media.Water,
          nPorts=1)
          annotation (Placement(transformation(extent={{-98,-8},{-74,16}})));
        Fluid.MixingVolumes.MixingVolume volume(
          redeclare package Medium = AixLib.Media.Water,
          T_start=353.15,
          final V=1,
          final m_flow_nominal=1,
          nPorts=3)                                                                                annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-58,14})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
              rotation=270,
              origin={-54,46})));
        Modelica.Blocks.Continuous.LimPID PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=50,
          Ti=20,
          yMax=50000,
          yMin=0,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=PID.yMax/2)
                  annotation (Placement(transformation(extent={{-42,66},{-22,86}})));
        Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
              AixLib.Media.Water, m_flow_nominal=1)
          annotation (Placement(transformation(extent={{-40,-8},{-20,12}})));
        Modelica.Blocks.Sources.Constant TSetGenerator(k=273.15 + 80) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-88,76})));
        Modelica.Blocks.Sources.Sine sineHeatDemand1(
          amplitude=5000,
          f=1/3600,
          offset=5000)
          annotation (Placement(transformation(extent={{20,72},{40,92}})));
        Modelica.Blocks.Sources.Sine sineHeatDemand2(
          amplitude=3000,
          f=1/3600,
          offset=2000,
          startTime=1800)
          annotation (Placement(transformation(extent={{98,72},{78,92}})));
        Interfaces.ConsumerControlBus consumerControlBus(nConsumers=nConsumers)
          annotation (Placement(transformation(extent={{44,46},{64,66}})));
        ConsumerDistributorModule                 modularConsumer(
          n_consumers=nConsumers,
          demandType=fill(1, nConsumers),
          TInSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
          TInSet={343.15,333.15},
          hasPump=fill(true, nConsumers),
          hasFeedback=fill(true, nConsumers),
          functionality="Q_flow_input",
          Q_flow_fixed(displayUnit="kW") = {15000,19000},
          T_fixed={333.15,333.15},
          TOutSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
          TOutSet={323.15,313.15},
          k_ControlConsumerPump=fill(0.1, nConsumers),
          Ti_ControlConsumerPump=fill(10, nConsumers),
          dp_nominalConPump=fill(0.1, nConsumers),
          capacity=fill(1, nConsumers),
          Q_flow_nom={10000,7000},
          dT_nom={20,20},
          dp_Valve(displayUnit="bar") = fill(0.01, nConsumers),
          k_ControlConsumerValve=fill(0.01, nConsumers),
          Ti_ControlConsumerValve=fill(10, nConsumers),
          allowFlowReversal=true,
          T_start=fill(273.15 + 70, nConsumers))
          annotation (Placement(transformation(extent={{16,-28},{76,32}})));

      equation
        connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(points={{-54,38},
                {-54,30},{-68,30},{-68,14}},     color={191,0,0}));
        connect(bou.ports[1], volume.ports[1]) annotation (Line(points={{-74,4},{
                -59.3333,4}},              color={0,127,255}));
        connect(PID.y, prescribedHeatFlow.Q_flow)
          annotation (Line(points={{-21,76},{-8,76},{-8,54},{-54,54}},
                                                                color={0,0,127}));
        connect(volume.ports[2], senTem.port_a) annotation (Line(points={{-58,4},{-58,
                2},{-40,2}},                                  color={0,127,255}));
        connect(senTem.T, PID.u_m) annotation (Line(points={{-30,13},{-32,13},{-32,64}},
                               color={0,0,127}));
        connect(TSetGenerator.y, PID.u_s) annotation (Line(points={{-77,76},{-44,76}},
                                         color={0,0,127}));
        connect(sineHeatDemand1.y, consumerControlBus.Q_flowSet[1]) annotation (Line(
              points={{41,82},{54.05,82},{54.05,56.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(sineHeatDemand2.y, consumerControlBus.Q_flowSet[2]) annotation (Line(
              points={{77,82},{54.05,82},{54.05,56.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(senTem.port_b, modularConsumer.port_a)
          annotation (Line(points={{-20,2},{16,2}}, color={0,127,255}));
        connect(modularConsumer.port_b, volume.ports[3]) annotation (Line(points={{76,2},{
                86,2},{86,4},{96,4},{96,-68},{-56.6667,-68},{-56.6667,4}},     color={
                0,127,255}));
        connect(modularConsumer.consumerControlBus, consumerControlBus) annotation (
            Line(
            points={{46,32},{46,42},{54,42},{54,56}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        annotation (experiment(StopTime=12000, __Dymola_Algorithm="Dassl"));
      end ModularConsumerDynamic;
    end Examples;

  end ModularConsumer;
end Modules;
