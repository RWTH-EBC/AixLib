within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model BoilerModular

   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = AixLib.Media.Water,
                           final m_flow_nominal=Q_nom/(Medium.cp_const*dT_w_nom));

  parameter Modelica.Units.SI.TemperatureDifference dT_w_nom=20 "Nominal temperature difference of flow and return"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature T_cold_nom=273.15 + 35
                                                             "Return temperature"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.HeatFlowRate Q_nom=50000 "Nominal heat flow rate"
   annotation (Dialog(group="Nominal condition"));

  parameter Boolean Pump=true "Model includes a pump"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));

   parameter Boolean DrinkingWaterSupply=true "Model includes additional drinking water supply"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));



  parameter Modelica.Units.SI.Temperature T_hot_max=273.15 + 90
                                                            "Maximal temperature to force shutdown";
  parameter Real PLR_min=0.15 "Minimal Part Load Ratio";

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


  Fluid.BoilerCHP.BoilerGeneric
                        heatGeneratorNoControl(
    allowFlowReversal=true,
    T_start=T_start,
    dTNom=dT_w_nom,
    TRetNom=T_cold_nom,
    QNom=Q_nom,
    redeclare package Medium = Media.Water,
    final m_flow_nominal=Q_nom/(Medium.cp_const*dT_w_nom))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.Sensors.TemperatureTwoPort        senTReturn(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=Q_nom/(Medium.cp_const*dT_w_nom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start,
    final transferHeat=false,
    final allowFlowReversal=true,
    final m_flow_small=0.001) "Temperature sensor return flow" annotation (
      Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=0,
        origin={-86,0})));
  Fluid.Sensors.MassFlowRate senMasFloHeizkreis(redeclare final package Medium =
        Media.Water, final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flow rate"
    annotation (Placement(transformation(extent={{-40,-10},{-24,10}})));
  AixLib.Controls.Continuous.LimPID conPID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=30,
    yMin=0)
    annotation (Placement(transformation(extent={{92,130},{112,150}})));
  Fluid.Sensors.MassFlowRate senMasFloBypass1(redeclare final package Medium =
        Media.Water, final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flow rate"
    annotation (Placement(transformation(extent={{-6,-38},{-26,-18}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom1(y=T_cold_nom)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{-2,104},{38,130}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{56,104},{76,124}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{56,50},{76,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  parameter Modelica.Units.SI.PressureDifference dp_nominal=18000+7.143*10^8*exp(-0.007078*Q_nom/1000)*(V_flow_nominal)^2;
   replaceable package MediumBoiler =Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val_Feedback(
    redeclare package Medium = Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    use_inputFilter=true,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=Q_nom/(Medium.cp_const*dT_w_nom),
    dpValve_nominal=6000,
    fraK=1,
    R=100) annotation (Placement(transformation(extent={{62,-8},{44,8}})));
  Fluid.Movers.SpeedControlled_y pump(
    redeclare package Medium = Media.Water,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per(pressure(
          V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/0.9,
            dp_nominal,0})),
    addPowerToMedium=false,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  TWWAdd_on               tWWAdd_on if DrinkingWaterSupply == true
    annotation (Placement(transformation(extent={{-8,-80},{12,-60}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(p(start=Medium.p_default),
      redeclare final package Medium = Medium)
                                             if DrinkingWaterSupply == true
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(p(start=Medium.p_default),
      redeclare final package Medium = Medium)
                                             if DrinkingWaterSupply == true
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,-90},{90,-70}})));
  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val_DrinkingWater(
    redeclare package Medium = Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    use_inputFilter=true,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=Q_nom/(Medium.cp_const*dT_w_nom),
    dpValve_nominal=6000,
    fraK=1,
    R=100) annotation (Placement(transformation(extent={{84,-8},{68,8}})));
equation
  connect(port_a,senTReturn. port_a)
    annotation (Line(points={{-100,0},{-92,0}}, color={0,127,255}));
  connect(senMasFloHeizkreis.port_b,heatGeneratorNoControl. port_a)
    annotation (Line(points={{-24,0},{-10,0}},color={0,127,255}));
  connect(dTWaterNom1.y,gain1. u) annotation (Line(points={{40,117},{40,114},{54,
          114}},                       color={0,0,127}));
  connect(gain1.y,conPID3. u_s)
    annotation (Line(points={{77,114},{84,114},{84,132},{82,132},{82,140},{90,140}},
                                                          color={0,0,127}));
  connect(senTReturn.T,boilerControlBus. TReturnMea) annotation (Line(points={{-86,8.8},
          {-86,100},{0,100}},                                   color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.TColdMea,gain2. u) annotation (Line(
      points={{0,100},{0,60},{54,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(gain2.y,conPID3. u_m)
    annotation (Line(points={{77,60},{102,60},{102,128}}, color={0,0,127}));
  connect(senMasFloBypass1.port_b, senTReturn.port_b) annotation (Line(points={
          {-26,-28},{-44,-28},{-44,-22},{-80,-22},{-80,0}}, color={0,127,255}));
  connect(boilerControlBus, heatGeneratorNoControl.boilerControlBus)
    annotation (Line(
      points={{0,100},{0,10},{-2.8,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatGeneratorNoControl.port_b, val_Feedback.port_2)
    annotation (Line(points={{10,0},{44,0}}, color={0,127,255}));
  connect(val_Feedback.port_3, senMasFloBypass1.port_a)
    annotation (Line(points={{53,-8},{53,-28},{-6,-28}}, color={0,127,255}));
  connect(conPID3.y, val_Feedback.y) annotation (Line(points={{113,140},{124,
          140},{124,34},{53,34},{53,9.6}}, color={0,0,127}));
  connect(senTReturn.port_b, pump.port_a)
    annotation (Line(points={{-80,0},{-68,0}}, color={0,127,255}));
  connect(pump.port_b, senMasFloHeizkreis.port_a)
    annotation (Line(points={{-48,0},{-40,0}}, color={0,127,255}));
  connect(boilerControlBus.m_flowSet, pump.y) annotation (Line(
      points={{0,100},{-4,100},{-4,64},{-48,64},{-48,12},{-58,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_a1, tWWAdd_on.port_a1) annotation (Line(points={{-100,-80},{-8,
          -80},{-8,-74}}, color={0,127,255}));
  connect(port_b1, tWWAdd_on.port_b1) annotation (Line(points={{100,-80},{72,
          -80},{72,-74},{12,-74}}, color={0,127,255}));
  connect(val_Feedback.port_1, val_DrinkingWater.port_2)
    annotation (Line(points={{62,0},{68,0}}, color={0,127,255}));
  connect(val_DrinkingWater.port_1, port_b)
    annotation (Line(points={{84,0},{100,0}}, color={0,127,255}));
  connect(val_DrinkingWater.port_3, tWWAdd_on.port_a2) annotation (Line(points=
          {{76,-8},{74,-8},{74,-36},{10,-36},{10,-60}}, color={0,127,255}));
  connect(tWWAdd_on.port_b2, port_a) annotation (Line(points={{-6,-60},{-30,-60},
          {-30,-56},{-100,-56},{-100,0}}, color={0,127,255}));
  connect(tWWAdd_on.TWW_Valve, val_DrinkingWater.y)
    annotation (Line(points={{13,-77},{13,9.6},{76,9.6}}, color={0,0,127}));
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
