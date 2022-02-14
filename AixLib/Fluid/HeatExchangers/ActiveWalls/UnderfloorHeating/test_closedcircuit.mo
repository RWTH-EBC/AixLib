within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model test_closedcircuit
  package MediumWater = AixLib.Media.Water;

  Modelica.Blocks.Sources.Constant const1(each k=313.15)
    annotation (Placement(transformation(extent={{-80,74},{-68,86}})));
  TABS_CCircuit tABS_CCircuit(
      redeclare package Medium = MediumWater,
    m_flow_total=0.04,
    V_Water=2)
    annotation (Placement(transformation(extent={{-24,-32},{30,6}})));
  MixingVolumes.MixingVolume              vol1(
    redeclare package Medium = MediumWater,
    allowFlowReversal=false,
    V=2,
    m_flow_nominal=0.04,
    nPorts=3)
    annotation (Placement(transformation(extent={{98,54},{122,78}})));
  Sources.Boundary_pT              bou1(
    redeclare package Medium = MediumWater,
    p=500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={74,72})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-1,
    duration=10000,
    offset=1,
    startTime=20000)
    annotation (Placement(transformation(extent={{-20,52},{-6,66}})));
equation
  connect(bou1.ports[1], vol1.ports[1]) annotation (Line(points={{74,62},{78,62},
          {78,42},{106.8,42},{106.8,54}}, color={0,127,255}));
  connect(const1.y, tABS_CCircuit.T) annotation (Line(points={{-67.4,80},{-34,
          80},{-34,5.05},{-2.4,5.05}},                           color={0,0,127}));
  connect(ramp.y, tABS_CCircuit.y) annotation (Line(points={{-5.3,59},{3,59},{3,
          5.05}},          color={0,0,127}));
  connect(vol1.ports[2], tABS_CCircuit.port_a) annotation (Line(points={{110,54},
          {110,54},{110,-36},{-24,-36},{-24,-13}}, color={0,127,255}));
  connect(vol1.ports[3], tABS_CCircuit.port_b) annotation (Line(points={{113.2,
          54},{112,54},{112,-13},{30,-13}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_closedcircuit;
