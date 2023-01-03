within AixLib.Fluid.Pool;
model IndoorSwimmingPool
  parameter AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam
    "Choose setup for this pool" annotation (choicesAllMatching=true);

  replaceable package WaterMedium = AixLib.Media.Water annotation (choicesAllMatching=true);

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  // Water transfer coefficients according to VDI 2089 Blatt 1
  parameter Real betaNonUse(unit="m/s")=7/3600 "Water transfer coefficient during non opening hours" annotation (Dialog(group="Water transfer coefficients"));
  parameter Real betaCover(unit="m/s")=0.7/3600 "Water transfer coefficient during non opening hours"
                                                                                                     annotation (Dialog(group="Water transfer coefficients"));
  parameter Real betaWavePool(unit="m/s")=50/3600 "Water transfer coefficient during wavePool operation"
                                                                                                        annotation (Dialog(group="Water transfer coefficients"));

  // Parameter and variables for evaporation
  constant Modelica.Units.SI.SpecificHeatCapacity RD=461.52
    "Specific gas constant for steam";                                // Source: Klaus Lucas, Thermodynamik (2008)
  final parameter Modelica.Units.SI.SpecificEnergy h_vapor=
      AixLib.Media.Air.enthalpyOfCondensingGas(poolParam.TPool)
    "Latent heat of evaporating water";
  Modelica.Units.SI.MassFlowRate m_flow_evap(start=0.0)
    "mass flow rate between pool water and air due to evaporation";
  Modelica.Units.SI.Pressure psat_TPool=
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
      poolWat.T) "Saturation pressure at pool temperature";
  Modelica.Units.SI.Pressure psat_TAir=
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
      TAir) "Saturation pressure at air temperature";
  Real phi "Relative humidity";

  // Pump
  parameter Modelica.Units.SI.Pressure pumpHead=170000
    "Expected average flow resistance of water cycle";

  // Pool circulation flow rate
  final parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=
      poolParam.V_flow_nominal*rhoWater_default
      "Nominal circulation mass flow rate to the pool";
  final parameter Modelica.Units.SI.MassFlowRate m_flow_partial=
      poolParam.V_flow_partial*rhoWater_default
    "Partial circulation mass flow rate to pool during non operating hours";
  Modelica.Units.SI.MassFlowRate m_flow_toPool(start=0.0)
     "Actual circulation mass flow rate to the pool";

  // Fresh water and water recycling
  final parameter Modelica.Units.SI.Efficiency eta=if poolParam.use_HRS then
      poolParam.etaHRS else 0;
  Modelica.Units.SI.MassFlowRate m_flow_add(start=0.0)
  "Mass flow of fresh water supplied to pool circulation system";

  // Convection and Radiation at pool water surface
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConvAir=3.5
    "Coefficient of heat transfer between the water surface and the room air";
    // approximated for free and forced convection at velocities between 0,05 to 0,2 m/s  above a plane area
  parameter Real eps = 0.9*0.95
    "Product of expected emission coefficients of water (0.95) and the surrounding wall surfaces (0.95)";

  AixLib.Fluid.MixingVolumes.MixingVolume poolSto(
    redeclare package Medium = WaterMedium,
    energyDynamics=energyDynamics,
    T_start=poolParam.TPool,
    m_flow_nominal=m_flow_nominal,
    V=poolParam.VStorage,
    nPorts=4) "water storage for pool "
    annotation (Placement(transformation(extent={{-38,-56},{-18,-36}})));

  AixLib.Fluid.Sources.Boundary_pT Sinc(
    redeclare package Medium = WaterMedium, nPorts=1)
    annotation (Placement(transformation(extent={{30,-92},{22,-84}})));
  AixLib.Fluid.MixingVolumes.MixingVolume poolWat(
    redeclare package Medium = WaterMedium,
    energyDynamics=energyDynamics,
    T_start=poolParam.TPool,
    m_flow_nominal=m_flow_nominal,
    V=poolParam.VPool,
    nPorts=3) "water volume of pool"
    annotation (Placement(transformation(extent={{14,-10},{-6,10}})));

  Modelica.Blocks.Sources.RealExpression getSetMasFlo(y=m_flow_toPool)
    "set circulating mass flow of pool water"
    annotation (Placement(transformation(extent={{42,-56},{28,-42}})));

  AixLib.Fluid.Movers.BaseClasses.IdealSource setEva(
    redeclare package Medium = WaterMedium,
    m_flow_small=0.00001,
    control_m_flow=true) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={-30,26})));
  Modelica.Blocks.Sources.RealExpression getEva(y=m_flow_evap) annotation (
      Placement(transformation(
        extent={{9,-9},{-9,9}},
        rotation=180,
        origin={-81,41})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness HeatExchanger(
    redeclare package Medium1 = WaterMedium,
    redeclare package Medium2 = WaterMedium,
    m1_flow_nominal=poolParam.m_flow_out*1.5,
    m2_flow_nominal=poolParam.m_flow_out,
    dp1_nominal(displayUnit="bar") = 100000,
    dp2_nominal(displayUnit="bar") = 100000,
    eps=eps)
     annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-33,-73})));
  Modelica.Blocks.Interfaces.RealInput timeOpe
    "Input profile for opening hours (0: closed, 1: open)" annotation (
      Placement(transformation(extent={{-118,-70},{-94,-46}}),
        iconTransformation(extent={{-118,-70},{-94,-46}})));
  Modelica.Blocks.Interfaces.RealInput uRelPer
    "relative number of people related to max. value" annotation (Placement(
        transformation(extent={{-120,-40},{-94,-14}}), iconTransformation(
          extent={{-120,-40},{-94,-14}})));

  Modelica.Blocks.Interfaces.RealInput TAir(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Temperature of the surrounding room air" annotation (
      Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=-90,
        origin={-67,103}),iconTransformation(
        extent={{-15,-15},{15,15}},
        rotation=-90,
        origin={-67,103})));
  Modelica.Blocks.Interfaces.RealInput X_w "Absolute humidty of the room Air"  annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=-90,
        origin={-29,103}), iconTransformation(
        extent={{-15,-15},{15,15}},
        rotation=-90,
        origin={-29,103})));

  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum
    "Calculation of the relative humidity of the room air " annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-59,77})));

  Modelica.Blocks.Sources.RealExpression getAddWat(y=m_flow_add)
    "requried added fresh warter to the pool circulation"
    annotation (Placement(transformation(extent={{-62,-78},{-48,-62}})));

  AixLib.Fluid.Sources.Boundary_pT sincEva(redeclare package Medium =
        WaterMedium, nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-64,26})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        WaterMedium) if not poolParam.use_idealHeater
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{90,-64},{110,-44}}),
        iconTransformation(extent={{90,-64},{110,-44}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        WaterMedium) if not poolParam.use_idealHeater
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{90,-40},{110,-20}}),
        iconTransformation(extent={{90,-40},{110,-20}})));

  .AixLib.Fluid.Pool.BaseClasses.waveMachine waveMachine(
    heightWave=poolParam.heightWave,
    widthWave=poolParam.widthWave,
    timeWavePul_start=poolParam.timeWavePul_start,
    periodeWavePul=poolParam.periodeWavePul,
    widthWavePul=poolParam.widthWavePul)     if poolParam.use_wavePool
    annotation (Placement(transformation(extent={{-92,-94},{-76,-80}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPool
    "Air temperature in zone" annotation (Placement(transformation(extent={{56,86},
            {80,110}}), iconTransformation(extent={{64,94},{84,114}})));

  AixLib.Utilities.Interfaces.RadPort radPool
    "Mean Radiation Temperature of surrounding walls " annotation (Placement(
        transformation(
        extent={{-8,-9},{8,9}},
        rotation=-90,
        origin={39,100}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={30,100})));

  Modelica.Thermal.HeatTransfer.Components.BodyRadiation radWaterSurface(
  final Gr=eps*poolParam.APool)
  "Model to depict the heat flow rate due to radiation between the pool surface an the surrounding walls" annotation (Placement(transformation(
      extent={{-7,-7},{7,7}},
      rotation=90,
      origin={39,73})));

  Modelica.Thermal.HeatTransfer.Components.Convection convWaterSurface
  "Convection at the watersurface" annotation (Placement(transformation(
      extent={{-7,7},{7,-7}},
      rotation=90,
      origin={67,75})));

  Modelica.Blocks.Sources.RealExpression getHeatCoefConv(y=hConvAir*poolParam.APool)
    "Coefficient of heat transfer between water surface and room air" annotation (Placement(transformation(extent={{100,66},
            {82,84}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeatFlowEvapLoss annotation (Placement(transformation(extent={{-4,52},
            {12,68}})));

  Modelica.Blocks.Math.Gain hEva(final k=h_vapor)
    "Calculation of heat flow rate due to evaporation" annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-44,52})));

  Modelica.Blocks.Interfaces.RealOutput m_flow_add_out(
    final quantity="MassFlowRate",
    final unit= "kg/s")
    "Flow rate of added fresh water to the pool and water treatment system"
    annotation (Placement(transformation(extent={{98,-102},{118,-82}}),
        iconTransformation(extent={{98,-102},{118,-82}})));

  AixLib.Fluid.Pool.BaseClasses.HeatTransferConduction heatTraCond(
    AWalInt=poolParam.AWalInt,
    AWalExt=poolParam.AWalExt,
    AFloInt=poolParam.AFloInt,
    AFloExt=poolParam.AFloExt,
    hConWaterHorizontal=poolParam.hConWaterHorizontal,
    hConWaterVertical=poolParam.hConWaterVertical,
    PoolWall=poolParam.PoolWallParam)
    "Model to depict the heat flow rate through the pool walls to the bordering room/soil"
    annotation (Placement(transformation(extent={{64,32},{80,48}})));

  Modelica.Blocks.Math.Gain minusGain(final k=-1) annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-20,60})));

  Modelica.Blocks.Interfaces.RealOutput QEva(
    final quantity="HeatFlowRate",
    final unit="W") "Heat due to evaporation" annotation (Placement(
        transformation(extent={{-92,46},{-122,76}}), iconTransformation(extent={
            {-94,46},{-114,66}})));

   Modelica.Blocks.Interfaces.RealOutput QPool(
     final quantity="HeatFlowRate",
     final unit="W")
     if poolParam.use_idealHeater
   "Heat flow rate to maintain the pool at the set temperature" annotation (
      Placement(transformation(extent={{98,-16},{118,4}}),  iconTransformation(
          extent={{98,-16},{118,4}})));

  Modelica.Blocks.Interfaces.RealInput TSoil(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Temperature of Soil" annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=180,
        origin={105,49}), iconTransformation(
      extent={{-11,-11},{11,11}},
      rotation=180,
      origin={103,47})));

  Modelica.Blocks.Interfaces.RealOutput PPool(
    final quantity="Power",
    final unit="W")
    "Output eletric energy needed for pool operation" annotation (Placement(transformation(extent={{98,-86},
            {118,-66}}),
      iconTransformation(extent={{98,-86},{118,-66}})));

  Modelica.Blocks.Interfaces.RealOutput TPool(
    final quantity="ThermodynamicTemperature",
    final unit="K")
    "current temperature of pool"
    annotation (Placement(transformation(extent={{98,6},{118,26}}),
        iconTransformation(extent={{98,6},{118,26}})));

  Modelica.Blocks.Math.MultiSum elPower(nu=if poolParam.use_wavePool then 2 else 1)
    "Add electric power of pump and the optional wave pool"
    annotation (Placement(transformation(extent={{72,-72},{80,-80}})));
  Sources.MassFlowSource_T bou(
    redeclare package Medium = WaterMedium,
    use_m_flow_in=true,
    T=283.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-52,-94},{-40,-82}})));
  Modelica.Blocks.Sources.RealExpression getMeaTPool(y=poolWat.T) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={72,16})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow idealHeater
    if poolParam.use_idealHeater
    annotation (Placement(transformation(extent={{48,-20},{32,-4}})));
  Controls.Continuous.LimPID        PI(
    k=poolParam.KHeat,
    yMax=poolParam.QMaxHeat,
    yMin=poolParam.QMinHeat,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=poolParam.THeat) if poolParam.use_idealHeater                                                                                                                                                                  annotation(Placement(transformation(extent={{-4,-4},
            {4,4}},
        rotation=180,
        origin={66,-16})));
  Modelica.Blocks.Sources.RealExpression getSetTPool(y=poolParam.TPool)
    if poolParam.use_idealHeater
    annotation (Placement(transformation(extent={{96,-24},{78,-8}})));
  Controls.Continuous.LimPID        PI1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=5,
    yMax=m_flow_nominal/0.9,
    yMin=0) annotation (Placement(transformation(extent={{18,-54},{8,-44}})));
  Movers.FlowControlled_m_flow cirPump(
    redeclare package Medium = WaterMedium,
    energyDynamics=energyDynamics,
    T_start=poolParam.TPool,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    redeclare Movers.Data.Generic per,
    inputType=AixLib.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    dp_nominal=pumpHead,
    m_flow_start=m_flow_nominal)
    "circulation pump for permanent pool circulation " annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={0,-68})));
  Sensors.MassFlowRate              senMasFlo(redeclare package Medium =
        WaterMedium, allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={22,-68})));
  FixedResistances.PressureDrop              res(
    redeclare package Medium = WaterMedium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    show_T=false,
    from_dp=false,
    dp_nominal=pumpHead - poolParam.dpHeaExcPool,
    homotopyInitialization=true,
    linearized=false,
    deltaM=0.3) "representative resistance for whole system "
    annotation (Placement(transformation(extent={{32,-76},{44,-60}})));


