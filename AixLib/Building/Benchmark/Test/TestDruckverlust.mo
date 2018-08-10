within AixLib.Building.Benchmark.Test;
model TestDruckverlust
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{62,8},{42,28}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=7.774)
    annotation (Placement(transformation(extent={{-136,20},{-116,40}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium_Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 55)
    annotation (Placement(transformation(extent={{-136,0},{-116,20}})));
  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe1(
                                                   redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    nPorts=1,
    length=25,
    dIns=1,
    kIns=1,
    thickness=1,
    v_nominal=1.543,
    m_flow_nominal=7.819)
    annotation (Placement(transformation(extent={{7.5,-7.5},{-7.5,7.5}},
        rotation=180,
        origin={-12.5,18.5})));
equation
  connect(realExpression.y, boundary.m_flow_in) annotation (Line(points={{-115,
          30},{-100,30},{-100,26},{-86,26}}, color={0,0,127}));
  connect(realExpression3.y, boundary.T_in) annotation (Line(points={{-115,10},
          {-102,10},{-102,22},{-88,22}}, color={0,0,127}));
  connect(boundary.ports[1], plugFlowPipe1.port_a) annotation (Line(points={{
          -66,18},{-44,18},{-44,18.5},{-20,18.5}}, color={0,127,255}));
  connect(plugFlowPipe1.ports_b[1], bou1.ports[1]) annotation (Line(points={{-5,
          18.5},{17.5,18.5},{17.5,18},{42,18}}, color={0,127,255}));
end TestDruckverlust;
