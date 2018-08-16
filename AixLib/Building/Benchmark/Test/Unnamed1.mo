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
    nPorts=1,
    redeclare package Medium = Medium_Air)
              annotation (Placement(transformation(extent={{-46,-18},{-26,2}})));
  Fluid.Sources.Boundary_pT bou(
    use_p_in=false,
    use_T_in=false,
    nPorts=2,
    redeclare package Medium = Medium_Air)                    annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={74,-10})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=10)
    annotation (Placement(transformation(extent={{-78,-8},{-58,12}})));
  Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
    redeclare package Medium = Medium_Air,
    from_dp=true,
    zeta=2,
    diameter=10,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{18,6},{38,26}})));
  Fluid.FixedResistances.HydraulicResistance hydraulicResistance1(
    redeclare package Medium = Medium_Air,
    from_dp=true,
    zeta=1,
    diameter=10,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{18,-22},{38,-2}})));
  Fluid.MixingVolumes.MixingVolume vol(
    nPorts=3,
    redeclare package Medium = Medium_Air,
    V=1,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{-12,14},{8,34}})));
equation
  connect(realExpression3.y, boundary.m_flow_in) annotation (Line(points={{-57,2},
          {-32,2},{-32,0},{-46,0}},            color={0,0,127}));
  connect(boundary.ports[1], vol.ports[1]) annotation (Line(points={{-26,-8},{
          -16,-8},{-16,14},{-4.66667,14}}, color={0,127,255}));
  connect(vol.ports[2], hydraulicResistance.port_a) annotation (Line(points={{
          -2,14},{8,14},{8,16},{18,16}}, color={0,127,255}));
  connect(vol.ports[3], hydraulicResistance1.port_a) annotation (Line(points={{
          0.66667,14},{8,14},{8,-12},{18,-12}}, color={0,127,255}));
  connect(hydraulicResistance.port_b, bou.ports[1]) annotation (Line(points={{
          38,16},{52,16},{52,-8},{64,-8}}, color={0,127,255}));
  connect(hydraulicResistance1.port_b, bou.ports[2])
    annotation (Line(points={{38,-12},{64,-12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Unnamed1;