protected
  final parameter Modelica.Units.SI.Density rhoWater_default=
      WaterMedium.density_pTX(
      p=WaterMedium.p_default,
      T=273.15 + 30,
      X=WaterMedium.X_default) "Default medium density";



equation
  // Fresh water and water recycling
  if poolParam.use_waterRecycling then
    m_flow_add=(1-poolParam.x_recycling)*(poolParam.m_flow_out + m_flow_evap);
  else
    m_flow_add=poolParam.m_flow_out + m_flow_evap;
  end if;

  // Pool circulation flow rate
  if poolParam.use_partialLoad then
    if timeOpe > 0 then
      m_flow_toPool = m_flow_nominal;
    else
      m_flow_toPool = m_flow_partial;
    end if;
  else
    m_flow_toPool = m_flow_nominal;
  end if;

  // Evaporation according to VDI 2089 sheet 1, formula (1)
   phi=absToRelHum.relHum;
   if psat_TPool-phi*psat_TAir<0 then
     m_flow_evap=0.0;
   else
    if timeOpe > 0 then
      if uRelPer > 0 then
         m_flow_evap =uRelPer*(poolParam.betaInUse/(RD*0.5*(poolWat.T + TAir))*(
          psat_TPool - phi*psat_TAir)*poolParam.APool);
       else
         m_flow_evap =betaNonUse/(RD*0.5*(poolWat.T + TAir))*(psat_TPool - phi*
          psat_TAir)*poolParam.APool;
       end if;
     else
       if poolParam.use_poolCover then
         m_flow_evap =betaCover/(RD*0.5*(poolWat.T + TAir))*(psat_TPool - phi*
          psat_TAir)*poolParam.APool;
       else
         m_flow_evap =betaNonUse/(RD*0.5*(poolWat.T + TAir))*(psat_TPool - phi*
          psat_TAir)*poolParam.APool;
       end if;
     end if;
   end if;

  if poolParam.use_idealHeater then
    connect(res.port_b, poolWat.ports[1]) annotation (Line(points={{44,-68},{54,
            -68},{54,-24},{6,-24},{6,-10},{5.33333,-10}}, color={0,127,255}));
  else
    connect(poolWat.ports[1], port_a1) annotation (Line(
        points={{5.33333,-10},{6,-10},{6,-22},{56,-22},{56,-30},{100,-30}},
        color={0,127,255},
        pattern=LinePattern.Dash));
    connect(port_b1, res.port_b) annotation (Line(
        points={{100,-54},{78,-54},{78,-68},{44,-68}},
        color={0,127,255},
        pattern=LinePattern.Dash));
  end if;

  connect(poolWat.ports[3], setEva.port_a) annotation (Line(points={{2.66667,-10},
          {2,-10},{2,-18},{-12,-18},{-12,26},{-24,26}}, color={0,127,255}));

  connect(poolSto.ports[2], HeatExchanger.port_b1) annotation (Line(points={{-28.5,
          -56},{-28.5,-64},{-36,-64},{-36,-68}}, color={0,127,255}));
  connect(poolSto.ports[3], HeatExchanger.port_a2) annotation (Line(points={{-27.5,
          -56},{-28,-56},{-28,-64},{-30,-64},{-30,-68}}, color={0,127,255}));
  connect(poolSto.ports[4], cirPump.port_a) annotation (Line(points={{-26.5,-56},
          {-14,-56},{-14,-68},{-8,-68}}, color={0,127,255}));
  connect(poolSto.ports[1], poolWat.ports[2]) annotation (Line(points={{-29.5,-56},
          {-29.5,-60},{-60,-60},{-60,-24},{4,-24},{4,-10}}, color={0,127,255}));

  connect(absToRelHum.TDryBul, TAir) annotation (Line(points={{-61.8,83},{-62,83},
          {-62,88},{-67,88},{-67,103}},color={0,0,127}));
  connect(absToRelHum.absHum, X_w) annotation (Line(points={{-56.4,83},{-56,83},
          {-56,88},{-29,88},{-29,103}},  color={0,0,127}));
  connect(HeatExchanger.port_b2, Sinc.ports[1]) annotation (Line(points={{-30,-78},
          {-30,-88},{22,-88}},                    color={0,127,255}));
  connect(setEva.port_b, sincEva.ports[1])
    annotation (Line(points={{-36,26},{-58,26}}, color={0,127,255}));
  connect(getEva.y, setEva.m_flow_in) annotation (Line(points={{-71.1,41},{-26.4,
          41},{-26.4,30.8}}, color={0,0,127}));
  connect(radWaterSurface.port_b, radPool)
    annotation (Line(points={{39,80},{39,100}}, color={191,0,0}));
  connect(convWaterSurface.fluid, convPool)
    annotation (Line(points={{67,82},{68,82},{68,98}}, color={191,0,0}));
  connect(convWaterSurface.solid, poolWat.heatPort) annotation (Line(points={{67,
          68},{66,68},{66,52},{38,52},{38,0},{14,0}}, color={191,0,0}));
  connect(radWaterSurface.port_a, poolWat.heatPort)
    annotation (Line(points={{39,66},{38,66},{38,0},{14,0}}, color={191,0,0}));
  connect(preHeatFlowEvapLoss.port, poolWat.heatPort)
    annotation (Line(points={{12,60},{26,60},{26,0},{14,0}}, color={191,0,0}));
  connect(getEva.y, hEva.u) annotation (Line(points={{-71.1,41},{-58,41},{-58,52},
          {-48.8,52}}, color={0,0,127}));
  connect(heatTraCond.heatport_a, poolWat.heatPort) annotation (Line(points={{63.76,
          39.92},{38,39.92},{38,0},{14,0}}, color={191,0,0}));
  connect(hEva.y, minusGain.u) annotation (Line(points={{-39.6,52},{-34,52},{-34,
          60},{-24.8,60}}, color={0,0,127}));
  connect(hEva.y, QEva) annotation (Line(points={{-39.6,52},{-34,52},{-34,61},{-107,
          61}}, color={0,0,127}));
  connect(heatTraCond.TSoil, TSoil) annotation (Line(points={{80.48,42.88},{82,42.88},
          {82,49},{105,49}}, color={0,0,127}));
  connect(convPool, convPool)
    annotation (Line(points={{68,98},{68,98}}, color={191,0,0}));
  connect(getHeatCoefConv.y, convWaterSurface.Gc) annotation (Line(points={{81.1,75},
          {74,75}},                                                                              color={0,0,127}));
  connect(minusGain.y, preHeatFlowEvapLoss.Q_flow)
    annotation (Line(points={{-15.6,60},{-4,60}}, color={0,0,127}));

  connect(bou.ports[1], HeatExchanger.port_a1) annotation (Line(points={{-40,-88},
          {-40,-78},{-36,-78}}, color={0,127,255}));
  connect(waveMachine.open, timeOpe) annotation (Line(points={{-93.28,-87},{-98,
          -87},{-98,-74},{-90,-74},{-90,-58},{-106,-58}}, color={0,0,127}));
  connect(getMeaTPool.y, TPool)
    annotation (Line(points={{83,16},{108,16}}, color={0,0,127}));

  connect(PI.y, idealHeater.Q_flow) annotation (Line(points={{61.6,-16},{54,-16},
          {54,-12},{48,-12}}, color={0,0,127}));
  connect(idealHeater.port, poolWat.heatPort) annotation (Line(points={{32,-12},
          {24,-12},{24,0},{14,0}}, color={191,0,0}));
  connect(getSetTPool.y, PI.u_s)
    annotation (Line(points={{77.1,-16},{70.8,-16}}, color={0,0,127}));
  connect(QPool, PI.y) annotation (Line(points={{108,-6},{58,-6},{58,-16},{61.6,
          -16}}, color={0,0,127}));
  connect(bou.m_flow_in, getAddWat.y) annotation (Line(points={{-53.2,-83.2},{-60,
          -83.2},{-60,-76},{-42,-76},{-42,-70},{-47.3,-70}}, color={0,0,127}));
  connect(getAddWat.y, m_flow_add_out) annotation (Line(points={{-47.3,-70},{-42,-70},
          {-42,-76},{-60,-76},{-60,-96},{94,-96},{94,-92},{108,-92}}, color={0,0,
          127}));
  connect(setEva.port_b, setEva.port_a) annotation (Line(
      points={{-36,26},{-30,26},{-24,26}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(cirPump.port_b, senMasFlo.port_a)
    annotation (Line(points={{8,-68},{16,-68}}, color={0,127,255}));
  connect(senMasFlo.port_b, res.port_a)
    annotation (Line(points={{28,-68},{32,-68}}, color={0,127,255}));
  connect(PI1.y, cirPump.m_flow_in)
    annotation (Line(points={{7.5,-49},{0,-49},{0,-58.4}}, color={0,0,127}));
  connect(PI1.u_s,getSetMasFlo. y)
    annotation (Line(points={{19,-49},{27.3,-49}}, color={0,0,127}));
  connect(senMasFlo.m_flow, PI1.u_m) annotation (Line(points={{22,-61.4},{22,-58},
          {13,-58},{13,-55}}, color={0,0,127}));

  connect(elPower.u[1], cirPump.P) annotation (Line(points={{72,-76},{62,-76},{62,
          -60.8},{8.8,-60.8}}, color={0,0,127}));
  connect(elPower.y, PPool)  annotation (Line(points={{80.68,-76},{108,-76}}, color={0,0,127}));
  connect(waveMachine.PWaveMachine, elPower.u[2]) annotation (Line(points={{-75.52,
          -87},{-72,-87},{-72,-100},{64,-100},{64,-76},{72,-76}},
                                                       color={0,0,127}));

  connect(PI.u_m,getMeaTPool. y) annotation (Line(points={{66,-11.2},{66,4},{92,
          4},{92,16},{83,16}}, color={0,0,127}));
  annotation (Line(
        points={{47,-32},{47,-14},{-25,-14},{-25,-6}}, color={0,127,255}),
             Line(points={{18.4,-40},
          {18,-40},{18,-44},{-100,-44}}, color={0,127,255}),
                Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-50,82}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,80})),
         Icon(coordinateSystem(preserveAspectRatio=false),
         graphics={
         Rectangle(
          extent={{98,98},{-98,-98}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Bitmap(extent={{-94,-150},{96,58}}, fileName="modelica://AixLib/Resources/Images/Fluid/Pools/icon_schwimmbecken.jpg")}),
          Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,2},{100,100}},
          lineColor={0,128,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-98,12},{-6,0}},
          textColor={85,85,255},
          textStyle={TextStyle.Bold},
          horizontalAlignment=TextAlignment.Left,
          textString="Heat and mass exchange 
