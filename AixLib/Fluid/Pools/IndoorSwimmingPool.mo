within AixLib.Fluid.Pools;
model IndoorSwimmingPool

  package Medium = AixLib.Media.Water (
      cp_const=4180,
      d_const=995.65,
      eta_const=0.00079722,
      lambda_const=0.61439);

  parameter DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam
    "Choose setup for this swimming pool" annotation (choicesAllMatching=true);

  //Calculated from record/input data

  final parameter Modelica.SIunits.MassFlowRate m_flow_start = poolParam.Q* Medium.d_const "Mass Flow Rate from Storage to Pool at the beginning";
  final parameter Modelica.SIunits.MassFlowRate m_flow_recycledStart=poolParam.Q*poolParam.x_recycling
                                                                           "Nominal Mass Flow Rate for recycled water, min to catch zero flow";

  final parameter Modelica.SIunits.SpecificEnergy h_evap = AixLib.Media.Air.enthalpyOfCondensingGas(poolParam.T_pool)
                                                                                                                     "Evaporation enthalpy";

  Modelica.SIunits.Pressure psat_T_pool=
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
      poolWater.T)     "Saturation pressure at pool temperature";
  Modelica.SIunits.Pressure psat_T_Air=
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
      TAir)
           "Saturation pressure at air temperature of the zone";
  Modelica.SIunits.HeatFlowRate Q_pool(start=0)
                                               "Heat demand of swimming pool";
  Modelica.SIunits.HeatFlowRate Q_sum(start=0) "Heat demand of swimming pool";
  Modelica.SIunits.HeatFlowRate Q_FW(start=0)  "Heat demand to bring fresh water to pool temp";
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
    "Fixed Volume to represent the usable volume of the water storage"
    annotation (Placement(transformation(extent={{-28,-54},{-8,-34}})));

  MixingVolumes.MixingVolume watertreatmentWR(
    redeclare package Medium = Medium,
    T_start=poolParam.T_pool,
    m_flow_nominal=m_flow_start,
    V=poolParam.V_storage,
    nPorts=5) if poolParam.use_waterRecycling
    "Fixed Volume to represent the usable volume of the water storage, 5 ports, with waterrecycling"
    annotation (Placement(transformation(extent={{-28,-54},{-8,-34}})));
  MixingVolumes.MixingVolume         poolWater(
    redeclare package Medium = Medium,
    T_start=poolParam.T_pool,
    m_flow_nominal=m_flow_start,
    V=poolParam.V_pool,
    nPorts=4)
             "Fixed Volume to represent the pool water" annotation (Placement(transformation(extent={{-12,6},
          {8,26}})));
  Sources.Boundary_pT souFW(
    redeclare package Medium = Medium,
    T=288.15,
    nPorts=1) "Source for fresh water"
    annotation (Placement(transformation(extent={{-94,-100},{-82,-88}})));
  Sources.Boundary_pT souRW(
    redeclare package Medium = Medium,
    T=poolParam.T_pool,
    nPorts=1) if poolParam.use_waterRecycling
              "Source for recycled water"
    annotation (Placement(transformation(extent={{-94,-72},{-82,-60}})));
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
    annotation (Placement(transformation(extent={{-72,-94},{-58,-82}})));

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
      origin={-45,73})));

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
    annotation (Placement(transformation(extent={{30,46},{46,62}})));
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
    annotation (Placement(transformation(extent={{102,-20},{122,0}}),
      iconTransformation(extent={{98,-26},{118,-6}})));
  Modelica.Blocks.Interfaces.RealOutput QPool(final quantity="HeatFlowRate", final
      unit="W") "Heat needed to compensate losses"
    annotation (Placement(transformation(extent={{100,-38},{120,-18}}),
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
  control_dp=false) if poolParam.use_waterRecycling
  "Pump to set the right mass flow rate for recycled water consumption"
  annotation (Placement(transformation(extent={{-44,-74},{-36,-66}})));
  Movers.BaseClasses.IdealSource mFlowFW(
  redeclare package Medium = Medium,
  allowFlowReversal=false,
  m_flow_small=0.0001,
  control_m_flow=true,
  control_dp=false)
  "Pump to set the right mass flow rate for fresh water consumption"
  annotation (Placement(transformation(extent={{-44,-98},{-36,-90}})));
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
  Modelica.Blocks.Math.RealToBoolean lunchbreak(threshold=0.5)
    "If input = 0.5, then lunchBreak =true, not in use and  without cover, even if cover is installed during night"
    annotation (Placement(transformation(extent={{-78,60},{-66,72}})));
  Modelica.Blocks.Interfaces.RealInput wavePool "Input profil wavePool "
    annotation (Placement(transformation(extent={{-118,28},{-92,54}}),
      iconTransformation(extent={{-118,42},{-92,68}})));
  BaseClasses.waveMachine waveMachine(h_wave=poolParam.h_wave, w_wave=poolParam.w_wave)
                    "Power consumption of wave machine"
    annotation (Placement(transformation(extent={{-80,14},{-64,30}})));
  Modelica.Blocks.Math.MultiSum sumP(nu=2) if poolParam.use_wavePool
    "Sum of power consumption of all components"
    annotation (Placement(transformation(extent={{54,-24},{62,-16}})));
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeatFlowEvapLoss
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
  Modelica.Blocks.Sources.RealExpression getTPool(final y=poolWater.T)
    "Get water temperature of poolWater"
    annotation (Placement(transformation(extent={{80,6},{94,18}})));
  Modelica.Blocks.Sources.RealExpression getQPool(final y=Q_pool)
    "Prescribed mass flow for intake of recycled water into the pool-watertreatment cycle"
    annotation (Placement(transformation(extent={{-6,-34},{8,-22}})));
  BaseClasses.idealHeatExchanger idealHeatExchanger(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_start,
    dp_nominal=0,
    uLow=poolParam.T_pool,
    uHigh=poolParam.T_pool + 0.2)
                  "Return Lost Heat to Watercycle" annotation (Placement(
        transformation(
        extent={{-6,-8},{6,8}},
        rotation=90,
        origin={24,-12})));
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
    connect(poolWater.ports[1], watertreatmentWR.ports[1]) annotation (Line(
          points={{-5,6},{-40,6},{-40,-54},{-21.2,-54}}, color={0,127,255}));
    connect(watertreatmentWR.ports[2], mFlowWW.port_a) annotation (Line(points=
            {{-19.6,-54},{22,-54},{22,-62},{52,-62}}, color={0,127,255}));
    connect(watertreatmentWR.ports[3], circPump.port_a) annotation (Line(points=
           {{-18,-54},{24,-54},{24,-52}}, color={0,127,255}));
    connect(mFlowFW.port_b, watertreatmentWR.ports[4]) annotation (Line(points=
            {{-36,-94},{-14,-94},{-14,-54},{-16.4,-54}}, color={0,127,255}));
    connect(mFlowRW.port_b, watertreatmentWR.ports[5]) annotation (Line(points=
            {{-36,-70},{-14,-70},{-14,-54},{-14.8,-54}}, color={0,127,255}));
    m_flow_freshWater = (1-poolParam.x_recycling)*(poolParam.m_flow_out + m_flow_evap);
    m_flow_recycledWater = poolParam.x_recycling *(poolParam.m_flow_out + m_flow_evap);
  else
    connect(poolWater.ports[1], watertreatment.ports[1]) annotation (Line(
          points={{-5,6},{-40,6},{-40,-54},{-21,-54}}, color={0,127,255}));
    connect(watertreatment.ports[2], mFlowWW.port_a) annotation (Line(points={{
            -19,-54},{22,-54},{22,-62},{52,-62}}, color={0,127,255}));
    connect(watertreatment.ports[3], circPump.port_a) annotation (Line(points={
            {-17,-54},{24,-54},{24,-52}}, color={0,127,255}));
    connect(mFlowFW.port_b, watertreatment.ports[4]) annotation (Line(points={{
            -36,-94},{-14,-94},{-14,-54},{-15,-54}}, color={0,127,255}));
    m_flow_freshWater= poolParam.m_flow_out+m_flow_evap;
    m_flow_recycledWater=0.0;
  end if;

  Q_FW = m_flow_freshWater*Medium.cp_const*(poolParam.T_pool-souFW.T);
  Q_sum = hEvapGain.y
          + heatTransferConduction.heatport_a.Q_flow
          + radWaterSurface.Q_flow
          + convWaterSurface.Q_flow
          + Q_FW;



    if Q_sum<0 then
       Q_pool =0;
    else


       Q_pool = Q_sum;

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
            {90,61},{90,56.88},{46.48,56.88}},
                                          color={0,0,127}));
  end if;

  connect(QPool, QPool)
    annotation (Line(points={{110,-28},{110,-28}}, color={0,0,127}));

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
  annotation (Line(points={{-82,-66},{-64,-66},{-64,-70},{-44,-70}},
                                                 color={0,127,255}));

  connect(getMFlowFW.y, MFlowFW)
    annotation (Line(points={{-57.3,-88},{24,-88},{24,-86},{106,-86}},
                                                     color={0,0,127}));
