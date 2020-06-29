within AixLib.Systems.Benchmark_old.Examples;
model GoethermalProbe "Test of geothermal probe"
  extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);

  Fluid.Sources.Boundary_pT          boundary6(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,0})));
  Fluid.Sources.MassFlowSource_T     boundary4(
    redeclare package Medium = Medium,
    m_flow=2,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,0})));
  Model.Generation.GeothermalProbe geothermalProbe(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    nParallel=5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.Sensors.TemperatureTwoPort senT_b(
    T_start=293.15,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=298.15,
    final m_flow_nominal=10,
    final allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={40,0})));
equation
  connect(boundary4.ports[1], geothermalProbe.port_a)
    annotation (Line(points={{-70,0},{-10,0}}, color={0,127,255}));
  connect(geothermalProbe.port_b, senT_b.port_a)
    annotation (Line(points={{10,0},{34,0}}, color={0,127,255}));
  connect(senT_b.port_b, boundary6.ports[1])
    annotation (Line(points={{46,0},{70,0}}, color={0,127,255}));
  annotation (experiment(StopTime=7200));
end GoethermalProbe;
