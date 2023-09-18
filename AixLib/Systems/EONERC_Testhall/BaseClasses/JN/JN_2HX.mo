within AixLib.Systems.EONERC_Testhall.BaseClasses.JN;
model JN_2HX
  AixLib.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = AixLib.Media.Air,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-172,94},{-152,114}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=3,
    V=19,
    nPorts=3)
    annotation (Placement(transformation(extent={{-124,-92},{-104,-72}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=3,
    V=19,
    nPorts=3)
    annotation (Placement(transformation(extent={{128,-100},{148,-80}})));
  AixLib.Systems.ModularAHU.RegisterModule registerModule1to6(
    redeclare package Medium1 = AixLib.Media.Air,
    redeclare package Medium2 = AixLib.Media.Water,
    hydraulicModuleIcon="Throttle",
    m1_flow_nominal=3.7,
    m2_flow_nominal=2.3,
    T_amb=288.15,
    redeclare AixLib.Systems.HydraulicModules.Throttle hydraulicModule(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
      Kv=4,
      pipe1(length=3.5),
      pipe2(length=8),
      pipe3(length=11.5))) "ThrotValve left "
    annotation (Placement(transformation(extent={{-86,-40},{-6,60}})));
  AixLib.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = AixLib.Media.Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={282,-122})));
  AixLib.Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = AixLib.Media.Water,
    p=115000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-272,-126},{-252,-106}})));
  AixLib.Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = AixLib.Media.Air,
    p=80000,
    nPorts=1) annotation (Placement(transformation(extent={{36,94},{16,114}})));
  AixLib.Fluid.FixedResistances.GenericPipe genericPipe(
    redeclare package Medium = AixLib.Media.Water,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    length=5.2,
    m_flow_nominal=2.3)
    annotation (Placement(transformation(extent={{-240,-126},{-220,-106}})));
  AixLib.Fluid.FixedResistances.GenericPipe genericPipe1(
    redeclare package Medium = AixLib.Media.Water,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    length=5.2,
    m_flow_nominal=2.3)
    annotation (Placement(transformation(extent={{248,-132},{268,-112}})));
  AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus
    annotation (Placement(transformation(extent={{-126,-2},{-108,20}}),
        iconTransformation(extent={{-112,-14},{-86,12}})));
  AixLib.Systems.ModularAHU.RegisterModule registerModule7to10(
    redeclare package Medium1 = AixLib.Media.Air,
    redeclare package Medium2 = AixLib.Media.Water,
    hydraulicModuleIcon="Throttle",
    m1_flow_nominal=3.7,
    m2_flow_nominal=2.3,
    T_amb=288.15,
    redeclare AixLib.Systems.HydraulicModules.Throttle hydraulicModule(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
      Kv=2.5,
      pipe1(length=3.5),
      pipe2(length=6),
      pipe3(length=8.5))) "ThrotValve right"
    annotation (Placement(transformation(extent={{102,-30},{182,70}})));
  AixLib.Fluid.Sources.Boundary_pT bou4(
    redeclare package Medium = AixLib.Media.Air,
    p=100000,
    nPorts=1) annotation (Placement(transformation(extent={{48,94},{68,114}})));
  AixLib.Fluid.Sources.Boundary_pT bou5(
    redeclare package Medium = AixLib.Media.Air,
    p=80000,
    nPorts=1)
    annotation (Placement(transformation(extent={{254,94},{234,114}})));
  AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus1
    annotation (Placement(transformation(extent={{60,4},{80,26}}),
        iconTransformation(extent={{-112,-14},{-86,12}})));

  AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
    pumpInterface_SpeedControlledNrpm(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=2.3,
    pump(redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))
    annotation (Placement(transformation(extent={{-166,-126},{-146,-106}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-204,-76},{-184,-56}})));
  AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus
                           pumpBus annotation (Placement(transformation(
          extent={{-182,-86},{-142,-46}}),
                                       iconTransformation(extent={{-20,80},{20,120}})));
  AixLib.Fluid.Actuators.Valves.ThreeWayLinear val_in(
    redeclare package Medium = MediumWater,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=15,
    m_flow_nominal=2.3) "SwitchValveSup"
    annotation (Placement(transformation(extent={{-206,-126},{-186,-106}})));
  AixLib.Fluid.Sources.Boundary_pT dummy_fernkaelte_ein(
    redeclare package Medium = MediumWater,
    T=281.15,
    p=115000,
    nPorts=1) "nominal mass flow 1 kg/s"
    annotation (Placement(transformation(extent={{-232,-170},{-212,-150}})));
  AixLib.Fluid.Actuators.Valves.ThreeWayLinear val_in1(
    redeclare package Medium = MediumWater,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=15,
    m_flow_nominal=2.3) "SwitchValveRet"
    annotation (Placement(transformation(extent={{212,-132},{232,-112}})));
  AixLib.Fluid.Sources.Boundary_ph dummy_fernkaelte_ais(
    redeclare package Medium = MediumWater,
    nPorts=1,
    p=100000)
    annotation (Placement(transformation(extent={{180,-166},{200,-146}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
                  "1-PumpSpeed, 9-PumpVolFlow, 10-ValveSet"
    annotation (Placement(transformation(extent={{-276,-4},{-240,32}})));
equation
  connect(vol.ports[1], registerModule1to6.port_a2) annotation (Line(points={{
          -115.333,-92},{-100,-92},{-100,-9.23077},{-86,-9.23077}}, color={0,
          127,255}));
  connect(vol1.ports[1], registerModule1to6.port_b2) annotation (Line(points={{136.667,
          -100},{20,-100},{20,-9.23077},{-6,-9.23077}},         color={0,127,
          255}));
  connect(registerModule1to6.port_a1, bou.ports[1]) annotation (Line(points={{-86,
          36.9231},{-86,38},{-128,38},{-128,104},{-152,104}},     color={0,127,
          255}));
  connect(registerModule1to6.port_b1, bou3.ports[1]) annotation (Line(points={{-6,
          36.9231},{6,36.9231},{6,104},{16,104}},    color={0,127,255}));
  connect(bou2.ports[1], genericPipe.port_a) annotation (Line(points={{-252,
          -116},{-240,-116}},                         color={0,127,255}));
  connect(genericPipe1.port_b, bou1.ports[1])
    annotation (Line(points={{268,-122},{272,-122}}, color={0,127,255}));
  connect(registerBus, registerModule1to6.registerBus) annotation (Line(
      points={{-117,9},{-104.5,9},{-104.5,13.4615},{-85.6,13.4615}},
      color={255,204,51},
      thickness=0.5));
  connect(bou4.ports[1], registerModule7to10.port_a1) annotation (Line(points={{68,104},
          {80,104},{80,46.9231},{102,46.9231}},          color={0,127,255}));
  connect(registerModule7to10.port_b1, bou5.ports[1]) annotation (Line(points={{182,
          46.9231},{182,46},{214,46},{214,104},{234,104}},      color={0,127,
          255}));
  connect(registerModule7to10.port_a2, vol.ports[2]) annotation (Line(points={{102,
          0.769231},{80,0.769231},{80,-92},{-114,-92}},         color={0,127,
          255}));
  connect(registerModule7to10.port_b2, vol1.ports[2]) annotation (Line(points={{182,
          0.769231},{198,0.769231},{198,-100},{138,-100}},          color={0,
          127,255}));
  connect(pumpInterface_SpeedControlledNrpm.port_b, vol.ports[3]) annotation (
      Line(points={{-146,-116},{-114,-116},{-114,-92},{-112.667,-92}}, color={0,
          127,255}));
  connect(booleanExpression.y, pumpBus.onSet) annotation (Line(points={{-183,
          -66},{-174,-66},{-174,-65.9},{-161.9,-65.9}}, color={255,0,255}));
  connect(pumpBus, pumpInterface_SpeedControlledNrpm.pumpBus) annotation (Line(
      points={{-162,-66},{-160,-66},{-160,-106},{-156,-106}},
      color={255,204,51},
      thickness=0.5));
  connect(dummy_fernkaelte_ein.ports[1], val_in.port_3) annotation (Line(points=
         {{-212,-160},{-196,-160},{-196,-126}}, color={0,127,255}));
  connect(genericPipe.port_b, val_in.port_1)
    annotation (Line(points={{-220,-116},{-206,-116}}, color={0,127,255}));
  connect(val_in.port_2, pumpInterface_SpeedControlledNrpm.port_a)
    annotation (Line(points={{-186,-116},{-166,-116}}, color={0,127,255}));
  connect(vol1.ports[3], val_in1.port_1) annotation (Line(points={{139.333,-100},
          {174,-100},{174,-122},{212,-122}}, color={0,127,255}));
  connect(val_in1.port_2, genericPipe1.port_a)
    annotation (Line(points={{232,-122},{248,-122}}, color={0,127,255}));
  connect(dummy_fernkaelte_ais.ports[1], val_in1.port_3) annotation (Line(
        points={{200,-156},{222,-156},{222,-132}}, color={0,127,255}));
  connect(registerBus1, registerModule7to10.registerBus) annotation (Line(
      points={{70,15},{86,15},{86,23.4615},{102.4,23.4615}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,
            -180},{320,180}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-280,-180},{320,180}})),
    experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
end JN_2HX;