at pool surface or pool walls 
"),     Rectangle(
          extent={{-66,-98},{100,-2}},
          lineColor={0,0,127},
          fillColor={155,195,232},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-100,-98},{-68,-2}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-98,-6},{-72,-14}},
          textColor={95,95,95},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Pool 
operation"),
        Text(
          extent={{-64,-2},{-22,-24}},
          textColor={0,0,127},
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Water treatment 
circuit
")}),
Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for indoor swimming pools to calculate energy and water
  demands. Optional use of a wave machine, pool cover, partial load for
  the circulation pump and heat recovery from wastewater or recycling.
  In addition, an ideal heater can be used to heat the pool.
</p>
<p>
  <br/>
  <br/>
  <img src=
  \"modelica://AixLib/Resources/Images/Fluid/Pools/PoolAndWaterCuircut.png\"
  alt=\"1\">
</p>
<p>
  <b><span style=\"color: #008000;\">Important parameters and
  Inputs</span></b>
</p>
<ul>
  <li>All pool specific parameters are collected in one <a href=
  \"AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord\">AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord</a>
  record.
  </li>
  <li>openingHours: Input profile for the opening hours to consider a
  pool cover or a reduced circulation flow during non-operating hours.
  Also, during non-opening hours pool occupancy is set to 0.
  </li>
  <li>persons: Input profile for occupancy of the pool to consider
  occupancy level for evaportaion.
  </li>
</ul>
<p>
  <b><span style=\"color: #008000;\">Assumptions</span></b>
</p>
<ul>
  <li>Evaporation is determined according to VDI 2089.
  </li>
  <li>Filter and disinfection units are not explicitly modeled and have
  to be considered within the pump delivery head (pumpHead). According
  to Saunus 1.7 bar is a good estimation for swimming pools in sport
  oriented swimming facilities.
  </li>
  <li>The type of the filter should be taken into account within the
  determination of the volume flow and storage capacities. DIN 19643
  provides standards for the volume flow and storage capacities, taking
  into account the pool size and type as well as the filter type.
  </li>
  <li>There are no water losses or heat gains due to people entering or
  leaving the swimming pool.
  </li>
</ul>
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<p>
  For automatic generation of a swimming pool within a thermal zone and
  multizone model as well as for datasets, see
  https://github.com/RWTH-EBC/TEASER
</p>
<p>
  References for implemented constants (use also for parametrization):
</p>
<ul>
  <li>German Association of Engineers: Guideline VDI 2089-1, January
  2010: Building Services in swimming baths - Indoor Pools
  </li>
  <li>German Institute for Standardization DIN 19643-1, November 2012:
  Treatment of water of swimming pools and baths - Part 1 General
  Requirements
  </li>
  <li>Chroistoph Saunus, 2005: Schwimmbäder Planung - Ausführung -
  Betrieb
  </li>
</ul>
</html>"));
end IndoorSwimmingPool;
