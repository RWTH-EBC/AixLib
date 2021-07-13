within AixLib.Fluid.Pools;
model IndoorSwimmingPool
  parameter AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam
  "Choose setup for this pool" annotation (choicesAllMatching=true);

  replaceable package WaterMedium = AixLib.Media.Water (
    cp_const = 4180,
    d_const = 995.65,
    eta_const = 0.00079722,
    lambda_const = 0.61439)
    "Water properties for water with 30 °C" annotation (choicesAllMatching=true);

  // Water transfer coefficients according to VDI 2089 Blatt 1
  parameter Real beta_nonUse(unit="m/s")=7/3600 "Water transfer coefficient during non opening hours" annotation (Dialog(group="Water transfer coefficients"));
  parameter Real beta_cover(unit="m/s")=0.7/3600 "Water transfer coefficient during non opening hours"
                                                                                                      annotation (Dialog(group="Water transfer coefficients"));
  parameter Real beta_wavePool(unit="m/s")=50/3600 "Water transfer coefficient during wavePool operation"
                                                                                                         annotation (Dialog(group="Water transfer coefficients"));

  // Parameter and variables for evaporation
  Modelica.SIunits.MassFlowRate m_flow_evap(start=0.0) "mass flow rate between pool water and air due to evaporation";
  Modelica.SIunits.Pressure psat_T_pool = Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(poolWater.T)
    "Saturation pressure at pool temperature";
  Modelica.SIunits.Pressure psat_T_Air = Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(TAir)
    "Saturation pressure at air temperature";
  Real phi "Relative humidity";
  constant Modelica.SIunits.SpecificHeatCapacity R_D=461.52 "Specific gas constant for steam"; // Source: Klaus Lucas, Thermodynamik (2008)
  parameter Modelica.SIunits.SpecificEnergy h_vapor = AixLib.Media.Air.enthalpyOfCondensingGas(poolParam.T_pool)
                                                                                                                "Latent heat of evaporating water";

  // Pump
  parameter Modelica.SIunits.Pressure pumpHead=170000   "Expected average flow resistance of water cycle";

  // Pool circulation flow rate
  parameter Modelica.SIunits.MassFlowRate m_flow = poolParam.V_flow * WaterMedium.d_const "Circulation mass flow rate to the pool";
  parameter Modelica.SIunits.MassFlowRate m_flow_partial = poolParam.V_flow_partial * WaterMedium.d_const "Partial circulation mass flow rate to pool during non operating hours";
  Modelica.SIunits.MassFlowRate m_flow_toPool(start=0.0);

  // Fresh water and water recycling
  Modelica.SIunits.MassFlowRate m_flow_freshWater(start=0.0);
  parameter Modelica.SIunits.Efficiency eps = if poolParam.use_HRS then poolParam.efficiencyHRS else 0;

  // Convection and Radiation at pool water surface
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air=3.5
    "Coefficient of heat transfer between the water surface and the room air";
    // approximated for free and forced convection at velocities between 0,05 to 0,2 m/s  above a plane area
  parameter Real epsilon = 0.9*0.95
    "Product of expected emission coefficients of water (0.95) and the surrounding wall surfaces (0.95)";

  AixLib.Fluid.MixingVolumes.MixingVolume Storage(
    redeclare package Medium = WaterMedium,
    m_flow_nominal=m_flow,
    V=poolParam.V_storage,
    nPorts=4) annotation (Placement(transformation(extent={{-28,-54},{-8,-34}})));

  AixLib.Fluid.Sources.Boundary_pT Source(
    redeclare package Medium = WaterMedium,
    T=283.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-94,-80},{-82,-68}})));
  AixLib.Fluid.Sources.Boundary_pT Sinc(
    redeclare package Medium = WaterMedium, nPorts=1)
    annotation (Placement(transformation(extent={{54,-80},{42,-68}})));
  AixLib.Fluid.MixingVolumes.MixingVolume poolWater(
    redeclare package Medium = WaterMedium,
    m_flow_nominal=m_flow,
    V=poolParam.V_pool,
    nPorts=3)
    annotation (Placement(transformation(extent={{-20,6},{0,26}})));

  Modelica.Blocks.Sources.RealExpression PoolWater(y=m_flow_toPool)
    annotation (Placement(transformation(extent={{26,-76},{10,-60}})));
  AixLib.Fluid.Movers.BaseClasses.IdealSource idealSource(
    redeclare package Medium = WaterMedium,
    m_flow_small=0.00001,
    control_m_flow=true)
    annotation (Placement(transformation(extent={{-60,-78},{-52,-70}})));
  AixLib.Fluid.HeatExchangers.Heater_T IdealHeatExchangerPool(
    redeclare package Medium = WaterMedium,
    m_flow_nominal=m_flow,
    m_flow_small=0.0001,
    dp_nominal(displayUnit="bar") = 100000,
    QMax_flow=1000000) if poolParam.use_idealHeatExchanger annotation (
      Placement(transformation(
        extent={{7,-10},{-7,10}},
        rotation=270,
        origin={48,-15})));
  Modelica.Blocks.Sources.RealExpression SetTemperature(y=poolParam.T_pool) if
    poolParam.use_idealHeatExchanger
    annotation (Placement(transformation(extent={{86,-36},{64,-20}})));
  Modelica.Blocks.Interfaces.RealOutput QPool if  poolParam.use_idealHeatExchanger
    "Heat flow rate to maintain the pool at the set temperature" annotation (
      Placement(transformation(extent={{100,-28},{120,-8}}),iconTransformation(
          extent={{100,-28},{120,-8}})));

  AixLib.Fluid.Movers.BaseClasses.IdealSource idealSource1(
    redeclare package Medium = WaterMedium,
    m_flow_small=0.00001,
    control_m_flow=true)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={44,6})));
  Modelica.Blocks.Sources.RealExpression m_Eavporation(y=m_flow_evap)
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=180,
        origin={63,21})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness HeatExchanger(
    redeclare package Medium1 = WaterMedium,
    redeclare package Medium2 = WaterMedium,
    m1_flow_nominal=poolParam.m_flow_out*1.5,
    m2_flow_nominal=poolParam.m_flow_out,
    dp1_nominal(displayUnit="bar") = 100000,
    dp2_nominal(displayUnit="bar") = 100000,
    eps=eps)
     annotation (Placement(transformation(
        extent={{-7,-6},{7,6}},
        rotation=90,
        origin={-20,-67})));
  Modelica.Blocks.Interfaces.RealInput openingHours
    "Input profile for opening hours"
    annotation (Placement(transformation(extent={{-118,66},{-84,100}}),
        iconTransformation(extent={{-118,66},{-84,100}})));
  Modelica.Blocks.Interfaces.RealInput persons "Input profile for persons"
    annotation (Placement(transformation(extent={{-118,28},{-84,62}}),
        iconTransformation(extent={{-118,28},{-84,62}})));
  Modelica.Blocks.Interfaces.RealInput wavePool if poolParam.use_wavePool
    "Input profile for wave pool operation times"
    annotation (Placement(transformation(extent={{-120,-108},{-86,-74}}),
        iconTransformation(extent={{-120,-108},{-86,-74}})));

  Modelica.Blocks.Interfaces.RealInput TAir(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Temperature of the surrounding room air" annotation (
      Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=-90,
        origin={29,107}), iconTransformation(
        extent={{-15,-15},{15,15}},
        rotation=-90,
        origin={29,107})));
  Modelica.Blocks.Interfaces.RealInput X_w "Absolute humidty of the room Air"  annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=-90,
        origin={65,107}),  iconTransformation(
        extent={{-15,-15},{15,15}},
        rotation=-90,
        origin={65,107})));

  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum
    "Calculation of the relative humidity of the room air " annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={49,77})));

  Modelica.Blocks.Sources.RealExpression FreshWater(y=m_flow_freshWater)  annotation (Placement(transformation(extent={{-82,-64},{-70,-50}})));

  BaseClasses.PumpAndPressureDrop pumpAndPressureDrop(
    redeclare package Medium = WaterMedium,
    allowFlowReversal=false,
    pumpHead=pumpHead,
    m_flow_nominal=m_flow,
    p_start=101300,
    T_water=poolParam.T_pool) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={8,-54})));

  AixLib.Fluid.Sources.Boundary_pT SincEvaporation(
    redeclare package Medium = WaterMedium, nPorts=1)   annotation (Placement(transformation(extent={{90,0},{78,12}})));

  AixLib.Fluid.HeatExchangers.ConstantEffectiveness HeatExchangerPool(
    redeclare package Medium1 = WaterMedium,
    redeclare package Medium2 = WaterMedium,
    m1_flow_nominal=poolParam.m_flow_out*1.5,
    m2_flow_nominal=poolParam.m_flow_out,
    dp1_nominal(displayUnit="bar") = 100000,
    dp2_nominal(displayUnit="bar") = 100000,
    eps=eps) if poolParam.use_idealHeatExchanger == false
             annotation (Placement(transformation(
        extent={{-7,-6},{7,6}},
        rotation=90,
        origin={22,-15})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
    redeclare package Medium = WaterMedium) if poolParam.use_idealHeatExchanger == false
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)" annotation (Placement(transformation(extent={{-110,-14},{-90,6}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare package Medium = WaterMedium) if poolParam.use_idealHeatExchanger == false
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)" annotation (Placement(transformation(extent={{-110,-38},{-90,-18}})));

  BaseClasses.waveMachine waveMachine if poolParam.use_wavePool
    annotation (Placement(transformation(extent={{-80,-98},{-64,-84}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPoolSurface
    "Air Temperature in Zone" annotation (Placement(transformation(extent={{-40,88},{-16,112}}),
      iconTransformation(extent={{-24,94},{-4,114}})));

  AixLib.Utilities.Interfaces.RadPort radPoolSurface
  "Mean Radiation Temperature of surrounding walls" annotation (Placement(
      transformation(
      extent={{-8,-9},{8,9}},
      rotation=-90,
      origin={-61,104}), iconTransformation(
      extent={{-11,-11},{11,11}},
      rotation=-90,
      origin={-68,104})));

  Modelica.Thermal.HeatTransfer.Components.BodyRadiation radWaterSurface(
  final Gr=epsilon*poolParam.A_pool)
  "Model to depict the heat flow rate due to radiation between the pool surface an the surrounding walls" annotation (Placement(transformation(
      extent={{-7,-7},{7,7}},
      rotation=90,
      origin={-61,77})));

  Modelica.Thermal.HeatTransfer.Components.Convection convWaterSurface
  "Convection at the watersurface" annotation (Placement(transformation(
      extent={{-7,7},{7,-7}},
      rotation=90,
      origin={-29,77})));

  Modelica.Blocks.Sources.RealExpression getHeatCoefConv(y=alpha_Air*poolParam.A_pool)
    "Coefficient of heat transfer between water surface and room air" annotation (Placement(transformation(extent={{4,68},{-14,86}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeatFlowEvapLoss annotation (Placement(transformation(extent={{0,36},{-16,52}})));

  Modelica.Blocks.Math.Gain hEvapLatentHeatGain(final k=h_vapor)
    "Calculation of heat flow rate due to evaporation" annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={42,34})));

  Modelica.Blocks.Interfaces.RealOutput MFlowFreshWater
    "Flow rate of added fresh water to the pool and water treatment system" annotation (Placement(transformation(extent={{100,-96},{120,-76}}),
        iconTransformation(extent={{100,-96},{120,-76}})));

  BaseClasses.HeatTransferConduction heatTransferConduction(
    AInnerPoolWall=poolParam.AInnerPoolWall,
    APoolWallWithEarthContact=poolParam.APoolWallWithEarthContact,
    APoolFloorWithEarthContact=poolParam.APoolFloorWithEarthContact,
    AInnerPoolFloor=poolParam.AInnerPoolFloor,
    hConWaterHorizontal=poolParam.hConWaterHorizontal,
    hConWaterVertical=poolParam.hConWaterVertical,
    PoolWall=poolParam.PoolWallParam)
    "Model to depict the heat flow rate through the pool walls to the bordering room/soil"
    annotation (Placement(transformation(extent={{6,52},{22,68}})));

  Modelica.Blocks.Math.Gain minus1Gain(final k=-1) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={24,44})));

  Modelica.Blocks.Interfaces.RealOutput QEvap(final quantity="HeatFlowRate",
      final unit="W")
                     "Heat needed to compensate losses" annotation (Placement(transformation(extent={{100,34},{120,54}}),
      iconTransformation(extent={{100,2},{120,22}})));

  Modelica.Blocks.Interfaces.RealInput TSoil(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Temperature of Soil" annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=180,
        origin={105,69}), iconTransformation(
      extent={{-11,-11},{11,11}},
      rotation=180,
      origin={103,67})));

  Modelica.Blocks.Interfaces.RealOutput PPool(
    final quantity="Power",
    final unit="W")
    "Output eletric energy needed for pool operation" annotation (Placement(transformation(extent={{100,-62},
            {120,-42}}),
      iconTransformation(extent={{100,-62},{120,-42}})));

  Modelica.Blocks.Math.MultiSum elPower(nu=if poolParam.use_wavePool then 2 else 1)
    "Add electric power of pump and the optional wave pool"
    annotation (Placement(transformation(extent={{78,-56},{86,-64}})));
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
      m_flow_toPool = m_flow;
    else
      m_flow_toPool = m_flow_partial;
    end if;
  else
    m_flow_toPool = m_flow;
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


  connect(pumpAndPressureDrop.port_b, IdealHeatExchangerPool.port_a) annotation (Line(points={{16,-54},
            {48,-54},{48,-22}},                                                                                                color={0,127,255}));
  connect(IdealHeatExchangerPool.port_b, poolWater.ports[2]) annotation (Line(
        points={{48,-8},{44,-8},{44,0},{-10,0},{-10,6}},        color={0,127,255}));
  connect(IdealHeatExchangerPool.Q_flow, QPool) annotation (Line(points={{56,-7.3},
            {56,-4},{84,-4},{84,-18},{110,-18}},                                                        color={0,0,127}));
  connect(IdealHeatExchangerPool.TSet, SetTemperature.y) annotation (Line(
        points={{56,-23.4},{56,-28},{62.9,-28}},   color={0,0,127}));
  connect(pumpAndPressureDrop.port_b, HeatExchangerPool.port_b2) annotation (Line(points={{16,-54},
            {25.6,-54},{25.6,-22}},                                                                                      color={0,127,255}));
  connect(HeatExchangerPool.port_a2, poolWater.ports[2]) annotation (Line(
        points={{25.6,-8},{26,-8},{26,0},{-10,0},{-10,6}},        color={0,127,255}));
  connect(HeatExchangerPool.port_b1, port_b1) annotation (Line(points={{18.4,-8},
            {18,-8},{18,-4},{-100,-4}},
                                 color={0,127,255}));
  connect(HeatExchangerPool.port_a1, port_a1) annotation (Line(points={{18.4,-22},
            {18,-22},{18,-28},{-100,-28}},
                                         color={0,127,255}));
  connect(waveMachine.PWaveMachine, elPower.u[2]) annotation (Line(points={{-63.52,
            -91},{64,-91},{64,-62},{78,-62},{78,-60}}, color={0,0,127}));
  connect(absToRelHum.TDryBul, TAir) annotation (Line(points={{46.2,83},{46,83},
          {46,88},{29,88},{29,107}},   color={0,0,127}));
  connect(absToRelHum.absHum, X_w) annotation (Line(points={{51.6,83},{52,83},{52,
          88},{65,88},{65,107}},         color={0,0,127}));
  connect(Source.ports[1], idealSource.port_a) annotation (Line(points={{-82,-74},
          {-60,-74}},                                                                         color={0,127,255}));
  connect(HeatExchanger.port_b2, Sinc.ports[1]) annotation (Line(points={{-16.4,
          -74},{42,-74}},                         color={0,127,255}));
  connect(FreshWater.y, idealSource.m_flow_in) annotation (Line(points={{-69.4,-57},
          {-58.4,-57},{-58.4,-70.8}}, color={0,0,127}));
  connect(HeatExchanger.port_b1, Storage.ports[1]) annotation (Line(points={{-23.6,
          -60},{-22,-60},{-22,-54},{-21,-54}},
                                   color={0,127,255}));
  connect(HeatExchanger.port_a2, Storage.ports[2])  annotation (Line(points={{-16.4,
          -60},{-18,-60},{-18,-54},{-19,-54}},           color={0,127,255}));
  connect(Storage.ports[3], pumpAndPressureDrop.port_a) annotation (Line(points={{-17,-54},
          {0,-54}},                                                                                          color={0,127,255}));
  connect(PoolWater.y, pumpAndPressureDrop.setMFlow) annotation (Line(points={{9.2,-68},
          {0,-68},{0,-59.76}},           color={0,0,127}));
  connect(poolWater.ports[1], Storage.ports[4]) annotation (Line(points={{
          -12.6667,6},{-12.6667,0},{-42,0},{-42,-54},{-15,-54}},
                                                 color={0,127,255}));
  connect(poolWater.ports[3], idealSource1.port_a) annotation (Line(points={{-7.33333,
          6},{40,6}},                 color={0,127,255}));
  connect(idealSource1.port_b, SincEvaporation.ports[1]) annotation (Line(
        points={{48,6},{78,6}},                   color={0,127,255}));
  connect(m_Eavporation.y, idealSource1.m_flow_in) annotation (Line(points={{53.1,21},
          {41.6,21},{41.6,9.2}},      color={0,0,127}));
  connect(radWaterSurface.port_b, radPoolSurface)  annotation (Line(points={{-61,84},{-61,104}},         color={191,0,0}));
  connect(convWaterSurface.fluid, convPoolSurface) annotation (Line(points={{-29,84},
          {-28,84},{-28,100}},                       color={191,0,0}));
  connect(convWaterSurface.solid, poolWater.heatPort) annotation (Line(points={{-29,70},
          {-28,70},{-28,16},{-20,16}},                         color={191,0,0}));
  connect(radWaterSurface.port_a, poolWater.heatPort) annotation (Line(points={{-61,70},
          {-60,70},{-60,30},{-28,30},{-28,16},{-20,16}},       color={191,0,0}));
  connect(preHeatFlowEvapLoss.port, poolWater.heatPort) annotation (Line(points={{-16,44},
          {-28,44},{-28,16},{-20,16}},        color={191,0,0}));
  connect(m_Eavporation.y, hEvapLatentHeatGain.u) annotation (Line(points={{53.1,21},
          {42,21},{42,26.8}},           color={0,0,127}));
  connect(FreshWater.y, MFlowFreshWater) annotation (Line(points={{-69.4,-57},{-40,
          -57},{-40,-86},{110,-86}},                       color={0,0,127}));
  connect(heatTransferConduction.heatport_a, poolWater.heatPort) annotation (
      Line(points={{5.76,59.92},{-28,59.92},{-28,16},{-20,16}}, color={191,0,0}));
  connect(hEvapLatentHeatGain.y, minus1Gain.u)  annotation (Line(points={{42,40.6},{42,44},{28.8,44}}, color={0,0,127}));
  connect(hEvapLatentHeatGain.y, QEvap) annotation (Line(points={{42,40.6},{42,44},{110,44}}, color={0,0,127}));
  connect(heatTransferConduction.TSoil, TSoil) annotation (Line(points={{22.48,62.88},
          {78,62.88},{78,69},{105,69}}, color={0,0,127}));
  connect(convPoolSurface, convPoolSurface) annotation (Line(points={{-28,100},{-28,100}}, color={191,0,0}));
  connect(getHeatCoefConv.y, convWaterSurface.Gc) annotation (Line(points={{-14.9,77},{-22,77}}, color={0,0,127}));
  connect(minus1Gain.y, preHeatFlowEvapLoss.Q_flow) annotation (Line(points={{19.6,44},{0,44}}, color={0,0,127}));
  connect(waveMachine.wavePool, wavePool)  annotation (Line(points={{-81.28,-91},{-103,-91}}, color={0,0,127}));
  connect(elPower.y, PPool)  annotation (Line(points={{86.68,-60},{98,-60},{98,-52},
          {110,-52}},                                                         color={0,0,127}));
  connect(pumpAndPressureDrop.P, elPower.u[1]) annotation (Line(points={{16.48,-57.68},
          {78,-57.68},{78,-60}},   color={0,0,127}));
  connect(idealSource.port_b, HeatExchanger.port_a1)
    annotation (Line(points={{-52,-74},{-23.6,-74}}, color={0,127,255}));
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
          Bitmap(extent={{-94,-150},{96,58}},
         fileName="modelica://AixLib/Fluid/Pools/icon_schwimmbecken.jpg")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
end IndoorSwimmingPool;
