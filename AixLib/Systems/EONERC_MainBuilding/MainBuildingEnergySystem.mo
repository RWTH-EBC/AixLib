within AixLib.Systems.EONERC_MainBuilding;
model MainBuildingEnergySystem
  "Energy system of E.ON ERC main building"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,60})));
  Fluid.Sources.MassFlowSource_T        boundary3(
    redeclare package Medium = Medium,
    m_flow=4,
    T=292.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,84})));
  HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-74},{50,-26}})));
  SwitchingUnit switchingUnit(redeclare package Medium = Medium, m_flow_nominal=
       2) annotation (Placement(transformation(extent={{20,40},{60,88}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=4,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,16})));
  HeatExchangerSystem heatExchangerSystem(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-150,-26},{-80,22}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-212,-48})));
  Fluid.Sources.Boundary_pT          boundary4(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-96,52})));
  Fluid.Sources.Boundary_pT          boundary6(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-76,52})));
  HighTemperatureSystem highTemperatureSystem(
    redeclare package Medium = Medium,
    T_amb=293.15,
    m_flow_nominal=2) annotation (Placement(transformation(
        extent={{-36,-27},{36,27}},
        rotation=90,
        origin={-167,-84})));
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
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=90,
        origin={-170.5,70.5})));
  HydraulicModules.Controller.CtrMix
                    ctrMix(
    TflowSet=313.15,
    Td=0,
    Ti=180,
    k=0.12,
    xi_start=0.5,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    reverseAction=false)
    annotation (Placement(transformation(extent={{-210,56},{-192,72}})));
  HydraulicModules.SimpleConsumer
                 simpleConsumer(
    kA=2000,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    T_amb=298.15,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-178,82},{-164,96}})));
  Controller.HeatPumpSystemDataInput heatPumpSystemDataInput
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Controller.CtrSWU ctrSWU
    annotation (Placement(transformation(extent={{4,98},{24,118}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=4)
    annotation (Placement(transformation(extent={{-34,98},{-14,118}})));
  Controller.CtrHXSsystem ctrHXSsystem(
    TflowSet=308.15,
    Ti=60,
    Td=0,
    rpm_pump=1000,
    rpm_pump_htc=1500)
    annotation (Placement(transformation(extent={{-148,48},{-128,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  Controller.CtrHighTemperatureSystem ctrHighTemperatureSystem
    annotation (Placement(transformation(extent={{-226,-94},{-206,-74}})));
equation
  connect(boundary2.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{-20,60},{20,60}}, color={0,127,255}));
  connect(boundary3.ports[1], switchingUnit.port_a1)
    annotation (Line(points={{-20,84},{20,84}}, color={0,127,255}));
  connect(switchingUnit.port_a2, heatpumpSystem.port_b1) annotation (Line(
        points={{60,60},{80,60},{80,-52.6667},{50,-52.6667}}, color={0,127,255}));
  connect(heatpumpSystem.port_a1, switchingUnit.port_b1) annotation (Line(
        points={{50,-42},{94,-42},{94,84},{60,84}}, color={0,127,255}));
  connect(vol.ports[1], switchingUnit.port_a3) annotation (Line(points={{42,26},
          {36,26},{36,40},{32,40}}, color={0,127,255}));
  connect(vol.ports[2], switchingUnit.port_b3) annotation (Line(points={{38,26},
          {46,26},{46,40},{48,40}}, color={0,127,255}));
  connect(heatpumpSystem.fluidportBottom1, heatExchangerSystem.port_b3)
    annotation (Line(points={{-60,-52.6667},{-86,-52.6667},{-86,-25.52},{-85,
          -25.52}}, color={0,127,255}));
  connect(heatpumpSystem.fluidportTop1, heatExchangerSystem.port_a2)
    annotation (Line(points={{-60,-42},{-95,-42},{-95,-26}}, color={0,127,255}));
  connect(boundary4.ports[1], heatExchangerSystem.port_b2)
    annotation (Line(points={{-96,42},{-96,22},{-95,22}}, color={0,127,255}));
  connect(boundary6.ports[1], heatExchangerSystem.port_a3) annotation (Line(
        points={{-76,42},{-80,42},{-80,22},{-85,22}}, color={0,127,255}));
  connect(highTemperatureSystem.port_a, heatExchangerSystem.port_b1)
    annotation (Line(points={{-172.4,-48},{-172.4,2.8},{-150,2.8}}, color={0,
          127,255}));
  connect(highTemperatureSystem.port_b, heatExchangerSystem.port_a1)
    annotation (Line(points={{-183.2,-48},{-182,-48},{-182,-6.8},{-150,-6.8}},
        color={0,127,255}));
  connect(ctrMix.hydraulicBus, admix.hydraulicBus) annotation (Line(
      points={{-192.63,63.12},{-186.315,63.12},{-186.315,70.5},{-181,70.5}},
      color={255,204,51},
      thickness=0.5));
  connect(admix.port_b1, simpleConsumer.port_a) annotation (Line(points={{
          -176.8,81},{-176.8,85.5},{-178,85.5},{-178,89}}, color={0,127,255}));
  connect(admix.port_a2, simpleConsumer.port_b) annotation (Line(points={{
          -164.2,81},{-164.2,85.5},{-164,85.5},{-164,89}}, color={0,127,255}));
  connect(admix.port_a1, highTemperatureSystem.port_b) annotation (Line(points=
          {{-176.8,60},{-182,60},{-182,-48},{-183.2,-48}}, color={0,127,255}));
  connect(admix.port_b2, highTemperatureSystem.port_a) annotation (Line(points=
          {{-164.2,60},{-172,60},{-172,-48},{-172.4,-48}}, color={0,127,255}));
  connect(boundary1.ports[1], highTemperatureSystem.port_b)
    annotation (Line(points={{-202,-48},{-183.2,-48}}, color={0,127,255}));
  connect(heatPumpSystemDataInput.heatPumpSystemBus1, heatpumpSystem.heatPumpSystemBus)
    annotation (Line(
      points={{-20,0.1},{-6,0.1},{-6,-26},{-5,-26}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrSWU.sWUBus, switchingUnit.sWUBus) annotation (Line(
      points={{24,108},{40,108},{40,88.4},{39.8,88.4}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrSWU.mode, integerExpression.y)
    annotation (Line(points={{4,108},{-13,108}}, color={255,127,0}));
  connect(ctrHXSsystem.hydraulicBusHTC, heatExchangerSystem.hydraulicBusHTC)
    annotation (Line(
      points={{-128.7,33.4},{-118,33.4},{-118,22},{-130,22}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrHXSsystem.hydraulicBus, heatExchangerSystem.hydraulicBusLTC)
    annotation (Line(
      points={{-128.7,39.1},{-105,39.1},{-105,22}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature.port, heatpumpSystem.T_outside) annotation (Line(
        points={{0,-110},{-2,-110},{-2,-71.3333},{-5,-71.3333}}, color={191,0,0}));
  connect(ctrHighTemperatureSystem.highTemperatureSystemBus,
    highTemperatureSystem.hTCBus) annotation (Line(
      points={{-206,-83.9},{-203,-83.9},{-203,-80.9538},{-193.73,-80.9538}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(extent={{-200,-120},{100,100}})), Icon(
        coordinateSystem(extent={{-200,-120},{100,100}})),
    experiment(
      StopTime=36000,
      Tolerance=0.001,
      __Dymola_Algorithm="Cvode"));
end MainBuildingEnergySystem;
