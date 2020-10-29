within AixLib.Systems.HydraulicModules.Example;
model ERC_ExperimentalHall_CoolingCircuit
  "Cooling circuit of the new ERC experimental hall"
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water
    "Medium within the system simulation"
    annotation (choicesAllMatching=true);
  parameter Modelica.SIunits.Temperature T_amb = 293.15 "Ambient temperature";

  AixLib.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-182,-78},{-162,-58}})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness hex(
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium) annotation (Placement(transformation(
        extent={{-20,-25},{20,25}},
        rotation=90,
        origin={-121,-48})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    m_flow=4,
    redeclare package Medium = Medium,
    T=280.15)
    annotation (Placement(transformation(extent={{-182,-38},{-162,-18}})));

  SimpleConsumer simpleConsumer(
    kA=2000,
    T_fixed=303.15,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="T_fixed",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-84,36},{-54,66}})));
  SimpleConsumer simpleConsumer1(
    kA=20000,
    T_fixed=303.15,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="T_fixed",
    T_start=293.15)
    annotation (Placement(transformation(extent={{-10,36},{20,66}})));
  SimpleConsumer simpleConsumer2(
    T_fixed=303.15,
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    functionality="T_fixed",
    kA=10000,
    T_start=293.15)
    annotation (Placement(transformation(extent={{60,36},{90,66}})));
  Controller.CtrMix ctrMix(
    Td=0,
    Ti=180,
    k=0.12,
    xi_start=0.5,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    reverseAction=true)
    annotation (Placement(transformation(extent={{-142,-2},{-116,24}})));
  Controller.CtrThrottle ctrUnmixedThrottle(
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    reverseAction=true,
    Td=0,
    rpm_pump=3000,
    TflowSet=291.15,
    k=0.2,
    Ti=60) annotation (Placement(transformation(extent={{-142,80},{-118,104}})));
  Controller.CtrPump ctrUnmixedSimple
    annotation (Placement(transformation(extent={{-142,58},{-118,82}})));
  AixLib.Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = Medium,
    p=200000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-106,-86})));
  AixLib.Systems.HydraulicModules.Pump unmixed(
    parameterPipe=DataBase.Pipes.Copper.Copper_35x1(),
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_amb=T_amb,
    pipe1(length=2),
    pipe2(length=2),
    pipe3(length=4),
    energyDynamics=admix.energyDynamics,
    length=2)                            annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={6,4})));
  AixLib.Systems.HydraulicModules.ThrottlePump unmixedThrottle(
    parameterPipe=DataBase.Pipes.Copper.Copper_42x1_2(),
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_amb=T_amb,
    pipe1(length=1),
    pipe2(length=1),
    pipe3(length=1),
    energyDynamics=admix.energyDynamics,
    length=2,
    Kv=6.3,
    pipe4(length=2)) annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={74,4})));
  AixLib.Systems.HydraulicModules.Admix admix(
    parameterPipe=DataBase.Pipes.Copper.Copper_35x1_5(),
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_amb=T_amb,
    pipe1(length=1),
    pipe2(length=1),
    pipe3(length=4),
    pipe4(length=5),
    pipe5(length=1),
    pipe6(length=1),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    Kv=10)                                                     annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={-68,4})));
  BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-124,94},{-104,114}})));
equation
  connect(bou.ports[1],hex. port_a1) annotation (Line(points={{-162,-68},{-136,
          -68}},                         color={0,127,255}));
  connect(boundary.ports[1],hex. port_b1) annotation (Line(points={{-162,-28},{
          -136,-28}},                      color={0,127,255}));
  connect(bou1.ports[1], hex.port_b2)
    annotation (Line(points={{-106,-76},{-106,-68}}, color={0,127,255}));
  connect(unmixed.port_b1, simpleConsumer1.port_a)
    annotation (Line(points={{-9,29},{-9,38},{-10,38},{-10,51}},
                                                 color={0,127,255}));
  connect(unmixed.port_a2, simpleConsumer1.port_b)
    annotation (Line(points={{21,29},{21,38},{20,38},{20,51}},
                                               color={0,127,255}));
  connect(unmixedThrottle.port_b1, simpleConsumer2.port_a)
    annotation (Line(points={{59,29},{59,38},{60,38},{60,51}},
                                               color={0,127,255}));
  connect(unmixedThrottle.port_a2, simpleConsumer2.port_b)
    annotation (Line(points={{89,29},{89,38},{90,38},{90,51}},
                                               color={0,127,255}));
  connect(simpleConsumer.port_a,admix.port_b1)
    annotation (Line(points={{-84,51},{-84,29},{-83,29}},
                                                 color={0,127,255}));
  connect(simpleConsumer.port_b,admix.port_a2)
    annotation (Line(points={{-54,51},{-54,29},{-53,29}},
                                                 color={0,127,255}));
  connect(ctrMix.hydraulicBus, admix.hydraulicBus) annotation (Line(
      points={{-114.18,11.26},{-104.455,11.26},{-104.455,4},{-93,4}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrUnmixedSimple.hydraulicBus, unmixed.hydraulicBus) annotation (Line(
      points={{-116.32,70.24},{-19,70.24},{-19,4}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrUnmixedThrottle.hydraulicBus, unmixedThrottle.hydraulicBus) annotation (Line(
      points={{-116.32,92.24},{-50,92.24},{-50,92},{50,92},{50,50},{49,50},{49,
          4}},
      color={255,204,51},
      thickness=0.5));
  connect(admix.port_a1, hex.port_a2) annotation (Line(points={{-83,-21},{-83,-28},{-106,-28}},
                       color={0,127,255}));
  connect(unmixed.port_a1, hex.port_a2) annotation (Line(points={{-9,-21},{-9,
          -28},{-106,-28}}, color={0,127,255}));
  connect(unmixedThrottle.port_a1, hex.port_a2) annotation (Line(points={{59,-21},
          {60,-21},{60,-28},{-106,-28}}, color={0,127,255}));
  connect(unmixedThrottle.port_b2, hex.port_b2) annotation (Line(points={{89,-21},
          {89,-68},{-106,-68}}, color={0,127,255}));
  connect(unmixed.port_b2, hex.port_b2) annotation (Line(points={{21,-21},{21,
          -68},{-106,-68}},
                       color={0,127,255}));
  connect(admix.port_b2, hex.port_b2) annotation (Line(points={{-53,-21},{-53,-68},{-106,-68}},
                       color={0,127,255}));
  connect(ctrUnmixedThrottle.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-116.32,92.24},{-114.42,92.24},{-114.42,104},{-114,104}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrUnmixedThrottle.Tact, hydraulicBus.TRtrnInMea) annotation (Line(
        points={{-144.4,99.2},{-152,99.2},{-152,104.05},{-113.95,104.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Diagram(coordinateSystem(extent={{-180,-100},{100,100}})), Icon(
        coordinateSystem(extent={{-180,-100},{100,100}})),
    Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This example demonstrates the use of the hydraulic modules and the
  controllers. The model represents a cooling circuit with different
  hydraulic circuits.
</p>
</html>"),
    experiment(StopTime=3600));
end ERC_ExperimentalHall_CoolingCircuit;
