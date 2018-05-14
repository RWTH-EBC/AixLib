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

  Admix admix(
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe3(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe4(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe5(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe6(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per),
    Tinit=293.15) annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={-67,11})));

  Unmixed unmixed(
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe3(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per),
    Tinit=293.15) annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={3,11})));

  Unmixed unmixed1(
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe3(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per),
    Tinit=293.15) annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={75,11})));

  SimpleConsumer simpleConsumer(
    kA=2000,
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    Tinit=293.15,
    Tambient=293.15)
    annotation (Placement(transformation(extent={{-82,34},{-52,64}})));
  SimpleConsumer simpleConsumer1(
    kA=20000,
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    Tinit=293.15,
    Tambient=293.15)
    annotation (Placement(transformation(extent={{-12,34},{18,64}})));
  SimpleConsumer simpleConsumer2(
    kA=10000,
    pipe1(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    pipe2(parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5()),
    Tinit=293.15)
    annotation (Placement(transformation(extent={{60,34},{90,64}})));
  Controls.HydraulicModules.Ctr_admix ctr_admix(
    Td=0,
    Ti=180,
    k=0.12) annotation (Placement(transformation(extent={{-134,8},{-106,36}})));
  Controls.HydraulicModules.Ctr_unmixed_simple ctr_unmixed_simple
    annotation (Placement(transformation(extent={{-134,78},{-108,104}})));
  Controls.HydraulicModules.Ctr_unmixed_simple ctr_unmixed_simple1
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
  connect(simpleConsumer.port_a, admix.port_fwrdOut)
    annotation (Line(points={{-82,49},{-82,36}}, color={0,127,255}));
  connect(simpleConsumer.port_b, admix.port_rtrnIn)
    annotation (Line(points={{-52,49},{-52,36}}, color={0,127,255}));
  connect(simpleConsumer1.port_a, unmixed.port_fwrdOut)
    annotation (Line(points={{-12,49},{-12,36}}, color={0,127,255}));
  connect(simpleConsumer1.port_b, unmixed.port_rtrnIn)
    annotation (Line(points={{18,49},{18,36}}, color={0,127,255}));
  connect(simpleConsumer2.port_a, unmixed1.port_fwrdOut)
    annotation (Line(points={{60,49},{60,36}}, color={0,127,255}));
  connect(simpleConsumer2.port_b, unmixed1.port_rtrnIn)
    annotation (Line(points={{90,49},{90,36}}, color={0,127,255}));
  connect(hex.port_a2, unmixed1.port_fwrdIn) annotation (Line(points={{-106,-28},
          {60,-28},{60,-14}}, color={0,127,255}));
  connect(hex.port_b2, unmixed1.port_rtrnOut) annotation (Line(points={{-106,
          -68},{90,-68},{90,-14}}, color={0,127,255}));
  connect(admix.port_fwrdIn, unmixed1.port_fwrdIn) annotation (Line(points={{
          -82,-14},{-82,-28},{60,-28},{60,-14}}, color={0,127,255}));
  connect(unmixed.port_fwrdIn, unmixed1.port_fwrdIn) annotation (Line(points={{
          -12,-14},{-12,-28},{60,-28},{60,-14}}, color={0,127,255}));
  connect(admix.port_rtrnOut, unmixed1.port_rtrnOut) annotation (Line(points={{
          -52,-14},{-52,-68},{90,-68},{90,-14}}, color={0,127,255}));
  connect(unmixed.port_rtrnOut, unmixed1.port_rtrnOut) annotation (Line(points=
          {{18,-14},{18,-68},{90,-68},{90,-14}}, color={0,127,255}));
  connect(admix.hydraulicBus, ctr_admix.hydraulicBus) annotation (Line(
      points={{-92,11},{-104,11},{-104,20.46},{-106.98,20.46}},
      color={255,204,51},
      thickness=0.5));
  connect(ctr_unmixed_simple.hydraulicBus, unmixed1.hydraulicBus) annotation (
      Line(
      points={{-107.87,91},{50,91},{50,1}},
      color={255,204,51},
      thickness=0.5));
  connect(ctr_unmixed_simple1.hydraulicBus, unmixed.hydraulicBus) annotation (
      Line(
      points={{-107.87,65},{-22,65},{-22,1}},
      color={255,204,51},
      thickness=0.5));
  connect(bou1.ports[1], hex.port_b2)
    annotation (Line(points={{-106,-76},{-106,-68}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-180,-100},{100,100}})), Icon(
        coordinateSystem(extent={{-180,-100},{100,100}})));
end ERC_ExperimentalHall_CoolingCircuit;
