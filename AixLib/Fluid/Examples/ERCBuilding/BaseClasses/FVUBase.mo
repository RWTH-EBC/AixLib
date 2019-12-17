within AixLib.Fluid.Examples.ERCBuilding.BaseClasses;
model FVUBase "Facade Ventilation Unit (FVU) equipped with a recuperator"
  import ExergyBasedControl;

 parameter Modelica.SIunits.Efficiency eps_facadeHeatTransfer = 0.5
    "Virtual efficiency for heat recovery over facadade";
 parameter Modelica.SIunits.Efficiency eps_casingHeatTransfer = 0.5
    "Virtual efficiency for heat recovery over casing";

 parameter Real radiationFactor = 1
    "Factor for calculating absolute solar radiation on facade volume";

 parameter Modelica.SIunits.ThermodynamicTemperature T_start = 293.15
    "Initial temperature for all components";

 replaceable package Water =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    "Water Model in the system";
 replaceable package Air = AixLib.Media.Air "Air Model in the system";

protected
  parameter Real valveRiseTime = 200 "Opening time for valves/flaps";

public
  Modelica.Fluid.Sensors.Temperature T_ExhaustAir(redeclare package Medium =
        Air)
    annotation (Placement(transformation(extent={{-8,-6},{8,6}},
        rotation=180,
        origin={152,-82})));
  Modelica.Fluid.Interfaces.FluidPort_b exhaustAir(redeclare package Medium =
        Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-210,16},{-190,36}})));
  Modelica.Fluid.Interfaces.FluidPort_a freshAir(redeclare package Medium = Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-210,-90},{-190,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a ExhaustAir(redeclare package Medium =
        Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{192,-78},{212,-58}})));
  Modelica.Fluid.Interfaces.FluidPort_b SupplyAir(redeclare package Medium =
        Air)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{192,16},{212,36}})));
  Modelica.Blocks.Interfaces.RealInput InputSignal_Fan_ExhaustAir
    "Real Input to control the revolving speed of the exhaust air fan"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-148,100}), iconTransformation(
        extent={{-17,-17},{17,17}},
        rotation=270,
        origin={-145,97})));
  Modelica.Blocks.Interfaces.RealInput InputSignal_Fan_SupplyAir
    "Real Input to control the revolving speed of the supply air fan"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={58,100}), iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=270,
        origin={62,96})));
  Modelica.Fluid.Interfaces.FluidPort_b Heater_Return(redeclare package Medium =
        Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{82,90},{102,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Heater_Flow(redeclare package Medium =
        Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{132,90},{152,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Cooler_Return(redeclare package Medium =
        Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{146,90},{166,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Cooler_Flow(redeclare package Medium =
        Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{188,90},{208,110}})));
  Modelica.Fluid.Sensors.Temperature T_FreshAir(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{-132,-42},{-116,-54}})));
  Modelica.Fluid.Sensors.Temperature T_OutgoingExhaustAir(redeclare package
      Medium = Air)
    annotation (Placement(transformation(extent={{-8,6},{8,-6}},
        rotation=180,
        origin={-124,0})));
  Modelica.Fluid.Sensors.Temperature T_SupplyAir(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{-8,-6},{8,6}},
        rotation=180,
        origin={186,6})));
  Modelica.Fluid.Sensors.Temperature T_AfterHeatRecovery(redeclare package
      Medium = Air)
    annotation (Placement(transformation(extent={{-24,-50},{-8,-62}})));

  Modelica.Blocks.Interfaces.RealInput InputSignal_HeatRecoveryFlap
    "Real Input to control the revolving speed of the exhaust air fan"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-98,100}), iconTransformation(
        extent={{-17,-17},{17,17}},
        rotation=270,
        origin={-95,97})));
  Modelica.Blocks.Interfaces.RealInput InputSignal_CircularAir
    "Real Input to control the revolving speed of the supply air fan"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={4,100}), iconTransformation(
        extent={{-17,-17},{17,17}},
        rotation=270,
        origin={7,97})));
  Modelica.Blocks.Math.Add add1(
                               k1=-1)
    annotation (Placement(transformation(extent={{-83,40},{-73,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(
                                                        y=1)
    annotation (Placement(transformation(extent={{-104,34},{-91,50}})));
  Modelica.Fluid.Sensors.Temperature T_Mix(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{32,18},{48,6}})));
  Modelica.Fluid.Sensors.Temperature T_AfterFan(redeclare package Medium =
        Air) annotation (Placement(transformation(extent={{66,42},{82,54}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-192,-100},{-172,-80}})));
  Modelica.Blocks.Interfaces.RealOutput SupplyTemperature annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={22,-106}), iconTransformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={19,-105})));
  Modelica.Blocks.Interfaces.RealOutput MixTemperature annotation (Placement(
        transformation(
        extent={{-15,-15},{15,15}},
        rotation=270,
        origin={-10,-107}), iconTransformation(
        extent={{-14,-13.5},{14,13.5}},
        rotation=270,
        origin={-11.5,-106})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening Flap_CirculationAir(
    m_flow_nominal=0.05,
    redeclare package Medium = Air,
    m_flow(start=Flap_CirculationAir.m_flow_nominal),
    dp(start=Flap_CirculationAir.dpValve_nominal),
    dpValve_nominal=20)             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-14})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening Flap_Bypass(
    m_flow_nominal=0.05,
    redeclare package Medium = Air,
    dp(start=Flap_Bypass.dpValve_nominal),
    dpValve_nominal=20,
    m_flow(start=Flap_Bypass.m_flow_nominal))
                                    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-39,36})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening Flap_HeatRecovery(
    m_flow_nominal=0.05,
    redeclare package Medium = Air,
    dpValve_nominal=20,
    m_flow(start=Flap_HeatRecovery.m_flow_nominal),
    dp(start=Flap_HeatRecovery.dpValve_nominal))
                                    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-64,-68})));
  Modelica.Fluid.Sensors.Temperature T_beforeCooler(redeclare package Medium =
        Air) annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=180,
        origin={133,6})));
  Modelica.Fluid.Sensors.Temperature T_BeforeHeatRecovery(
                                                         redeclare package
      Medium = Air)
    annotation (Placement(transformation(extent={{-48,-72},{-32,-84}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow exhaustAirFan(
    redeclare package Medium = Air,
    addPowerToMedium=false,
    m_flow_nominal=0.05,
    riseTime=5,
    T_start=T_start,
    m_flow(start=exhaustAirFan.m_flow_nominal),
    dp(start=exhaustAirFan.dp_nominal),
    m_flow_start=exhaustAirFan.m_flow_nominal,
    dp_nominal=70) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-56,14})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening roomCirculation(
    redeclare package Medium = Air,
    m_flow_nominal=0.01,
    linearized=true,
    use_inputFilter=false,
    dpValve_nominal=10)    annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=270,
        origin={194,-22})));
  Modelica.Blocks.Sources.Constant const1(k=0.1)
                                               annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={98,-22})));
  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow    recuperator(
    redeclare package Medium1 = Air,
    redeclare package Medium2 = Air,
    m1_flow_nominal=0.05,
    m2_flow_nominal=0.05,
    dp1_nominal=20,
    dp2_nominal=20,
    tau_m=500,
    tau1=500,
    tau2=500,
    UA_nominal=50)
             annotation (Placement(transformation(
        extent={{-10,11},{10,-11}},
        rotation=0,
        origin={-30,-25})));
  AixLib.Fluid.Movers.FlowControlled_m_flow supplyAirFan(
    redeclare package Medium = Air,
    addPowerToMedium=false,
    m_flow_nominal=0.05,
    riseTime=5,
    T_start=T_start,
    m_flow(start=supplyAirFan.m_flow_nominal),
    dp(start=supplyAirFan.dp_nominal),
    m_flow_start=supplyAirFan.m_flow_nominal,
    dp_nominal=120)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={58,26})));
  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow    heater(
    redeclare package Medium1 = Air,
    redeclare package Medium2 = Water,
    m1_flow_nominal=0.05,
    m2_flow_nominal=0.05,
    dp1_nominal=20,
    dp2_nominal=500,
    tau2=5,
    tau_m=80,
    UA_nominal=350)
             annotation (Placement(transformation(
        extent={{-10,11},{10,-11}},
        rotation=0,
        origin={102,33})));
  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow    cooler(
    redeclare package Medium1 = Air,
    redeclare package Medium2 = Water,
    m1_flow_nominal=0.05,
    m2_flow_nominal=0.05,
    dp1_nominal=20,
    dp2_nominal=500,
    tau2=5,
    tau_m=80,
    UA_nominal=350)
             annotation (Placement(transformation(
        extent={{-10,11},{10,-11}},
        rotation=0,
        origin={166,33})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening heatingValve(
    m_flow_nominal=0.05,
    redeclare package Medium = Water,
    dpValve_nominal=200)              annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=180,
        origin={129,40})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening coolingValve(
    m_flow_nominal=0.05,
    redeclare package Medium = Water,
    dpValve_nominal=200)              annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=180,
        origin={191,40})));
  Modelica.Blocks.Interfaces.RealInput heatingValveOpening
    "Actuator position (0: closed, 1: open)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={120,100})));
  Modelica.Blocks.Interfaces.RealInput coolingValveOpening
    "Actuator position (0: closed, 1: open)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={178,100})));
  Modelica.Blocks.Tables.CombiTable2D supplyVolumeFlow(tableOnFile=false, table=
       [0.0,0.0,50.0,100; 0,0,0,0; 20,65,65,65; 25,85,80,78; 30,105,100,95; 35,120,
        118,112; 40,140,135,132; 45,160,155,150; 50,170,165,160; 55,190,180,175;
        60,210,200,195; 65,225,220,215; 70,250,240,235; 75,270,260,255; 80,290,280,
        270; 85,310,300,290; 90,320,310,305; 95,340,330,320; 100,365,360,350])
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={7,67})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[0.0,0.0; 10,0; 20,74;
        30,121; 40,172; 50,207; 60,254; 70,305; 80,352; 90,391; 100,437])
    annotation (Placement(transformation(extent={{0,40},{14,54}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{24,50},{38,64}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D1(table=[0.0,0.0; 10,0; 20,30;
        30,58; 40,86; 50,112; 60,144; 70,189; 80,215; 90,245; 100,280])
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-148,68})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=0.5)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-23,75})));
  Modelica.Blocks.Continuous.LimPID PID(
    y_start=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=50)
    annotation (Placement(transformation(extent={{-114,50},{-100,64}})));
  Modelica.Fluid.Sensors.MassFlowRate bypassMassFlowRate(
  redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{-24,43},{-10,29}})));
  Modelica.Fluid.Sensors.MassFlowRate recuperatorMassFlowRate(redeclare package
      Medium =         Air) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-48,-50})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-100,26})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=180,
        origin={-137,21})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D2(table=[0.0,1; 55,0.95; 60,
        0.93; 70,0.89; 80,0.85; 85,0.82; 90,0.78; 95,0.73; 99,0.71; 100,0])
    annotation (Placement(transformation(extent={{-134,50},{-120,64}})));
  Modelica.Blocks.Math.Gain gain(k=1/3600*1.25) annotation (Placement(
        transformation(
        extent={{-3.5,-4},{3.5,4}},
        rotation=270,
        origin={-147.5,48})));
  Modelica.Blocks.Math.Gain gain1(k=1/3600*1.25) annotation (Placement(
        transformation(
        extent={{-3.5,-4},{3.5,4}},
        rotation=0,
        origin={46.5,57})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1000, uMin=0.001)
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-117,17})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0)
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-8,17})));
  Modelica.Fluid.Sensors.MassFlowRate heaterMassFlowRate(redeclare package
      Medium = Water)
    annotation (Placement(transformation(extent={{-7,7},{7,-7}},
        rotation=90,
        origin={92,60})));
  Modelica.Fluid.Sensors.MassFlowRate heaterMassFlowRate1(
                                                         redeclare package
      Medium = Water)
    annotation (Placement(transformation(extent={{-7,7},{7,-7}},
        rotation=90,
        origin={156,58})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening roomCirculation1(
    redeclare package Medium = Air,
    linearized=true,
    use_inputFilter=false,
    dpValve_nominal=10,
    m_flow_nominal=0.04)   annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=180,
        origin={180,-68})));
  Modelica.Blocks.Math.Add add3(
                               k1=-1)
    annotation (Placement(transformation(extent={{137,-42},{147,-32}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(
                                                        y=1)
    annotation (Placement(transformation(extent={{104,-48},{117,-32}})));
  Modelica.Fluid.Vessels.ClosedVolume case1(
    redeclare package Medium = Air,
    T_start=T_start,
    use_portsData=false,
    use_HeatTransfer=true,
    nPorts=2,
    V=0.01)
    annotation (Placement(transformation(extent={{-88,-32},{-108,-52}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=5)
    annotation (Placement(transformation(extent={{-102,-97},{-88,-83}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1
    annotation (Placement(transformation(extent={{-136,-114},{-116,-94}})));
  Modelica.Blocks.Interfaces.RealOutput supplyMassFlow
    "Output signal connector" annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={56,-106})));
  Modelica.Blocks.Math.Gain supplayFaPower(k=85)       annotation (Placement(
        transformation(
        extent={{-6.75,-6.75},{6.75,6.75}},
        rotation=270,
        origin={-188.75,64.75})));
  Modelica.Blocks.Math.Gain exhaustFaPower(k=85)       annotation (Placement(
        transformation(
        extent={{-6.75,-6.75},{6.75,6.75}},
        rotation=270,
        origin={-168.75,64.75})));
  Modelica.Blocks.Math.Add add5
                               annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-180,40})));
  Modelica.Blocks.Interfaces.RealOutput electricalPower
    "Output signal connector" annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={90,-104})));
  Modelica.Blocks.Sources.Constant const2(k=273)
                                               annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-158,-86})));
  Modelica.Fluid.Vessels.ClosedVolume case2(
    redeclare package Medium = Air,
    T_start=T_start,
    use_portsData=false,
    use_HeatTransfer=true,
    nPorts=2,
    V=0.01) annotation (Placement(transformation(extent={{14,-32},{-6,-52}})));
  Modelica.Blocks.Math.Gain exhaustFaPower1(
                                           k=1/100*85) annotation (Placement(
        transformation(
        extent={{-4.75,-4.75},{4.75,4.75}},
        rotation=270,
        origin={119.25,70.75})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=0.99, uMin=0.01)
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={120,55})));
  Modelica.Blocks.Math.Gain exhaustFaPower2(
                                           k=1/100*85) annotation (Placement(
        transformation(
        extent={{-4.75,-4.75},{4.75,4.75}},
        rotation=270,
        origin={179.25,70.75})));
  Modelica.Blocks.Nonlinear.Limiter limiter3(uMax=0.99, uMin=0.01)
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={180,55})));
equation

  connect(freshAir,freshAir)  annotation (Line(
      points={{-200,-80},{-200,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_SupplyAir.T, SupplyTemperature);
  connect(T_Mix.T, MixTemperature);
  connect(ExhaustAir, ExhaustAir) annotation (Line(
      points={{202,-68},{202,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(roomCirculation.y, const1.y)
    annotation (Line(points={{183.2,-22},{158,-22},{104.6,-22}},
                                                       color={0,0,127}));
  connect(recuperator.port_b2, exhaustAirFan.port_a) annotation (Line(points={{-40,
          -18.4},{-44,-18.4},{-44,-18},{-46,-18},{-46,14}}, color={0,127,255}));
  connect(recuperator.port_a1, T_BeforeHeatRecovery.port) annotation (Line(
        points={{-40,-31.6},{-40,-31.6},{-40,-48},{-40,-50},{-40,-72}}, color={0,
          127,255}));
  connect(Flap_CirculationAir.port_b, supplyAirFan.port_a)
    annotation (Line(points={{30,-4},{30,26},{48,26}}, color={0,127,255}));
  connect(T_Mix.port, supplyAirFan.port_a) annotation (Line(points={{40,18},{40,
          26},{48,26}},                 color={0,127,255}));
  connect(supplyAirFan.port_b, T_AfterFan.port)
    annotation (Line(points={{68,26},{74,26},{74,42}}, color={0,127,255}));
  connect(supplyAirFan.port_b, heater.port_a1)
    annotation (Line(points={{68,26},{92,26},{92,26.4}}, color={0,127,255}));
  connect(heater.port_b1, cooler.port_a1)
    annotation (Line(points={{112,26.4},{156,26.4}}, color={0,127,255}));
  connect(cooler.port_b1, SupplyAir) annotation (Line(points={{176,26.4},{182,26.4},
          {182,26},{202,26}}, color={0,127,255}));
  connect(Heater_Flow, heatingValve.port_a) annotation (Line(points={{142,100},{
          142,40},{138,40}},  color={0,127,255}));
  connect(heatingValve.port_b, heater.port_a2) annotation (Line(points={{120,40},
          {120,39.6},{112,39.6}},     color={0,127,255}));
  connect(Cooler_Flow, coolingValve.port_a) annotation (Line(points={{198,100},{
          200,100},{200,40}},  color={0,127,255}));
  connect(coolingValve.port_b, cooler.port_a2) annotation (Line(points={{182,40},
          {182,39.6},{176,39.6}},     color={0,127,255}));
  connect(roomCirculation.port_a, SupplyAir) annotation (Line(points={{194,
          -13},{194,26},{202,26}}, color={0,127,255}));
  connect(T_beforeCooler.port, heater.port_b1) annotation (Line(points={{133,12},
          {134,12},{134,18},{134,26.4},{112,26.4}},     color={0,127,255}));
  connect(T_SupplyAir.port, SupplyAir) annotation (Line(points={{186,12},{186,
          26},{202,26}}, color={0,127,255}));
  connect(InputSignal_Fan_SupplyAir, supplyVolumeFlow.u1) annotation (Line(
        points={{58,100},{58,76},{-8,76},{-8,71.2},{-1.4,71.2}}, color={0,0,127}));
  connect(InputSignal_HeatRecoveryFlap, supplyVolumeFlow.u2) annotation (Line(
        points={{-98,100},{-98,62.8},{-1.4,62.8}}, color={0,0,127}));
  connect(InputSignal_Fan_SupplyAir, combiTable1D.u[1]) annotation (Line(points=
         {{58,100},{58,100},{58,76},{-8,76},{-8,47},{-1.4,47}}, color={0,0,127}));
  connect(lessThreshold.y, switch1.u2) annotation (Line(points={{-30.7,75},{
          -38,75},{-38,57},{22.6,57}},
                                   color={255,0,255}));
  connect(Flap_Bypass.port_b, bypassMassFlowRate.port_a)
    annotation (Line(points={{-30,36},{-24,36}}, color={0,127,255}));
  connect(bypassMassFlowRate.port_b, supplyAirFan.port_a) annotation (Line(
        points={{-10,36},{18,36},{18,26},{48,26}},
                                                 color={0,127,255}));
  connect(Flap_HeatRecovery.port_b, recuperatorMassFlowRate.port_a)
    annotation (Line(points={{-55,-68},{-48,-68},{-48,-60}}, color={0,127,255}));
  connect(recuperatorMassFlowRate.port_b, recuperator.port_a1) annotation (
      Line(points={{-48,-40},{-48,-31.6},{-40,-31.6}}, color={0,127,255}));
  connect(recuperatorMassFlowRate.m_flow, add.u1) annotation (Line(points={{
          -59,-50},{-82,-50},{-82,22.4},{-92.8,22.4}}, color={0,0,127}));
  connect(realExpression1.y, add1.u2) annotation (Line(points={{-90.35,42},{
          -88,42},{-84,42}}, color={0,0,127}));
  connect(PID.y, add1.u1) annotation (Line(points={{-99.3,57},{-94,57},{-94,
          48},{-84,48}}, color={0,0,127}));
  connect(division.y, PID.u_m) annotation (Line(points={{-144.7,21},{-154,21},
          {-154,42},{-107,42},{-107,48.6}}, color={0,0,127}));
  connect(InputSignal_Fan_ExhaustAir, combiTable1D1.u[1]) annotation (Line(
        points={{-148,100},{-148,100},{-148,76.4}}, color={0,0,127}));
  connect(combiTable1D1.y[1], gain.u) annotation (Line(points={{-148,60.3},{
          -148,60.3},{-148,56},{-147.5,56},{-147.5,52.2}}, color={0,0,127}));
  connect(gain.y, exhaustAirFan.m_flow_in) annotation (Line(points={{-147.5,44.15},
          {-147.5,38},{-56,38},{-56,26}},            color={0,0,127}));
  connect(switch1.y, gain1.u) annotation (Line(points={{38.7,57},{38.7,57},{
          42.3,57}}, color={0,0,127}));
  connect(gain1.y, supplyAirFan.m_flow_in) annotation (Line(points={{50.35,57},{
          58,57},{58,38}},      color={0,0,127}));
  connect(combiTable1D.y[1], switch1.u3) annotation (Line(points={{14.7,47},{
          18,47},{18,51.4},{22.6,51.4}}, color={0,0,127}));
  connect(supplyVolumeFlow.y, switch1.u1) annotation (Line(points={{14.7,67},
          {18,67},{18,62.6},{22.6,62.6}}, color={0,0,127}));
  connect(combiTable1D2.y[1], PID.u_s) annotation (Line(points={{-119.3,57},{
          -119.3,57},{-115.4,57}}, color={0,0,127}));
  connect(InputSignal_HeatRecoveryFlap, combiTable1D2.u[1]) annotation (Line(
        points={{-98,100},{-98,76},{-135.4,76},{-135.4,57}}, color={0,0,127}));
  connect(bypassMassFlowRate.m_flow, add.u2) annotation (Line(points={{-17,
          28.3},{-17,29.6},{-92.8,29.6}}, color={0,0,127}));
  connect(bypassMassFlowRate.m_flow, division.u1) annotation (Line(points={{
          -17,28.3},{-17,30},{-84,30},{-84,34},{-118,34},{-118,25.2},{-128.6,
          25.2}}, color={0,0,127}));
  connect(division.u2, limiter.y) annotation (Line(points={{-128.6,16.8},{
          -126,16.8},{-126,17},{-122.5,17}}, color={0,0,127}));
  connect(add.y, limiter.u) annotation (Line(points={{-106.6,26},{-111,26},{
          -111,17}}, color={0,0,127}));
  connect(InputSignal_CircularAir, lessThreshold.u) annotation (Line(points={
          {4,100},{-8,100},{-8,98},{-8,78},{-8,75},{-14.6,75}}, color={0,0,
          127}));
  connect(InputSignal_CircularAir, limiter1.u) annotation (Line(points={{4,100},
          {-8,100},{-8,20},{-8,23}},           color={0,0,127}));
  connect(heater.port_b2, heaterMassFlowRate.port_a)
    annotation (Line(points={{92,39.6},{92,53}}, color={0,127,255}));
  connect(heaterMassFlowRate.port_b, Heater_Return)
    annotation (Line(points={{92,67},{92,67},{92,100}}, color={0,127,255}));
  connect(Cooler_Return, heaterMassFlowRate1.port_b)
    annotation (Line(points={{156,100},{156,65}}, color={0,127,255}));
  connect(heaterMassFlowRate1.port_a, cooler.port_b2)
    annotation (Line(points={{156,51},{156,39.6}}, color={0,127,255}));
  connect(ExhaustAir, roomCirculation1.port_a) annotation (Line(points={{202,-68},
          {196,-68},{189,-68}},           color={0,127,255}));
  connect(add3.y, roomCirculation1.y) annotation (Line(points={{147.5,-37},{180,
          -37},{180,-57.2}}, color={0,0,127}));
  connect(add3.u2, realExpression3.y) annotation (Line(points={{136,-40},{132,-40},
          {117.65,-40}}, color={0,0,127}));
  connect(const1.y, add3.u1) annotation (Line(points={{104.6,-22},{126,-22},{126,
          -34},{136,-34}}, color={0,0,127}));
  connect(Flap_HeatRecovery.port_a, Flap_Bypass.port_a) annotation (Line(points=
         {{-73,-68},{-78,-68},{-78,36},{-48,36}}, color={0,127,255}));
  connect(T_AfterHeatRecovery.port, recuperator.port_b1) annotation (Line(
        points={{-16,-50},{-16,-31.6},{-20,-31.6}}, color={0,127,255}));
  connect(Flap_HeatRecovery.port_a, case1.ports[1]) annotation (Line(points={{-73,-68},
          {-78,-68},{-78,-28},{-96,-28},{-96,-32}},           color={0,127,
          255}));
  connect(recuperator.port_a2, roomCirculation1.port_b) annotation (Line(
        points={{-20,-18.4},{-12,-18.4},{-12,-18},{-8,-18},{-8,-68},{171,-68}},
        color={0,127,255}));
  connect(roomCirculation.port_b, roomCirculation1.port_b) annotation (Line(
        points={{194,-31},{194,-42},{152,-42},{152,-68},{171,-68}}, color={0,
          127,255}));
  connect(T_ExhaustAir.port, roomCirculation1.port_b) annotation (Line(points=
         {{152,-76},{152,-68},{171,-68}}, color={0,127,255}));
  connect(Flap_CirculationAir.port_a, roomCirculation1.port_b) annotation (
      Line(points={{30,-24},{30,-68},{171,-68}}, color={0,127,255}));
  connect(gain1.y, supplyMassFlow) annotation (Line(points={{50.35,57},{58,57},
          {58,46},{36,46},{36,-46},{56,-46},{56,-106}}, color={0,0,127}));
  connect(InputSignal_Fan_ExhaustAir, exhaustFaPower.u) annotation (Line(
        points={{-148,100},{-158,100},{-158,82},{-168.75,82},{-168.75,72.85}},
        color={0,0,127}));
  connect(InputSignal_Fan_SupplyAir, supplayFaPower.u) annotation (Line(
        points={{58,100},{58,134},{-188.75,134},{-188.75,72.85}}, color={0,0,
          127}));
  connect(supplayFaPower.y, add5.u2) annotation (Line(points={{-188.75,57.325},
          {-188.75,54},{-183.6,54},{-183.6,47.2}}, color={0,0,127}));
  connect(exhaustFaPower.y, add5.u1) annotation (Line(points={{-168.75,57.325},
          {-168.75,54},{-176.4,54},{-176.4,47.2}}, color={0,0,127}));
  connect(recuperator.port_b1, case2.ports[1]) annotation (Line(points={{-20,
          -31.6},{-10,-31.6},{-10,-32},{6,-32}}, color={0,127,255}));
  connect(case2.ports[2], supplyAirFan.port_a) annotation (Line(points={{2,
          -32},{14,-32},{14,26},{48,26}}, color={0,127,255}));
  connect(thermalConductor.port_b, case2.heatPort) annotation (Line(points={{-88,-90},
          {-86,-90},{20,-90},{20,-42},{14,-42}},                    color={
          191,0,0}));
  connect(PID.y, Flap_Bypass.y) annotation (Line(points={{-99.3,57},{-39,57},
          {-39,46.8}}, color={0,0,127}));
  connect(add1.y, Flap_HeatRecovery.y) annotation (Line(points={{-72.5,45},{
          -68,45},{-68,-32},{-64,-32},{-64,-57.2}}, color={0,0,127}));
  connect(heatingValveOpening, exhaustFaPower1.u) annotation (Line(points={{120,100},
          {120,100},{120,76.45},{119.25,76.45}},      color={0,0,127}));
  connect(exhaustFaPower1.y, limiter2.u) annotation (Line(points={{119.25,
          65.525},{119.25,63.7625},{120,63.7625},{120,61}}, color={0,0,127}));
  connect(limiter2.y, heatingValve.y) annotation (Line(points={{120,49.5},{120,
          56},{129,56},{129,50.8}}, color={0,0,127}));
  connect(coolingValveOpening, exhaustFaPower2.u) annotation (Line(points={{178,
          100},{178,100},{178,76.45},{179.25,76.45}}, color={0,0,127}));
  connect(exhaustFaPower2.y, limiter3.u) annotation (Line(points={{179.25,
          65.525},{180,65.525},{180,61}}, color={0,0,127}));
  connect(limiter3.y, coolingValve.y) annotation (Line(points={{180,49.5},{180,
          44},{184,44},{184,56},{191,56},{191,50.8}}, color={0,0,127}));
  connect(limiter1.y, Flap_CirculationAir.y)
    annotation (Line(points={{-8,11.5},{-8,-14},{18,-14}}, color={0,0,127}));
  connect(port_a1, port_a1) annotation (Line(points={{-126,-104},{-126,-104},{
          -126,-104}}, color={191,0,0}));
  connect(port_a1, thermalConductor.port_a) annotation (Line(points={{-126,-104},
          {-128,-104},{-128,-90},{-102,-90}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}})),
    Icon(coordinateSystem(extent={{-200,-100},{200,100}}, preserveAspectRatio=false),
        graphics={Rectangle(
          extent={{-160,100},{200,-100}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}), Text(
          extent={{-120,56},{168,-52}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="FVU",
          textStyle={TextStyle.Bold})}),
    experiment(StopTime=86400, Interval=1),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color: #008000\">overview</span></h4>
<p><br>The Modell &QUOT;Facade Ventilation Unit&QUOT; (FVU) can be used for heating, cooling and ventilation purposes. The user has this possibility to activate the FVU in Auto- or Manual-mode. In order to control the &ldquo;Facade Ventilation Unit&rdquo; a FVU-Controller is used which gives six output signals in each operation mode. These output signals are listed as follows: </p>
<ol>
<li><b>HRC:</b> Heat Recovery Flap </li>
<li><b>Pheat_o: </b>Valve Opening of heating circuit in heating mode </li>
<li><b>Pcool_o:</b> Valve Opening of cooling circuit in cooling mode</li>
<li><b>Circ:</b> Circulation Air Flap</li>
<li><b>Psup_o:</b> needed Power (in percent of nominal power) for supply fan </li>
<li><b>Pexa_o:</b> needed Power (in percent of nominal power) for exhaust fan </li>
</ol>
<p>&nbsp; </p>
<p><b><span style=\"color: #005c00;\">Operation Modes of FVU:</span></b> </p>
<p>The fresh air sucked in by the Fan flows through either the heat recovery or bypass flap or through both of them towards the heat exchangers. Depending on operation mode the fresh air cools down or heats up in cooler or heater to achieve the desired supply temperature before it enters the room. The air sucked out of the room flows through either circulation air flap or heat recovery unit or both of them and finally towards the outside. The heater and cooler are connected to hot and cold water which depending on operation mode and the output signals, namely Pheat_o and Pcool_o, it will be calculated how much volume flow rate of water flows through the valves located in hot and cold water pipes. </p>
<h4><span style=\"color: #008000\">FVU Components:</span></h4>
<h4>Supply- and Exhaust fans:</h4>
<p>The supply- and exhaust Fans are modelled based on a table which gets an input signal in percent, namely power share, and gives finally a mass flow rate according to the data defined in the table. Regarding the supply air fan, the recuperator flap position is also taken into account. The tables are only valid if the circulation air flap is either fully open or fully closed.  </p>
<h4>Further Heat Exchangers:</h4>
<p>These are used to model heat transfers from the facade and from the casing to the fluid.</p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Solare Radiation:</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Is added to the facade volume using a factor to obtain the absolute solar radiation added to the volume from the specific solar radiation measurement on a horizontal area.</span></p>
</html>", revisions="<html>
<ul>
<li><i>April 1, 2014&nbsp;</i> by Roozbeh Sangi:<br>Developed.</li>
<li><i>November 11, 2015   </i>by Farid Davani:<br>Developed.</li>
</ul>
</html>"));
end FVUBase;
