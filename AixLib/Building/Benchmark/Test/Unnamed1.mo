within AixLib.Building.Benchmark.Test;
model Unnamed1
    replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
      replaceable package Medium_Air = AixLib.Media.Air
    "Medium in the component";
  Fluid.Sources.MassFlowSource_T boundary(
    use_m_flow_in=true,
    use_X_in=false,
    use_T_in=false,
    redeclare package Medium = Medium_Water,
    nPorts=1) annotation (Placement(transformation(extent={{-46,-108},{-26,-88}})));
  Fluid.Sources.Boundary_pT bou(
    use_p_in=false,
    use_T_in=false,
    redeclare package Medium = Medium_Water,
    nPorts=1)                                                 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,-98})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = Medium_Water,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    dp1_nominal=1,
    dp2_nominal=1,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    redeclare package Medium2 = Medium_Water)
    annotation (Placement(transformation(extent={{14,-102},{-6,-82}})));
  Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = Medium_Water,
    nPorts=2,
    p=100000) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={36,-66})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=90,
        origin={18,-46})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=1)
    annotation (Placement(transformation(extent={{-102,-96},{-82,-76}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=1)
    annotation (Placement(transformation(extent={{48,-90},{68,-70}})));
equation
  connect(bou3.ports[1],hex. port_a1) annotation (Line(points={{36.8,-70},{18,
          -70},{18,-86},{14,-86}},
                             color={0,127,255}));
  connect(realExpression3.y, boundary.m_flow_in) annotation (Line(points={{-81,
          -86},{-56,-86},{-56,-90},{-46,-90}}, color={0,0,127}));
  connect(realExpression4.y, fan4.y) annotation (Line(points={{69,-80},{82,-80},
          {82,-46},{27.6,-46}}, color={0,0,127}));
  connect(fan4.port_b, bou3.ports[2]) annotation (Line(points={{18,-54},{26,-54},
          {26,-70},{35.2,-70}}, color={0,127,255}));
  connect(hex.port_b1, fan4.port_a) annotation (Line(points={{-6,-86},{-18,-86},
          {-18,-24},{18,-24},{18,-38}}, color={0,127,255}));
  connect(hex.port_b2, bou.ports[1])
    annotation (Line(points={{14,-98},{40,-98}}, color={0,127,255}));
  connect(boundary.ports[1], hex.port_a2)
    annotation (Line(points={{-26,-98},{-6,-98}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Unnamed1;
