within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationCooling "Example of the SubstationCooling model"
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
    use_T_in=true,
    nPorts=1) "Cool pipe" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={44,70})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/3600,
    startTime=0,
    amplitude=1000,
    offset=2000)
    annotation (Placement(transformation(extent={{-98,36},{-78,56}})));
  Modelica.Blocks.Sources.Constant const(k=288.15)
    annotation (Placement(transformation(extent={{-44,72},{-24,92}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=7200,
    startTime=3600,
    height=5,
    offset=288.15)
    annotation (Placement(transformation(extent={{-100,-84},{-80,-64}})));
  Modelica.Blocks.Sources.Step step(
    startTime=18000,
    height=-2,
    offset=283.15)
    annotation (Placement(transformation(extent={{-98,4},{-78,24}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-56,-18},{-36,2}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{22,2},{42,22}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationCooling
    substationCooling(
    coolingDemand_max=-3000,
    deltaT_coolingSet(displayUnit="K") = 6,
    deltaT_coolingGridSet(displayUnit="K") = 4,
    m_flow_nominal=5,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-16,-10},{8,12}})));
equation
  connect(ramp.y, cooPip.T_in)
    annotation (Line(points={{-79,-74},{-60,-74},{-60,-56}}, color={0,0,127}));
  connect(cooPip.ports[1], senTem.port_a) annotation (Line(points={{-56,-34},{-56,
          -34},{-56,-8}}, color={0,127,255}));
  connect(senTem.port_b,substationCooling. port_a) annotation (Line(points={{-36,-8},
          {-28,-8},{-28,0},{-16.2,0}},     color={0,127,255}));
  connect(substationCooling.port_b, senTem1.port_a) annotation (Line(points={{8,
          0},{16,0},{16,12},{22,12}}, color={0,127,255}));
  connect(const.y, cooPip1.T_in)
    annotation (Line(points={{-23,82},{40,82}}, color={0,0,127}));
  connect(cooPip1.ports[1], senTem1.port_b)
    annotation (Line(points={{44,60},{44,12},{42,12}}, color={0,127,255}));
  connect(sine.y, substationCooling.coolingDemand) annotation (Line(points={{
          -77,46},{-40,46},{-40,8},{-16.6,8}}, color={0,0,127}));
  connect(step.y, substationCooling.T_supplyCoolingSet) annotation (Line(points=
         {{-77,14},{-52,14},{-52,3},{-16.6,3}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60));
end SubstationCooling;
