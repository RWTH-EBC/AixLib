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
    connect(heatTransferWaterSurface.heatport_noCover, PoolWater.heatPort)
      annotation (Line(points={{-13,52},{-14,52},{-14,16},{-2,16}}, color={191,0,0}));
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
    connect(mFlowToPool.y, circulationPump.m_flow_pump) annotation (Line(points={{
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


    connect(mFlowRecycledWater.y, pumpPressureDropRecycledWater.m_flow_pump)
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

    connect(mFlowFreshWater.y, pumpPressureDropFreshWater.m_flow_pump)
      annotation (Line(points={{-55.3,-84},{-50.65,-84},{-50.65,-89.4},{-46,-89.4}},
          color={0,0,127}));
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
    Modelica.SIunits.MassFlowRate m_flow_freshWater( start=poolParam.m_flow_sewer)
                                                   "Mass flow rate of fresh water";
    Modelica.SIunits.MassFlowRate m_flow_recycledWater( start=m_flow_recycledStart)
                                                      "Mass flow rate of recycled water";


    MixingVolumes.MixingVolume Watertreatment(
      redeclare package Medium = Medium,
      T_start=poolParam.T_pool,
      m_flow_nominal=m_flow_start,
      V=poolParam.V_storage,
      nPorts=5)
               "Fixed Volume to represent the usable volume of the water storage" annotation (Placement(transformation(extent={{-28,-54},
              {-8,-34}})));
    BaseClasses.MixingVolumeEvapLosses PoolWater(
      redeclare package Medium = Medium,
      T_start=poolParam.T_pool,
      m_flow_nominal=m_flow_start,
      V=V_pool,
      nPorts=4)
               "Fixed Volume to represent the pool water" annotation (Placement(transformation(extent={{-2,6},{
              18,26}})));
    Sources.Boundary_pT                   freshWater(redeclare package Medium =
          Medium,
      T=283.15,
      nPorts=1)
               "Source for fresh water"
      annotation (Placement(transformation(extent={{-94,-98},{-82,-86}})));
    Sources.Boundary_pT                   recycledWater(redeclare package Medium =
          Medium,
      T=poolParam.T_pool - 5,
      nPorts=1) "Source for recycled water"
      annotation (Placement(transformation(extent={{-94,-80},{-82,-68}})));
    Sources.Boundary_pT                   sewer(redeclare package Medium =
          Medium,
      nPorts=2) "Sink for waste water"
      annotation (Placement(transformation(extent={{88,-70},{76,-58}})));

    Movers.BaseClasses.IdealSource mFlow_Evap(redeclare package Medium =
          Medium,
      m_flow_small=0.00000000001,
      show_V_flow=false,
      control_m_flow=true,
      control_dp=false)
      "Set mass flow rate to present water losses due to evaporation"
      annotation (Placement(transformation(extent={{64,2},{74,12}})));

    Modelica.Blocks.Sources.RealExpression mFlowRecycledWater(final y=
          m_flow_recycledWater)
      "Prescribed mass flow for intake of recycled water into the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{-72,-66},{-58,-54}})));

    Modelica.Blocks.Sources.RealExpression mFlowFreshWater(final y=m_flow_freshWater)
      "Prescribed mass flow for intake of fresh water into the pool-watertreatment cycle"
      annotation (Placement(transformation(extent={{-70,-90},{-56,-78}})));

    Modelica.Blocks.Sources.RealExpression mFlowToPool(final y=m_flow_toPool)
      "Prescribed mass flow to depict the mass flow from the watertreatment back to the swimming pool"
      annotation (Placement(transformation(extent={{-4,-52},{10,-40}})));

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
          origin={-20,8})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvPoolSurface
      "Air Temperature in Zone"
      annotation (Placement(transformation(extent={{-22,88},{2,112}})));
    BaseClasses.HeatTransferWaterSurface heatTransferWaterSurface(final alpha_Air=alpha_Air,
    final A= poolParam.A_pool)
      "Model to describe heat flow at the water surface due to convection"
      annotation (Placement(transformation(extent={{-22,52},{-4,66}})));
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
          origin={26,-44})));

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
      nPorts=1) annotation (Placement(transformation(extent={{38,14},{30,22}})));
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
    HeatExchangers.PrescribedOutlet preQPool(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_start,
      dp_nominal=0,
      T_start=poolParam.T_pool,
      use_X_wSet=false)
      "Calculates heat flow rate to keep Watertemperature at a steady level"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={38,-20})));
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
    connect(PoolWater.ports[1], Watertreatment.ports[1]) annotation (Line(points={{5,6},{0,
            6},{0,-4},{-40,-4},{-40,-52},{-30,-52},{-30,-54},{-21.2,-54}},
                                            color={0,127,255}));
    connect(mFlowEvap.y, mFlow_Evap.m_flow_in) annotation (Line(points={{58.7,22},
            {66,22},{66,11}},          color={0,0,127}));
    connect(PoolWater.ports[2], mFlow_Evap.port_a)
      annotation (Line(points={{7,6},{64,6},{64,7}}, color={0,127,255}));
    connect(X_w,absToRelHum. absHum) annotation (Line(points={{73,105},{60,105},
          {60,87},{61.6,87}},
                            color={0,0,127}));
    connect(TAir,absToRelHum. TDryBul)
      annotation (Line(points={{43,105},{56.2,105},{56.2,87}}, color={0,0,127}));
    connect(mFlowEvap.y, gain.u) annotation (Line(points={{58.7,22},{64,22},{64,32},{-21.2,
            32}},        color={0,0,127}));
    connect(PoolWater.QEvap_in, gain1.y) annotation (Line(points={{-2.6,12.2},{-10,
            12.2},{-10,8},{-15.6,8}},   color={0,0,127}));
    connect(gain.y, gain1.u) annotation (Line(points={{-30.4,32},{-34,32},{-34,8},
            {-24.8,8}},  color={0,0,127}));
    connect(heatTransferWaterSurface.heatport_noCover, PoolWater.heatPort)
      annotation (Line(points={{-13,52},{-14,52},{-14,16},{-2,16}}, color={191,0,0}));
    connect(TRad,prescribedTemperature. T) annotation (Line(points={{-55,105},{-55,
            94.5},{-55,94.5},{-55,83}}, color={0,0,127}));
    connect(prescribedTemperature.port,bodyRadiation. port_b)
      annotation (Line(points={{-55,72},{-55,62}}, color={191,0,0}));
    connect(TSoil, heatTransferConduction.TSoil) annotation (Line(points={{107,55},
            {90,55},{90,55.6},{72.6,55.6}}, color={0,0,127}));
    connect(circulationPump.P, PPump) annotation (Line(points={{22.32,-35.52},{72,
            -35.52},{72,-16},{108,-16}},
                                 color={0,0,127}));
    connect(QPool, QPool)
      annotation (Line(points={{108,-30},{108,-30}}, color={0,0,127}));
    connect(Watertreatment.ports[2], mFlow_sewer.port_a)
      annotation (Line(points={{-19.6,-54},{22,-54},{22,-64},{48,-64}},
                                                    color={0,127,255}));
    connect(mFlow_sewer.port_b, sewer.ports[1]) annotation (Line(points={{60,-64},
            {68,-64},{68,-62.8},{76,-62.8}}, color={0,127,255}));
    connect(mFlowSewer.y, mFlow_sewer.m_flow_in) annotation (Line(points={{66.7,-46},
            {68,-46},{68,-59.2},{50.4,-59.2}}, color={0,0,127}));
    connect(pressureBoundary.ports[1], PoolWater.ports[3]) annotation (Line(
          points={{30,18},{20,18},{20,6},{9,6}},         color={0,127,255}));
    connect(Watertreatment.ports[3], circulationPump.port_a) annotation (Line(
          points={{-18,-54},{24,-54},{24,-50},{26,-50},{26,-52}},
                                                                color={0,127,255}));
    connect(mFlowToPool.y, circulationPump.m_flow_pump) annotation (Line(points={{10.7,
            -46},{14,-46},{14,-52},{20.24,-52}},      color={0,0,127}));
    connect(mFlow_Evap.port_b, sewer.ports[2])
      annotation (Line(points={{74,7},{74,-30},{76,-30},{76,-65.2}},
                                                   color={0,127,255}));
    connect(MFlowRecycledWater, mFlowRecycledWater.y) annotation (Line(points={{106,-78},
            {30,-78},{30,-60},{-57.3,-60}}, color={0,0,127}));
    connect(mFlowSewer.y, MFlowWasteWater) annotation (Line(points={{66.7,-46},{80,-46},
            {80,-48},{92,-48},{92,-70},{106,-70}}, color={0,0,127}));
    connect(QEvap, gain.y) annotation (Line(points={{108,-4},{36,-4},{36,0},{-38,0},
            {-38,32},{-30.4,32}},
          color={0,0,127}));


    connect(mFlowRecycledWater.y, pumpPressureDropRecycledWater.m_flow_pump)
      annotation (Line(points={{-57.3,-60},{-48.65,-60},{-48.65,-69.96},{-50,-69.96}},
          color={0,0,127}));
    connect(recycledWater.ports[1], pumpPressureDropRecycledWater.port_a)
      annotation (Line(points={{-82,-74},{-66,-74},{-66,-75},{-50,-75}}, color={0,
            127,255}));
    connect(pumpPressureDropRecycledWater.port_b, Watertreatment.ports[4])
      annotation (Line(points={{-36,-75},{-14,-75},{-14,-54},{-16.4,-54}},
                                                                         color={0,
            127,255}));
      connect(MFlowRecycledWater, mFlowRecycledWater.y) annotation (Line(points={{106,-78},
            {30,-78},{30,-60},{-57.3,-60}}, color={0,0,127}));

    connect(mFlowFreshWater.y, pumpPressureDropFreshWater.m_flow_pump)
      annotation (Line(points={{-55.3,-84},{-50.65,-84},{-50.65,-89.4},{-46,-89.4}},
          color={0,0,127}));
    connect(mFlowFreshWater.y, MFlowFreshWater) annotation (Line(points={{-55.3,-84},
            {24,-84},{24,-86},{106,-86}}, color={0,0,127}));
    connect(freshWater.ports[1], pumpPressureDropFreshWater.port_a) annotation (
        Line(points={{-82,-92},{-64,-92},{-64,-93},{-46,-93}}, color={0,127,255}));
    connect(pumpPressureDropFreshWater.port_b, Watertreatment.ports[5])
      annotation (Line(points={{-36,-93},{-18,-93},{-18,-94},{2,-94},{2,-54},{-14.8,
            -54}}, color={0,127,255}));
    connect(openingHours, inUse.u) annotation (Line(points={{-105,87},{-100,87},{-100,
            86},{-81.2,86}}, color={0,0,127}));
    connect(getTpool.y, TPool) annotation (Line(
          points={{88.7,74},{96,74},{96,86},{108,86}},
          color={0,0,127}));
    connect(heatTransferWaterSurface.heatPort_b, ConvPoolSurface) annotation (
        Line(points={{-13.18,66.4667},{-13.18,83.2334},{-10,83.2334},{-10,100}},
          color={191,0,0}));
    connect(PoolWater.heatPort, bodyRadiation.port_a) annotation (Line(points={{-2,
            16},{-54,16},{-54,48},{-55,48}}, color={191,0,0}));
    connect(PoolWater.heatPort, heatTransferConduction.heatport_a) annotation (
        Line(points={{-2,16},{-14,16},{-14,38},{2,38},{2,52.2},{52,52.2}}, color={
            191,0,0}));
    connect(preQPool.port_b, PoolWater.ports[4]) annotation (Line(points={{48,-20},
            {54,-20},{54,6},{11,6}}, color={0,127,255}));
    connect(preQPool.port_a, circulationPump.port_b) annotation (Line(points={{28,
            -20},{28,-28},{26,-28},{26,-36}}, color={0,127,255}));
    connect(preQPool.Q_flow, QPool) annotation (Line(points={{49,-12},{64,-12},{64,
            -30},{108,-30}}, color={0,0,127}));
  connect(getTpool.y, preQPool.TSet) annotation (Line(points={{88.7,74},{88.7,
          30},{26,30},{26,-12}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
              points={{-72,30}}, color={255,255,170}), Bitmap(extent={{-102,-104},{100,98}},
                           fileName=
                "modelica://AixLib/Fluid/Pools/icon_schwimmbecken.jpg"),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end IndoorSwimmingPool;
end Pools;
