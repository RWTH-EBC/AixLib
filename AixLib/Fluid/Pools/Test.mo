within AixLib.Fluid.Pools;
model Test
  Sources.Boundary_pT              sou(
    redeclare package Medium = Media.Water,
    p=101325,
    T=273.15 + 20,
    use_p_in=false,
    nPorts=1)
    "Pressure boundary condition"
    annotation (Placement(transformation(
          extent={{-64,-10},{-44,10}})));
  Sources.Boundary_pT              sin(
    redeclare package Medium = Media.Water,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325)
    "Pressure boundary condition"
    annotation (Placement(transformation(
          extent={{82,-8},{62,12}})));
  FixedResistances.PressureDrop              res(
    redeclare package Medium = Media.Water,
    m_flow_nominal=10,
    from_dp=true,
    dp_nominal=170000)
    "Fixed resistance"
    annotation (Placement(transformation(extent={{28,-10},{48,10}})));
Movers.BaseClasses.IdealSource prescribed_m_flow_toPool(
    redeclare package Medium = Media.Water,
    m_flow_small=0.0001,
    control_m_flow=true,
    control_dp=false) annotation (Placement(transformation(
      extent={{-8,-8},{8,8}},
      rotation=0,
      origin={-2,0})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=5,
    period=30,
    offset=10) annotation (Placement(transformation(extent={{-12,62},{8,82}})));
  Movers.FlowControlled_dp fan(
    redeclare package Medium = Media.Water,
    m_flow_nominal=10,
    addPowerToMedium=false,
    dp_nominal=170000)
    annotation (Placement(transformation(extent={{22,22},{42,42}})));
  Modelica.Blocks.Sources.Constant
                               P1(k=170000)
                        "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-62,42},{-42,62}})));
equation
  connect(res.port_b,sin. ports[1])
    annotation (Line(points={{48,0},{48,2},{62,2}},    color={0,127,255}));
  connect(pulse.y, prescribed_m_flow_toPool.m_flow_in) annotation (Line(points=
          {{9,72},{26,72},{26,40},{-6.8,40},{-6.8,6.4}}, color={0,0,127}));
  connect(P1.y, fan.dp_in) annotation (Line(points={{-41,52},{-34,52},{-34,44},
          {32,44}}, color={0,0,127}));
  connect(sou.ports[1], prescribed_m_flow_toPool.port_a) annotation (Line(
        points={{-44,0},{-30,0},{-30,-2},{-10,-2},{-10,0}}, color={0,127,255}));
  connect(prescribed_m_flow_toPool.port_b, fan.port_a)
    annotation (Line(points={{6,0},{8,0},{8,32},{22,32}}, color={0,127,255}));
  connect(fan.port_b, res.port_a) annotation (Line(points={{42,32},{42,16},{28,
          16},{28,0}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=300));
end Test;
