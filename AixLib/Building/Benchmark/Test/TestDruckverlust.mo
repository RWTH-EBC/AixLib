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
        origin={11.5,16.5})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium_Water,
    p=100000,
    T=328.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,6},{-76,26}})));
  Fluid.Movers.SpeedControlled_y fan(redeclare package Medium = Medium_Water,
      redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{-54,6},{-34,26}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-84,46},{-64,66}})));
equation
  connect(plugFlowPipe1.ports_b[1], bou1.ports[1]) annotation (Line(points={{19,16.5},
          {17.5,16.5},{17.5,18},{42,18}},       color={0,127,255}));
  connect(bou2.ports[1], fan.port_a)
    annotation (Line(points={{-76,16},{-54,16}}, color={0,127,255}));
  connect(fan.port_b, plugFlowPipe1.port_a) annotation (Line(points={{-34,16},{
          -16,16},{-16,16.5},{4,16.5}}, color={0,127,255}));
  connect(realExpression.y, fan.y)
    annotation (Line(points={{-63,56},{-44,56},{-44,28}}, color={0,0,127}));
end TestDruckverlust;
