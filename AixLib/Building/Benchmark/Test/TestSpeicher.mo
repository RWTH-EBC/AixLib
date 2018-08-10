within AixLib.Building.Benchmark.Test;
model TestSpeicher
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-110,-22},{-90,-2}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=3.91)
    annotation (Placement(transformation(extent={{-136,20},{-116,40}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium_Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
  Fluid.Storage.BufferStorage bufferStorage(
    useHeatingRod=false,
    redeclare package Medium = Medium_Water,
    redeclare package MediumHC1 = Medium_Water,
    redeclare package MediumHC2 = Medium_Water,
    alphaHC1=600,
    useHeatingCoil1=true,
    useHeatingCoil2=false,
    TStart=278.15,
    data=DataBase.Storage.Benchmark_12000l(),
    upToDownHC1=false,
    TStartWall=278.15,
    TStartIns=278.15)
    annotation (Placement(transformation(extent={{-18,-22},{22,28}})));
  Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Medium_Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-22,-60},{-2,-40}})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium_Water,
    p=100000,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-38,46},{-18,66}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=6.31)
    annotation (Placement(transformation(extent={{-84,-52},{-64,-32}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 18)
    annotation (Placement(transformation(extent={{-88,-70},{-68,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 5)
    annotation (Placement(transformation(extent={{-136,0},{-116,20}})));
  Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    redeclare package Medium = Medium_Water,
    m_flow_nominal=3.81,
    V=0.01,
    T_start=278.15)
    annotation (Placement(transformation(extent={{-60,-12},{-40,8}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    nPorts=2,
    redeclare package Medium = Medium_Water,
    V=0.01,
    m_flow_nominal=7.82,
    T_start=283.15)
    annotation (Placement(transformation(extent={{-10,48},{10,68}})));
equation
  connect(boundary1.ports[1], bufferStorage.fluidportBottom2) annotation (Line(
        points={{-2,-50},{7.75,-50},{7.75,-22.25}}, color={0,127,255}));
  connect(realExpression.y, boundary.m_flow_in) annotation (Line(points={{-115,
          30},{-100,30},{-100,26},{-86,26}}, color={0,0,127}));
  connect(realExpression3.y, boundary.T_in) annotation (Line(points={{-115,10},
          {-102,10},{-102,22},{-88,22}}, color={0,0,127}));
  connect(realExpression1.y, boundary1.m_flow_in)
    annotation (Line(points={{-63,-42},{-22,-42}}, color={0,0,127}));
  connect(realExpression2.y, boundary1.T_in) annotation (Line(points={{-67,-60},
          {-46,-60},{-46,-46},{-24,-46}}, color={0,0,127}));
  connect(bou1.ports[1], vol.ports[1])
    annotation (Line(points={{-90,-12},{-52,-12}}, color={0,127,255}));
  connect(bou2.ports[1], vol1.ports[1]) annotation (Line(points={{-18,56},{-10,
          56},{-10,48},{-2,48}}, color={0,127,255}));
  connect(vol1.ports[2], bufferStorage.fluidportTop2) annotation (Line(points={
          {2,48},{4,48},{4,28.25},{8.25,28.25}}, color={0,127,255}));
  connect(boundary.ports[1], bufferStorage.portHC1In) annotation (Line(points={
          {-66,18},{-42,18},{-42,17.25},{-18.5,17.25}}, color={0,127,255}));
  connect(vol.ports[2], bufferStorage.portHC1Out) annotation (Line(points={{-48,
          -12},{-34,-12},{-34,9.5},{-18.25,9.5}}, color={0,127,255}));
end TestSpeicher;
