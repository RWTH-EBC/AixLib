within AixLib.Systems.EONERC_MainBuilding;
model HeatpumpSystem "Heatpump system of the E.ON ERC main building"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

    parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=10
    "Nominal mass flow rate";
    parameter Modelica.SIunits.Temperature T_start_hot=303.15
    "Initialization temperature hot side" annotation(Dialog(tab = "Initialization"));
    parameter Modelica.SIunits.Temperature T_start_cold=288.15
    "Initialization temperature hot side" annotation(Dialog(tab = "Initialization"));
    parameter Modelica.SIunits.Temperature T_amb=298.15
    "Ambient temperature of technics room";

  HydraulicModules.Pump pump_hot(
    redeclare package Medium = Medium,
    parameterPipe=DataBase.Pipes.Copper.Copper_133x3(),
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start_hot,
    length=3,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    redeclare replaceable
      HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(
        redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per,
        addPowerToMedium=false)),
    T_amb=T_amb,
    pipe3(length=6))
                  annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-60,0})));

  HydraulicModules.Pump pump_cold(
    redeclare package Medium = Medium,
    parameterPipe=DataBase.Pipes.Copper.Copper_108x2_5(),
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start_cold,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    redeclare replaceable
      HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(
        redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per,
        addPowerToMedium=false)),
    length=4,
    pipe3(length=8),
    T_amb=T_amb)  annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={60,0})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=T_amb)
                annotation (Placement(transformation(extent={{88,-4},{96,4}})));
  Fluid.Storage.BufferStorage coldStorage(
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    final m1_flow_nominal=m_flow_nominal,
    final m2_flow_nominal=m_flow_nominal,
    n=4,
    redeclare package Medium = Medium,
    data=DataBase.Storage.Generic_5000l(),
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    upToDownHC1=false,
    upToDownHC2=false,
    useHeatingRod=false,
    TStartWall=T_start_cold,
    TStartIns=T_start_cold,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart=T_start_cold)
    annotation (Placement(transformation(extent={{124,-16},{100,14}})));
  Fluid.Storage.BufferStorage heatStorage(
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    final m1_flow_nominal=m_flow_nominal,
    final m2_flow_nominal=m_flow_nominal,
    n=4,
    redeclare package Medium = Medium,
    data=DataBase.Storage.Generic_4000l(),
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    upToDownHC1=false,
    upToDownHC2=false,
    useHeatingRod=false,
    TStartWall=T_start_hot,
    TStartIns=T_start_hot,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart=T_start_hot)
                   annotation (Placement(transformation(
        extent={{12,-15},{-12,15}},
        rotation=0,
        origin={-166,-1})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=T_amb)
    annotation (Placement(transformation(extent={{-196,-6},{-188,2}})));
  HydraulicModules.Throttle throttle_recool(
    redeclare package Medium = Medium,
    parameterPipe=DataBase.Pipes.Copper.Copper_133x3(),
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start_hot,
    tauHeaTra(displayUnit="h") = 21600,
    length=10,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    Kv=160,
    valve(
      riseTime=240,
      order=1,
      l=0.0000001),
    pipe3(length=20),
    T_amb=T_amb)  annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-60,-100})));
  HydraulicModules.Throttle throttle_HS(
    redeclare package Medium = Medium,
    parameterPipe=DataBase.Pipes.Copper.Copper_133x3(),
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start_hot,
    length=3,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    valve(riseTime=240, order=1),
    pipe3(length=6),
    Kv=100,
    T_amb=T_amb)  annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-120,0})));
  HydraulicModules.Throttle throttle_CS(
    redeclare package Medium = Medium,
    parameterPipe=DataBase.Pipes.Copper.Copper_133x3(),
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start_cold,
    length=2,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    valve(riseTime=240, order=1),
    pipe3(length=4),
    Kv=160,
    T_amb=T_amb)  annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={160,0})));
  HydraulicModules.Throttle throttle_freecool(
    redeclare package Medium = Medium,
    parameterPipe=DataBase.Pipes.Copper.Copper_108x2_5(),
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start_cold,
    length=10,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    valve(riseTime=240, order=1),
    pipe3(length=20),
    Kv=100,
    T_amb=T_amb)  annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={140,-100})));
  Fluid.MixingVolumes.MixingVolume volAirCoolerRecool(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    T_start=T_start_hot - 15,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal,
    V=0.5,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-20,-100})));
  Fluid.MixingVolumes.MixingVolume volAirCoolerFreecool(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    T_start=T_start_cold,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal,
    V=0.4,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={104,-100})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-230,-30},{-210,-10}}),
        iconTransformation(extent={{-230,-50},{-210,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-230,10},{-210,30}}),
        iconTransformation(extent={{-230,-10},{-210,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{210,-30},{230,-10}}),
        iconTransformation(extent={{210,-50},{230,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{210,10},{230,30}}),
        iconTransformation(extent={{210,-10},{230,10}})));
  Fluid.HeatPumps.HeatPump        heatPump(
    refIneFre_constant=0.1,
    scalingFactor=1,
    nthOrder=2,
    useBusConnectorOnly=true,
    VEva=0.1,
    CEva=100,
    GEvaOut=5,
    CCon=100,
    GConOut=5,
    dpEva_nominal=42000,
    dpCon_nominal=44000,
    mFlow_conNominal=m_flow_nominal,
    mFlow_evaNominal=m_flow_nominal,
    VCon=0.176,
    use_conCap=false,
    use_evaCap=false,
    redeclare package Medium_con = Medium,
    redeclare package Medium_eva = Medium,
    use_refIne=true,
    transferHeat=true,
    allowFlowReversalEva=allowFlowReversal,
    allowFlowReversalCon=allowFlowReversal,
    tauHeaTraEva(displayUnit="h") = 43200,
    tauHeaTraCon(displayUnit="h") = 36000,
    TAmbCon_nominal=T_amb,
    TAmbEva_nominal=T_amb,
    TCon_start=T_start_hot,
    TEva_start=T_start_cold,
    massDynamics=energyDynamics,
    energyDynamics=massDynamics,
    redeclare model PerDataMainHP =
        DataBase.HeatPump.PerformanceData.LookUpTable2D (smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
          dataTable=AixLib.DataBase.HeatPump.EN255.Vitocal350AWI114(
            tableQdot_con=[0,12.5,15; 26.5,310000,318000; 44.2,251000,254000],
            tableP_ele=[0,12.5,15; 26.5,51000,51000; 44.2,51000,51000])),
    redeclare model PerDataRevHP =
        DataBase.Chiller.PerformanceData.LookUpTable2D (smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
          dataTable=AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201(
            tableQdot_con=[0,12.5,15; 26.5,310000,318000; 44.2,251000,254000],
            tableP_ele=[0,12.5,15; 26.5,51000,51000; 44.2,51000,51000])))
                       annotation (Placement(transformation(
        extent={{-18,-22},{18,22}},
        rotation=90,
        origin={0,0})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(extent={{0,-118},{20,-98}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,-108})));
  Modelica.Blocks.Sources.Constant const1(k=8340/2)
    annotation (Placement(transformation(extent={{24,-68},{32,-60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b T_outside annotation (
      Placement(transformation(extent={{30,-118},{50,-98}}), iconTransformation(
          extent={{-8,-118},{8,-102}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    annotation (Placement(transformation(extent={{24,-84},{32,-76}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{42,-80},{54,-68}})));
  BaseClasses.HeatPumpSystemBus heatPumpSystemBus annotation (Placement(
        transformation(extent={{-14,46},{14,74}}), iconTransformation(extent={{
            -10,50},{10,70}})));


  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{42,-58},{54,-46}})));
  Modelica.Blocks.Sources.Constant const2(k=1800)
    annotation (Placement(transformation(extent={{24,-50},{32,-42}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-132})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=300, initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{60,-78},{68,-70}})));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state" annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of mass balance: dynamic (3 initialization options) or steady state" annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{50,-126},{58,-118}})));
