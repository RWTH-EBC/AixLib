within AixLib.Fluid.HeatGenerators.Examples;
model CHPSystem
  extends Modelica.Icons.Example;
  CHP cHP(redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1, redeclare package Medium =
        Media.Specialized.Water.TemperatureDependentDensity)
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
equation
  connect(source.ports[1], cHP.port_a)
    annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,127,255}));
  connect(cHP.port_b, sink.ports[1])
    annotation (Line(points={{10,0},{26,0},{40,0}}, color={0,127,255}));
end CHPSystem;
