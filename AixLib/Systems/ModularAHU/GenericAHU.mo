within AixLib.Systems.ModularAHU;
model GenericAHU
  "Generic air-handling unit with heat recovery system"
  replaceable package Medium1 =
    Modelica.Media.Interfaces.PartialCondensingGases "Medium in air canal in the component"    annotation (choices(
      choice(redeclare package Medium = AixLib.Media.Air "Moist air")));


replaceable package Medium2 =
      Modelica.Media.Interfaces.PartialMedium "Medium in hydraulic circuits"
    annotation (choices(
      choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
      choice(redeclare package Medium = AixLib.Media.Water "Water"),
      choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (property_T=293.15,
              X_a=0.40) "Propylene glycol water, 40% mass fraction")));


  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors" annotation(Dialog(tab="Advanced"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of mass balance: dynamic (3 initialization options) or steady state" annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  parameter Fluid.Movers.BaseClasses.Characteristics.efficiencyParameters
    hydraulicEfficiency(
      V_flow={0},
      eta={0.7}) "Hydraulic efficiency of the fans" annotation (dialog(group="Fans"));

  parameter  Modelica.SIunits.Temperature T_amb "Ambient temperature";
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal
    "Nominal mass flow rate in air canal";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal
    "Nominal mass flow rate in hydraulics";
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced", group="Initialization"));

  parameter Boolean usePreheater = true "If true, a preaheater is used" annotation (choices(checkBox=true), Dialog(group="Preheater"));
  parameter Boolean useHumidifierRet = true "If true, a humidifier in return canal is used" annotation (choices(checkBox=true), Dialog(group="Humidifiers"));
  parameter Boolean useHumidifier = true "If true, a humidifier in supply canal is used" annotation (choices(checkBox=true), Dialog(group="Humidifiers"));
  parameter Boolean allowFlowReversal1=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium in air canal" annotation(Dialog(tab="Assumptions"), Evaluate=true);
  parameter Boolean allowFlowReversal2=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium in hydraulics" annotation(Dialog(tab="Assumptions"), Evaluate=true);

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium1,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-230,-10},{-210,10}}),
        iconTransformation(extent={{-230,-10},{-210,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium1,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{230,-10},{210,10}}),
        iconTransformation(extent={{232,-10},{212,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium1,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{210,70},{230,90}}),
        iconTransformation(extent={{212,70},{232,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium1,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-210,70},{-230,90}}),
        iconTransformation(extent={{-210,70},{-230,90}})));
  RegisterModule preheater(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal2,
    final m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    T_start=T_start,
    tau=tau,
    T_amb=T_amb,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics) if
                    usePreheater "Preheating coil subsystem"
    annotation (Dialog(enable=usePreheater, group="Preheater"),Placement(transformation(extent={{-154,
            -46},{-110,14}})));
  RegisterModule cooler(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal2,
    final m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    T_start=T_start,
    tau=tau,
    T_amb=T_amb,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics) "Cooling coil subsystem"
    annotation (Dialog(enable=true, group="Cooler"),Placement(transformation(extent={{2,-46},{46,14}})));
  RegisterModule heater(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal2,
    final m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    T_start=T_start,
    tau=tau,
    T_amb=T_amb,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics) "Heating coil subsystem"
    annotation (Dialog(enable=true, group="Heater"),Placement(transformation(extent={{76,-46},{120,14}})));
  Fluid.HeatExchangers.DynamicHX dynamicHX(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium1,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal1,
    final m1_flow_nominal=m1_flow_nominal,
    final m2_flow_nominal=m1_flow_nominal,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    final T1_start=T_start,
    final T2_start=T_start) "Heat recovery heat exchanger"
    annotation (Dialog(enable=true, group="Heat recovery heat exchanger"),Placement(transformation(extent={{-20,-14},
            {-60,54}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare package Medium =
        Medium2) if     usePreheater
    "Fluid connector a3 (positive design flow direction is from port_a3 to port_b3)"
    annotation (Placement(transformation(extent={{-170,-110},{-150,-90}}),
        iconTransformation(extent={{-170,-110},{-150,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium =
        Medium2) if     usePreheater
    "Fluid connector b3 (positive design flow direction is from port_a3 to port_b3)"
    annotation (Placement(transformation(extent={{-130,-110},{-110,-90}}),
        iconTransformation(extent={{-130,-110},{-110,-90}})));
  Fluid.Actuators.Dampers.Exponential flapSup(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    final dpDamper_nominal=dpDamper_nominal)
                                          "Supply air flap"
    annotation (Placement(transformation(extent={{-190,-10},{-170,10}})));
  Fluid.Actuators.Dampers.Exponential flapRet(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    final dpDamper_nominal=dpDamper_nominal)
                                          "Return air flap"
    annotation (Placement(transformation(extent={{200,70},{180,90}})));
  Fluid.Actuators.Dampers.Exponential dampHX(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    final dpDamper_nominal=dpDamper_nominal)
                                          "Flap to heat recovery system"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Fluid.Actuators.Dampers.Exponential dampBypass(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    final dpDamper_nominal=dpDamper_nominal)
                                          "Bypass flap of heat recovery system"
    annotation (Placement(transformation(extent={{-90,-10},{-70,-30}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-100,30},{-94,36}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-88,34},{-80,42}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a4(redeclare package Medium =
        Medium2)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b4(redeclare package Medium =
        Medium2)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}}),
        iconTransformation(extent={{30,-110},{50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a5(redeclare package Medium =
        Medium2)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{70,-110},{90,-90}}),
        iconTransformation(extent={{70,-110},{90,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b5(redeclare package Medium =
        Medium2)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{110,-110},{130,-90}}),
        iconTransformation(extent={{108,-110},{128,-90}})));
  Fluid.Movers.FlowControlled_dp fanSup(
    redeclare package Medium = Medium1,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    T_start=T_start,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    redeclare Fluid.Movers.Data.Fans.GenericFan per(hydraulicEfficiency=
          hydraulicEfficiency, motorEfficiency(eta={0.95})),
    final inputType=AixLib.Fluid.Types.InputType.Continuous) "Supply air fan"
    annotation (Placement(transformation(extent={{156,-10},{176,10}})));
  Fluid.Movers.FlowControlled_dp fanRet(
    redeclare package Medium = Medium1,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    T_start=T_start,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    redeclare Fluid.Movers.Data.Fans.GenericFan per(hydraulicEfficiency=
          hydraulicEfficiency, motorEfficiency(eta={0.95})),
    final inputType=AixLib.Fluid.Types.InputType.Continuous) "Return air fan"
                                        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,80})));
  Fluid.Humidifiers.GenericHumidifier_u
                                 humidifier(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    T_start=T_start) if
                       useHumidifier "Steam or adiabatic humdifier in supply canal"
    annotation (Dialog(enable=useHumidifier, group="Humidifiers"), Placement(transformation(extent={{130,-10},{150,10}})));
  Fluid.Humidifiers.GenericHumidifier_u humidifierRet(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    final steamHumidifier=false) if
                              useHumidifierRet
    "Adiabatic humidifier in retrun canal: cools inlet air of heat recovery system"
    annotation (Dialog(enable=useHumidifierRet, group="Humidifiers"), Placement(
        transformation(extent={{60,70},{40,90}})));
  Fluid.Sensors.TemperatureTwoPort senTRet(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    T_start=T_start) "Return air temperature sensor"
    annotation (Placement(transformation(extent={{160,70},{140,90}})));
  Fluid.Sensors.TemperatureTwoPort senTExh(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    T_start=T_start) "Exhaust air temperature sensor"
    annotation (Placement(transformation(extent={{-140,70},{-160,90}})));
  Fluid.Sensors.TemperatureTwoPort senTSup(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    T_start=T_start) "Supply air temperature sensor"
                                           annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={206,0})));
  Fluid.Sensors.TemperatureTwoPort senTOda(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    T_start=T_start) "Outside air temperature sensor" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-204,0})));
  Fluid.Sensors.VolumeFlowRate senVolFlo(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    m_flow_nominal=m1_flow_nominal) "Exhaust volume flow sensor"
                                         annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-110,80})));
  Fluid.Sensors.RelativeHumidityTwoPort senRelHumSup(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    m_flow_nominal=m1_flow_nominal) "Supply air humidity sensor"
    annotation (Placement(transformation(extent={{180,-6},{192,6}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRelHumSup1(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    m_flow_nominal=m1_flow_nominal) "Return air humidity sensor"
    annotation (Placement(transformation(extent={{130,74},{118,86}})));

  BaseClasses.GenericAHUBus genericAHUBus "Bus connector for generic ahu"
                                          annotation (Placement(transformation(
          extent={{-18,102},{18,138}}), iconTransformation(extent={{-14,108},{14,
            134}})));
  Fluid.Interfaces.PassThroughMedium passThroughPreheater(
    redeclare package Medium = Medium1,
    allowFlowReversal=allowFlowReversal1) if usePreheater == false
    "Passthrough if without preheater"
    annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
  Fluid.Interfaces.PassThroughMedium passThroughHumidifer(
    redeclare package Medium = Medium1,
    allowFlowReversal=allowFlowReversal1) if useHumidifier == false
    "Passthrough if without humidifier"
    annotation (Placement(transformation(extent={{132,-38},{152,-18}})));
  Fluid.Interfaces.PassThroughMedium passThroughHumidiferRet(
    redeclare package Medium = Medium1,
    allowFlowReversal=allowFlowReversal1) if useHumidifierRet == false
    "Passthough if without adiabtic return air humidifier"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,40})));


  parameter Modelica.SIunits.PressureDifference dpDamper_nominal = 1
    "Pressure drop of fully open dampers at nominal mass flow rate";