protected
  Fluid.Sensors.TemperatureTwoPort senT_a2(
    tau(displayUnit="s"),
    T_start=T_start_hot,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-204,-14},{-192,-26}})));
  Modelica.Blocks.Continuous.FirstOrder PT1_a1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start_hot,
    final T(displayUnit="s") = 15)
                 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-198,-36})));
  Fluid.Sensors.TemperatureTwoPort senT_b1(
    tau(displayUnit="s"),
    T_start=T_start_cold,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{200,-6},{212,-18}})));
  Modelica.Blocks.Continuous.FirstOrder PT1_a2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start_cold,
    final T(displayUnit="s") = 15)
                 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={206,-28})));
  Fluid.Sensors.TemperatureTwoPort senT_a1(
    tau(displayUnit="s"),
    T_start=T_start_cold,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{206,6},{194,18}})));
  Modelica.Blocks.Continuous.FirstOrder PT1_a3(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start_cold,
    final T(displayUnit="s") = 15)
                 annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=270,
        origin={200,28})));
  Fluid.Sensors.TemperatureTwoPort senT_b2(
    tau(displayUnit="s"),
    T_start=T_start_hot,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-190,20})));
  Modelica.Blocks.Continuous.FirstOrder PT1_a4(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start_hot,
    final T(displayUnit="s") = 15)
                 annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-190,40})));
