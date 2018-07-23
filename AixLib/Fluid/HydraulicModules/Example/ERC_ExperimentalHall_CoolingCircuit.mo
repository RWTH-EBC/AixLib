within AixLib.Fluid.HydraulicModules.Example;
model ERC_ExperimentalHall_CoolingCircuit
  "Cooling circuit of the new ERC experimental hall"
  extends Modelica.Icons.Example;
  Sources.Boundary_pT              bou(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
    annotation (Placement(transformation(extent={{-182,-78},{-162,-58}})));
  HeatExchangers.ConstantEffectiveness              hex(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    dp1_nominal=10,
    dp2_nominal=10) annotation (Placement(transformation(
        extent={{-20,-25},{20,25}},
        rotation=90,
        origin={-121,-48})));
  Sources.MassFlowSource_T              boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=4,
    T=280.15)
    annotation (Placement(transformation(extent={{-182,-38},{-162,-18}})));

  .AixLib.Fluid.HydraulicModules.Admix admix(
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe3(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe4(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe5(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe6(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    val(Kv=6.3, m_flow_nominal=1),
    T_start=293.15,
    redeclare BaseClasses.PumpInterface_SpeedControlledNrpm basicPumpInterface(
        pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12
          per)))  annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={-67,11})));

  .AixLib.Fluid.HydraulicModules.Unmixed unmixed(
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe3(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    T_start=293.15,
    redeclare BaseClasses.PumpInterface_SpeedControlledNrpm basicPumpInterface(
        pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8
          per)))  annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={3,11})));

  .AixLib.Fluid.HydraulicModules.Unmixed unmixed1(
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe3(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    T_start=293.15,
    redeclare BaseClasses.PumpInterface_SpeedControlledNrpm basicPumpInterface(
        pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to4
          per)))  annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={75,11})));

  SimpleConsumer simpleConsumer(
    kA=2000,
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    T_start=293.15,
    Tamb=293.15)
    annotation (Placement(transformation(extent={{-78,34},{-48,64}})));
  SimpleConsumer simpleConsumer1(
    kA=20000,
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    T_start=293.15,
    Tamb=293.15)
    annotation (Placement(transformation(extent={{-12,34},{18,64}})));
  SimpleConsumer simpleConsumer2(
    kA=10000,
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    T_start=293.15)
    annotation (Placement(transformation(extent={{60,34},{90,64}})));
  Controls.HydraulicModules.CtrAdmix ctr_admix(
    Td=0,
    Ti=180,
    k=0.12) annotation (Placement(transformation(extent={{-134,8},{-106,36}})));
  Controls.HydraulicModules.CtrUnmixed ctr_unmixed_simple
    annotation (Placement(transformation(extent={{-134,78},{-108,104}})));
  Controls.HydraulicModules.CtrUnmixed ctr_unmixed_simple1
    annotation (Placement(transformation(extent={{-134,52},{-108,78}})));
  Sources.Boundary_pT              bou1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    nPorts=1,
    p=200000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-106,-86})));
equation
  connect(bou.ports[1],hex. port_a1) annotation (Line(points={{-162,-68},{-136,
          -68}},                         color={0,127,255}));
  connect(boundary.ports[1],hex. port_b1) annotation (Line(points={{-162,-28},{
          -136,-28}},                      color={0,127,255}));
  connect(admix.hydraulicBus, ctr_admix.hydraulicBus) annotation (Line(
      points={{-92,11},{-104,11},{-104,20.46},{-106.98,20.46}},
      color={255,204,51},
      thickness=0.5));
  connect(ctr_unmixed_simple.hydraulicBus, unmixed1.hydraulicBus) annotation (
      Line(
      points={{-107.87,91},{50,91},{50,11}},
      color={255,204,51},
      thickness=0.5));
  connect(ctr_unmixed_simple1.hydraulicBus, unmixed.hydraulicBus) annotation (
      Line(
      points={{-107.87,65},{-22,65},{-22,11}},
      color={255,204,51},
      thickness=0.5));
  connect(bou1.ports[1], hex.port_b2)
    annotation (Line(points={{-106,-76},{-106,-68}}, color={0,127,255}));
  connect(hex.port_a2, admix.port_a1) annotation (Line(points={{-106,-28},{
          -80.8889,-28},{-80.8889,-14}}, color={0,127,255}));
  connect(hex.port_a2, unmixed.port_a1) annotation (Line(points={{-106,-28},{
          -12,-28},{-12,-14}}, color={0,127,255}));
  connect(hex.port_a2, unmixed1.port_a1) annotation (Line(points={{-106,-28},{
          60,-28},{60,-14}}, color={0,127,255}));
  connect(hex.port_b2, unmixed1.port_b2) annotation (Line(points={{-106,-68},{
          90,-68},{90,-14}}, color={0,127,255}));
  connect(hex.port_b2, unmixed.port_b2) annotation (Line(points={{-106,-68},{18,
          -68},{18,-14}}, color={0,127,255}));
  connect(hex.port_b2, admix.port_b2) annotation (Line(points={{-106,-68},{
          -47.5556,-68},{-47.5556,-14}}, color={0,127,255}));
  connect(admix.port_b1, simpleConsumer.port_a) annotation (Line(points={{
          -80.8889,36},{-80.8889,43},{-78,43},{-78,49}}, color={0,127,255}));
  connect(admix.port_a2, simpleConsumer.port_b) annotation (Line(points={{
          -47.5556,36},{-47.5556,42},{-48,42},{-48,49}}, color={0,127,255}));
  connect(unmixed.port_b1, simpleConsumer1.port_a)
    annotation (Line(points={{-12,36},{-12,49}}, color={0,127,255}));
  connect(unmixed.port_a2, simpleConsumer1.port_b)
    annotation (Line(points={{18,36},{18,49}}, color={0,127,255}));
  connect(unmixed1.port_b1, simpleConsumer2.port_a)
    annotation (Line(points={{60,36},{60,49}}, color={0,127,255}));
  connect(unmixed1.port_a2, simpleConsumer2.port_b)
    annotation (Line(points={{90,36},{90,49}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-180,-100},{100,100}})), Icon(
        coordinateSystem(extent={{-180,-100},{100,100}})),
    Documentation(revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>This example demonstrates the use of the hydraulic modules. </p>
</html>"),
    experiment(StopTime=3600));
end ERC_ExperimentalHall_CoolingCircuit;