connect(souFW.ports[1], mFlowFW.port_a)
  annotation (Line(points={{-82,-94},{-44,-94}}, color={0,127,255}));

  connect(openingHours, inUse.u) annotation (Line(points={{-105,87},{-100,87},
        {-100,86},{-79.2,86}},
                           color={0,0,127}));
  connect(openingHours,lunchbreak. u) annotation (Line(points={{-105,87},{
        -93.5,87},{-93.5,66},{-79.2,66}},
                                      color={0,0,127}));
  connect(wavePool, waveMachine.wavePool) annotation (Line(points={{-105,41},{
          -100,41},{-100,42},{-94,42},{-94,25.2},{-80.64,25.2}},
                                      color={0,0,127}));

  if poolParam.use_wavePool then
    connect(circPump.P, sumP.u[1]) annotation (Line(points={{20.32,-35.52},{20.32,
            -36},{20,-36},{20,-22},{54,-22},{54,-18.6}},
                                    color={0,0,127}));
    connect(waveMachine.PWaveMachine, sumP.u[2]) annotation (Line(points={{-63.52,
            22},{-56,22},{-56,-20},{54,-20},{54,-21.4}},
                                            color={0,0,127}));
    connect(sumP.y, PPool) annotation (Line(points={{62.68,-20},{86,-20},{86,-10},
            {112,-10}},
                 color={0,0,127}));
  else
    connect(circPump.P, PPool) annotation (Line(points={{20.32,-35.52},{20,-35.52},
            {20,-28},{66,-28},{66,-10},{112,-10}},
                             color={0,0,127}));
  end if;