protected
  Fluid.Sensors.VolumeFlowRate VFSen_hot(
    redeclare package Medium = Medium,
    T_start=T_start_hot,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    "Inflow into admix module in forward line" annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=180,
        origin={-204,20})));
protected
  Fluid.Sensors.VolumeFlowRate VFSen_cold(
    redeclare package Medium = Medium,
    T_start=T_start_cold,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    "Inflow into admix module in forward line" annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=180,
        origin={214,12})));
equation
  connect(pump_cold.port_a1, coldStorage.fluidportTop2) annotation (Line(
        points={{80,12},{88,12},{88,20},{108,20},{108,14.15},{108.25,14.15}},
        color={0,127,255}));
  connect(pump_cold.port_b2, coldStorage.fluidportBottom2) annotation (Line(
        points={{80,-12},{90,-12},{90,-20},{108,-20},{108,-16},{108.55,-16},{
          108.55,-16.15}}, color={0,127,255}));
  connect(fixedTemperature.port, coldStorage.heatportOutside) annotation (
      Line(points={{96,0},{100.3,0},{100.3,-0.1}}, color={191,0,0}));
  connect(heatStorage.heatportOutside, fixedTemperature1.port) annotation (
      Line(points={{-177.7,-0.1},{-178,-0.1},{-178,-2},{-188,-2}},
                                                                 color={191,0,
          0}));
  connect(throttle_HS.port_a1, pump_hot.port_b2)
    annotation (Line(points={{-100,12},{-80,12}}, color={0,127,255}));
  connect(throttle_HS.port_b2, pump_hot.port_a1)
    annotation (Line(points={{-100,-12},{-80,-12}}, color={0,127,255}));
  connect(throttle_HS.port_a2, heatStorage.fluidportBottom1) annotation (Line(
        points={{-140,-12},{-146,-12},{-146,-20},{-161.95,-20},{-161.95,-16.3}},
        color={0,127,255}));
  connect(throttle_HS.port_b1, heatStorage.fluidportTop1) annotation (Line(
        points={{-140,12},{-140,20},{-162,20},{-162,14.15},{-161.8,14.15}},
        color={0,127,255}));
  connect(throttle_CS.port_a2, coldStorage.fluidportBottom1) annotation (Line(
        points={{140,-12},{134,-12},{134,-20},{116.05,-20},{116.05,-16.3}},
        color={0,127,255}));
  connect(throttle_CS.port_b1, coldStorage.fluidportTop1) annotation (Line(
        points={{140,12},{136,12},{136,20},{116.2,20},{116.2,14.15}}, color={
          0,127,255}));
  connect(throttle_freecool.port_a1, throttle_CS.port_a1) annotation (Line(
        points={{160,-112},{190,-112},{190,12},{180,12}},
                                                        color={0,127,255}));
  connect(throttle_freecool.port_b2, throttle_CS.port_b2) annotation (Line(
        points={{160,-88},{184,-88},{184,-12},{180,-12}}, color={0,127,255}));
  connect(pump_hot.port_b1, heatPump.port_a1) annotation (Line(points={{-40,-12},
          {-26,-12},{-26,-18},{-11,-18}}, color={0,127,255}));
  connect(pump_hot.port_a2, heatPump.port_b1) annotation (Line(points={{-40,12},
          {-25,12},{-25,18},{-11,18}}, color={0,127,255}));
  connect(heatPump.port_b2, pump_cold.port_a2) annotation (Line(points={{11,-18},
          {40,-18},{40,-12}},                   color={0,127,255}));
  connect(heatPump.port_a2, pump_cold.port_b1) annotation (Line(points={{11,18},
          {40,18},{40,12}},         color={0,127,255}));
  connect(volAirCoolerRecool.heatPort, convection.solid)
    annotation (Line(points={{-20,-110},{-14,-110},{-14,-108},{0,-108}},
                                                  color={191,0,0}));
  connect(convection1.solid, volAirCoolerFreecool.heatPort)
    annotation (Line(points={{80,-108},{92,-108},{92,-110},{104,-110}},
                                                  color={191,0,0}));
  connect(throttle_recool.port_a2, volAirCoolerRecool.ports[1]) annotation (
      Line(points={{-40,-88},{-30,-88},{-30,-102}},color={0,127,255}));
  connect(throttle_recool.port_b1, volAirCoolerRecool.ports[2]) annotation (
      Line(points={{-40,-112},{-30,-112},{-30,-98}},
                                                   color={0,127,255}));
  connect(throttle_recool.port_a1, pump_hot.port_b2) annotation (Line(points={{-80,
          -112},{-94,-112},{-94,12},{-80,12}},     color={0,127,255}));
  connect(throttle_recool.port_b2, pump_hot.port_a1) annotation (Line(points={{-80,-88},
          {-86,-88},{-86,-12},{-80,-12}},          color={0,127,255}));
  connect(convection.fluid, T_outside)
    annotation (Line(points={{20,-108},{40,-108}},
                                                 color={191,0,0}));
  connect(throttle_freecool.port_a2, volAirCoolerFreecool.ports[1]) annotation (
     Line(points={{120,-88},{114,-88},{114,-102}},color={0,127,255}));
  connect(throttle_freecool.port_b1, volAirCoolerFreecool.ports[2]) annotation (
     Line(points={{120,-112},{114,-112},{114,-98}},
                                                  color={0,127,255}));
  connect(convection.Gc, convection1.Gc) annotation (Line(points={{10,-98},{10,-90},
          {70,-90},{70,-98}},      color={0,0,127}));
  connect(T_outside, T_outside) annotation (Line(points={{40,-108},{40,-108}},
                     color={191,0,0}));
  connect(throttle_HS.hydraulicBus, heatPumpSystemBus.busThrottleHS)
    annotation (Line(
      points={{-120,20},{-120,60},{0.07,60},{0.07,60.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pump_hot.hydraulicBus, heatPumpSystemBus.busPumpHot) annotation (Line(
      points={{-60,-20},{-62,-20},{-62,60.07},{0.07,60.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pump_cold.hydraulicBus, heatPumpSystemBus.busPumpCold) annotation (
      Line(
      points={{60,20},{60,60},{0.07,60},{0.07,60.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(throttle_CS.hydraulicBus, heatPumpSystemBus.busThrottleCS)
    annotation (Line(
      points={{160,20},{160,60.07},{0.07,60.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(throttle_freecool.hydraulicBus, heatPumpSystemBus.busThrottleFreecool)
    annotation (Line(
      points={{140,-120},{226,-120},{226,60.07},{0.07,60.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(throttle_recool.hydraulicBus, heatPumpSystemBus.busThrottleRecool)
    annotation (Line(
      points={{-60,-120},{-226,-120},{-226,60.07},{0.07,60.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPump.sigBus, heatPumpSystemBus.busHP) annotation (Line(
      points={{7.15,-17.82},{7.15,-16.91},{0.07,-16.91},{0.07,60.07}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.u2, heatPumpSystemBus.AirCoolerOnSet) annotation (Line(points={{40.8,
          -74},{20,-74},{20,60.07},{0.07,60.07}},    color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatStorage.TTop, heatPumpSystemBus.TTopHSMea) annotation (Line(points={{-154,
          12.2},{-150,12.2},{-150,60.07},{0.07,60.07}},       color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatStorage.TBottom, heatPumpSystemBus.TBottomHSMea) annotation (Line(
        points={{-154,-13},{-150,-13},{-150,60},{0.07,60},{0.07,60.07}}, color=
          {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(coldStorage.TTop, heatPumpSystemBus.TTopCSMea) annotation (Line(points={{124,
          12.2},{124,60.07},{0.07,60.07}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(coldStorage.TBottom, heatPumpSystemBus.TBottomCSMea) annotation (Line(
        points={{124,-13},{126,-13},{126,60.07},{0.07,60.07}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const1.y, switch1.u1)
    annotation (Line(points={{32.4,-64},{36,-64},{36,-69.2},{40.8,-69.2}},
                                                   color={0,0,127}));
  connect(zero.y, switch1.u3)
    annotation (Line(points={{32.4,-80},{36,-80},{36,-78.8},{40.8,-78.8}},
                                                   color={0,0,127}));
  connect(switch2.u3, switch1.u3)
    annotation (Line(points={{40.8,-56.8},{40.8,-78.8}}, color={0,0,127}));
  connect(const2.y, switch2.u1) annotation (Line(points={{32.4,-46},{36,-46},{36,
          -47.2},{40.8,-47.2}}, color={0,0,127}));
  connect(switch1.u2, switch2.u2) annotation (Line(points={{40.8,-74},{20,-74},{
          20,-52},{40.8,-52}}, color={255,0,255}));
  connect(senT_a2.T,PT1_a1. u) annotation (Line(points={{-198,-26.6},{-198,
          -31.2}},       color={0,0,127}));
  connect(heatStorage.fluidportBottom2, senT_a2.port_b) annotation (Line(points=
         {{-169.45,-16.15},{-192,-16.15},{-192,-20}}, color={0,127,255}));
  connect(senT_a2.port_a, port_a2)
    annotation (Line(points={{-204,-20},{-220,-20}}, color={0,127,255}));
  connect(senT_b1.T,PT1_a2. u) annotation (Line(points={{206,-18.6},{206,-23.2}},
                         color={0,0,127}));
  connect(throttle_CS.port_b2, senT_b1.port_a)
    annotation (Line(points={{180,-12},{200,-12}}, color={0,127,255}));
  connect(senT_b1.port_b, port_b1) annotation (Line(points={{212,-12},{220,-12},
          {220,-20}}, color={0,127,255}));
  connect(throttle_CS.port_a1, senT_a1.port_b)
    annotation (Line(points={{180,12},{194,12}}, color={0,127,255}));
  connect(senT_a1.T, PT1_a3.u)
    annotation (Line(points={{200,18.6},{200,23.2}}, color={0,0,127}));
  connect(heatStorage.fluidportTop2, senT_b2.port_a) annotation (Line(points={{
          -169.75,14.15},{-169.75,20},{-184,20}}, color={0,127,255}));
  connect(senT_b2.T, PT1_a4.u)
    annotation (Line(points={{-190,26.6},{-190,35.2}}, color={0,0,127}));
  connect(port_b2, VFSen_hot.port_b)
    annotation (Line(points={{-220,20},{-208,20}}, color={0,127,255}));
  connect(senT_b2.port_b, VFSen_hot.port_a)
    annotation (Line(points={{-196,20},{-200,20}}, color={0,127,255}));
  connect(senT_a1.port_a, VFSen_cold.port_b)
    annotation (Line(points={{206,12},{210,12}}, color={0,127,255}));
  connect(VFSen_cold.port_a, port_a1)
    annotation (Line(points={{218,12},{220,12},{220,20}}, color={0,127,255}));
  connect(VFSen_cold.V_flow, heatPumpSystemBus.VFlowColdMea) annotation (Line(
        points={{214,16.4},{214,60},{0.07,60},{0.07,60.07}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(PT1_a3.y, heatPumpSystemBus.TColdInMea) annotation (Line(points={{200,
          32.4},{200,60},{0.07,60},{0.07,60.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(PT1_a2.y, heatPumpSystemBus.TColdOutMea) annotation (Line(points={{
          206,-32.4},{208,-32.4},{208,-36},{234,-36},{234,60.07},{0.07,60.07}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PT1_a4.y, heatPumpSystemBus.THotOutMea) annotation (Line(points={{
          -190,44.4},{-190,60.07},{0.07,60.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(PT1_a1.y, heatPumpSystemBus.THotInMea) annotation (Line(points={{-198,
          -40.4},{-212,-40.4},{-212,-42},{-240,-42},{-240,60.07},{0.07,60.07}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(VFSen_hot.V_flow, heatPumpSystemBus.VFlowHotMea) annotation (Line(
        points={{-204,24.4},{-206,24.4},{-206,60.07},{0.07,60.07}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(temperatureSensor.port, T_outside)
    annotation (Line(points={{40,-122},{40,-108}}, color={191,0,0}));
  connect(temperatureSensor.T, heatPumpSystemBus.TOutsideMea) annotation (Line(
        points={{40,-142},{-92,-142},{-92,-130},{-224,-130},{-224,60.07},{0.07,
          60.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch2.y, heatPumpSystemBus.PelAirCoolerMea) annotation (Line(points=
         {{54.6,-52},{84,-52},{84,60},{0.07,60},{0.07,60.07}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch1.y, firstOrder.u)
    annotation (Line(points={{54.6,-74},{59.2,-74}}, color={0,0,127}));
  connect(firstOrder.y, convection1.Gc)
    annotation (Line(points={{68.4,-74},{70,-74},{70,-98}}, color={0,0,127}));
  connect(temperatureSensor.T, prescribedTemperature.T) annotation (Line(points
        ={{40,-142},{49.2,-142},{49.2,-122}}, color={0,0,127}));
  connect(prescribedTemperature.port, convection1.fluid)
    annotation (Line(points={{58,-122},{60,-122},{60,-108}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -120},{220,60}}), graphics={
        Rectangle(
          extent={{-220,60},{220,-120}},
          lineColor={0,0,0},
          lineThickness=0.5,
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-192,24},{-132,-60}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{100,24},{160,-60}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{20,10},{40,-50}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-40,10},{-20,-50}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-40,10},{40,-50}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-40,-74},{40,-106}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Ellipse(
          extent={{0,-86},{28,-92}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Ellipse(
          extent={{-28,-86},{0,-92}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Ellipse(
          extent={{-4,-78},{4,-88}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-40,-40},{-132,-40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-40,0},{-132,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,0},{-100,-100},{-40,-100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-80,-40},{-80,-80},{-40,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-192,0},{-220,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-192,-40},{-220,-40}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-68,8},{-52,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-52,0},{-60,8}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-52,0},{-60,-8}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{40,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,-40},{100,-40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{160,0},{220,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{160,-40},{220,-40}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{200,0},{200,-100},{40,-100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{180,-40},{180,-80},{40,-80}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{52,8},{68,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{60,28}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,8},{52,0},{60,-8}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-102,-20}},
          color={238,46,47},
          thickness=0.5),
        Polygon(
          points={{-104,-74},{-96,-74},{-104,-88},{-96,-88},{-104,-74}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4,7},{4,7},{-4,-7},{4,-7},{-4,7}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-114,0},
          rotation=90),
        Polygon(
          points={{-4,7},{4,7},{-4,-7},{4,-7},{-4,7}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={76,-100},
          rotation=90),
        Line(
          points={{-22,-110}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-28,-64},{-28,-102}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-10,-64},{-10,-102}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{10,-64},{10,-102}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{28,-64},{28,-102}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Rectangle(
          extent={{-40,10},{-20,-50}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{20,10},{40,-50}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-182,0},{-142,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={28,108,200},
          textString="HS"),
        Text(
          extent={{108,-2},{150,-32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={28,108,200},
          textString="CS"),
        Text(
          extent={{-18,-6},{20,-32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={28,108,200},
          textString="HP"),
        Rectangle(
          extent={{-192,24},{-132,-60}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{100,24},{160,-60}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Polygon(
          points={{-4,7},{4,7},{-4,-7},{4,-7},{-4,7}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={184,0},
          rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-220,-120},{220,60}})));
end HeatpumpSystem;
