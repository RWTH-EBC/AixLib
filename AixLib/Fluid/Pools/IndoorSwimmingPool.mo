within AixLib.Fluid.Pools;
model IndoorSwimmingPool

  package Medium = AixLib.Fluid.Pools.BaseClasses.Water30degC;

  // ***********************Defined by Record*****************

  parameter Modelica.SIunits.Temperature T_pool "Water temperature of swimming pool";
  parameter Modelica.SIunits.Volume V_storage "Usable Volume of water storage";
  parameter Modelica.SIunits.Area A_pool "Area of water surface of swimming pool";
  parameter Modelica.SIunits.Length d_pool "Depth of swimming pool";
  parameter Real openAt = 7 "Swimming hall opens at, 7 am default value";
  parameter Real openingHours = 16/24 "Open for x/24 hours";
  parameter Modelica.SIunits.VolumeFlowRate Q(min= 0.0001) "Volume Flow Rate";

  parameter Real beta_inUse "Water transfer coefficient during opening hours";
  parameter Real beta_nonUse "Water transfer coefficient during non opening hours";

  parameter Boolean PartialLoad  "Partial load operation implemented for the non opening hours?";
  parameter Real x_partialLoad "In case of partial load: percentage of mass flow rate of opening hours, which is active during non-opening hours";
  parameter Boolean poolCover "Pool cover installed for non opening hours?";
  parameter Boolean WaterRecycling "Recycled water used for refilling pool water?";
  parameter Real x_recycling "Percentage of fill water which comes from the recycling unit";
  parameter Boolean NextToSoil "Pool bedded into the soil? (or does it abut a room?)";

    //Pool Wall
  parameter Integer nExt(min=1) "Number of RC-elements of exterior walls"
    annotation (Dialog(group="Exterior walls"));
  parameter Modelica.SIunits.ThermalResistance RExt[nExt](each min=Modelica.Constants.small)
    "Vector of resistors, from port_a to port_b"
    annotation (Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.ThermalResistance RExtRem(min=Modelica.Constants.small)
    "Resistance of remaining resistor RExtRem between capacitor n and port_b"
    annotation (Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.HeatCapacity CExt[nExt](each min=Modelica.Constants.small)
    "Vector of heat capacities, from port_a to port_b"
    annotation (Dialog(group="Thermal mass"));


  //*********************************************
  //****************END RECORD DATA *************

  //Calculated from record/input data

  parameter Modelica.SIunits.MassFlowRate m_flow_start = Q* Medium.d_const;
  final parameter Modelica.SIunits.Volume V_pool= A_pool * d_pool "Volume of swimming pool water";
  final parameter Modelica.SIunits.SpecificEnergy h_evap = AixLib.Media.Air.enthalpyOfCondensingGas(T_pool);
  parameter Modelica.SIunits.Pressure psat_T_pool=
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
      T_pool);
  Modelica.SIunits.Pressure psat_T_Air=
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
      TAir);

  Real phi=absToRelHum.relHum;

  // Fixed parameters

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
  Modelica.SIunits.MassFlowRate m_flow_evap;
  Modelica.SIunits.MassFlowRate m_flow_toPool;
  Modelica.SIunits.MassFlowRate m_flow_freshWater;
  Modelica.SIunits.MassFlowRate m_flow_recycledWater;

  MixingVolumes.MixingVolume Watertreatment(
    redeclare package Medium = AixLib.Fluid.Pools.BaseClasses.Water30degC,
    T_start=T_pool,
    m_flow_nominal=m_flow_start,
    V=V_storage,
    nPorts=5) annotation (Placement(transformation(extent={{-6,-64},{14,-44}})));
  BaseClasses.MixingVolumeEvapLosses PoolWater(
    redeclare package Medium = Medium,
    T_start=T_pool,
    m_flow_nominal=m_flow_start,
    V=V_pool,
    nPorts=3) annotation (Placement(transformation(extent={{-2,4},{18,24}})));
  Modelica.Fluid.Interfaces.FluidPort_a freshWater(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC)
    annotation (Placement(transformation(extent={{-110,-104},{-90,-84}})));
  Modelica.Fluid.Interfaces.FluidPort_a recycledWater(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC)
    annotation (Placement(transformation(extent={{-110,-86},{-90,-66}})));
  Modelica.Fluid.Interfaces.FluidPort_b sewer(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC)
    annotation (Placement(transformation(extent={{90,-64},{110,-44}})));
  Modelica.Fluid.Interfaces.FluidPort_b MEvap(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC)
    annotation (Placement(transformation(extent={{90,2},{110,22}})));

  Movers.BaseClasses.IdealSource mFlow_toPool(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC,
    m_flow_small=0.00000000001,
    control_m_flow=true,
    control_dp=false) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={34,-56})));

  Movers.BaseClasses.IdealSource mFlow_recycledWater(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC,
    m_flow_small=0.00000000001,
    control_m_flow=true,
    control_dp=false) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-40,-76})));

  Movers.BaseClasses.IdealSource mFlow_freshWater(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC,
    m_flow_small=0.00000000001,
    control_m_flow=true,
    control_dp=false) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-42,-94})));

  Movers.BaseClasses.IdealSource mFlow_Evap(redeclare package Medium =
        AixLib.Fluid.Pools.BaseClasses.Water30degC,
    m_flow_small=0.00000000001,
    control_m_flow=true,
    control_dp=false)
    annotation (Placement(transformation(extent={{46,0},{56,10}})));

  Modelica.Blocks.Sources.RealExpression mFlowRecycledWater(final y=
        m_flow_recycledWater) "Prescribed MassFlow"
    annotation (Placement(transformation(extent={{-62,-72},{-48,-60}})));

  Modelica.Blocks.Sources.RealExpression mFlowFreshWater(final y=m_flow_freshWater)
    "Prescribed Mass flow"
    annotation (Placement(transformation(extent={{-72,-94},{-58,-82}})));

  Modelica.Blocks.Sources.RealExpression mFlowToPool(final y=m_flow_toPool)
    "Prescribed mass flow"
    annotation (Placement(transformation(extent={{12,-80},{26,-68}})));

  Modelica.Blocks.Sources.RealExpression mFlowEvap(final y=m_flow_evap)
    "Prescribed mass flow"
    annotation (Placement(transformation(extent={{32,10},{46,22}})));

  Modelica.Blocks.Math.Gain gain(final k=h_evap)
    annotation (Placement(transformation(extent={{-22,28},{-30,36}})));

  Modelica.Blocks.Sources.BooleanPulse inUse(
    final width=openingHours,
    final period=86400,
    final startTime=openAt)
    "is the swimming pool currently in use - pulse between opening hours of swimming hall"
    annotation (Placement(transformation(extent={{16,74},{30,88}})));
  ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum
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
        origin={-80,-24})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvPoolSurface
    "Air Temperature in Zone"
    annotation (Placement(transformation(extent={{-22,88},{2,112}})));
  BaseClasses.HeatTransferWaterSurface heatTransferWaterSurface(final alpha_Air=alpha_Air,
  final A= A_pool)
    annotation (Placement(transformation(extent={{-22,52},{-4,66}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor QFlow_Conv_Sensor
    annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=90,
        origin={-13,79})));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(final Gr=
        epsilon) annotation (Placement(transformation(
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
    final nExt=nExt,
    final CExt = CExt,
    final NextToSoil = NextToSoil,
    final RExt=RExt,
    final RExtRem=RExtRem,
    final T_nextDoor= T_pool)
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
  Modelica.Blocks.Interfaces.RealOutput Q_Lat_mEvap
    "Latent heat of evaporation rate from swimming pool to surrounding air"
    annotation (Placement(transformation(extent={{98,-18},{118,2}})));
  BaseClasses.PumpAndPressureDrop pumpAndPressureDrop( final replaceable
      package Medium =
               Medium,final m_flow_nominal=m_flow_start, final pumpHead = pumpHead) annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={42,-22})));

  Modelica.Blocks.Sources.Constant dp_pump(k=pumpHead)
    "Input for circulation pump"
    annotation (Placement(transformation(extent={{20,-38},{30,-28}})));
  Modelica.Blocks.Interfaces.RealOutput P_pump(final quantity="Power", final
      unit="W") "Output eletric energy needed for pump operation"
    annotation (Placement(transformation(extent={{98,-36},{118,-16}})));
  Modelica.Blocks.Interfaces.RealOutput Q_pool
    "Heat needed to compensate losses"
    annotation (Placement(transformation(extent={{96,-92},{116,-72}})));
