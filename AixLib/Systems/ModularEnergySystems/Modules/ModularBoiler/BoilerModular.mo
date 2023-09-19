within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model BoilerModular

  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare final
      package Medium = AixLib.Media.Water, final m_flow_nominal=DesQ/(Medium.cp_const
        *DesDelT));

  parameter Modelica.Units.SI.TemperatureDifference DesDelT=20
    "Design temperature difference between supply and return"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature DesRetT=273.15 + 35
    "Design return temperature"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.HeatFlowRate DesQ=50000 "Design thermal capacity"
   annotation (Dialog(group="Nominal condition"));

    parameter Boolean Pump=true "Model includes a pump"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));

  parameter Boolean DWheating=false "Model includes drinking water heating system"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));

  final parameter Real PLR_min=0.15 "Minimal Part Load Ratio";

  parameter Modelica.Units.SI.Temperature T_start=273.15 + 20
                                                           "Starting temperature"
   annotation (Dialog(tab="Advanced"));

   parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=0
     "Guess value of dp = port_a.p - port_b.p"
     annotation (Dialog(tab="Advanced", group="Initialization"));
   parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
     "Guess value of m_flow = port_a.m_flow"
     annotation (Dialog(tab="Advanced", group="Initialization"));
   parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
     "Start value of pressure"
     annotation (Dialog(tab="Advanced", group="Initialization"));


  Fluid.BoilerCHP.BoilerGeneric boilerGeneric(
    allowFlowReversal=true,
    T_start=T_start,
    dTDes=DesDelT,
    TRetDes=DesRetT,
    QDes=DesQ)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Fluid.Sensors.TemperatureTwoPort senTIn(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start,
    final transferHeat=false,
    final allowFlowReversal=true,
    final m_flow_small=0.001) "Temperature sensor module inlet" annotation (
      Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=0,
        origin={-72,0})));
  Fluid.Sensors.MassFlowRate senMasFloFeedback(redeclare final package Medium =
        AixLib.Media.Water, final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flow rate feedback"
    annotation (Placement(transformation(extent={{-6,-38},{-26,-18}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  final parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  final parameter Modelica.Units.SI.PressureDifference dp_nominal=18000 + 7.143*
      10^8*exp(-0.007078*DesQ/1000)*(V_flow_nominal)^2;


  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val_Feedback(
    redeclare final package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    use_inputFilter=true,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    final m_flow_nominal=DesQ/(Medium.cp_const*DesDelT),
    dpValve_nominal=6000,
    fraK=1,
    R=100) annotation (Placement(transformation(extent={{50,-8},{32,8}})));
  Fluid.Movers.SpeedControlled_y pump(
    redeclare package Medium = AixLib.Media.Water,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per(pressure(
          V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/0.9,
            dp_nominal,0})),
    addPowerToMedium=false,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  TWWAdd_on               tWWAdd_on if DWheating == true
    annotation (Placement(transformation(extent={{-10,-86},{10,-66}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_DW(p(start=Medium.p_default),
      redeclare final package Medium = Medium) if DWheating == true
    "drinking water inlet"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_DW(p(start=Medium.p_default),
      redeclare final package Medium = Medium) if DWheating == true
    "drinking water outlet"
    annotation (Placement(transformation(extent={{110,-90},{90,-70}})));
  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val_DrinkingWater(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    use_inputFilter=true,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    final m_flow_nominal=m_flow_nominal,
    dpValve_nominal=6000,
    fraK=1,
    R=100) if DWheating == true annotation (Placement(transformation(extent={{84,-8},{68,8}})));
  FeedbackControl feedbackControl(T_cold_Des=DesRetT)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
equation
  connect(port_a, senTIn.port_a)
    annotation (Line(points={{-100,0},{-78,0}}, color={0,127,255}));
  connect(boilerControlBus, boilerGeneric.boilerControlBus) annotation (Line(
      points={{0,100},{0,10},{-2.8,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerGeneric.port_b, val_Feedback.port_2)
    annotation (Line(points={{10,0},{32,0}}, color={0,127,255}));
  connect(val_Feedback.port_3, senMasFloFeedback.port_a)
    annotation (Line(points={{41,-8},{41,-28},{-6,-28}}, color={0,127,255}));
  connect(senTIn.port_b, pump.port_a)
    annotation (Line(points={{-66,0},{-50,0}}, color={0,127,255}));
  connect(boilerControlBus.m_flowSet, pump.y) annotation (Line(
      points={{0,100},{0,22},{-40,22},{-40,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(val_Feedback.port_1, val_DrinkingWater.port_2)
    annotation (Line(points={{50,0},{68,0}}, color={0,127,255},
      pattern=LinePattern.Dash));


    if DWheating == true then

      connect(tWWAdd_on.valDWpos, val_DrinkingWater.y) annotation (Line(points={{0,-65},
          {0,-36},{66,-36},{66,9.6},{76,9.6}}, color={0,0,127},
        pattern=LinePattern.Dash));
           connect(val_DrinkingWater.port_1, port_b)
    annotation (Line(points={{84,0},{100,0}}, color={0,127,255},
        pattern=LinePattern.Dash));
  connect(val_DrinkingWater.port_3, tWWAdd_on.port_a_feedback)
    annotation (Line(points={{76,-8},{76,-70},{10,-70}}, color={0,127,255},
        pattern=LinePattern.Dash));
    connect(tWWAdd_on.port_b_feedback, senTIn.port_a)
    annotation (Line(points={{-10,-70},{-78,-70},{-78,0}}, color={0,127,255},
        pattern=LinePattern.Dash));

      connect(port_a_DW, tWWAdd_on.port_a_DW)
    annotation (Line(points={{-100,-80},{-10,-80}}, color={0,127,255},
        pattern=LinePattern.Dash));
  connect(port_b_DW, tWWAdd_on.port_b_DW)
    annotation (Line(points={{100,-80},{10,-80}}, color={0,127,255},
        pattern=LinePattern.Dash));

    else
      connect(val_Feedback.port_1, port_b) annotation (Line(points={{50,0},{56,0},
            {56,14},{92,14},{92,0},{100,0}},
                                       color={0,127,255},
        pattern=LinePattern.Dash));


    end if;


    connect(senTIn.T, boilerControlBus.TBoilerIn) annotation (Line(points={{-72,8.8},
          {-72,94},{0,94},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(feedbackControl.boilerControlBus, boilerControlBus) annotation (Line(
      points={{60,70},{0,70},{0,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PosValFeedback, val_Feedback.y) annotation (Line(
      points={{0,100},{0,38},{40,38},{40,9.6},{41,9.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(pump.port_b, boilerGeneric.port_a)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,127,255}));
  connect(senMasFloFeedback.port_b, pump.port_a)
    annotation (Line(points={{-26,-28},{-50,-28},{-50,0}}, color={0,127,255}));
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
          points={{-16.5,-21.5},{-6.5,-1.5},{19.5,-21.5},{-6.5,-21.5},{-16.5,
              -21.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26.5,-21.5},{27.5,-29.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerModular;
