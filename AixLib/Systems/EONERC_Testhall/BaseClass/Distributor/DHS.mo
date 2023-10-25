within AixLib.Systems.EONERC_Testhall.BaseClass.Distributor;
model DHS

      replaceable package MediumWater =
      AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
      choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);

  AixLib.DataBase.Pumps.HydraulicModules.Throttle dhs(
    redeclare package Medium = MediumWater,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
    Kv=5,
    m_flow_nominal=1,
    pipe1(length=14),
    pipe2(length=1),
    pipe3(length=6),
    T_amb=273.15 + 10,
    T_start=323.15) "distribute heating system"
    annotation (Placement(transformation(extent={{-144,-56},{-44,44}})));
  AixLib.Fluid.Sources.Boundary_ph                FernwaermeAus(
    redeclare package Medium = MediumWater,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-264,-40},{-244,-20}})));
  AixLib.Fluid.Sources.Boundary_pT                FernwaermeEin(
    redeclare package Medium = MediumWater,
    p=115000,
    T=403.15,
    nPorts=1) "nominal mass flow 1 kg/s"
    annotation (Placement(transformation(extent={{-262,20},{-242,40}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe1(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
    length=2,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={188,26})));

  AixLib.Fluid.HeatExchangers.ConstantEffectiveness     hex(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=2.3,
    m2_flow_nominal=2.3,
    dp1_nominal=0,
    dp2_nominal=0,
    eps=0.95) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={12,2})));
  AixLib.DataBase.Pumps.HydraulicModules.Pump pump(
    redeclare package Medium = MediumWater,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    m_flow_nominal=2.3,
    redeclare
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12 per,
          riseTime=5)),
    pipe1(length=3.5),
    pipe2(length=7),
    pipe3(length=10),
    T_amb=273.15 + 10,
    T_start=353.15) "nominal mass flow 2.2 kg/s"
    annotation (Placement(transformation(extent={{68,-38},{148,42}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe14(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
    length=2,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={192,-22})));

  AixLib.Fluid.FixedResistances.GenericPipe pipe15(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
    length=12,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-194,-30})));

  Modelica.Blocks.Sources.RealExpression valve(y=0.27)
    annotation (Placement(transformation(extent={{-170,104},{-150,124}})));
  Modelica.Blocks.Sources.RealExpression nSet(y=2307)
    annotation (Placement(transformation(extent={{-22,98},{-2,118}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-22,116},{-2,136}})));
  AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus
    annotation (Placement(transformation(extent={{36,88},{74,126}}),
        iconTransformation(extent={{-112,-14},{-86,12}})));
  AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus1
    annotation (Placement(transformation(extent={{-114,60},{-76,98}}),
        iconTransformation(extent={{-112,-14},{-86,12}})));
  AixLib.Fluid.Sources.Boundary_ph bou1(
    redeclare package Medium = MediumWater,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{238,-32},{218,-12}})));
  AixLib.Fluid.Sources.Boundary_ph bou(
    redeclare package Medium = MediumWater,
    p=100000,
    nPorts=1) annotation (Placement(transformation(extent={{242,16},{222,36}})));
equation
  connect(FernwaermeEin.ports[1],dhs. port_a1)
    annotation (Line(points={{-242,30},{-194,30},{-194,24},{-144,24}},
                                                 color={0,127,255}));
  connect(dhs.port_b1,hex. port_a1) annotation (Line(points={{-44,24},{6,24},{6,
          12}},                       color={0,127,255}));
  connect(hex.port_b1,dhs. port_a2)
    annotation (Line(points={{6,-8},{6,-36},{-44,-36}},color={0,127,255}));
  connect(hex.port_b2,pump. port_a1)
    annotation (Line(points={{18,12},{18,26},{68,26}},    color={0,127,255}));
  connect(hex.port_a2,pump. port_b2)
    annotation (Line(points={{18,-8},{18,-22},{68,-22}},color={0,127,255}));
  connect(pump.port_b1,pipe1. port_a) annotation (Line(points={{148,26},{178,26}},
                                  color={0,127,255}));
  connect(pump.port_a2,pipe14. port_a) annotation (Line(points={{148,-22},{182,-22}},
                              color={0,127,255}));
  connect(FernwaermeAus.ports[1],pipe15. port_a) annotation (Line(points={{-244,
          -30},{-204,-30}},                             color={0,127,255}));
  connect(pipe15.port_b,dhs. port_b2) annotation (Line(points={{-184,-30},{-164,
          -30},{-164,-36},{-144,-36}},         color={0,127,255}));
  connect(nSet.y,registerBus. hydraulicBus.pumpBus.rpmSet) annotation (Line(
        points={{-1,108},{26,108},{26,107.095},{55.095,107.095}},color={0,0,127}));
  connect(booleanExpression.y,registerBus. hydraulicBus.pumpBus.onSet)
    annotation (Line(points={{-1,126},{30,126},{30,107.095},{55.095,107.095}},
        color={255,0,255}));
  connect(registerBus, pump.hydraulicBus) annotation (Line(
      points={{55,107},{55,105.5},{108,105.5},{108,42}},
      color={255,204,51},
      thickness=0.5));
  connect(dhs.hydraulicBus, registerBus1) annotation (Line(
      points={{-94,44},{-94,62},{-94,79},{-95,79}},
      color={255,204,51},
      thickness=0.5));
  connect(valve.y, registerBus1.hydraulicBus.valveSet) annotation (Line(points=
          {{-149,114},{-102,114},{-102,79.095},{-94.905,79.095}}, color={0,0,
          127}));
  connect(bou.ports[1], pipe1.port_b)
    annotation (Line(points={{222,26},{198,26}}, color={0,127,255}));
  connect(pipe14.port_b, bou1.ports[1]) annotation (Line(points={{202,-22},{210,
          -22},{210,-22},{218,-22}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,-100},{300,120}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-280,-100},{300,
            120}})),
    experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
end DHS;