connect(radWaterSurface.port_b, radPoolSurface)
  annotation (Line(points={{-45,80},{-45,104}}, color={191,0,0}));
connect(getMFlowRW.y, mFlowRW.m_flow_in) annotation (Line(points={{-57.3,-60},
        {-52,-60},{-52,-66.8},{-42.4,-66.8}}, color={0,0,127}));
connect(getMFlowFW.y, mFlowFW.m_flow_in) annotation (Line(points={{-57.3,-88},{-50,
          -88},{-50,-90.8},{-42.4,-90.8}},    color={0,0,127}));
connect(preHeatFlowEvapLoss.port, poolWater.heatPort) annotation (Line(points=
       {{10,38},{-14,38},{-14,16},{-12,16}}, color={191,0,0}));
connect(minus1Gain.y, preHeatFlowEvapLoss.Q_flow)
  annotation (Line(points={{29.6,38},{22,38}}, color={0,0,127}));
connect(getHeatCoefConv.y, convWaterSurface.Gc)
  annotation (Line(points={{-0.4,74},{-8,74}}, color={0,0,127}));
connect(convWaterSurface.fluid, convPoolSurface)
  annotation (Line(points={{-14,80},{-14,100},{-6,100}}, color={191,0,0}));
  connect(getTPool.y, TPool)
    annotation (Line(points={{94.7,12},{108,12}}, color={0,0,127}));
  connect(poolWater.heatPort, radWaterSurface.port_a) annotation (Line(points={{
          -12,16},{-28,16},{-28,66},{-45,66}}, color={191,0,0}));
  connect(poolWater.heatPort, convWaterSurface.solid)
    annotation (Line(points={{-12,16},{-14,16},{-14,68}}, color={191,0,0}));
  connect(poolWater.heatPort, heatTransferConduction.heatport_a) annotation (
      Line(points={{-12,16},{-14,16},{-14,54.16},{30,54.16}}, color={191,0,0}));
  connect(getQPool.y, QPool)
    annotation (Line(points={{8.7,-28},{110,-28}},   color={0,0,127}));
  connect(circPump.port_b, idealHeatExchanger.port_a)
    annotation (Line(points={{24,-36},{24,-18}}, color={0,127,255}));
  connect(idealHeatExchanger.port_b, poolWater.ports[4])
    annotation (Line(points={{24,-6},{24,6},{1,6}}, color={0,127,255}));
  connect(getQPool.y, idealHeatExchanger.setQFlow) annotation (Line(points={{
          8.7,-28},{12,-28},{12,-12},{16.96,-12}}, color={0,0,127}));
  connect(getTPool.y, idealHeatExchanger.TPool) annotation (Line(points={{94.7,
          12},{96,12},{96,-4},{30,-4},{30,-6},{29.76,-6},{29.76,-6.48}}, color=
          {0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
            points={{-72,30}}, color={255,255,170}), Bitmap(extent={{-102,-104},{100,98}},
                         fileName=
              "modelica://AixLib/Fluid/Pools/icon_schwimmbecken.jpg"),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3153600,
      Interval=600,
      __Dymola_Algorithm="Dassl"));
end IndoorSwimmingPool;
