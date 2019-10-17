within AixLib.Systems.Benchmark;
model BenchmarkBuilding "Benchmark building model"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={200,-60})));
  Fluid.Sources.MassFlowSource_T        boundary3(
    redeclare package Medium = Medium,
    m_flow=4,
    T=292.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={198,-36})));
  Model.Generation.HeatpumpSystem heatpumpSystem(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-40,-80},{70,-34}})));
  EONERC_MainBuilding.SwitchingUnit switchingUnit(redeclare package Medium =
        Medium, m_flow_nominal=2) annotation (Placement(transformation(
        extent={{20,-24},{-20,24}},
        rotation=0,
        origin={120,-56})));
  EONERC_MainBuilding.HeatExchangerSystem heatExchangerSystem(redeclare package
      Medium = Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-130,-40},{-60,8}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-208,-66})));
  Fluid.Sources.Boundary_pT          boundary4(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-76,50})));
  Fluid.Sources.Boundary_pT          boundary6(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-56,50})));
  HydraulicModules.Admix                admix(
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per, energyDynamics=
            admix.energyDynamics)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_amb=298.15,
    dIns=0.01,
    kIns=0.028,
    d=0.032,
    pipe1(length=1),
    pipe2(length=1),
    pipe3(length=4),
    pipe4(
      kIns=0.028,
      length=5,
      dIns=0.02),
    pipe5(length=1),
    pipe6(length=1),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    Kv=10)                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-170,70})));
  HydraulicModules.Controller.CtrMix
                    ctrMix(
    TflowSet=313.15,
    Td=0,
    Ti=180,
    k=0.12,
    xi_start=0.5,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    reverseAction=false)
    annotation (Placement(transformation(extent={{-204,64},{-188,78}})));
  HydraulicModules.SimpleConsumer
                 simpleConsumer(
    kA=2000,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    T_amb=298.15,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-176,82},{-164,94}})));
  EONERC_MainBuilding.Controller.CtrSWU ctrSWU
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=4)
    annotation (Placement(transformation(extent={{52,-20},{72,0}})));
  EONERC_MainBuilding.Controller.CtrHXSsystem ctrHXSsystem(
    TflowSet=308.15,
    Ti=60,
    Td=0,
    rpm_pump=1000,
    rpm_pump_htc=1500)
    annotation (Placement(transformation(extent={{-148,48},{-128,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  Model.Generation.HighTemperatureSystem highTemperatureSystem(redeclare
      package Medium = Medium, m_flow_nominal=10)
    annotation (Placement(transformation(extent={{-188,-80},{-144,-34}})));
  EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus heatPumpSystemBus1
    annotation (Placement(transformation(extent={{6,-34},{26,-14}})));
  Model.Generation.BaseClasses.HighTemperatureSystemBus
    highTemperatureSystemBus1
    annotation (Placement(transformation(extent={{-178,-36},{-158,-16}})));
  Model.Generation.GeothermalProbe geothermalProbe(m_flow_nominal=1)
    annotation (Placement(transformation(extent={{110,-118},{130,-98}})));
equation
  connect(switchingUnit.port_a2, heatpumpSystem.port_b1) annotation (Line(
        points={{100,-60},{80,-60},{80,-59.5556},{70,-59.5556}},
                                                              color={0,127,255}));
  connect(heatpumpSystem.port_a1, switchingUnit.port_b1) annotation (Line(
        points={{70,-49.3333},{94,-49.3333},{94,-36},{100,-36}},
                                                    color={0,127,255}));
  connect(heatpumpSystem.fluidportBottom1, heatExchangerSystem.port_b3)
    annotation (Line(points={{-40,-59.5556},{-64,-59.5556},{-64,-39.52},{-65,
          -39.52}}, color={0,127,255}));
  connect(heatpumpSystem.fluidportTop1, heatExchangerSystem.port_a2)
    annotation (Line(points={{-40,-49.3333},{-75,-49.3333},{-75,-40}},
                                                             color={0,127,255}));
  connect(boundary4.ports[1], heatExchangerSystem.port_b2)
    annotation (Line(points={{-76,40},{-76,8},{-75,8}},   color={0,127,255}));
  connect(boundary6.ports[1], heatExchangerSystem.port_a3) annotation (Line(
        points={{-56,40},{-62,40},{-62,8},{-65,8}},   color={0,127,255}));
  connect(ctrMix.hydraulicBus, admix.hydraulicBus) annotation (Line(
      points={{-188.56,70.23},{-186.315,70.23},{-186.315,70},{-180,70}},
      color={255,204,51},
      thickness=0.5));
  connect(admix.port_b1, simpleConsumer.port_a)
    annotation (Line(points={{-176,80},{-176,88}}, color={0,127,255}));
  connect(admix.port_a2, simpleConsumer.port_b)
    annotation (Line(points={{-164,80},{-164,88}}, color={0,127,255}));
  connect(ctrSWU.sWUBus, switchingUnit.sWUBus) annotation (Line(
      points={{100,-10},{120,-10},{120,-31.6},{120.2,-31.6}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrSWU.mode, integerExpression.y)
    annotation (Line(points={{80,-10},{73,-10}}, color={255,127,0}));
  connect(ctrHXSsystem.hydraulicBusHTC, heatExchangerSystem.hydraulicBusHTC)
    annotation (Line(
      points={{-128.7,33.4},{-118,33.4},{-118,8},{-110,8}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrHXSsystem.hydraulicBus, heatExchangerSystem.hydraulicBusLTC)
    annotation (Line(
      points={{-128.7,39.1},{-85,39.1},{-85,8}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature.port, heatpumpSystem.T_outside) annotation (Line(
        points={{0,-110},{14,-110},{14,-77.4444},{15,-77.4444}}, color={191,0,0}));
  connect(highTemperatureSystem.port_b, heatExchangerSystem.port_a1)
    annotation (Line(points={{-144,-66.2},{-142,-66.2},{-142,-66},{-138,-66},{
          -138,-20.8},{-130,-20.8}}, color={0,127,255}));
  connect(highTemperatureSystem.port_a, heatExchangerSystem.port_b1)
    annotation (Line(points={{-188,-66.2},{-188,-66},{-194,-66},{-194,-11.2},{
          -130,-11.2}}, color={0,127,255}));
  connect(boundary1.ports[1], highTemperatureSystem.port_a) annotation (Line(
        points={{-198,-66},{-196,-66},{-196,-66.2},{-188,-66.2}}, color={0,127,
          255}));
  connect(boundary3.ports[1], switchingUnit.port_a1)
    annotation (Line(points={{188,-36},{140,-36}}, color={0,127,255}));
  connect(boundary2.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{190,-60},{140,-60}}, color={0,127,255}));
  connect(heatpumpSystem.heatPumpSystemBus, heatPumpSystemBus1) annotation (
      Line(
      points={{15,-34},{16,-34},{16,-24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(highTemperatureSystem.highTemperatureSystemBus,
    highTemperatureSystemBus1) annotation (Line(
      points={{-165.78,-34},{-165.78,-30},{-168,-30},{-168,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(admix.port_a1, highTemperatureSystem.port_b) annotation (Line(points=
          {{-176,60},{-176,2},{-138,2},{-138,-66},{-144,-66},{-144,-66.2}},
        color={0,127,255}));
  connect(admix.port_b2, heatExchangerSystem.port_b1) annotation (Line(points={
          {-164,60},{-164,24},{-194,24},{-194,-11.2},{-130,-11.2}}, color={0,
          127,255}));
  connect(geothermalProbe.port_a, switchingUnit.port_b3) annotation (Line(
        points={{110,-108},{112,-108},{112,-80}}, color={0,127,255}));
  connect(geothermalProbe.port_b, switchingUnit.port_a3) annotation (Line(
        points={{130,-108},{130,-80},{128,-80}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-200,-120},{200,200}})), Icon(
        coordinateSystem(extent={{-200,-120},{200,200}})),
    experiment(
      StopTime=36000,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.5,
      __Dymola_Algorithm="Cvode"));
end BenchmarkBuilding;