protected
  Modelica.Blocks.Continuous.FirstOrder PT1_airIn(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=270,
        origin={206,20})));
  Modelica.Blocks.Continuous.FirstOrder PT1_airIn1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) "Oda sensor delay"
                 annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=270,
        origin={-206,26})));
  Modelica.Blocks.Continuous.FirstOrder PT1_airIn2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=270,
        origin={-150,106})));
  Modelica.Blocks.Continuous.FirstOrder PT1_airIn3(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=270,
        origin={150,102})));
equation
  connect(preheater.port_a2, port_a3) annotation (Line(points={{-154,-27.5385},
          {-160,-27.5385},{-160,-100}},            color={0,127,255}));
  connect(preheater.port_b2, port_b3) annotation (Line(points={{-110,-27.5385},
          {-110,-100},{-120,-100}},          color={0,127,255}));
  connect(const.y, add.u2)
    annotation (Line(points={{-93.7,33},{-94,33},{-94,35.6},{-88.8,35.6}},
                                                     color={0,0,127}));
  connect(dampHX.port_b, dynamicHX.port_a2) annotation (Line(points={{-70,0},{
          -64,0},{-64,-0.4},{-60,-0.4}},
                                   color={0,127,255}));
  connect(preheater.port_b1, dampHX.port_a) annotation (Line(points={{-110,
          0.153846},{-112,0.153846},{-112,0},{-90,0}},
                                           color={0,127,255}));
  connect(flapSup.port_b,preheater. port_a1) annotation (Line(points={{-170,0},
          {-164,0},{-164,0.153846},{-154,0.153846}}, color={0,127,255}));
  connect(cooler.port_b1, heater.port_a1)
    annotation (Line(points={{46,0.153846},{76,0.153846}}, color={0,127,255}));
  connect(dampHX.port_a,dampBypass. port_a)
    annotation (Line(points={{-90,0},{-90,-20}},           color={0,127,255}));
  connect(dampBypass.port_b, dynamicHX.port_b2) annotation (Line(points={{-70,-20},
          {-20,-20},{-20,-0.4}},color={0,127,255}));
  connect(cooler.port_a2, port_a4) annotation (Line(points={{2,-27.5385},{-4,
          -27.5385},{-4,-100},{0,-100}},
                               color={0,127,255}));
  connect(cooler.port_b2, port_b4) annotation (Line(points={{46,-27.5385},{46,
          -28},{48,-28},{48,-100},{40,-100}},
                                         color={0,127,255}));
  connect(heater.port_a2, port_a5) annotation (Line(points={{76,-27.5385},{76,
          -100},{80,-100}},                       color={0,127,255}));
  connect(heater.port_b2, port_b5) annotation (Line(points={{120,-27.5385},{122,
          -27.5385},{122,-100},{120,-100}},                     color={0,127,255}));
  connect(dynamicHX.port_b2, cooler.port_a1) annotation (Line(points={{-20,-0.4},
          {-8,-0.4},{-8,0.153846},{2,0.153846}},color={0,127,255}));
  connect(heater.port_b1, humidifier.port_a) annotation (Line(points={{120,
          0.153846},{130,0.153846},{130,0}},
                                           color={0,127,255}));
  connect(humidifier.port_b, fanSup.port_a)
    annotation (Line(points={{150,0},{156,0}}, color={0,127,255}));

  connect(fanRet.port_b, humidifierRet.port_a)
    annotation (Line(points={{80,80},{60,80}}, color={0,127,255}));
  connect(humidifierRet.port_b, dynamicHX.port_a1) annotation (Line(points={{40,80},
          {-10,80},{-10,40.4},{-20,40.4}},   color={0,127,255}));
  connect(senTExh.port_b, port_b2)
    annotation (Line(points={{-160,80},{-220,80}}, color={0,127,255}));
  connect(senTSup.port_b, port_b1)
    annotation (Line(points={{214,0},{220,0}}, color={0,127,255}));
  connect(port_a1, senTOda.port_a)
    annotation (Line(points={{-220,0},{-214,0}}, color={0,127,255}));
  connect(senTOda.port_b, flapSup.port_a)
    annotation (Line(points={{-194,0},{-190,0}}, color={0,127,255}));
  connect(dynamicHX.port_b1, senVolFlo.port_a) annotation (Line(points={{-60,
          40.4},{-60,80},{-100,80}}, color={0,127,255}));
  connect(senVolFlo.port_b, senTExh.port_a)
    annotation (Line(points={{-120,80},{-140,80}}, color={0,127,255}));
  connect(add.y, dampHX.y) annotation (Line(points={{-79.6,38},{-79.6,26.5},{
          -80,26.5},{-80,12}}, color={0,0,127}));
  connect(dampBypass.y, add.u1) annotation (Line(points={{-80,-32},{-104,-32},{
          -104,40.4},{-88.8,40.4}}, color={0,0,127}));
  connect(fanSup.port_b, senRelHumSup.port_a)
    annotation (Line(points={{176,0},{180,0}}, color={0,127,255}));
  connect(senRelHumSup.port_b, senTSup.port_a)
    annotation (Line(points={{192,0},{198,0}}, color={0,127,255}));
  connect(senTRet.port_b, senRelHumSup1.port_a)
    annotation (Line(points={{140,80},{130,80}}, color={0,127,255}));
  connect(port_a2, flapRet.port_a)
    annotation (Line(points={{220,80},{200,80}}, color={0,127,255}));
  connect(flapRet.port_b, senTRet.port_a)
    annotation (Line(points={{180,80},{160,80}}, color={0,127,255}));
  connect(senRelHumSup1.port_b, fanRet.port_a)
    annotation (Line(points={{118,80},{100,80}}, color={0,127,255}));
  connect(fanRet.dp_in, genericAHUBus.dpFanRetSet) annotation (Line(points={{90,92},
          {90,120.09},{0.09,120.09}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(fanRet.dp_actual, genericAHUBus.dpFanRetMea) annotation (Line(points={{79,85},
          {72,85},{72,120.09},{0.09,120.09}},         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(fanRet.P, genericAHUBus.powerFanRetMea) annotation (Line(points={{79,89},
          {79,120.09},{0.09,120.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(fanSup.dp_in, genericAHUBus.dpFanSupSet) annotation (Line(points={{166,12},
          {166,52},{234,52},{234,120},{118,120},{118,120.09},{0.09,120.09}},
                                                             color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(fanSup.P, genericAHUBus.powerFanSupMea) annotation (Line(points={{177,9},
          {177,30},{178,30},{178,52},{234,52},{234,120},{0.09,120},{0.09,120.09}},
                                                                    color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(fanSup.dp_actual, genericAHUBus.dpFanSupMea) annotation (Line(points={{177,5},
          {180,5},{180,52},{234,52},{234,120},{118,120},{118,120.09},{0.09,
          120.09}},                                                      color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senRelHumSup1.phi, genericAHUBus.relHumRetMea) annotation (Line(
        points={{123.94,86.6},{123.94,102},{124,102},{124,120},{0.09,120},{0.09,
          120.09}},                                                   color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senRelHumSup.phi, genericAHUBus.relHumSupMea) annotation (Line(points={{186.06,
          6.6},{186.06,30},{186,30},{186,52},{234,52},{234,120},{0.09,120},{
          0.09,120.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(humidifierRet.u, genericAHUBus.adiabHumSet) annotation (Line(points={{61,86},
          {62,86},{62,120.09},{0.09,120.09}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(humidifier.u, genericAHUBus.steamHumSet) annotation (Line(points={{129,6},
          {128,6},{128,52},{234,52},{234,120},{118,120},{118,120.09},{0.09,
          120.09}},                                                 color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(humidifier.powerEva, genericAHUBus.powerSteamHumMea) annotation (Line(
        points={{151,10},{156,10},{156,52},{234,52},{234,120},{0.09,120},{0.09,
          120.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(flapRet.y, genericAHUBus.flapRetSet) annotation (Line(points={{190,92},
          {190,120.09},{0.09,120.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(flapRet.y_actual, genericAHUBus.flapRetMea) annotation (Line(points={{185,87},
          {185,108},{184,108},{184,120},{92,120},{92,120.09},{0.09,120.09}},
                                                                   color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(flapSup.y, genericAHUBus.flapSupSet) annotation (Line(points={{-180,12},
          {-180,52},{-242,52},{-242,120.09},{0.09,120.09}},           color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(flapSup.y_actual, genericAHUBus.flapSupMea) annotation (Line(points={{-175,7},
          {-175,52},{-242,52},{-242,120},{0.09,120},{0.09,120.09}},       color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(dampBypass.y, genericAHUBus.bypassHrsSet) annotation (Line(points={{-80,-32},
          {-80,-114},{-242,-114},{-242,120},{-120,120},{-120,120.09},{0.09,
          120.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dampBypass.y_actual, genericAHUBus.bypassHrsMea) annotation (Line(
        points={{-75,-27},{-75,-114},{-242,-114},{-242,120.09},{0.09,120.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senVolFlo.V_flow, genericAHUBus.V_flow_RetAirMea) annotation (Line(
        points={{-110,91},{-110,120.09},{0.09,120.09}},           color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(preheater.registerBus, genericAHUBus.preheaterBus) annotation (Line(
      points={{-153.78,-13.9231},{-172,-13.9231},{-172,-14},{-242,-14},{-242,
          120},{-118,120},{-118,120.09},{0.09,120.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cooler.registerBus, genericAHUBus.coolerBus) annotation (Line(
      points={{2.22,-13.9231},{-16,-13.9231},{-16,-120},{234,-120},{234,120.09},
          {0.09,120.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heater.registerBus, genericAHUBus.heaterBus) annotation (Line(
      points={{76.22,-13.9231},{68,-13.9231},{68,-120},{234,-120},{234,120},{
          0.09,120},{0.09,120.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(fanRet.port_b, passThroughHumidiferRet.port_a) annotation (Line(
      points={{80,80},{74,80},{74,40},{60,40}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(passThroughHumidiferRet.port_b, dynamicHX.port_a1) annotation (Line(
      points={{40,40},{0,40},{0,40.4},{-20,40.4}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(heater.port_b1, passThroughHumidifer.port_a) annotation (Line(
      points={{120,0.153846},{122,0.153846},{122,0},{126,0},{126,-28},{132,-28}},
      color={0,127,255},
      pattern=LinePattern.Dash));

  connect(passThroughHumidifer.port_b, fanSup.port_a) annotation (Line(
      points={{152,-28},{156,-28},{156,0}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(flapSup.port_b, passThroughPreheater.port_a) annotation (Line(
      points={{-170,0},{-168,0},{-168,40},{-140,40}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(passThroughPreheater.port_b, dampHX.port_a) annotation (Line(
      points={{-120,40},{-106,40},{-106,0},{-90,0}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(senTSup.T, PT1_airIn.u)
    annotation (Line(points={{206,8.8},{206,15.2}},
                                                  color={0,0,127}));
  connect(PT1_airIn.y, genericAHUBus.TSupAirMea) annotation (Line(points={{206,
          24.4},{206,52},{234,52},{234,120},{116,120},{116,120.09},{0.09,120.09}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senTOda.T, PT1_airIn1.u) annotation (Line(points={{-204,11},{-204,
          21.2},{-206,21.2}}, color={0,0,127}));
  connect(PT1_airIn1.y, genericAHUBus.TOutsAirMea) annotation (Line(points={{-206,
          30.4},{-206,52},{-242,52},{-242,120},{0.09,120},{0.09,120.09}},
                                                                       color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTExh.T, PT1_airIn2.u) annotation (Line(points={{-150,91},{-150,
          101.2}},               color={0,0,127}));
  connect(PT1_airIn2.y, genericAHUBus.TExhAirMea) annotation (Line(points={{-150,
          110.4},{-150,120.09},{0.09,120.09}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTRet.T, PT1_airIn3.u) annotation (Line(points={{150,91},{150,97.2}},
                             color={0,0,127}));
  connect(PT1_airIn3.y, genericAHUBus.TRetAirMea) annotation (Line(points={{150,
          106.4},{150,120.09},{0.09,120.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},
            {220,120}}),       graphics={
        Rectangle(
          extent={{-220,120},{220,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-210,0},{-166,0},{-90,0}},  color={28,108,200}),
        Rectangle(visible=usePreheater, extent={{-164,38},{-116,-40}}, lineColor=
              {0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-4,38},{44,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{74,38},{122,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{-90,100},{-30,-40}}, lineColor={0,0,0}),
        Line(visible=usePreheater,points={{-164,-40},{-116,38}}, color={0,0,0}),
        Line(points={{-4,-40},{44,38}}, color={0,0,0}),
        Line(points={{74,-40},{122,38}}, color={0,0,0}),
        Line(points={{-4,36},{44,-40}}, color={0,0,0}),
        Line(points={{-90,-34},{-36,100}}, color={0,0,0}),
        Line(points={{-84,-40},{-30,94}}, color={0,0,0}),
        Line(points={{-90,100},{-30,-40}},color={0,0,0}),
        Line(points={{122,0},{166,0}}, color={28,108,200}),
        Line(points={{144,80},{-30,80}},color={28,108,200}),
        Ellipse(extent={{202,-18},{166,18}}, lineColor={0,0,0}),
        Line(points={{176,16},{200,8}}, color={0,0,0}),
        Line(points={{200,-8},{176,-16}}, color={0,0,0}),
        Ellipse(
          extent={{18,-18},{-18,18}},
          lineColor={0,0,0},
          origin={162,80},
          rotation=180),
        Line(
          points={{-12,4},{12,-4}},
          color={0,0,0},
          origin={158,68},
          rotation=180),
        Line(
          points={{12,4},{-12,-4}},
          color={0,0,0},
          origin={158,92},
          rotation=180),
        Line(points={{212,80},{180,80}}, color={28,108,200}),
        Rectangle(visible=useHumidifier, extent={{138,38},{160,-40}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(visible=useHumidifier, points={{146,24},{152,28}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,24},{146,24}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,20},{146,24}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{146,0},{152,4}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,0},{146,0}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,-4},{146,0}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{146,-20},{152,-16}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,-20},{146,-20}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,-24},{146,-20}}, color={0,0,0}),
        Rectangle(visible=useHumidifierRet, extent={{0,100},{20,58}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(visible=useHumidifierRet, points={{8,86},{14,90}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{14,90},{8,90}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{14,90},{8,94}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{8,66},{14,70}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{14,70},{8,70}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{14,70},{8,74}}, color={0,0,0}),
        Line(points={{0,78}}, color={28,108,200}),
        Line(points={{-90,80},{-210,80}}, color={28,108,200}),
        Line(points={{-30,0},{-4,0}}, color={28,108,200}),
        Line(points={{44,0},{74,0}}, color={28,108,200}),
        Line(points={{202,0},{218,0}}, color={28,108,200}),
        Line(visible=usePreheater, points={{-160,-40},{-160,-90}}, color={28,108,200}),
        Line(visible=usePreheater, points={{-120,-40},{-120,-90}}, color={28,108,200}),
        Line(points={{0,-40},{0,-90}}, color={28,108,200}),
        Line(points={{40,-40},{40,-90}}, color={28,108,200}),
        Line(points={{80,-40},{80,-90}}, color={28,108,200}),
        Line(points={{118,-40},{118,-90}}, color={28,108,200})}),Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},{220,120}})),
    Documentation(revisions="<html>
<ul>
<li>October 29, 2019, by Alexander K&uuml;mpel:<br/>First implementation</li>
</ul>
</html>", info="<html>
<p>The GenericAHU is a air-handling unit model with detailed hydraulic system of the preheater, heater and cooler. The ahu includes a heat exchanger for heat recovery and a humidifier for the supply air. The humidifier can be insert steam or water that evaporates completely (adiabatic). Further, the ahu includes an adiabatic humidifier in the return air chanal in order to cool the return air and use the heat recovery heat excahnger to cool the supply air. The preheater, steam humdifier and adiabatic humidifier are conditional and can be deactivated.</p>
</html>"));
end GenericAHU;
