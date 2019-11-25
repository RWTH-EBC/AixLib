within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationHeating "Example of the SubstationHeating model"
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT cooPip(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Cool pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-56,-44})));
  AixLib.Fluid.Sources.Boundary_pT cooPip1(
    redeclare package Medium = Medium,
    nPorts=1,
    use_T_in=true) "Cool pipe" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={44,70})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1000,
    freqHz=1/3600,
    offset=2000,
    startTime=0)
    annotation (Placement(transformation(extent={{-4,-40},{16,-20}})));
  Modelica.Blocks.Sources.Constant const(k=288.15)
    annotation (Placement(transformation(extent={{-44,72},{-24,92}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=10,
    duration=7200,
    startTime=3600,
    offset=293.15)
    annotation (Placement(transformation(extent={{-100,-84},{-80,-64}})));
  Modelica.Blocks.Sources.Step step(
    height=10,
    offset=313.15,
    startTime=18000)
    annotation (Placement(transformation(extent={{52,-42},{72,-22}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeating
    substationHeating(
    redeclare package Medium = Medium,
    heatDemand_max=3000,
    deltaT_heatingSet(displayUnit="K") = 10,
    deltaT_heatingGridSet(displayUnit="K") = 5,
    m_flow_nominal=3)
    annotation (Placement(transformation(extent={{-14,-2},{10,20}})));
equation
  connect(ramp.y, cooPip.T_in)
    annotation (Line(points={{-79,-74},{-60,-74},{-60,-56}}, color={0,0,127}));
  connect(const.y, cooPip1.T_in)
    annotation (Line(points={{-23,82},{40,82}}, color={0,0,127}));
  connect(cooPip.ports[1], substationHeating.port_a)
    annotation (Line(points={{-56,-34},{-56,8},{-14,8}}, color={0,127,255}));
  connect(substationHeating.port_b, cooPip1.ports[1]) annotation (Line(points={
          {10,8},{18,8},{18,10},{44,10},{44,60}}, color={0,127,255}));
  connect(sine.y, substationHeating.heatDemand) annotation (Line(points={{17,
          -30},{24,-30},{24,4.2},{7.78462,4.2}}, color={0,0,127}));
  connect(substationHeating.T_supplyHeatingSet, step.y) annotation (Line(points=
         {{7.78462,-0.2},{82,-0.2},{82,-32},{73,-32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60));
end SubstationHeating;