equation

 if inUse.y or not PartialLoad then
     m_flow_toPool = Q*Medium.d_const;
     m_flow_evap = -(beta_inUse)/(R_D*0.5*(T_pool + TAir))*(psat_T_pool - phi*
       psat_T_Air)*A_pool;
 else
     m_flow_toPool= Q*x_partialLoad*Medium.d_const;
     m_flow_evap = -(beta_nonUse)/(R_D*0.5*(T_pool + TAir))*(psat_T_pool - phi*
        psat_T_Air)*A_pool;
 end if;

  0= m_flow_freshWater + (1-x_recycling)*(sewer.m_flow + m_flow_evap);
  0= m_flow_recycledWater + x_recycling *(sewer.m_flow + m_flow_evap);

  connect(Watertreatment.ports[1], sewer) annotation (Line(points={{0.8,-64},{4,
          -64},{4,-66},{58,-66},{58,-56},{100,-56},{100,-54}},
                                            color={0,127,255}));
  connect(PoolWater.ports[1], Watertreatment.ports[2]) annotation (Line(points={{5.33333,
          4},{-8,4},{-8,-64},{2.4,-64}},  color={0,127,255}));
  connect(mFlowRecycledWater.y, mFlow_recycledWater.m_flow_in) annotation (Line(
        points={{-47.3,-66},{-43.6,-66},{-43.6,-71.2}}, color={0,0,127}));
  connect(mFlowFreshWater.y, mFlow_freshWater.m_flow_in) annotation (Line(
        points={{-57.3,-88},{-45.6,-88},{-45.6,-89.2}}, color={0,0,127}));
  connect(mFlowToPool.y, mFlow_toPool.m_flow_in)
    annotation (Line(points={{26.7,-74},{30.4,-74},{30.4,-60.8}},
                                                   color={0,0,127}));
  connect(mFlowEvap.y, mFlow_Evap.m_flow_in) annotation (Line(points={{46.7,16},
          {46.7,10},{48,10},{48,9}}, color={0,0,127}));
  connect(PoolWater.ports[2], mFlow_Evap.port_a)
    annotation (Line(points={{8,4},{46,4},{46,5}}, color={0,127,255}));
  connect(recycledWater, mFlow_recycledWater.port_a)
    annotation (Line(points={{-100,-76},{-46,-76}}, color={0,127,255}));
  connect(mFlow_recycledWater.port_b, Watertreatment.ports[3]) annotation (Line(
        points={{-34,-76},{4,-76},{4,-64}},                     color={0,127,255}));
  connect(Watertreatment.ports[4], mFlow_toPool.port_a) annotation (Line(points={{5.6,-64},
          {22,-64},{22,-56},{28,-56}},                    color={0,127,255}));
  connect(freshWater, mFlow_freshWater.port_a) annotation (Line(points={{-100,
          -94},{-48,-94}},                color={0,127,255}));
  connect(mFlow_freshWater.port_b, Watertreatment.ports[5]) annotation (Line(
        points={{-36,-94},{7.2,-94},{7.2,-64}},                     color={0,127,
          255}));
  connect(X_w,absToRelHum. absHum) annotation (Line(points={{73,105},{60,105},
        {60,87},{61.6,87}},
                          color={0,0,127}));
  connect(TAir,absToRelHum. TDryBul)
    annotation (Line(points={{43,105},{56.2,105},{56.2,87}}, color={0,0,127}));
  connect(mFlow_Evap.port_b, MEvap) annotation (Line(points={{56,5},{72,5},{72,
          4},{100,4},{100,12}},
                             color={0,127,255}));
  connect(mFlowEvap.y, gain.u) annotation (Line(points={{46.7,16},{54,16},{54,32},
          {-21.2,32}}, color={0,0,127}));
  connect(PoolWater.QEvap_in, gain1.y) annotation (Line(points={{-2.6,10.2},{-10,
          10.2},{-10,6},{-15.6,6}},   color={0,0,127}));
  connect(gain.y, gain1.u) annotation (Line(points={{-30.4,32},{-34,32},{-34,6},
          {-24.8,6}},  color={0,0,127}));
  connect(multiSum.y,prescribedHeatFlow. Q_flow) annotation (Line(points={{-80,-31.02},
          {-80,-42},{-66,-42}}, color={0,0,127}));
  connect(multiSum.u[1], gain.y) annotation (Line(points={{-76.85,-18},{-76.85,-12},
          {-38,-12},{-38,32},{-30.4,32}}, color={0,0,127}));
  connect(heatTransferWaterSurface.heatport_noCover, PoolWater.heatPort)
    annotation (Line(points={{-13,52},{-14,52},{-14,14},{-2,14}}, color={191,0,0}));
  connect(ConvPoolSurface, QFlow_Conv_Sensor.port_b) annotation (Line(points={{
          -10,100},{-12,100},{-12,86},{-13,86}}, color={191,0,0}));
  connect(heatTransferWaterSurface.heatPort_b, QFlow_Conv_Sensor.port_a)
    annotation (Line(points={{-13.18,66.4667},{-13,66.4667},{-13,72}}, color={191,
          0,0}));
  connect(QFlow_Conv_Sensor.Q_flow, multiSum.u[2]) annotation (Line(points={{-20,79},
          {-28,79},{-28,44},{-78.95,44},{-78.95,-18}},   color={0,0,127}));
  connect(TRad,prescribedTemperature. T) annotation (Line(points={{-55,105},{-55,
          94.5},{-55,94.5},{-55,83}}, color={0,0,127}));
  connect(prescribedTemperature.port,bodyRadiation. port_b)
    annotation (Line(points={{-55,72},{-55,62}}, color={191,0,0}));
  connect(QFlow_Rad_Sensor.port_b, bodyRadiation.port_a)
    annotation (Line(points={{-53,36},{-55,36},{-55,48}}, color={191,0,0}));
  connect(QFlow_Rad_Sensor.port_a, PoolWater.heatPort) annotation (Line(points={
          {-53,22},{-54,22},{-54,14},{-2,14}}, color={191,0,0}));
  connect(QFlow_Rad_Sensor.Q_flow, multiSum.u[3]) annotation (Line(points={{-60,
          29},{-72,29},{-72,26},{-82.1,26},{-82.1,-18},{-81.05,-18}}, color={0,0,
          127}));
  connect(prescribedHeatFlow.port, Watertreatment.heatPort) annotation (Line(
        points={{-46,-42},{-36,-42},{-36,-52},{-6,-52},{-6,-54}}, color={191,0,0}));
  connect(TSoil, heatTransferConduction.TSoil) annotation (Line(points={{107,55},
          {90,55},{90,55.6},{72.6,55.6}}, color={0,0,127}));
  connect(heatTransferConduction.heatport_a, QFlow_Cond_Sensor.port_b)
    annotation (Line(points={{52,52.2},{48,52.2},{48,48},{29,48}}, color={191,0,
          0}));
  connect(PoolWater.heatPort, QFlow_Cond_Sensor.port_a) annotation (Line(points=
         {{-2,14},{-14,14},{-14,34},{29,34}}, color={191,0,0}));
  connect(QFlow_Cond_Sensor.Q_flow, multiSum.u[4]) annotation (Line(points={{22,
          41},{4,41},{4,40},{-84,40},{-84,-14},{-83.15,-14},{-83.15,-18}},
        color={0,0,127}));
  connect(gain.y, Q_Lat_mEvap) annotation (Line(points={{-30.4,32},{-36,32},{
          -36,-8},{108,-8}},
                           color={0,0,127}));
  connect(mFlow_toPool.port_b, pumpAndPressureDrop.port_a) annotation (Line(
        points={{40,-56},{42,-56},{42,-30}},          color={0,127,255}));
  connect(pumpAndPressureDrop.port_b, PoolWater.ports[3]) annotation (Line(
        points={{42,-14},{42,-4},{10.6667,-4},{10.6667,4}},      color={0,127,255}));
  connect(dp_pump.y, pumpAndPressureDrop.dp_in) annotation (Line(points={{30.5,
          -33},{38.32,-33},{38.32,-29.84}},
                                    color={0,0,127}));
  connect(pumpAndPressureDrop.P, P_pump) annotation (Line(points={{38.32,-13.52},
          {72,-13.52},{72,-26},{108,-26}}, color={0,0,127}));
  connect(multiSum.y, Q_pool) annotation (Line(points={{-80,-31.02},{-80,-82},{
          106,-82}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
            points={{-72,30}}, color={255,255,170}), Bitmap(extent={{-82,-100},
              {98,100}}, fileName=
              "modelica://AixLib/Fluid/Pools/icon_schwimmbecken.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IndoorSwimmingPool;
