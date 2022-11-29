within AixLib.Fluid;
package Pool
  model IndoorSwimmingPool
    parameter AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam
    "Choose setup for this pool" annotation (choicesAllMatching=true);

    replaceable package WaterMedium = AixLib.Media.Water annotation (choicesAllMatching=true);

    // Water transfer coefficients according to VDI 2089 Blatt 1
    parameter Real beta_nonUse(unit="m/s")=7/3600 "Water transfer coefficient during non opening hours" annotation (Dialog(group="Water transfer coefficients"));
    parameter Real beta_cover(unit="m/s")=0.7/3600 "Water transfer coefficient during non opening hours"
                                                                                                        annotation (Dialog(group="Water transfer coefficients"));
    parameter Real beta_wavePool(unit="m/s")=50/3600 "Water transfer coefficient during wavePool operation"
                                                                                                           annotation (Dialog(group="Water transfer coefficients"));

    // Parameter and variables for evaporation
    constant Modelica.Units.SI.SpecificHeatCapacity R_D=461.52
      "Specific gas constant for steam";                                // Source: Klaus Lucas, Thermodynamik (2008)
    final parameter Modelica.Units.SI.SpecificEnergy h_vapor=
        AixLib.Media.Air.enthalpyOfCondensingGas(poolParam.T_pool)
      "Latent heat of evaporating water";
    Modelica.Units.SI.MassFlowRate m_flow_evap(start=0.0)
      "mass flow rate between pool water and air due to evaporation";
    Modelica.Units.SI.Pressure psat_T_pool=
    Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
        poolWater.T) "Saturation pressure at pool temperature";
    Modelica.Units.SI.Pressure psat_T_Air=
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
    final parameter Modelica.Units.SI.Efficiency eps=if poolParam.use_HRS then
        poolParam.efficiencyHRS else 0;
    Modelica.Units.SI.MassFlowRate m_flow_freshWater(start=0.0)
    "Mass flow of fresh water supplied to pool circulation system";

    // Convection and Radiation at pool water surface
    parameter Modelica.Units.SI.CoefficientOfHeatTransfer alpha_Air=3.5
      "Coefficient of heat transfer between the water surface and the room air";
      // approximated for free and forced convection at velocities between 0,05 to 0,2 m/s  above a plane area
    parameter Real epsilon = 0.9*0.95
      "Product of expected emission coefficients of water (0.95) and the surrounding wall surfaces (0.95)";

    AixLib.Fluid.MixingVolumes.MixingVolume Storage(
      redeclare package Medium = WaterMedium,
      T_start=poolParam.T_pool,
      m_flow_nominal=m_flow_nominal,
      V=poolParam.V_storage,
      nPorts=4) annotation (Placement(transformation(extent={{-38,-56},{-18,-36}})));

    AixLib.Fluid.Sources.Boundary_pT Sinc(
      redeclare package Medium = WaterMedium, nPorts=1)
      annotation (Placement(transformation(extent={{30,-92},{22,-84}})));
    AixLib.Fluid.MixingVolumes.MixingVolume poolWater(
      redeclare package Medium = WaterMedium,
      T_start=poolParam.T_pool,
      m_flow_nominal=m_flow_nominal,
      V=poolParam.V_pool,
      nPorts=3)
      annotation (Placement(transformation(extent={{14,-10},{-6,10}})));

    Modelica.Blocks.Sources.RealExpression PoolWater(y=m_flow_toPool)
      annotation (Placement(transformation(extent={{42,-56},{28,-42}})));
    Modelica.Blocks.Interfaces.RealOutput QPool if poolParam.use_idealHeater
      "Heat flow rate to maintain the pool at the set temperature" annotation (
        Placement(transformation(extent={{98,-16},{118,4}}),  iconTransformation(
            extent={{98,-16},{118,4}})));

    AixLib.Fluid.Movers.BaseClasses.IdealSource Evaporation(
      redeclare package Medium = WaterMedium,
      m_flow_small=0.00001,
      control_m_flow=true) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-30,26})));
    Modelica.Blocks.Sources.RealExpression m_Eavporation(y=m_flow_evap)
      annotation (Placement(transformation(extent={{9,-9},{-9,9}},
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
    Modelica.Blocks.Interfaces.RealInput openingHours
      "Input profile for opening hours"
      annotation (Placement(transformation(extent={{-118,-70},{-94,-46}}),
          iconTransformation(extent={{-118,-70},{-94,-46}})));
    Modelica.Blocks.Interfaces.RealInput persons "Input profile for persons"
      annotation (Placement(transformation(extent={{-118,-38},{-92,-12}}),
          iconTransformation(extent={{-118,-38},{-92,-12}})));

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

    Modelica.Blocks.Sources.RealExpression FreshWater(y=m_flow_freshWater)  annotation (Placement(transformation(extent={{-62,-78},
              {-48,-62}})));

    AixLib.Fluid.Sources.Boundary_pT SincEvaporation(
      redeclare package Medium = WaterMedium, nPorts=1)   annotation (Placement(transformation(extent={{6,-6},{
              -6,6}},
          rotation=180,
          origin={-64,26})));

    Modelica.Fluid.Interfaces.FluidPort_b fromPool(redeclare package Medium =
          WaterMedium)                        if poolParam.use_idealHeater == false
      "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{90,-64},{110,-44}}),
          iconTransformation(extent={{90,-64},{110,-44}})));

    Modelica.Fluid.Interfaces.FluidPort_a toPool(redeclare package Medium =
          WaterMedium)                        if poolParam.use_idealHeater == false
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{90,-40},{110,-20}}),
          iconTransformation(extent={{90,-40},{110,-20}})));

    .AixLib.Fluid.Pool.BaseClasses.waveMachine waveMachine(
      h_wave=poolParam.h_wave,
      w_wave=poolParam.w_wave,
      wavePool_startTime=poolParam.wavePool_startTime,
      wavePool_period=poolParam.wavePool_period,
      wavePool_width=poolParam.wavePool_width) if poolParam.use_wavePool
      annotation (Placement(transformation(extent={{-92,-94},{-76,-80}})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPoolSurface
      "Air Temperature in Zone" annotation (Placement(transformation(extent={{56,86},
              {80,110}}),
        iconTransformation(extent={{64,94},{84,114}})));

    AixLib.Utilities.Interfaces.RadPort radPoolSurface
    "Mean Radiation Temperature of surrounding walls" annotation (Placement(
        transformation(
        extent={{-8,-9},{8,9}},
        rotation=-90,
        origin={39,100}),  iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={30,100})));

    Modelica.Thermal.HeatTransfer.Components.BodyRadiation radWaterSurface(
    final Gr=epsilon*poolParam.A_pool)
    "Model to depict the heat flow rate due to radiation between the pool surface an the surrounding walls" annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={39,73})));

    Modelica.Thermal.HeatTransfer.Components.Convection convWaterSurface
    "Convection at the watersurface" annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=90,
        origin={67,75})));

    Modelica.Blocks.Sources.RealExpression getHeatCoefConv(y=alpha_Air*poolParam.A_pool)
      "Coefficient of heat transfer between water surface and room air" annotation (Placement(transformation(extent={{100,66},
              {82,84}})));

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeatFlowEvapLoss annotation (Placement(transformation(extent={{-4,52},
              {12,68}})));

    Modelica.Blocks.Math.Gain hEvapLatentHeatGain(final k=h_vapor)
      "Calculation of heat flow rate due to evaporation" annotation (Placement(
          transformation(
          extent={{-4,-4},{4,4}},
          rotation=0,
          origin={-44,52})));

    Modelica.Blocks.Interfaces.RealOutput MFlowFreshWater
      "Flow rate of added fresh water to the pool and water treatment system" annotation (Placement(transformation(extent={{98,-102},
              {118,-82}}),
          iconTransformation(extent={{98,-102},{118,-82}})));

    AixLib.Fluid.Pool.BaseClasses.HeatTransferConduction heatTransferConduction(
      AInnerPoolWall=poolParam.AInnerPoolWall,
      APoolWallWithEarthContact=poolParam.APoolWallWithEarthContact,
      APoolFloorWithEarthContact=poolParam.APoolFloorWithEarthContact,
      AInnerPoolFloor=poolParam.AInnerPoolFloor,
      hConWaterHorizontal=poolParam.hConWaterHorizontal,
      hConWaterVertical=poolParam.hConWaterVertical,
      PoolWall=poolParam.PoolWallParam)
      "Model to depict the heat flow rate through the pool walls to the bordering room/soil"
      annotation (Placement(transformation(extent={{64,32},{80,48}})));

    Modelica.Blocks.Math.Gain minus1Gain(final k=-1) annotation (Placement(
          transformation(
          extent={{-4,-4},{4,4}},
          rotation=0,
          origin={-20,60})));

    Modelica.Blocks.Interfaces.RealOutput QEvap(final quantity="HeatFlowRate",
        final unit="W")
                       "Heat needed to compensate losses" annotation (Placement(transformation(extent={{-92,46},
              {-122,76}}),
        iconTransformation(extent={{-94,46},{-114,66}})));

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

    Modelica.Blocks.Math.MultiSum elPower(nu=if poolParam.use_wavePool then 2 else 1)
      "Add electric power of pump and the optional wave pool"
      annotation (Placement(transformation(extent={{72,-72},{80,-80}})));
    Sources.MassFlowSource_T boundary(
      redeclare package Medium = WaterMedium,
      use_m_flow_in=true,
      T=283.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-52,-94},{-40,-82}})));
    Modelica.Blocks.Sources.RealExpression ReadPoolTemp(y=poolWater.T)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={72,16})));
    Modelica.Blocks.Interfaces.RealOutput T_Pool "Value of Real output"
      annotation (Placement(transformation(extent={{98,6},{118,26}}),
          iconTransformation(extent={{98,6},{118,26}})));

    final parameter Modelica.Units.SI.Density rhoWater_default=
        WaterMedium.density_pTX(
        p=WaterMedium.p_default,
        T=273.15 + 30,
        X=WaterMedium.X_default) "Default medium density";

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow idealHeater
      annotation (Placement(transformation(extent={{48,-20},{32,-4}})));
    Controls.Continuous.LimPID        PI(
      k=1000,
      yMax=100000000,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=5,
      Td=0.1)                                                                                                                                                                                               annotation(Placement(transformation(extent={{-4,-4},
              {4,4}},
          rotation=180,
          origin={66,-16})));
    Modelica.Blocks.Sources.RealExpression SetTemperature(y=poolParam.T_pool)
      if poolParam.use_idealHeater
      annotation (Placement(transformation(extent={{96,-24},{78,-8}})));
    Controls.Continuous.LimPID        PI1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=5,
      yMax=m_flow_nominal/0.9,
      yMin=0) annotation (Placement(transformation(extent={{18,-54},{8,-44}})));
    Movers.FlowControlled_m_flow              CirculationPump(
      redeclare package Medium = WaterMedium,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      T_start=poolParam.T_pool,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_nominal,
      redeclare Movers.Data.Generic per,
      inputType=AixLib.Fluid.Types.InputType.Continuous,
      addPowerToMedium=false,
      nominalValuesDefineDefaultPressureCurve=true,
      dp_nominal=pumpHead,
      m_flow_start=m_flow_nominal)
      annotation (Placement(transformation(extent={{-8,-8},{8,8}},
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
      dp_nominal=pumpHead - poolParam.dpHeatExchangerPool,
      homotopyInitialization=true,
      linearized=false,
      deltaM=0.3)
      annotation (Placement(transformation(extent={{32,-76},{44,-60}})));
  equation
    // Fresh water and water recycling
    if poolParam.use_waterRecycling then
      m_flow_freshWater=(1-poolParam.x_recycling)*(poolParam.m_flow_out + m_flow_evap);
    else
      m_flow_freshWater=poolParam.m_flow_out + m_flow_evap;
    end if;

    // Pool circulation flow rate
    if poolParam.use_partialLoad then
      if openingHours > 0 then
        m_flow_toPool = m_flow_nominal;
      else
        m_flow_toPool = m_flow_partial;
      end if;
    else
      m_flow_toPool = m_flow_nominal;
    end if;

    // Evaporation according to VDI 2089 sheet 1, formula (1)
     phi=absToRelHum.relHum;
     if psat_T_pool-phi*psat_T_Air<0 then
       m_flow_evap=0.0;
     else
      if openingHours > 0 then
        if persons > 0 then
           m_flow_evap =persons*(poolParam.beta_inUse/(R_D*0.5*(poolWater.T +
            TAir))*(psat_T_pool - phi*psat_T_Air)*poolParam.A_pool);
         else
           m_flow_evap = beta_nonUse /(R_D*0.5*(poolWater.T + TAir))*(psat_T_pool-phi*psat_T_Air)*poolParam.A_pool;
         end if;
       else
         if poolParam.use_poolCover then
           m_flow_evap = beta_cover /(R_D*0.5*(poolWater.T + TAir))*(psat_T_pool-phi*psat_T_Air)*poolParam.A_pool;
         else
           m_flow_evap = beta_nonUse /(R_D*0.5*(poolWater.T + TAir))*(psat_T_pool-phi*psat_T_Air)*poolParam.A_pool;
         end if;
       end if;
     end if;

    if poolParam.use_idealHeater then
          connect(res.port_b, poolWater.ports[1]) annotation (Line(points={{44,-68},
              {54,-68},{54,-24},{6,-24},{6,-10},{5.33333,-10}},
                                                      color={0,127,255}));
    else
        connect(poolWater.ports[1], toPool) annotation (Line(
        points={{5.33333,-10},{6,-10},{6,-22},{56,-22},{56,-30},{100,-30}},
        color={0,127,255},
        pattern=LinePattern.Dash));
        connect(fromPool, res.port_b) annotation (Line(
        points={{100,-54},{78,-54},{78,-68},{44,-68}},
        color={0,127,255},
        pattern=LinePattern.Dash));
    end if;

    connect(poolWater.ports[3], Evaporation.port_a) annotation (Line(points={{2.66667,
            -10},{2,-10},{2,-18},{-12,-18},{-12,26},{-24,26}},   color={0,127,255}));

    connect(Storage.ports[2], HeatExchanger.port_b1) annotation (Line(points={{-28.5,
            -56},{-28.5,-64},{-36,-64},{-36,-68}}, color={0,127,255}));
    connect(Storage.ports[3], HeatExchanger.port_a2) annotation (Line(points={{-27.5,
            -56},{-28,-56},{-28,-64},{-30,-64},{-30,-68}}, color={0,127,255}));
    connect(Storage.ports[4], CirculationPump.port_a) annotation (Line(points={{-26.5,
            -56},{-14,-56},{-14,-68},{-8,-68}},                color={0,127,255}));
    connect(Storage.ports[1], poolWater.ports[2]) annotation (Line(points={{-29.5,
            -56},{-29.5,-60},{-60,-60},{-60,-24},{4,-24},{4,-10}},     color={0,127,
            255}));

    connect(absToRelHum.TDryBul, TAir) annotation (Line(points={{-61.8,83},{-62,83},
            {-62,88},{-67,88},{-67,103}},color={0,0,127}));
    connect(absToRelHum.absHum, X_w) annotation (Line(points={{-56.4,83},{-56,83},
            {-56,88},{-29,88},{-29,103}},  color={0,0,127}));
    connect(HeatExchanger.port_b2, Sinc.ports[1]) annotation (Line(points={{-30,-78},
            {-30,-88},{22,-88}},                    color={0,127,255}));
    connect(Evaporation.port_b, SincEvaporation.ports[1])
      annotation (Line(points={{-36,26},{-58,26}}, color={0,127,255}));
    connect(m_Eavporation.y, Evaporation.m_flow_in) annotation (Line(points={{-71.1,
            41},{-26.4,41},{-26.4,30.8}}, color={0,0,127}));
    connect(radWaterSurface.port_b, radPoolSurface)  annotation (Line(points={{39,80},
            {39,100}},                                                                                     color={191,0,0}));
    connect(convWaterSurface.fluid, convPoolSurface) annotation (Line(points={{67,82},
            {68,82},{68,98}},                          color={191,0,0}));
    connect(convWaterSurface.solid, poolWater.heatPort) annotation (Line(points={{67,68},
            {66,68},{66,52},{38,52},{38,0},{14,0}},              color={191,0,0}));
    connect(radWaterSurface.port_a, poolWater.heatPort) annotation (Line(points={{39,66},
            {38,66},{38,0},{14,0}},                              color={191,0,0}));
    connect(preHeatFlowEvapLoss.port, poolWater.heatPort) annotation (Line(points={{12,60},
            {26,60},{26,0},{14,0}},             color={191,0,0}));
    connect(m_Eavporation.y, hEvapLatentHeatGain.u) annotation (Line(points={{-71.1,
            41},{-58,41},{-58,52},{-48.8,52}},
                                          color={0,0,127}));
    connect(heatTransferConduction.heatport_a, poolWater.heatPort) annotation (
        Line(points={{63.76,39.92},{38,39.92},{38,0},{14,0}},     color={191,0,0}));
    connect(hEvapLatentHeatGain.y, minus1Gain.u)  annotation (Line(points={{-39.6,
            52},{-34,52},{-34,60},{-24.8,60}},                                                           color={0,0,127}));
    connect(hEvapLatentHeatGain.y, QEvap) annotation (Line(points={{-39.6,52},{-34,
            52},{-34,61},{-107,61}},                                                            color={0,0,127}));
    connect(heatTransferConduction.TSoil, TSoil) annotation (Line(points={{80.48,42.88},
            {82,42.88},{82,49},{105,49}}, color={0,0,127}));
    connect(convPoolSurface, convPoolSurface) annotation (Line(points={{68,98},{68,
            98}},                                                                            color={191,0,0}));
    connect(getHeatCoefConv.y, convWaterSurface.Gc) annotation (Line(points={{81.1,75},
            {74,75}},                                                                              color={0,0,127}));
    connect(minus1Gain.y, preHeatFlowEvapLoss.Q_flow) annotation (Line(points={{-15.6,
            60},{-4,60}},                                                                         color={0,0,127}));

    connect(boundary.ports[1], HeatExchanger.port_a1) annotation (Line(points={{-40,-88},
            {-40,-78},{-36,-78}},                                  color={0,127,
            255}));
    connect(waveMachine.open, openingHours) annotation (Line(points={{-93.28,
            -87},{-98,-87},{-98,-74},{-90,-74},{-90,-58},{-106,-58}},
                                           color={0,0,127}));
    connect(ReadPoolTemp.y, T_Pool)
      annotation (Line(points={{83,16},{108,16}}, color={0,0,127}));

    connect(PI.y, idealHeater.Q_flow) annotation (Line(points={{61.6,-16},{54,-16},
            {54,-12},{48,-12}}, color={0,0,127}));
    connect(idealHeater.port, poolWater.heatPort) annotation (Line(points={{32,-12},
            {24,-12},{24,0},{14,0}}, color={191,0,0}));
    connect(SetTemperature.y, PI.u_s)
      annotation (Line(points={{77.1,-16},{70.8,-16}}, color={0,0,127}));
    connect(QPool, PI.y) annotation (Line(points={{108,-6},{58,-6},{58,-16},{61.6,
            -16}}, color={0,0,127}));
    connect(boundary.m_flow_in, FreshWater.y) annotation (Line(points={{-53.2,-83.2},
            {-60,-83.2},{-60,-76},{-42,-76},{-42,-70},{-47.3,-70}}, color={0,0,127}));
    connect(FreshWater.y, MFlowFreshWater) annotation (Line(points={{-47.3,-70},{-42,
            -70},{-42,-76},{-60,-76},{-60,-96},{94,-96},{94,-92},{108,-92}},
          color={0,0,127}));
    connect(Evaporation.port_b, Evaporation.port_a) annotation (Line(
        points={{-36,26},{-30,26},{-24,26}},
        color={0,127,255},
        smooth=Smooth.Bezier));
    connect(CirculationPump.port_b, senMasFlo.port_a)
      annotation (Line(points={{8,-68},{16,-68}}, color={0,127,255}));
    connect(senMasFlo.port_b, res.port_a)
      annotation (Line(points={{28,-68},{32,-68}}, color={0,127,255}));
    connect(PI1.y, CirculationPump.m_flow_in)
      annotation (Line(points={{7.5,-49},{0,-49},{0,-58.4}}, color={0,0,127}));
    connect(PI1.u_s, PoolWater.y)
      annotation (Line(points={{19,-49},{27.3,-49}}, color={0,0,127}));
    connect(senMasFlo.m_flow, PI1.u_m) annotation (Line(points={{22,-61.4},{22,-58},
            {13,-58},{13,-55}}, color={0,0,127}));

    connect(elPower.u[1], CirculationPump.P) annotation (Line(points={{72,-76},{62,
            -76},{62,-60.8},{8.8,-60.8}},      color={0,0,127}));
    connect(elPower.y, PPool)  annotation (Line(points={{80.68,-76},{108,-76}}, color={0,0,127}));
    connect(waveMachine.PWaveMachine, elPower.u[2]) annotation (Line(points={{-75.52,
            -87},{-72,-87},{-72,-100},{64,-100},{64,-76},{72,-76}},
                                                         color={0,0,127}));

    connect(PI.u_m, ReadPoolTemp.y) annotation (Line(points={{66,-11.2},{66,4},{92,
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
"),       Rectangle(
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
")}));
  end IndoorSwimmingPool;

  package BaseClasses
      extends Modelica.Icons.BasesPackage;

    model HeatTransferConduction
      "Heat transfer due to conduction through pool walls"
      parameter Modelica.Units.SI.Area AInnerPoolWall;
      parameter Modelica.Units.SI.Area APoolWallWithEarthContact;
      parameter Modelica.Units.SI.Area APoolFloorWithEarthContact;
      parameter Modelica.Units.SI.Area AInnerPoolFloor;

      parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterHorizontal;
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWaterVertical;

      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature HeatFlowOuter
        "Generate Heat Flow for earth contact" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=180,
            origin={74,-28})));

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_a
        "Inlet for heattransfer"  annotation (Placement(transformation(extent={{-116,
                -14},{-90,12}}),
            iconTransformation(extent={{-116,-14},{-90,12}})));

      Modelica.Blocks.Interfaces.RealInput TSoil "Temperature of Soil" annotation (Placement(transformation(extent={{130,-48},
                {90,-8}}),
            iconTransformation(extent={{126,16},{86,56}})));

      AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
        InnerPoolFloor(
        A=AInnerPoolFloor,
       wallRec=PoolWall,
        T_start=fill((0), (PoolWall.n)))
                 annotation (Placement(transformation(extent={{-10,-34},{18,-10}})));
      AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterHorizontalInner(
        hCon_const=hConWaterHorizontal,
        A=AInnerPoolFloor,
        calcMethod=3,
        surfaceOrientation=1)
                      annotation (Placement(transformation(
            origin={-48,-22},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterVerticalOuter(
        hCon_const=hConWaterVertical,
        A=APoolWallWithEarthContact,
        calcMethod=3,
        surfaceOrientation=1)  annotation (Placement(transformation(
            origin={-54,40},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
        PoolWallWithEarthContact(
        A=APoolWallWithEarthContact,
        wallRec=PoolWall,
        T_start=fill((0), (PoolWall.n)))
                 annotation (Placement(transformation(extent={{-6,26},{22,54}})));
      AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterHorizontalOuter(
        hCon_const=hConWaterHorizontal,
        A=APoolFloorWithEarthContact,
        calcMethod=3,
        surfaceOrientation=1)  annotation (Placement(transformation(
            origin={-52,-60},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
        PoolFloorWithEarthContact(
        A=APoolFloorWithEarthContact,
        wallRec=PoolWall,
        T_start=fill((0), (PoolWall.n)))
                 annotation (Placement(transformation(extent={{-10,-72},{14,-50}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow1 "Generate Heat Flow for earth contact"
                               annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=180,
            origin={44,12})));
      AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
        InnerPoolWall(
        A=AInnerPoolWall,
        wallRec=PoolWall,
        T_start=fill((0), (PoolWall.n)))
                 annotation (Placement(transformation(extent={{-6,64},{22,92}})));
      Modelica.Blocks.Sources.RealExpression HeatFlowInner(y=0)
        "Inner pool walls are not connected to other zones, only outer pool walls have earth contact"
        annotation (Placement(transformation(extent={{96,2},{76,22}})));
      AixLib.Utilities.HeatTransfer.HeatConvInside HeatConvWaterVerticalInner(
        hCon_const=hConWaterVertical,
        A=AInnerPoolWall,
        calcMethod=3,
        surfaceOrientation=1)  annotation (Placement(transformation(
            origin={-54,78},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition PoolWall
        annotation (Placement(transformation(extent={{76,-98},{96,-78}})));
    equation
      connect(HeatFlowOuter.T, TSoil)
        annotation (Line(points={{81.2,-28},{110,-28}}, color={0,0,127}));
      connect(heatport_a, heatport_a)
        annotation (Line(points={{-103,-1},{-103,-1}}, color={191,0,0}));
      connect(HeatConvWaterHorizontalInner.port_a, InnerPoolFloor.port_a)
        annotation (Line(points={{-38,-22},{-10,-22}}, color={191,0,0}));
      connect(PoolFloorWithEarthContact.port_b, HeatFlowOuter.port) annotation (
          Line(points={{14,-61},{58,-61},{58,-28},{68,-28}}, color={191,0,0}));
      connect(PoolFloorWithEarthContact.port_a, HeatConvWaterHorizontalOuter.port_a)
        annotation (Line(points={{-10,-61},{-10,-60},{-42,-60}}, color={191,0,0}));
      connect(InnerPoolWall.port_b, prescribedHeatFlow1.port) annotation (Line(
            points={{22,78},{30,78},{30,12},{38,12}}, color={191,0,0}));
      connect(HeatConvWaterVerticalOuter.port_b, heatport_a) annotation (Line(
            points={{-64,40},{-72,40},{-72,-1},{-103,-1}}, color={191,0,0}));
      connect(HeatConvWaterHorizontalInner.port_b, heatport_a) annotation (Line(
            points={{-58,-22},{-72,-22},{-72,-1},{-103,-1}}, color={191,0,0}));
      connect(HeatConvWaterHorizontalOuter.port_b, heatport_a) annotation (Line(
            points={{-62,-60},{-72,-60},{-72,-1},{-103,-1}}, color={191,0,0}));
      connect(prescribedHeatFlow1.Q_flow, HeatFlowInner.y)
        annotation (Line(points={{50,12},{75,12}}, color={0,0,127}));
      connect(HeatFlowOuter.port, PoolWallWithEarthContact.port_b) annotation (Line(
            points={{68,-28},{58,-28},{58,40},{22,40}}, color={191,0,0}));
      connect(InnerPoolFloor.port_b, prescribedHeatFlow1.port) annotation (Line(
            points={{18,-22},{30,-22},{30,12},{38,12}}, color={191,0,0}));
      connect(HeatConvWaterVerticalOuter.port_a, PoolWallWithEarthContact.port_a)
        annotation (Line(points={{-44,40},{-6,40}}, color={191,0,0}));
      connect(InnerPoolWall.port_a, HeatConvWaterVerticalInner.port_a) annotation (
          Line(points={{-6,78},{-44,78}},                   color={191,0,0}));
      connect(HeatConvWaterVerticalInner.port_b, heatport_a) annotation (Line(
            points={{-64,78},{-72,78},{-72,-1},{-103,-1}},color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-80,58},{28,-26}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{28,68},{48,-46}},
              lineColor={135,135,135},
              fillColor={175,175,175},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{-86,-26},{30,-46}},
              lineColor={135,135,135},
              fillColor={175,175,175},
              fillPattern=FillPattern.Forward),
            Polygon(
              points={{-16,-10},{-4,6},{58,-52},{46,-62},{-16,-10}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{32,-68},{36,-66},{62,-38},{76,-78},{32,-68}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>This model is a base model to calculate the heat transfer through pool walls. The pool walls are sorted by: vertical walls with earth contact, pool floor with earth contact and the sum of walls and pool floor without earth contact.</p>
</html>"));
    end HeatTransferConduction;

    model waveMachine "Calculate energy demands of a wave machine"

      parameter Modelica.Units.SI.Length h_wave "Height of generated wave";
      parameter Modelica.Units.SI.Length w_wave
        "Width of wave machine outlet/of generated wave";
      parameter Modelica.Units.SI.Time wavePool_startTime
        "Start time of first wave cycle";
      parameter Modelica.Units.SI.Time wavePool_period "Time of cycling period";
      parameter Real wavePool_width "Length of wave generation within cycling period";

      Modelica.Blocks.Math.RealToBoolean useWavePool(threshold=1)
        "If input = 1, then true, else no waves generated"
        annotation (Placement(transformation(extent={{-58,-8},{-42,8}})));
      Modelica.Blocks.Tables.CombiTable1Dv tablePWave(
        y(unit="W/m"),
        tableOnFile=false,
        table=[0,0; 0.7,3500; 0.9,6000; 1.3,12000],
        extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
        "Estimate consumed power per width to generate wave of a certain heigth; "
        annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
      Modelica.Blocks.Sources.RealExpression get_h_wave(y=h_wave)
        "Get height of generated wave"
        annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
      Modelica.Blocks.Interfaces.RealInput open "Input profil of wave machine"
        annotation (Placement(transformation(extent={{-136,-20},{-96,20}})));
      Modelica.Blocks.Interfaces.RealOutput PWaveMachine( final unit="W", final quantity="Power")
        "Power consumption of wave machine"
        annotation (Placement(transformation(extent={{96,-10},{116,10}})));
      Modelica.Blocks.Math.Gain multiply(k=w_wave) "Multply by width of wave"
        annotation (Placement(transformation(extent={{0,52},{16,68}})));
      Modelica.Blocks.Sources.Constant zero(k=0)
        "no output if wave machine is off"
        annotation (Placement(transformation(extent={{-14,-78},{0,-64}})));
      Modelica.Blocks.Logical.Switch switchWaveMachine
        annotation (Placement(transformation(extent={{60,-10},{80,10}})));
      Modelica.Blocks.Logical.And and1
        annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
      Modelica.Blocks.Sources.BooleanPulse wavePoolCycle(
        width=wavePool_width,
        period=wavePool_period,
        startTime=wavePool_startTime)
        annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
    equation
      connect(get_h_wave.y, tablePWave.u[1]) annotation (Line(points={{-69,60},{-48,
              60}},                  color={0,0,127}));
      connect(multiply.u, tablePWave.y[1]) annotation (Line(points={{-1.6,60},{-25,60}},
                                  color={0,0,127}));
      connect(open, useWavePool.u)
        annotation (Line(points={{-116,0},{-59.6,0}}, color={0,0,127}));
      connect(switchWaveMachine.y, PWaveMachine) annotation (Line(points={{81,0},{
              106,0}},                     color={0,0,127}));
      connect(multiply.y, switchWaveMachine.u1)
        annotation (Line(points={{16.8,60},{42,60},{42,8},{58,8}},
                                                                 color={0,0,127}));
      connect(zero.y, switchWaveMachine.u3) annotation (Line(points={{0.7,-71},{52,-71},
              {52,-8},{58,-8}},         color={0,0,127}));
      connect(PWaveMachine, PWaveMachine) annotation (Line(
          points={{106,0},{101,0},{101,0},{106,0}},
          color={0,0,127},
          smooth=Smooth.Bezier));
      connect(useWavePool.y, and1.u1)
        annotation (Line(points={{-41.2,0},{-10,0}}, color={255,0,255}));
      connect(and1.y, switchWaveMachine.u2)
        annotation (Line(points={{13,0},{58,0}}, color={255,0,255}));
      connect(wavePoolCycle.y, and1.u2) annotation (Line(points={{-39,-40},{-24,-40},
              {-24,-8},{-10,-8}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
            Line(
              points={{-98,0},{-52,62},{-2,-24},{50,60},{100,-2}},
              color={28,108,200},
              smooth=Smooth.Bezier,
              thickness=1),
            Line(
              points={{-98,-18},{-52,44},{-2,-42},{50,42},{98,-20}},
              color={28,108,200},
              smooth=Smooth.Bezier,
              thickness=1),
            Line(
              points={{-98,-36},{-52,26},{-2,-60},{50,24},{96,-36}},
              color={28,108,200},
              smooth=Smooth.Bezier,
              thickness=1)}),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Model to calculate the energy demand of a wavemachine. Based on values of:</p>
<ul>
<li>German Association for the Recreational and Medicinal Bath Industry (Deutsche Gesellschaft f&uuml;r das Badewesen DGfdB), April 2015 : Richtlinien f&uuml;r den B&auml;derbau</li>
<li>Chroistoph Saunus, 2005: Schwimmb&auml;der Planung - Ausf&uuml;hrung - Betrieb</li>
</ul>
</html>"));
    end waveMachine;
  end BaseClasses;

  package Example
        extends Modelica.Icons.ExamplesPackage;

    model IndoorSwimmingPool
        extends Modelica.Icons.Example;
      Modelica.Blocks.Interfaces.RealOutput MFlowFreshWater
        "Flow rate of added fresh water to the pool and water treatment system"
        annotation (Placement(transformation(extent={{98,-96},{126,-68}}),
            iconTransformation(extent={{98,-96},{126,-68}})));
      .AixLib.Fluid.Pool.IndoorSwimmingPool indoorSwimming(poolParam=
            AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(),
          redeclare package WaterMedium = WaterMedium)
        annotation (Placement(transformation(extent={{-38,-36},{30,38}})));

        replaceable package WaterMedium = AixLib.Media.Water annotation (choicesAllMatching=true);

      Modelica.Blocks.Sources.RealExpression TSoil(y=273.15 + 8)
        annotation (Placement(transformation(extent={{96,44},{80,60}})));
      Modelica.Blocks.Sources.RealExpression X_W(y=14.3)
        annotation (Placement(transformation(extent={{-86,54},{-70,70}})));
      Modelica.Blocks.Sources.RealExpression T_Air(y=273.15 + 30)
        annotation (Placement(transformation(extent={{-86,72},{-70,88}})));
      Modelica.Blocks.Sources.Pulse pulse(
        amplitude=1,
        width=13/15,
        period=(24 - 7)*3600,
        offset=0,
        startTime=3600*7)
        annotation (Placement(transformation(extent={{-94,-50},{-80,-36}})));
      Modelica.Blocks.Sources.Trapezoid Person(
        amplitude=0.5,
        rising=7*3600,
        width=1*3600,
        falling=7*3600,
        period=17*3600,
        offset=0.3,
        startTime=7*3600)
        annotation (Placement(transformation(extent={{-96,-16},{-80,0}})));
      Modelica.Blocks.Interfaces.RealOutput QEvap annotation (Placement(
            transformation(extent={{-86,16},{-118,48}}), iconTransformation(extent={
                {-86,16},{-118,48}})));
      Modelica.Blocks.Interfaces.RealOutput PPool
        "Output eletric energy needed for pool operation" annotation (Placement(
            transformation(extent={{98,-62},{124,-36}}),iconTransformation(extent={{98,-62},
                {124,-36}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature
        annotation (Placement(transformation(extent={{-16,74},{-4,86}})));
      Modelica.Blocks.Interfaces.RealOutput T_Pool "Value of Real output"
        annotation (Placement(transformation(extent={{98,8},{118,28}})));
      Modelica.Blocks.Interfaces.RealOutput QPool
        "Heat flow rate to maintain the pool at the set temperature"
        annotation (Placement(transformation(extent={{98,-20},{122,4}}),
            iconTransformation(extent={{98,-20},{122,4}})));
    equation
      connect(TSoil.y, indoorSwimming.TSoil) annotation (Line(points={{79.2,52},
              {40,52},{40,18.39},{31.02,18.39}},
                                             color={0,0,127}));
      connect(indoorSwimming.X_w, X_W.y) annotation (Line(points={{-13.86,39.11},{-12,
              39.11},{-12,62},{-69.2,62}}, color={0,0,127}));
      connect(indoorSwimming.TAir, T_Air.y) annotation (Line(points={{-26.78,39.11},
              {-26.78,80},{-69.2,80}}, color={0,0,127}));
      connect(pulse.y, indoorSwimming.openingHours) annotation (Line(points={{-79.3,
              -43},{-50,-43},{-50,-20.46},{-40.04,-20.46}}, color={0,0,127}));
      connect(Person.y, indoorSwimming.persons) annotation (Line(points={{-79.2,-8},
              {-48,-8},{-48,-8.25},{-39.7,-8.25}}, color={0,0,127}));
      connect(indoorSwimming.QEvap, QEvap) annotation (Line(points={{-39.36,21.72},{
              -39.36,22},{-66,22},{-66,32},{-102,32}}, color={0,0,127}));
      connect(indoorSwimming.PPool, PPool) annotation (Line(points={{32.72,
              -27.12},{32.72,-26},{96,-26},{96,-49},{111,-49}},    color={0,0,127}));
      connect(indoorSwimming.MFlowFreshWater, MFlowFreshWater) annotation (Line(
            points={{32.72,-33.04},{32.72,-82},{112,-82}}, color={0,0,127}));
      connect(prescribedTemperature.T, T_Air.y)
        annotation (Line(points={{-17.2,80},{-69.2,80}}, color={0,0,127}));
      connect(prescribedTemperature.port, indoorSwimming.convPoolSurface)
        annotation (Line(points={{-4,80},{21.16,80},{21.16,39.48}}, color={191,0,0}));
      connect(indoorSwimming.T_Pool, T_Pool) annotation (Line(points={{32.72,
              6.92},{92,6.92},{92,18},{108,18}}, color={0,0,127}));
      connect(MFlowFreshWater, MFlowFreshWater)
        annotation (Line(points={{112,-82},{112,-82}}, color={0,0,127}));
      connect(indoorSwimming.QPool, QPool) annotation (Line(points={{32.72,
              -1.22},{32.72,0},{92,0},{92,-8},{110,-8}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=1080000, __Dymola_Algorithm="Dassl"));
    end IndoorSwimmingPool;
  end Example;
end Pool;
