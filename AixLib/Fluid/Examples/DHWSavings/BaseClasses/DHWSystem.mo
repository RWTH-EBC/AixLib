within AixLib.Fluid.Examples.DHWSavings.BaseClasses;
model DHWSystem
  "Model for just a DHW system, including control etc."
  import DHWSavings;
  extends BESMod.Systems.BaseClasses.PartialFluidSubsystem(T_start=
        TSetDHW_nominal,                                   redeclare package
      Medium = IBPSA.Media.Water);
  parameter Real factorInsWall = 1 "Insulation factor for wall pipe";
  parameter Real factorInsAir = 1 "Insulation factor for pipe in basement connected to air";
  parameter Modelica.Units.SI.TemperatureDifference dTHysDHW=5;
  parameter Modelica.Units.SI.Length lengthPipeAir=2 "Pipe length";
  parameter Modelica.Units.SI.Length lengthPipeWall=20
                                                    "Pipe length";
  parameter Modelica.Units.SI.Temperature TAmbWall=288.15 "Wall temperatures";
  parameter Modelica.Units.SI.Temperature TAmbAir=288.15 "Wall temperatures";
  parameter Modelica.Units.SI.MassFlowRate mDHW_flow_nominal;
  parameter Modelica.Units.SI.Volume VolDHWDay;
  parameter Modelica.Units.SI.Temperature TSetDHW_nominal=323.15
    "Nominal DHW temperature";
  parameter Modelica.Units.SI.Temperature TDHWWaterCold=283.15
    "Nominal DHW temperature of cold city water";
  parameter Modelica.Units.SI.HeatFlowRate QDHW_flow_nominal=1000
    "Nominal heat flow rate to DHW";
  parameter Modelica.Units.SI.HeatFlowRate QBui_flow_nominal=10000
    "Nominal heat flow rate to Building";
  parameter Modelica.Units.SI.MassFlowRate mBoi_flow_nominal=(
      QDHW_flow_nominal + QBui_flow_nominal)/(10*4184)
                                  "Nominal mass flow rate" annotation (Dialog(
        group="Design - Bottom Up: Parameters are defined by the subsystem"));
  parameter Modelica.Units.SI.PressureDifference dpDHW_nominal(displayUnit="Pa")=
     100
    "Nominal pressure difference at m_flow_nominal" annotation (Dialog(group=
          "Design - Bottom Up: Parameters are defined by the subsystem"));
  parameter Real etaTempBased[:,2]=[293.15,1.09; 303.15,1.08; 313.15,1.05; 323.15,
      1.; 373.15,0.99] "Table matrix for temperature based efficiency";
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperatureAir(final T=
        TAmbAir)                                                                                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,-128})));
  Modelica.Blocks.Sources.RealExpression T_stoDHWBot(final y(
      unit="K",
      displayUnit="degC") = storageDHW.layer[1].T)
    annotation (Placement(transformation(
        extent={{-19,-10},{19,10}},
        rotation=0,
        origin={219,190})));
  Modelica.Blocks.Sources.RealExpression T_stoDHWTop(final y(
      unit="K",
      displayUnit="degC") = storageDHW.layer[dhwParameters.nLayer].T)
                                 annotation (Placement(transformation(
        extent={{-19,-11},{19,11}},
        rotation=0,
        origin={219,211})));
  BoundaryConditions.DomesticHotWater.DHW dHW(
    redeclare package Medium = Medium,
    redeclare AixLib.BoundaryConditions.DomesticHotWater.DHWDesignParameters
      parameters(
      final mDHW_flow_nominal=mDHW_flow_nominal,
      final QDHW_flow_nominal=QDHW_flow_nominal,
      final TDHW_nominal=TSetDHW_nominal,
      final TDHWCold_nominal=TDHWWaterCold,
      final VDHWDay=VolDHWDay),
    DHWProfile=DHWProfile,
    dpFixed_nominal=genericPipeAirFlow.plugFlowPipe.res.dp_nominal +
        genericPipeWallFlow.plugFlowPipe.res.dp_nominal,
    redeclare BESMod.Systems.RecordsCollection.Movers.DefaultMover pumpData,
    redeclare AixLib.BoundaryConditions.DomesticHotWater.TappingProfiles.calcmFlowEquDynamic
      calcmFlow)
    annotation (Placement(transformation(extent={{188,-100},{292,-8}})));
  BoundaryConditions.DomesticHotWater.AntiLegionellaControl TSet_DHW(
    T_DHW=TSetDHW_nominal,
    triggerEvery(displayUnit="d") = 259200,
    aux_for_desinfection=true)
    annotation (Placement(transformation(extent={{-260,198},{-240,220}})));
  Modelica.Blocks.Logical.OnOffController boilerOnOffDHW(bandwidth=dTHysDHW,
      pre_y_start=true)
    "Generates the on/off signal depending on the temperature inputs"
    annotation (Placement(transformation(extent={{-206,148},{-188,166}})));
  AixLib.Fluid.BoilerCHP.BoilerNoControl boilerNoControl(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=mBoi_flow_nominal,
    final m_flow_small=1E-4*abs(mBoi_flow_nominal),
    final show_T=show_T,
    final tau=temperatureSensorData.tau,
    final initType=temperatureSensorData.initType,
    final transferHeat=temperatureSensorData.transferHeat,
    final TAmb=TAmbAir,
    final tauHeaTra=temperatureSensorData.tauHeaTra,
    final rho_default=rho,
    final p_start=p_start,
    final T_start=T_start,
    paramBoiler=AixLib.DataBase.Boiler.General.Boiler_Vitogas200F_15kW(),
    etaTempBased=etaTempBased)
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=90,
        origin={-190,-52})));
  AixLib.Fluid.Movers.SpeedControlled_y pump(
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final allowFlowReversal=allowFlowReversal,
    final show_T=show_T,
    redeclare
      BESMod.Systems.RecordsCollection.Movers.AutomaticConfigurationData per(
      final speed_rpm_nominal=pumpData.speed_rpm_nominal,
      final m_flow_nominal=mBoi_flow_nominal,
      final dp_nominal=(boilerNoControl.dp_nominal + sum(storageDHW.heatingCoil1.pipe.res.dp_nominal)),
      final rho=rho,
      final V_flowCurve=pumpData.V_flowCurve,
      final dpCurve=pumpData.dpCurve),
    final inputType=AixLib.Fluid.Types.InputType.Continuous,
    final addPowerToMedium=pumpData.addPowerToMedium,
    final tau=pumpData.tau,
    final use_inputFilter=pumpData.use_inputFilter,
    final riseTime=pumpData.riseTimeInpFilter,
    final init=Modelica.Blocks.Types.Init.InitialOutput,
    final y_start=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-130,-70})));
  AixLib.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium,
    p=p_start,
    T=T_start,
    nPorts=1)                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-110,-30})));
  BESMod.Systems.RecordsCollection.TemperatureSensors.DefaultSensor
    temperatureSensorData
    annotation (                         Placement(transformation(extent={{-254,
            -84},{-234,-64}})));
  BESMod.Systems.RecordsCollection.Movers.DefaultMover
    pumpData annotation (                         Placement(transformation(extent={{-118,
            -90},{-104,-78}})));
  AixLib.Fluid.Storage.BufferStorage storageDHW(
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final p_start=p_start,
    final mSenFac=1,
    redeclare final package MediumHC1 = Medium,
    redeclare final package MediumHC2 = Medium,
    final m1_flow_nominal=mDHW_flow_nominal,
    final m2_flow_nominal=mDHW_flow_nominal,
    final mHC1_flow_nominal=dhwParameters.mHC1_flow_nominal,
    final mHC2_flow_nominal=dhwParameters.mHC2_flow_nominal,
    final useHeatingCoil1=true,
    final useHeatingCoil2=false,
    final useHeatingRod=false,
    final TStart=T_start,
    redeclare final
      BESMod.Systems.Hydraulical.Distribution.RecordsCollection.BufferStorage.bufferData
      data(
      final hTank=dhwParameters.h,
      hHC1Low=0,
      hHR=dhwParameters.nLayerHR/dhwParameters.nLayer*dhwParameters.h,
      final dTank=dhwParameters.d,
      final sWall=dhwParameters.sIns/2,
      final sIns=dhwParameters.sIns/2,
      final lambdaWall=dhwParameters.lambda_ins,
      final lambdaIns=dhwParameters.lambda_ins,
      final rhoIns(displayUnit="g/cm3") = 373,
      final cIns=1000,
      pipeHC1=dhwParameters.pipeHC1,
      pipeHC2=dhwParameters.pipeHC2,
      lengthHC1=dhwParameters.lengthHC1,
      lengthHC2=dhwParameters.lengthHC2),
    final n=dhwParameters.nLayer,
    final hConIn=dhwParameters.hConIn,
    final hConOut=dhwParameters.hConOut,
    final hConHC1=dhwParameters.hConHC1,
    final hConHC2=dhwParameters.hConHC2,
    final upToDownHC1=true,
    final upToDownHC2=true,
    final TStartWall=T_start,
    final TStartIns=T_start,
    nLowerPortDemand=dhwParameters.nLayer - 1,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferBuoyancyWetter,
    final allowFlowReversal_layers=allowFlowReversal,
    final allowFlowReversal_HC1=allowFlowReversal,
    final allowFlowReversal_HC2=allowFlowReversal)
    annotation (Placement(transformation(extent={{-74,-52},{-52,-24}})));
  AixLib.Fluid.Movers.SpeedControlled_y pumpCircular(
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final allowFlowReversal=allowFlowReversal,
    final show_T=show_T,
    redeclare
      BESMod.Systems.RecordsCollection.Movers.AutomaticConfigurationData per(
      final speed_rpm_nominal=pumpData.speed_rpm_nominal,
      final m_flow_nominal=mDHW_flow_nominal,
      final dp_nominal=dpDHW_nominal + genericPipeAirFlow.plugFlowPipe.res.dp_nominal + genericPipeWallFlow.plugFlowPipe.res.dp_nominal + genericPipeAirReturn.plugFlowPipe.res.dp_nominal + genericPipeWallFlow.plugFlowPipe.res.dp_nominal,
      final rho=rho,
      final V_flowCurve=pumpData.V_flowCurve,
      final dpCurve=pumpData.dpCurve),
    final inputType=AixLib.Fluid.Types.InputType.Continuous,
    final addPowerToMedium=pumpData.addPowerToMedium,
    final tau=pumpData.tau,
    final use_inputFilter=pumpData.use_inputFilter,
    final riseTime=pumpData.riseTimeInpFilter,
    final init=Modelica.Blocks.Types.Init.InitialOutput,
    final y_start=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-26,-20})));
  AixLib.Fluid.FixedResistances.GenericPipe genericPipeAirFlow(
    redeclare package Medium = Medium,
    pipeModel="PlugFlowPipe",
    parameterPipe=AixLib.Fluid.Examples.DHWSavings.DataBase.HotWaterPipeDN13(),
    length=lengthPipeAir/2,
    parameterIso=AixLib.DataBase.Pipes.Insulation.Iso25pc(factor=factorInsAir),
    hCon=4,
    m_flow_nominal=mDHW_flow_nominal,
    T_start=T_start)
    annotation (Placement(transformation(extent={{16,-8},{56,-46}})));

  AixLib.Fluid.FixedResistances.GenericPipe genericPipeAirReturn(
    redeclare package Medium = Medium,
    pipeModel="PlugFlowPipe",
    parameterPipe=AixLib.Fluid.Examples.DHWSavings.DataBase.HotWaterPipeDN13(),
    length=lengthPipeAir/2,
    parameterIso=AixLib.DataBase.Pipes.Insulation.Iso25pc(factor=factorInsAir),
    hCon=4,
    m_flow_nominal=mDHW_flow_nominal,
    T_start=T_start)
    annotation (Placement(transformation(extent={{32,-122},{-8,-160}})));

  AixLib.Fluid.FixedResistances.GenericPipe genericPipeWallReturn(
    redeclare package Medium = Medium,
    pipeModel="PlugFlowPipe",
    parameterPipe=AixLib.Fluid.Examples.DHWSavings.DataBase.HotWaterPipeDN13(),
    length=lengthPipeWall/2,
    parameterIso=AixLib.DataBase.Pipes.Insulation.Iso25pc(factor=
        factorInsWall),
    hCon=4,
    m_flow_nominal=mDHW_flow_nominal,
    T_start=T_start)
    annotation (Placement(transformation(extent={{102,-160},{62,-122}})));

  AixLib.Fluid.FixedResistances.GenericPipe genericPipeWallFlow(
    redeclare package Medium = Medium,
    pipeModel="PlugFlowPipe",
    parameterPipe=AixLib.Fluid.Examples.DHWSavings.DataBase.HotWaterPipeDN13(),
    length=lengthPipeWall/2,
    parameterIso=AixLib.DataBase.Pipes.Insulation.Iso25pc(factor=
        factorInsWall),
    hCon=4,
    m_flow_nominal=mDHW_flow_nominal,
    T_start=T_start)
    annotation (Placement(transformation(extent={{80,-8},{120,-46}})));

  BESMod.Systems.Hydraulical.Distribution.RecordsCollection.BufferStorage.DefaultDetailedStorage
    dhwParameters(
    final rho=rho,
    final c_p=cp,
    final TAmb=TAmbAir,
    final use_HC1=storageDHW.useHeatingCoil1,
    final QHC1_flow_nominal=QDHW_flow_nominal + QBui_flow_nominal,
    final V=VolDHWDay,
    final Q_flow_nominal=QDHW_flow_nominal,
    final VPerQ_flow=0,
    T_m=TSetDHW_nominal,
    final mHC1_flow_nominal=mBoi_flow_nominal,
    redeclare final AixLib.DataBase.Pipes.Copper.Copper_12x1 pipeHC1,
    use_QLos=true,
    QLosPerDay=QLosPerDay,
    final use_HC2=storageDHW.useHeatingCoil2,
    final dTLoadingHC2=9999999,
    final fHeiHC2=1,
    final fDiaHC2=1,
    final QHC2_flow_nominal=9999999,
    final mHC2_flow_nominal=9999999,
    redeclare final AixLib.DataBase.Pipes.Copper.Copper_10x0_6 pipeHC2)
    annotation (Placement(transformation(extent={{-64,8},{-50,22}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperatureWall(final T=
        TAmbWall)                                                                                                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={66,-74})));

  Modelica.Blocks.Interfaces.RealInput circulatorPump
    "Constant normalized rotational speed"
    annotation (Placement(transformation(extent={{-380,-126},{-340,-86}})));
  Modelica.Blocks.Math.BooleanToReal hp_on_to_n_hp
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,210})));
  Modelica.Blocks.Interfaces.RealInput TSetDHW
    "Connector of first Real input signal"
    annotation (Placement(transformation(extent={{-380,86},{-340,126}})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-278,-42})));
  Modelica.Blocks.Logical.Or              boilerOnOffDHW1
    "Generates the on/off signal depending on the temperature inputs"
    annotation (Placement(transformation(extent={{-160,200},{-140,220}})));
  AixLib.Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium,
    p=p_start,
    T=T_start,
    nPorts=1)                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-6})));
  BESMod.Systems.Interfaces.SystemOutputs outBusGen
    annotation (Placement(transformation(extent={{356,-12},{376,8}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCirMin(
    final transferHeat=false,
    redeclare final package Medium = Medium,
    final m_flow_nominal=0.1) "Temperature of DHW" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-56,-80})));
  parameter Real QLosPerDay=1 "Heat loss per day. MUST BE IN kWh/d";
  Modelica.Blocks.Logical.Switch setOrLegionellaPump
    "Generates the on/off signal depending on the temperature inputs"
    annotation (Placement(transformation(extent={{-244,-114},{-216,-142}})));
  Modelica.Blocks.Sources.Constant       pumpAlwaysOn(k=1)     annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-275,-163})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperatureSto(final T=
        TAmbAir) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,-170})));
  parameter AixLib.DataBase.DomesticHotWater.PartialDHWTap DHWProfile;
  Modelica.Blocks.Continuous.Integrator integratorQBoi(
    use_reset=false,
    y_start=Modelica.Constants.eps,
    y(unit="J")) if calc_integral
    annotation (Placement(transformation(extent={{300,200},{320,220}})));
  Modelica.Blocks.Continuous.Integrator integratorPBoi(
    use_reset=false,
    y_start=Modelica.Constants.eps,
    y(unit="J")) if calc_integral
    annotation (Placement(transformation(extent={{300,180},{320,200}})));
  Modelica.Blocks.Continuous.Integrator integratorPipeWall(
    use_reset=false,
    y_start=Modelica.Constants.eps,
    y(unit="J"),
    u=fixedTemperatureWall.port.Q_flow) if calc_integral
    annotation (Placement(transformation(extent={{300,160},{320,180}})));
  Modelica.Blocks.Continuous.Integrator integratorPipeAir(
    use_reset=false,
    y_start=Modelica.Constants.eps,
    y(unit="J"),
    u=fixedTemperatureAir.port.Q_flow) if calc_integral
    annotation (Placement(transformation(extent={{300,140},{320,160}})));
  Modelica.Blocks.Continuous.Integrator integratorSto(
    use_reset=false,
    y_start=Modelica.Constants.eps,
    y(unit="J"),
    u=fixedTemperatureSto.port.Q_flow) if calc_integral
    annotation (Placement(transformation(extent={{300,120},{320,140}})));
  Modelica.Blocks.Continuous.Integrator integratorSto1(
    use_reset=false,
    y_start=Modelica.Constants.eps,
    y(unit="J"),
    u=dHW.calcmFlow.Q_flowERROR) if calc_integral
    annotation (Placement(transformation(extent={{300,100},{320,120}})));
