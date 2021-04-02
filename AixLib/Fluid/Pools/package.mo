within AixLib.Fluid;
package Pools "Models to describe Swimming Pools"

  model IndoorSwimmingPool_alt

    package Medium = AixLib.Media.Water;

    parameter DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam
      "Choose setup for this swimming pool" annotation (choicesAllMatching=true);

    //Calculated from record/input data

    final parameter Modelica.SIunits.MassFlowRate m_flow_start = poolParam.Q* Medium.d_const "Mass Flow Rate from Storage to Pool at the beginning";
    final parameter Modelica.SIunits.MassFlowRate m_flow_recycledStart=0.0001
                                                                             "Nominal Mass Flow Rate for recycled water, min to catch zero flow";
    final parameter Modelica.SIunits.Volume V_pool= poolParam.A_pool * poolParam.d_pool "Volume of swimming pool water";
    final parameter Modelica.SIunits.SpecificEnergy h_evap = AixLib.Media.Air.enthalpyOfCondensingGas(poolParam.T_pool)
                                                                                                                       "Evaporation enthalpy";
    final parameter Modelica.SIunits.Pressure psat_T_pool=
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
        poolParam.T_pool)
                         "Saturation pressure at pool temperature";
    Modelica.SIunits.Pressure psat_T_Air=
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
        TAir)
             "Saturation pressure at air temperature of the zone";

    Real phi=absToRelHum.relHum "Relative humidty";

    // Fixed Constants

    final parameter Modelica.SIunits.Pressure pumpHead = 170000
      "Expected average flow resistance of watertreatment cycle";
    final parameter Real epsilon = 0.9*0.95
      "Product of expected emission coefficients of water and the surrounding wall surfaces";
    final constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air=3.5
      "Coefficient of heat transfer between the water surface and the room air";
    final constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_W=820
      "Coefficient of heat transfer between the water and the pool walls";
    final constant Real R_D(final unit="J/(kg.K)") = 461.52
      "Specific gas constant for steam";

    // Flow variables
    Modelica.SIunits.MassFlowRate m_flow_evap( start= 0.001)
                                             "Evaporation mass flow at pool surface";
    Modelica.SIunits.MassFlowRate m_flow_toPool( start=m_flow_start)
                                               "Water supply of pool";
    Modelica.SIunits.MassFlowRate m_flow_freshWater( start=0.001)
                                                   "Mass flow rate of fresh water";
    Modelica.SIunits.MassFlowRate m_flow_recycledWater( start=m_flow_recycledStart)
                                                      "Mass flow rate of recycled water";


    MixingVolumes.MixingVolume Watertreatment(
      redeclare package Medium = Medium,
      T_start=poolParam.T_pool,
      m_flow_nominal=m_flow_start,
      V=poolParam.V_storage,
      nPorts=5)
               "Fixed Volume to represent the usable volume of the water storage" annotation (Placement(transformation(extent={{-6,-64},{14,-44}})));
    BaseClasses.MixingVolumeEvapLosses PoolWater(
      redeclare package Medium = Medium,
      T_start=poolParam.T_pool,
      m_flow_nominal=m_flow_start,
      V=V_pool,
      nPorts=4)
               "Fixed Volume to represent the pool water" annotation (Placement(transformation(extent={{-2,6},{
              18,26}})));
    Sources.Boundary_pT                   freshWater(redeclare package
                Medium =
          Medium,
      T=283.15,
      nPorts=1)
               "Source for fresh water"
      annotation (Placement(transformation(extent={{-94,-98},{-82,-86}})));
    Sources.Boundary_pT                   recycledWater(redeclare package
                Medium =
          Medium,
      T=poolParam.T_pool - 5,
      nPorts=1) "Source for recycled water"
      annotation (Placement(transformation(extent={{-94,-80},{-82,-68}})));
    Sources.Boundary_pT                   sewer(redeclare package
                Medium =
          Medium,
      nPorts=2) "Sink for waste water"
      annotation (Placement(transformation(extent={{88,-70},{76,-58}})));

    Movers.BaseClasses.IdealSource mFlow_Evap(redeclare package
                Medium =
          Medium,
      m_flow_small=0.00000000001,
      show_V_flow=false,
      control_m_flow=true,
      control_dp=false)
      "Set mass flow rate to present water losses due to evaporation"
      annotation (Placement(transformation(extent={{62,4},{72,14}})));

    Modelica.Blocks.Sources.RealExpression mFlowRecycledWater(final y=
          m_flow_recycledWater)
      "Prescribed mass flow for intake of recycled water into the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{-72,-66},{-58,-54}})));

    Modelica.Blocks.Sources.RealExpression mFlowFreshWater(final y=m_flow_freshWater)
      "Prescribed mass flow for intake of fresh water into the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{-70,-90},{-56,-78}})));

    Modelica.Blocks.Sources.RealExpression mFlowToPool(final y=m_flow_toPool)
      "Prescribed mass flow to depict the mass flow from the watertreatment back to the swimming pool"
      annotation (Placement(transformation(extent={{10,-30},{24,-18}})));

    Modelica.Blocks.Sources.RealExpression mFlowEvap(final y=m_flow_evap)
      "Calculated evaporation mass flow"
      annotation (Placement(transformation(extent={{44,16},{58,28}})));

    Modelica.Blocks.Math.Gain gain(final k=h_evap) "Calculation of heat flow rate due to evaporation"
      annotation (Placement(transformation(extent={{-22,28},{-30,36}})));

    ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum
      "Calculation of the relative humidity of the room air "
      annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=-90,
          origin={59,81})));
    Modelica.Blocks.Interfaces.RealInput TAir(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Temperature of the surrounding room air" annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={43,105})));

    Modelica.Blocks.Interfaces.RealInput X_w "Absolute humidty of the room Air"
      annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={73,105})));
    Modelica.Blocks.Math.Gain gain1(final k=-1)
      annotation (Placement(transformation(extent={{4,-4},{-4,4}},
          rotation=180,
          origin={-20,6})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-66,-52},{-46,-32}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=4) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-80,-14})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvPoolSurface
      "Air Temperature in Zone"
      annotation (Placement(transformation(extent={{-22,88},{2,112}})));
    BaseClasses.HeatTransferWaterSurface heatTransferWaterSurface(final alpha_Air=alpha_Air,
    final A= poolParam.A_pool)
      "Model to describe heat flow at the water surface due to convection"
      annotation (Placement(transformation(extent={{-22,52},{-4,66}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor QFlow_Conv_Sensor
      annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={-13,79})));
    Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(final Gr=
          epsilon)
      "Model to depict the heat flow rate due to radiation between the pool surface an the surrounding walls"
                   annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-55,55})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=-90,
          origin={-55,77})));

    Modelica.Blocks.Interfaces.RealInput TRad(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Mean Radiation Temperature of surrounding walls"
      annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={-55,105}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={-72,106})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor QFlow_Rad_Sensor
      annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={-53,29})));
    BaseClasses.HeatTransferConduction heatTransferConduction( final alpha_W = alpha_W,
      final nExt=poolParam.nPool,
      final CExt = poolParam.CPool,
      final nextToSoil = poolParam.nextToSoil,
      final RExt=poolParam.RPool,
      final RExtRem=poolParam.RPoolRem,
      final T_nextDoor= poolParam.T_pool)
      "Model to depict the heat flow rate through the pool walls to the bordering room/soil"
      annotation (Placement(transformation(extent={{52,42},{72,62}})));
    Modelica.Blocks.Interfaces.RealInput TSoil(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Temperature of Soil" annotation (Placement(
          transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={107,55})));

    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor QFlow_Cond_Sensor
      annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={29,41})));
    BaseClasses.PumpAndPressureDrop circulationPump(
      final replaceable package Medium = Medium,
      final m_flow_nominal=m_flow_start,
      final pumpHead=pumpHead,
      p_start=200000,
      T_water=poolParam.T_pool)
      "Pumping system to depict power consumption and set the right mass flow rate"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=90,
          origin={42,-18})));

    Modelica.Blocks.Interfaces.RealOutput PPump(final quantity="Power", final unit="W")
      "Output eletric energy needed for pump operation"
      annotation (Placement(transformation(extent={{98,-26},{118,-6}})));
    Modelica.Blocks.Interfaces.RealOutput QPool(final quantity="HeatFlowRate", final
        unit="W") "Heat needed to compensate losses"
      annotation (Placement(transformation(extent={{98,-40},{118,-20}})));
    Movers.BaseClasses.IdealSource mFlow_sewer(
      redeclare package Medium = Medium,
      m_flow_small=0.00000000001,
      control_m_flow=true,
      control_dp=false)
      "Set correct mass flow for waste water out of the pool-watertreatment-cycle"
      annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={54,-64})));
    Modelica.Blocks.Sources.RealExpression mFlowSewer(final y=poolParam.m_flow_sewer)
      "Prescribed mass flow of waste water out of the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{52,-52},{66,-40}})));
    Sources.Boundary_pT                pressureBoundary(
      redeclare package Medium = Medium,
      p=200000,
      nPorts=1) annotation (Placement(transformation(extent={{38,6},{30,14}})));
    Modelica.Blocks.Interfaces.RealOutput MFlowFreshWater(final quantity="MassFlowRate",
        final unit="kg/s")
      "Fresh water to compensate waste water and evaporation losses"
      annotation (Placement(transformation(extent={{96,-96},{116,-76}})));
    Modelica.Blocks.Interfaces.RealOutput MFlowRecycledWater(final quantity="MassFlowRate",
        final unit="kg/s")
      "Recycled Water to compensate waste water and evaporation losses"
      annotation (Placement(transformation(extent={{96,-88},{116,-68}})));
    Modelica.Blocks.Interfaces.RealOutput MFlowWasteWater(final quantity="MassFlowRate",
        final unit="kg/s") "Waste wate due to filter flusehs and visitors"
      annotation (Placement(transformation(extent={{96,-80},{116,-60}})));
    Modelica.Blocks.Interfaces.RealOutput QEvap(final quantity="HeatFlowRate", final
        unit="W") "Heat needed to compensate losses"
      annotation (Placement(transformation(extent={{98,-14},{118,6}})));
    BaseClasses.PumpAndPressureDrop pumpPressureDropRecycledWater(
      redeclare package Medium = Medium,
      pumpHead=pumpHead,
      m_flow_nominal=m_flow_recycledStart,
      p_start=200000,
      T_water=poolParam.T_pool - 5)
      "Pump to set the right mass flow rate for recycled water consumption"
      annotation (Placement(transformation(extent={{-50,-82},{-36,-68}})));
    BaseClasses.PumpAndPressureDrop pumpPressureDropFreshWater(
      redeclare package Medium = Medium,
      pumpHead=pumpHead,
      m_flow_nominal=(1 - poolParam.x_recycling)*poolParam.m_flow_sewer,
      p_start=200000,
      T_water=poolParam.T_pool)
      "Pump to set the right mass flow rate for fresh water consumption"
      annotation (Placement(transformation(extent={{-46,-98},{-36,-88}})));
    Modelica.Blocks.Math.RealToBoolean inUse(threshold=0.5)
      "If input = 1, then inUse =true, else pool not in use"
      annotation (Placement(transformation(extent={{-80,80},{-68,92}})));
    Modelica.Blocks.Interfaces.RealInput openingHours
      "Profil opening hours input"
      annotation (Placement(transformation(extent={{-118,74},{-92,100}})));
    Modelica.Blocks.Interfaces.RealOutput TPool
      "Output Pool Temperature" annotation (
        Placement(transformation(extent={{98,76},{118,
              96}})));
    Modelica.Blocks.Sources.RealExpression getTpool(final y=
          poolParam.T_pool)
      "Prescribed mass flow for intake of fresh water into the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{
              74,68},{88,80}})));
  equation

   if inUse.y or not poolParam.partialLoad then
       m_flow_toPool = poolParam.Q*Medium.d_const;
       m_flow_evap = (poolParam.beta_inUse)/(R_D*0.5*(poolParam.T_pool + TAir))*(psat_T_pool - phi*
         psat_T_Air)*poolParam.A_pool;
   else
       m_flow_toPool= poolParam.Q*poolParam.x_partialLoad*Medium.d_const;
       m_flow_evap = (poolParam.beta_nonUse)/(R_D*0.5*(poolParam.T_pool + TAir))*(psat_T_pool - phi*
          psat_T_Air)*poolParam.A_pool;
   end if;

  if poolParam.waterRecycling then
    m_flow_freshWater = (1-poolParam.x_recycling)*(poolParam.m_flow_sewer + m_flow_evap);
    m_flow_recycledWater = poolParam.x_recycling *(poolParam.m_flow_sewer + m_flow_evap);
  else
    m_flow_freshWater= poolParam.m_flow_sewer+m_flow_evap;
    m_flow_recycledWater=0.0001;
  end if;
    connect(PoolWater.ports[1], Watertreatment.ports[1]) annotation (Line(points={{5,6},{
            -8,6},{-8,-64},{0.8,-64}},      color={0,127,255}));
    connect(mFlowEvap.y, mFlow_Evap.m_flow_in) annotation (Line(points={{58.7,22},{64,22},
            {64,13}},                  color={0,0,127}));
    connect(PoolWater.ports[2], mFlow_Evap.port_a)
      annotation (Line(points={{7,6},{62,6},{62,9}}, color={0,127,255}));
    connect(X_w,absToRelHum. absHum) annotation (Line(points={{73,105},{60,105},
          {60,87},{61.6,87}},
                            color={0,0,127}));
    connect(TAir,absToRelHum. TDryBul)
      annotation (Line(points={{43,105},{56.2,105},{56.2,87}}, color={0,0,127}));
    connect(mFlowEvap.y, gain.u) annotation (Line(points={{58.7,22},{64,22},{64,32},{-21.2,
            32}},        color={0,0,127}));
    connect(PoolWater.QEvap_in, gain1.y) annotation (Line(points={{-2.6,12.2},{-10,
            12.2},{-10,6},{-15.6,6}},   color={0,0,127}));
    connect(gain.y, gain1.u) annotation (Line(points={{-30.4,32},{-34,32},{-34,6},{-24.8,
            6}},         color={0,0,127}));
    connect(multiSum.y,prescribedHeatFlow. Q_flow) annotation (Line(points={{-80,-21.02},
            {-80,-42},{-66,-42}}, color={0,0,127}));
    connect(multiSum.u[1], gain.y) annotation (Line(points={{-76.85,-8},{-78,-8},{-78,-4},
            {-38,-4},{-38,32},{-30.4,32}},  color={0,0,127}));
  connect(heatTransferWaterSurface.heatport_a, PoolWater.heatPort) annotation (
      Line(points={{-13,52},{-14,52},{-14,16},{-2,16}}, color={191,0,0}));
    connect(ConvPoolSurface, QFlow_Conv_Sensor.port_b) annotation (Line(points={{
            -10,100},{-12,100},{-12,86},{-13,86}}, color={191,0,0}));
    connect(heatTransferWaterSurface.heatPort_b, QFlow_Conv_Sensor.port_a)
      annotation (Line(points={{-13.18,66.4667},{-13,66.4667},{-13,72}}, color={191,
            0,0}));
    connect(QFlow_Conv_Sensor.Q_flow, multiSum.u[2]) annotation (Line(points={{-20,79},{
            -28,79},{-28,44},{-78.95,44},{-78.95,-8}},     color={0,0,127}));
    connect(TRad,prescribedTemperature. T) annotation (Line(points={{-55,105},{-55,
            94.5},{-55,94.5},{-55,83}}, color={0,0,127}));
    connect(prescribedTemperature.port,bodyRadiation. port_b)
      annotation (Line(points={{-55,72},{-55,62}}, color={191,0,0}));
    connect(QFlow_Rad_Sensor.port_b, bodyRadiation.port_a)
      annotation (Line(points={{-53,36},{-55,36},{-55,48}}, color={191,0,0}));
    connect(QFlow_Rad_Sensor.port_a, PoolWater.heatPort) annotation (Line(points={{-53,22},
            {-54,22},{-54,16},{-2,16}},          color={191,0,0}));
    connect(QFlow_Rad_Sensor.Q_flow, multiSum.u[3]) annotation (Line(points={{-60,29},{-72,
            29},{-72,24},{-78,24},{-78,-8},{-81.05,-8}},                color={0,0,
            127}));
    connect(prescribedHeatFlow.port, Watertreatment.heatPort) annotation (Line(
          points={{-46,-42},{-36,-42},{-36,-52},{-6,-52},{-6,-54}}, color={191,0,0}));
    connect(TSoil, heatTransferConduction.TSoil) annotation (Line(points={{107,55},
            {90,55},{90,55.6},{72.6,55.6}}, color={0,0,127}));
    connect(heatTransferConduction.heatport_a, QFlow_Cond_Sensor.port_b)
      annotation (Line(points={{52,52.2},{48,52.2},{48,48},{29,48}}, color={191,0,
            0}));
    connect(PoolWater.heatPort, QFlow_Cond_Sensor.port_a) annotation (Line(points={{-2,16},
            {-14,16},{-14,34},{29,34}},         color={191,0,0}));
    connect(QFlow_Cond_Sensor.Q_flow, multiSum.u[4]) annotation (Line(points={{22,41},{4,
            41},{4,42},{-78,42},{-78,-8},{-83.15,-8}},
          color={0,0,127}));
    connect(circulationPump.port_b, PoolWater.ports[3]) annotation (Line(points={{42,-10},
            {42,-4},{9,-4},{9,6}},         color={0,127,255}));
    connect(circulationPump.P, PPump) annotation (Line(points={{38.32,-9.52},{72,-9.52},
            {72,-16},{108,-16}}, color={0,0,127}));
    connect(multiSum.y, QPool)
      annotation (Line(points={{-80,-21.02},{-80,-30},{108,-30}}, color={0,0,127}));
    connect(QPool, QPool)
      annotation (Line(points={{108,-30},{108,-30}}, color={0,0,127}));
    connect(Watertreatment.ports[2], mFlow_sewer.port_a)
      annotation (Line(points={{2.4,-64},{48,-64}}, color={0,127,255}));
    connect(mFlow_sewer.port_b, sewer.ports[1]) annotation (Line(points={{60,-64},
            {68,-64},{68,-62.8},{76,-62.8}}, color={0,127,255}));
    connect(mFlowSewer.y, mFlow_sewer.m_flow_in) annotation (Line(points={{66.7,-46},
            {68,-46},{68,-59.2},{50.4,-59.2}}, color={0,0,127}));
    connect(pressureBoundary.ports[1], PoolWater.ports[4]) annotation (Line(
          points={{30,10},{20,10},{20,6},{11,6}},        color={0,127,255}));
    connect(Watertreatment.ports[3], circulationPump.port_a) annotation (Line(
          points={{4,-64},{24,-64},{24,-50},{42,-50},{42,-26}}, color={0,127,255}));
  connect(mFlowToPool.y, circulationPump.setMFlow) annotation (Line(points={{
          24.7,-24},{32,-24},{32,-26},{36.24,-26}}, color={0,0,127}));
    connect(mFlow_Evap.port_b, sewer.ports[2])
      annotation (Line(points={{72,9},{72,8},{74,8},{74,-64},{76,-64},{76,-65.2}},
                                                   color={0,127,255}));
    connect(MFlowRecycledWater, mFlowRecycledWater.y) annotation (Line(points={{106,-78},
            {30,-78},{30,-60},{-57.3,-60}}, color={0,0,127}));
    connect(mFlowSewer.y, MFlowWasteWater) annotation (Line(points={{66.7,-46},{80,-46},
            {80,-48},{92,-48},{92,-70},{106,-70}}, color={0,0,127}));
    connect(QEvap, gain.y) annotation (Line(points={{108,-4},{-38,-4},{-38,32},{-30.4,32}},
          color={0,0,127}));


  connect(mFlowRecycledWater.y, pumpPressureDropRecycledWater.setMFlow)
    annotation (Line(points={{-57.3,-60},{-48.65,-60},{-48.65,-69.96},{-50,-69.96}},
        color={0,0,127}));
    connect(recycledWater.ports[1], pumpPressureDropRecycledWater.port_a)
      annotation (Line(points={{-82,-74},{-66,-74},{-66,-75},{-50,-75}}, color={0,
            127,255}));
    connect(pumpPressureDropRecycledWater.port_b, Watertreatment.ports[4])
      annotation (Line(points={{-36,-75},{-14,-75},{-14,-64},{5.6,-64}}, color={0,
            127,255}));
      connect(MFlowRecycledWater, mFlowRecycledWater.y) annotation (Line(points={{106,-78},
            {30,-78},{30,-60},{-57.3,-60}}, color={0,0,127}));

  connect(mFlowFreshWater.y, pumpPressureDropFreshWater.setMFlow) annotation (
      Line(points={{-55.3,-84},{-50.65,-84},{-50.65,-89.4},{-46,-89.4}}, color=
          {0,0,127}));
    connect(mFlowFreshWater.y, MFlowFreshWater) annotation (Line(points={{-55.3,-84},
            {24,-84},{24,-86},{106,-86}}, color={0,0,127}));
    connect(freshWater.ports[1], pumpPressureDropFreshWater.port_a) annotation (
        Line(points={{-82,-92},{-64,-92},{-64,-93},{-46,-93}}, color={0,127,255}));
    connect(pumpPressureDropFreshWater.port_b, Watertreatment.ports[5])
      annotation (Line(points={{-36,-93},{-18,-93},{-18,-94},{2,-94},{2,-64},{7.2,
            -64}}, color={0,127,255}));
    connect(openingHours, inUse.u) annotation (Line(points={{-105,87},{-100,87},{-100,
            86},{-81.2,86}}, color={0,0,127}));
    connect(getTpool.y, TPool) annotation (Line(
          points={{88.7,74},{96,74},{96,86},{108,86}},
          color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
              points={{-72,30}}, color={255,255,170}), Bitmap(extent={{-102,-104},{100,98}},
                           fileName=
                "modelica://AixLib/Fluid/Pools/icon_schwimmbecken.jpg"),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end IndoorSwimmingPool_alt;

  model IndoorSwimmingPool

    package Medium = AixLib.Media.Water;

    parameter DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam
      "Choose setup for this swimming pool" annotation (choicesAllMatching=true);

    //Calculated from record/input data

    final parameter Modelica.SIunits.MassFlowRate m_flow_start = poolParam.Q* Medium.d_const "Mass Flow Rate from Storage to Pool at the beginning";
    final parameter Modelica.SIunits.MassFlowRate m_flow_recycledStart=poolParam.Q*poolParam.x_recycling
                                                                             "Nominal Mass Flow Rate for recycled water, min to catch zero flow";
    final parameter Modelica.SIunits.Volume V_pool= poolParam.A_pool * poolParam.d_pool "Volume of swimming pool water";
    final parameter Modelica.SIunits.SpecificEnergy h_evap = AixLib.Media.Air.enthalpyOfCondensingGas(poolParam.T_pool)
                                                                                                                       "Evaporation enthalpy";
    final parameter Modelica.SIunits.Pressure psat_T_pool=
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
        poolParam.T_pool)
                         "Saturation pressure at pool temperature";
    Modelica.SIunits.Pressure psat_T_Air=
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
        TAir)
             "Saturation pressure at air temperature of the zone";

    Real phi(start=0)  "Relative humidty";


    // Fixed parameters and constants

    final parameter Real beta_nonUse( final unit= "m/s")=7/3600 "Water transfer coefficient during non opening hours";
    final parameter Real beta_cover( final unit= "m/s")=0.7/3600 "Water transfer coefficient during non opening hours";
    final parameter Real beta_wavePool( final unit= "m/s")=50/3600 "Water transfer coefficient during non opening hours";
    final parameter Modelica.SIunits.Pressure pumpHead = 170000
      "Expected average flow resistance of watertreatment cycle";
    final parameter Real epsilon = 0.9*0.95
      "Product of expected emission coefficients of water and the surrounding wall surfaces";
    final constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air=3.5
      "Coefficient of heat transfer between the water surface and the room air";
    final constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_W=820
      "Coefficient of heat transfer between the water and the pool walls";
    final constant Real R_D(final unit="J/(kg.K)") = 461.52
      "Specific gas constant for steam";

    // Flow variables
    Modelica.SIunits.MassFlowRate m_flow_evap( start= 0.001)
                                             "Evaporation mass flow at pool surface";
    Modelica.SIunits.MassFlowRate m_flow_toPool( start=m_flow_start)
                                               "Water supply of pool";
    Modelica.SIunits.MassFlowRate m_flow_freshWater( start=poolParam.m_flow_out)
                                                   "Mass flow rate of fresh water";
    Modelica.SIunits.MassFlowRate m_flow_recycledWater( start=m_flow_recycledStart)
                                                      "Mass flow rate of recycled water";


    MixingVolumes.MixingVolume watertreatment(
      redeclare package Medium = Medium,
      T_start=poolParam.T_pool,
      m_flow_nominal=m_flow_start,
      V=poolParam.V_storage,
      nPorts=4) if
                  not poolParam.use_waterRecycling
               "Fixed Volume to represent the usable volume of the water storage" annotation (Placement(transformation(extent={{-28,-54},
              {-8,-34}})));

    MixingVolumes.MixingVolume watertreatmentWR(
      redeclare package Medium = Medium,
      T_start=poolParam.T_pool,
      m_flow_nominal=m_flow_start,
      V=poolParam.V_storage,
      nPorts=5) if poolParam.use_waterRecycling
      "Fixed Volume to represent the usable volume of the water storage, 5 ports, with waterrecycling"
                                                                                  annotation (Placement(transformation(extent={{-28,-54},
              {-8,-34}})));
    MixingVolumes.MixingVolume         poolWater(
      redeclare package Medium = Medium,
      T_start=poolParam.T_pool,
      m_flow_nominal=m_flow_start,
      V=V_pool,
      nPorts=4)
               "Fixed Volume to represent the pool water" annotation (Placement(transformation(extent={{-12,6},
            {8,26}})));
    Sources.Boundary_pT souFW(
      redeclare package Medium = Medium,
      T=288.15,
      nPorts=1) "Source for fresh water"
      annotation (Placement(transformation(extent={{-94,-98},{-82,-86}})));
    Sources.Boundary_pT souRW(
      redeclare package Medium = Medium,
      T=poolParam.T_pool - 3,
      nPorts=1) if poolParam.x_recycling > 0
                "Source for recycled water"
      annotation (Placement(transformation(extent={{-94,-76},{-82,-64}})));
    Sources.Boundary_pT sink(redeclare package Medium = Medium, nPorts=2)
      "Sink for waste water and evaporating water"
      annotation (Placement(transformation(extent={{88,-70},{76,-58}})));

    Movers.BaseClasses.IdealSource mFlowEvap(
      redeclare package Medium = Medium,
      m_flow_small=0.00000000001,
      show_V_flow=false,
      control_m_flow=true,
      control_dp=false) "Set mass flow rate to present water losses due to evaporation"
      annotation (Placement(transformation(extent={{60,2},{68,10}})));

    Modelica.Blocks.Sources.RealExpression getMFlowRW(final y=m_flow_recycledWater)
      "Prescribed mass flow for intake of recycled water into the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{-72,-66},{-58,-54}})));

    Modelica.Blocks.Sources.RealExpression getMFlowFW(final y=m_flow_freshWater)
      "Prescribed mass flow for intake of fresh water into the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{-72,-92},{-58,-80}})));

    Modelica.Blocks.Sources.RealExpression getMFlowToPool(final y=m_flow_toPool)
      "Prescribed mass flow to depict the mass flow from the watertreatment back to the swimming pool"
      annotation (Placement(transformation(extent={{-4,-52},{10,-40}})));

    Modelica.Blocks.Sources.RealExpression getMFlowEvap(final y=m_flow_evap)
      "Calculated evaporation mass flow"
      annotation (Placement(transformation(extent={{42,12},{56,24}})));

    Modelica.Blocks.Math.Gain hEvapGain(final k=h_evap)
      "Calculation of heat flow rate due to evaporation"
      annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={64,30})));

    ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum
      "Calculation of the relative humidity of the room air "
      annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=-90,
          origin={59,81})));
    Modelica.Blocks.Interfaces.RealInput TAir(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Temperature of the surrounding room air" annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={43,105})));

    Modelica.Blocks.Interfaces.RealInput X_w "Absolute humidty of the room Air"
      annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={73,105})));
    Modelica.Blocks.Math.Gain minus1Gain(final k=-1) annotation (Placement(
          transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={34,38})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPoolSurface
      "Air Temperature in Zone"
      annotation (Placement(transformation(extent={{-18,88},{6,112}}),
        iconTransformation(extent={{-22,88},{2,112}})));
    Modelica.Thermal.HeatTransfer.Components.BodyRadiation radWaterSurface(final Gr=
        epsilon*poolParam.A_pool)
    "Model to depict the heat flow rate due to radiation between the pool surface an the surrounding walls"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-45,55})));

    Utilities.Interfaces.RadPort radPoolSurface
    "Mean Radiation Temperature of surrounding walls" annotation (Placement(
        transformation(
        extent={{-8,-9},{8,9}},
        rotation=-90,
        origin={-45,104}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={-68,104})));
    BaseClasses.HeatTransferConduction heatTransferConduction(
    T_start=poolParam.T_pool,
      AExt=poolParam.AExt,
      hConExt=poolParam.hConExt,
      nInt=poolParam.nInt,
      RInt=poolParam.RInt,
      CInt=poolParam.CInt,
      AInt=poolParam.AInt,
      hConInt=poolParam.hConInt,
      nFloor=poolParam.nFloor,
      RFloor=poolParam.RFloor,
      RFloorRem=poolParam.RFloorRem,
      CFloor=poolParam.CFloor,
      AFloor=poolParam.AFloor,
      hConFloor=poolParam.hConFloor,
      final nExt=poolParam.nExt,
      final CExt=poolParam.CExt,
      final RExt=poolParam.RExt,
      final RExtRem=poolParam.RExtRem)
      "Model to depict the heat flow rate through the pool walls to the bordering room/soil"
      annotation (Placement(transformation(extent={{30,50},{46,66}})));
    Modelica.Blocks.Interfaces.RealInput TSoil(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Temperature of Soil" annotation (Placement(
          transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={107,61}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={107,55})));

    BaseClasses.PumpAndPressureDrop circPump(
      final replaceable package Medium = Medium,
      final m_flow_nominal=m_flow_start,
      final pumpHead=pumpHead,
      p_start=200000,
      T_water=poolParam.T_pool)
      "Pumping system to depict power consumption and set the right mass flow rate"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=90,
          origin={24,-44})));

    Modelica.Blocks.Interfaces.RealOutput PPool(final quantity="Power", final unit="W")
      "Output eletric energy needed for pool operation"
      annotation (Placement(transformation(extent={{100,-28},{120,-8}}),
        iconTransformation(extent={{98,-26},{118,-6}})));
    Modelica.Blocks.Interfaces.RealOutput QPool(final quantity="HeatFlowRate", final
        unit="W") "Heat needed to compensate losses"
      annotation (Placement(transformation(extent={{100,-16},{120,4}}),
        iconTransformation(extent={{98,-40},{118,-20}})));
    Movers.BaseClasses.IdealSource mFlowWW(
      redeclare package Medium = Medium,
      m_flow_small=0.00000000001,
      control_m_flow=true,
      control_dp=false)
      "Set correct mass flow for waste water out of the pool-watertreatment-cycle"
      annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=0,
          origin={56,-62})));
    Modelica.Blocks.Sources.RealExpression getMFlowOut(final y=poolParam.m_flow_out)
      "Prescribed mass flow of waste water out of the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{44,-52},{58,-40}})));
    Sources.Boundary_pT preBou(
      redeclare package Medium = Medium,
      p=200000,
      nPorts=1) annotation (Placement(transformation(extent={{38,10},{30,18}})));
    Modelica.Blocks.Interfaces.RealOutput MFlowFW(final quantity="MassFlowRate", final
        unit="kg/s") "Fresh water to compensate waste water and evaporation losses"
      annotation (Placement(transformation(extent={{96,-96},{116,-76}})));
    Modelica.Blocks.Interfaces.RealOutput MFlowRW(final quantity="MassFlowRate", final
        unit="kg/s") "Recycled Water to compensate waste water and evaporation losses"
      annotation (Placement(transformation(extent={{96,-88},{116,-68}})));
    Modelica.Blocks.Interfaces.RealOutput MFlowWW(final quantity="MassFlowRate", final
        unit="kg/s") "Waste wate due to filter flusehs and visitors"
      annotation (Placement(transformation(extent={{96,-80},{116,-60}})));
    Modelica.Blocks.Interfaces.RealOutput QEvap(final quantity="HeatFlowRate", final
        unit="W") "Heat needed to compensate losses"
      annotation (Placement(transformation(extent={{98,28},{118,48}}),
        iconTransformation(extent={{98,-14},{118,6}})));
    Movers.BaseClasses.IdealSource mFlowRW(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    control_m_flow=true,
    control_dp=false) if               poolParam.x_recycling > 0
    "Pump to set the right mass flow rate for recycled water consumption"
    annotation (Placement(transformation(extent={{-44,-74},{-36,-66}})));
    Movers.BaseClasses.IdealSource mFlowFW(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    control_m_flow=true,
    control_dp=false)
    "Pump to set the right mass flow rate for fresh water consumption"
    annotation (Placement(transformation(extent={{-44,-96},{-36,-88}})));
    Modelica.Blocks.Math.RealToBoolean inUse(threshold=1)
    "If input = 1, then inUse.y=true, else pool inUse.y=false"
      annotation (Placement(transformation(extent={{-78,80},{-66,92}})));
    Modelica.Blocks.Interfaces.RealInput openingHours
      "Profil opening hours input"
      annotation (Placement(transformation(extent={{-118,74},{-92,100}})));
    Modelica.Blocks.Interfaces.RealOutput TPool
      "Output Pool Temperature" annotation (
        Placement(transformation(extent={{98,2},{118,22}}), iconTransformation(
          extent={{98,76},{118,96}})));
    Modelica.Blocks.Sources.Constant       getTpool(k=poolParam.T_pool)
      "Prescribed mass flow for intake of fresh water into the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{82,10},{88,16}})));
    HeatExchangers.PrescribedOutlet preQPool(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_start,
      dp_nominal=0,
      T_start=poolParam.T_pool,
      use_X_wSet=false)
      "Calculates heat flow rate to keep Watertemperature at a steady level"
      annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=0,
          origin={27,-11})));
    Modelica.Blocks.Math.RealToBoolean lunchbreak(threshold=0.5)
      "If input = 0.5, then lunchBreak =true, not in use and  without cover, even if cover is installed during night"
      annotation (Placement(transformation(extent={{-78,60},{-66,72}})));
    Modelica.Blocks.Interfaces.RealInput wavePool "Input profil wavePool "
      annotation (Placement(transformation(extent={{-122,-34},{-96,-8}}),
        iconTransformation(extent={{-118,42},{-92,68}})));
    BaseClasses.waveMachine waveMachine(h_wave=poolParam.h_wave, w_wave=poolParam.w_wave)
                      "Power consumption of wave machine"
      annotation (Placement(transformation(extent={{-82,-34},{-66,-18}})));
    Modelica.Blocks.Math.MultiSum sumP(nu=2) if poolParam.use_wavePool
      "Sum of power consumption of all components"
      annotation (Placement(transformation(extent={{54,-30},{62,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow presHeatFlowEvapLoss
    annotation (Placement(transformation(extent={{22,32},{10,44}})));
    Modelica.Blocks.Sources.Constant getHeatCoefConv(k=alpha_Air*poolParam.A_pool)
    "Coefficient of heat transfer between water surface and room air"
    annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={4,74})));
    Modelica.Thermal.HeatTransfer.Components.Convection convWaterSurface
    "Convection at the watersurface" annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-14,74})));
  equation

    phi=absToRelHum.relHum;

     if inUse.y or not poolParam.use_partialLoad then
       m_flow_toPool = poolParam.Q*Medium.d_const;
     else
       m_flow_toPool= poolParam.Q_night*Medium.d_const;
     end if;


     if (psat_T_pool - phi* psat_T_Air)<0 then
         m_flow_evap=0.0;
     else
       if inUse.y then
         if poolParam.use_wavePool then
           if waveMachine.use_wavePool then
             m_flow_evap = (beta_wavePool)/(R_D*0.5*(poolParam.T_pool + TAir))*(psat_T_pool - phi*
             psat_T_Air)*poolParam.A_pool;
           else
             m_flow_evap = (poolParam.beta_inUse)/(R_D*0.5*(poolParam.T_pool + TAir))*(psat_T_pool - phi*
             psat_T_Air)*poolParam.A_pool;
           end if;
         else
           m_flow_evap = (poolParam.beta_inUse)/(R_D*0.5*(poolParam.T_pool + TAir))*(psat_T_pool - phi*
             psat_T_Air)*poolParam.A_pool;
         end if;
       else
        if not poolParam.use_poolCover or lunchbreak.y then
         m_flow_evap = (beta_nonUse)/(R_D*0.5*(poolParam.T_pool + TAir))*(psat_T_pool - phi*
          psat_T_Air)*poolParam.A_pool;
         else
         m_flow_evap = (beta_cover)/(R_D*0.5*(poolParam.T_pool + TAir))*(psat_T_pool - phi*
          psat_T_Air)*poolParam.A_pool;
        end if;
       end if;
     end if;




  if poolParam.use_waterRecycling then

    connect(poolWater.ports[1],watertreatmentWR. ports[1]) annotation (Line(points={{-5,6},{
            -40,6},{-40,-54},{-21.2,-54}},  color={0,127,255}));
    connect(watertreatmentWR.ports[2], mFlowWW.port_a) annotation (Line(points={{-19.6,
            -54},{22,-54},{22,-62},{52,-62}},
                                         color={0,127,255}));
    connect(watertreatmentWR.ports[3], circPump.port_a)
      annotation (Line(points={{-18,-54},{24,-54},{24,-52}}, color={0,127,255}));
    connect(mFlowFW.port_b, watertreatmentWR.ports[4]) annotation (Line(points=
            {{-36,-92},{-14,-92},{-14,-54},{-16.4,-54}}, color={0,127,255}));
    connect(mFlowRW.port_b, watertreatmentWR.ports[5]) annotation (Line(points=
            {{-36,-70},{-14,-70},{-14,-54},{-14.8,-54}}, color={0,127,255}));
    m_flow_freshWater = (1-poolParam.x_recycling)*(poolParam.m_flow_out + m_flow_evap);
    m_flow_recycledWater = poolParam.x_recycling *(poolParam.m_flow_out + m_flow_evap);

  else
    connect(poolWater.ports[1],watertreatment. ports[1]) annotation (Line(points={{-5,6},{
            -40,6},{-40,-54},{-21,-54}},    color={0,127,255}));
    connect(watertreatment.ports[2], mFlowWW.port_a) annotation (Line(points={{-19,-54},
            {22,-54},{22,-62},{52,-62}}, color={0,127,255}));
    connect(watertreatment.ports[3], circPump.port_a)
      annotation (Line(points={{-17,-54},{24,-54},{24,-52}}, color={0,127,255}));
    connect(mFlowFW.port_b, watertreatment.ports[4]) annotation (Line(points={{
            -36,-92},{-14,-92},{-14,-54},{-15,-54}}, color={0,127,255}));
    m_flow_freshWater= poolParam.m_flow_out+m_flow_evap;
    m_flow_recycledWater=0.0;
  end if;

    connect(getMFlowEvap.y, mFlowEvap.m_flow_in)
      annotation (Line(points={{56.7,18},{61.6,18},{61.6,9.2}},
                                                           color={0,0,127}));
    connect(poolWater.ports[2], mFlowEvap.port_a)
      annotation (Line(points={{-3,6},{60,6}},       color={0,127,255}));
    connect(X_w,absToRelHum. absHum) annotation (Line(points={{73,105},{60,105},
          {60,87},{61.6,87}},
                            color={0,0,127}));
    connect(TAir,absToRelHum. TDryBul)
      annotation (Line(points={{43,105},{56.2,105},{56.2,87}}, color={0,0,127}));
    connect(getMFlowEvap.y, hEvapGain.u)
      annotation (Line(points={{56.7,18},{64,18},{64,25.2}},          color={0,0,127}));
    connect(hEvapGain.y, minus1Gain.u) annotation (Line(points={{64,34.4},{64,
          38},{38.8,38}},  color={0,0,127}));

    if poolParam.AExt>0 or poolParam.AFloor>0 then
      connect(TSoil, heatTransferConduction.TSoil) annotation (Line(points={{107,61},
            {90,61},{90,60.88},{46.48,60.88}},
                                            color={0,0,127}));
    end if;

    connect(QPool, QPool)
      annotation (Line(points={{110,-6},{110,-6}},   color={0,0,127}));

    connect(mFlowWW.port_b, sink.ports[1]) annotation (Line(points={{60,-62},{
          68,-62},{68,-62.8},{76,-62.8}},
                                color={0,127,255}));
    connect(getMFlowOut.y, mFlowWW.m_flow_in) annotation (Line(points={{58.7,
          -46},{70,-46},{70,-58.8},{53.6,-58.8}},
                                      color={0,0,127}));
    connect(preBou.ports[1], poolWater.ports[3])
      annotation (Line(points={{30,14},{20,14},{20,6},{-1,6}},color={0,127,255}));

  connect(getMFlowToPool.y, circPump.setMFlow) annotation (Line(points={{10.7,
          -46},{14,-46},{14,-52},{18.24,-52}}, color={0,0,127}));
    connect(mFlowEvap.port_b, sink.ports[2])
      annotation (Line(points={{68,6},{76,6},{76,-65.2}},        color={0,127,255}));
    connect(MFlowRW, getMFlowRW.y) annotation (Line(points={{106,-78},{14,-78},{14,-60},{
            -57.3,-60}}, color={0,0,127}));
    connect(getMFlowOut.y, MFlowWW) annotation (Line(points={{58.7,-46},{80,-46},{80,-48},
            {92,-48},{92,-70},{106,-70}}, color={0,0,127}));
    connect(QEvap, hEvapGain.y) annotation (Line(points={{108,38},{64,38},{64,
          34.4}},                 color={0,0,127}));


  connect(souRW.ports[1], mFlowRW.port_a)
    annotation (Line(points={{-82,-70},{-44,-70}}, color={0,127,255}));


    connect(getMFlowFW.y, MFlowFW)
      annotation (Line(points={{-57.3,-86},{106,-86}}, color={0,0,127}));
  connect(souFW.ports[1], mFlowFW.port_a)
    annotation (Line(points={{-82,-92},{-44,-92}}, color={0,127,255}));

    connect(openingHours, inUse.u) annotation (Line(points={{-105,87},{-100,87},
          {-100,86},{-79.2,86}},
                             color={0,0,127}));
    connect(getTpool.y, TPool) annotation (Line(
          points={{88.3,13},{96,13},{96,12},{108,12}},
          color={0,0,127}));
  connect(poolWater.heatPort, radWaterSurface.port_a) annotation (Line(points={
          {-12,16},{-44,16},{-44,48},{-45,48}}, color={191,0,0}));
    connect(poolWater.heatPort, heatTransferConduction.heatport_a) annotation (
        Line(points={{-12,16},{-14,16},{-14,58.16},{30,58.16}},            color={
            191,0,0}));
    connect(preQPool.port_b,poolWater. ports[4]) annotation (Line(points={{34,-11},
          {38,-11},{38,6},{1,6}},    color={0,127,255}));
    connect(preQPool.port_a, circPump.port_b) annotation (Line(points={{20,-11},
          {20,-10},{18,-10},{18,-24},{24,-24},{24,-36}},
                                color={0,127,255}));
    connect(preQPool.Q_flow, QPool) annotation (Line(points={{34.7,-5.4},{104,
          -5.4},{104,-6},{110,-6}},
                             color={0,0,127}));
    connect(getTpool.y, preQPool.TSet) annotation (Line(points={{88.3,13},{92,
          13},{92,-2},{18.6,-2},{18.6,-5.4}},
                                       color={0,0,127}));
    connect(openingHours,lunchbreak. u) annotation (Line(points={{-105,87},{
          -93.5,87},{-93.5,66},{-79.2,66}},
                                        color={0,0,127}));
    connect(wavePool, waveMachine.wavePool) annotation (Line(points={{-109,-21},
          {-100.5,-21},{-100.5,-22.8},{-82.64,-22.8}},
                                        color={0,0,127}));

    if poolParam.use_wavePool then
      connect(circPump.P, sumP.u[1]) annotation (Line(points={{20.32,-35.52},{
            20.32,-36},{20,-36},{20,-32},{38,-32},{38,-24.6},{54,-24.6}},
                                      color={0,0,127}));
      connect(waveMachine.PWaveMachine, sumP.u[2]) annotation (Line(points={{-65.52,
            -26},{54,-26},{54,-27.4}},        color={0,0,127}));
      connect(sumP.y, PPool) annotation (Line(points={{62.68,-26},{86,-26},{86,
            -18},{110,-18}},
                   color={0,0,127}));
    else
      connect(circPump.P, PPool) annotation (Line(points={{20.32,-35.52},{20,
            -35.52},{20,-32},{38,-32},{38,-18},{110,-18}},
                               color={0,0,127}));
    end if;


  connect(radWaterSurface.port_b, radPoolSurface)
    annotation (Line(points={{-45,62},{-45,104}}, color={191,0,0}));
  connect(getMFlowRW.y, mFlowRW.m_flow_in) annotation (Line(points={{-57.3,-60},
          {-52,-60},{-52,-66.8},{-42.4,-66.8}}, color={0,0,127}));
  connect(getMFlowFW.y, mFlowFW.m_flow_in) annotation (Line(points={{-57.3,-86},
          {-50,-86},{-50,-88.8},{-42.4,-88.8}}, color={0,0,127}));
  connect(presHeatFlowEvapLoss.port, poolWater.heatPort) annotation (Line(
        points={{10,38},{-14,38},{-14,16},{-12,16}}, color={191,0,0}));
  connect(minus1Gain.y, presHeatFlowEvapLoss.Q_flow)
    annotation (Line(points={{29.6,38},{22,38}}, color={0,0,127}));
  connect(getHeatCoefConv.y, convWaterSurface.Gc)
    annotation (Line(points={{-0.4,74},{-8,74}}, color={0,0,127}));
  connect(convWaterSurface.fluid, convPoolSurface)
    annotation (Line(points={{-14,80},{-14,100},{-6,100}}, color={191,0,0}));
  connect(convWaterSurface.solid, poolWater.heatPort)
    annotation (Line(points={{-14,68},{-14,16},{-12,16}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
              points={{-72,30}}, color={255,255,170}), Bitmap(extent={{-102,-104},{100,98}},
                           fileName=
                "modelica://AixLib/Fluid/Pools/icon_schwimmbecken.jpg"),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end IndoorSwimmingPool;
end Pools;
