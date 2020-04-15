within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationCooling
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT    coo(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1)      "Cool pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,-16})));
  AixLib.Fluid.Sources.Boundary_pT    coo1(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1)      "Cool pipe" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={82,24})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/3600,
    startTime=0,
    amplitude=1000,
    offset=2000)
    annotation (Placement(transformation(extent={{-50,66},{-30,86}})));
  Modelica.Blocks.Sources.Constant const(k=288.15)
    annotation (Placement(transformation(extent={{44,46},{64,66}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=7200,
    startTime=3600,
    height=5,
    offset=288.15)
    annotation (Placement(transformation(extent={{-96,-76},{-76,-56}})));
  Modelica.Blocks.Sources.Step step(
    startTime=18000,
    height=-2,
    offset=283.15)
    annotation (Placement(transformation(extent={{-50,34},{-30,54}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationCooling
    substationCooling(
    coolingDemand_max=-3000,
    deltaT_coolingSet(displayUnit="K") = 6,
    deltaT_coolingGridSet(displayUnit="K") = 4,
    m_flow_nominal=5,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{6,-10},{30,12}})));
equation
  connect(ramp.y, coo.T_in)
    annotation (Line(points={{-75,-66},{-72,-66},{-72,-28}}, color={0,0,127}));
  connect(coo.ports[1], senTem.port_a) annotation (Line(points={{-68,-6},{-68,0},
          {-48,0}},  color={0,127,255}));
  connect(senTem.port_b,substationCooling. port_a) annotation (Line(points={{-28,0},
          {5.8,0}},                        color={0,127,255}));
  connect(substationCooling.port_b, senTem1.port_a) annotation (Line(points={{30,0},{
          40,0}},                     color={0,127,255}));
  connect(coo1.ports[1], senTem1.port_b)
    annotation (Line(points={{82,14},{82,0},{60,0}},   color={0,127,255}));
  connect(sine.y, substationCooling.coolingDemand) annotation (Line(points={{-29,76},
          {0,76},{0,8},{5.4,8}},               color={0,0,127}));
  connect(step.y, substationCooling.T_supplyCoolingSet) annotation (Line(points={{-29,44},
          {-20,44},{-20,3.6},{5.4,3.6}},        color={0,0,127}));
  connect(const.y, coo1.T_in)
    annotation (Line(points={{65,56},{78,56},{78,36}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60));
end SubstationCooling;