equation
  connect(T_stoDHWTop.y, boilerOnOffDHW.u) annotation (Line(points={{239.9,211},
          {239.9,208},{284,208},{284,148},{-180,148},{-180,140},{-207.8,140},{
          -207.8,151.6}},                         color={0,0,127}));
  connect(TSet_DHW.TSet_DHW, boilerOnOffDHW.reference) annotation (Line(points={{-239,
          209},{-220,209},{-220,162.4},{-207.8,162.4}},       color={0,0,127}));
  connect(pump.port_a, bou1.ports[1]) annotation (Line(points={{-120,-70},{-120,
          -68},{-110,-68},{-110,-40}}, color={0,127,255}));
  connect(pump.port_b, boilerNoControl.port_a) annotation (Line(points={{-140,
          -70},{-160,-70},{-160,-80},{-190,-80},{-190,-68}},
                                  color={0,127,255}));
  connect(boilerNoControl.port_b, storageDHW.portHC1In) annotation (Line(points=
         {{-190,-36},{-190,-16},{-82,-16},{-82,-30},{-74.275,-30},{-74.275,-30.02}},
        color={0,127,255}));
  connect(storageDHW.portHC1Out, pump.port_a) annotation (Line(points={{
          -74.1375,-34.36},{-76,-34.36},{-76,-58},{-106,-58},{-106,-68},{-120,
          -68},{-120,-70}},                                      color={0,127,255}));
  connect(storageDHW.fluidportTop2, pumpCircular.port_a) annotation (Line(
        points={{-59.5625,-23.86},{-59.5625,-20},{-36,-20}}, color={0,127,255}));
  connect(fixedTemperatureAir.port, genericPipeAirReturn.heatPort) annotation (
      Line(points={{-78,-128},{-40,-128},{-40,-172},{12,-172},{12,-160}}, color=
         {191,0,0}));
  connect(pumpCircular.port_b, genericPipeAirFlow.port_a) annotation (Line(
        points={{-16,-20},{4,-20},{4,-26},{16,-26},{16,-27}}, color={0,127,255}));
  connect(genericPipeAirFlow.port_b, genericPipeWallFlow.port_a)
    annotation (Line(points={{56,-27},{80,-27}}, color={0,127,255}));
  connect(genericPipeAirReturn.port_a, genericPipeWallReturn.port_b)
    annotation (Line(points={{32,-141},{62,-141}}, color={0,127,255}));
  connect(fixedTemperatureAir.port, genericPipeAirFlow.heatPort) annotation (
      Line(points={{-78,-128},{-40,-128},{-40,-108},{36,-108},{36,-46}}, color={
          191,0,0}));
  connect(genericPipeWallReturn.heatPort,fixedTemperatureWall. port)
    annotation (Line(points={{82,-122},{80,-122},{80,-92},{92,-92},{92,-74},{76,
          -74}}, color={191,0,0}));
  connect(fixedTemperatureWall.port, genericPipeWallFlow.heatPort)
    annotation (Line(points={{76,-74},{100,-74},{100,-46}}, color={191,0,0}));
  connect(dHW.port_b, storageDHW.fluidportBottom1) annotation (Line(points={{188,
          -81.6},{176,-81.6},{176,-82},{134,-82},{134,-184},{-66.7125,-184},{-66.7125,
          -52.28}}, color={0,127,255}));
  connect(genericPipeWallFlow.port_b, genericPipeWallReturn.port_a) annotation (
     Line(points={{120,-27},{128,-27},{128,-141},{102,-141}}, color={0,127,255}));
  connect(hp_on_to_n_hp.y, pump.y) annotation (Line(points={{-99,210},{12,210},
          {12,36},{4,36},{4,32},{-64,32},{-64,28},{-130,28},{-130,-58}},
                                     color={0,0,127}));
  connect(TSet_DHW.TSetDHW, TSetDHW) annotation (Line(points={{-262.2,216.7},{
          -328,216.7},{-328,106},{-360,106}},
                            color={0,0,127}));
  connect(fixedDelay.y, boilerNoControl.u_rel) annotation (Line(points={{-267,-42},
          {-224,-42},{-224,-56},{-216,-56},{-216,-63.2},{-201.2,-63.2}}, color={
          0,0,127}));
  connect(fixedDelay.u, hp_on_to_n_hp.y) annotation (Line(points={{-290,-42},{
          -300,-42},{-300,24},{-128,24},{-128,28},{-64,28},{-64,32},{4,32},{4,
          36},{12,36},{12,210},{-99,210}},
                                   color={0,0,127}));
  connect(TSet_DHW.y, boilerOnOffDHW1.u1) annotation (Line(points={{-239,202.62},
          {-228,202.62},{-228,188},{-220,188},{-220,184},{-180,184},{-180,210},
          {-162,210}},                           color={255,0,255}));
  connect(boilerOnOffDHW1.u2, boilerOnOffDHW.y) annotation (Line(points={{-162,
          202},{-162,157},{-187.1,157}},                               color={
          255,0,255}));
  connect(boilerOnOffDHW1.y, hp_on_to_n_hp.u) annotation (Line(points={{-139,
          210},{-122,210}},                    color={255,0,255}));
  connect(pumpCircular.port_a, bou2.ports[1]) annotation (Line(points={{-36,-20},
          {-36,-16},{-70,-16}}, color={0,127,255}));
  connect(dHW.port_a, storageDHW.fluidportTop1) annotation (Line(points={{188,-26.4},
          {188,-26},{154,-26},{154,28},{-66.85,28},{-66.85,-23.86}},
                                                        color={0,127,255}));
  connect(storageDHW.fluidportBottom2, senTCirMin.port_a) annotation (Line(
        points={{-59.8375,-52.14},{-59.8375,-70},{-56,-70}}, color={0,127,255}));
  connect(senTCirMin.port_b, genericPipeAirReturn.port_b) annotation (Line(
        points={{-56,-90},{-56,-132},{-20,-132},{-20,-141},{-8,-141}}, color={0,
          127,255}));
  connect(T_stoDHWTop.y, outBusGen.TStoDHWTop) annotation (Line(points={{239.9,
          211},{239.9,210},{286,210},{286,-2},{366,-2}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_stoDHWBot.y, outBusGen.TStoDHWBot) annotation (Line(points={{239.9,
          190},{286,190},{286,-2},{366,-2}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_stoDHWBot.y, TSet_DHW.TLowest) annotation (Line(points={{239.9,190},
          {239.9,176},{-272,176},{-272,201.3},{-261.8,201.3}},      color={0,0,
          127}));
  connect(circulatorPump, setOrLegionellaPump.u3) annotation (Line(points={{-360,
          -106},{-348,-106},{-348,-108},{-316,-108},{-316,-116.8},{-246.8,-116.8}},
        color={0,0,127}));
  connect(setOrLegionellaPump.y, pumpCircular.y) annotation (Line(points={{-214.6,
          -128},{-198,-128},{-198,-130},{-26,-130},{-26,-32}}, color={0,0,127}));
  connect(TSet_DHW.y, setOrLegionellaPump.u2) annotation (Line(points={{-239,
          202.62},{-228,202.62},{-228,188},{-224,188},{-224,184},{-176,184},{
          -176,108},{-304,108},{-304,-128},{-246.8,-128}},             color={255,
          0,255}));
  connect(pumpAlwaysOn.y, setOrLegionellaPump.u1) annotation (Line(points={{-265.1,
          -163},{-265.1,-156},{-246.8,-156},{-246.8,-139.2}}, color={0,0,127}));
  connect(fixedTemperatureSto.port, storageDHW.heatportOutside) annotation (
      Line(points={{-78,-170},{-52.275,-170},{-52.275,-37.16}}, color={191,0,0}));
  connect(integratorQBoi.y, outBusGen.QBoi) annotation (Line(points={{321,210},{
          321,208},{366,208},{366,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integratorPBoi.y, outBusGen.PBoi) annotation (Line(points={{321,190},{
          366,190},{366,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integratorPipeWall.y, outBusGen.pipeWallLosses) annotation (Line(
        points={{321,170},{366,170},{366,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integratorPipeAir.y, outBusGen.pipeAirLosses) annotation (Line(points=
         {{321,150},{324,150},{324,152},{366,152},{366,-2}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integratorSto.y, outBusGen.StorageLosses) annotation (Line(points={{321,
          130},{366,130},{366,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integratorSto1.y, outBusGen.QDHWError) annotation (Line(points={{321,110},
          {366,110},{366,-2}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,-220},
            {360,220}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-340,-220},{360,220}})),
    experiment(
      StartTime=300,
      StopTime=864000,
      __Dymola_Algorithm="Dassl"));
end DHWSystem;
