within AixLib.Fluid.MixingVolumes.Examples;
model HydraulicSeparator
  import AixLib;
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Component media";

  AixLib.Fluid.MixingVolumes.HydraulicSeparator hydraulicSeparator(DFlange=
        0.01,
    redeclare package Medium = Medium,
    pumpMaxVolumeFlow=0.03)
    annotation (Placement(transformation(extent={{18,-6},{38,14}})));
  AixLib.Fluid.Movers.Pump
                         pump(
    V_flow(start=0.002),
    ControlStrategy=2,
    V_flow_max=12,
    Head_max=10,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
  AixLib.Fluid.Sources.FixedBoundary
                                   boundary_p(
    nPorts=1,
    redeclare package Medium = Medium,
    p=150000)                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-94,28})));
  AixLib.Fluid.FixedResistances.Pipe
                         pipe(D=0.01, l=2,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{-30,-2},{-10,18}})));
  AixLib.Fluid.FixedResistances.Pipe
                         pipe1(D=0.01, l=10,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{30,-46},{10,-66}})));
  AixLib.Fluid.FixedResistances.StaticPipe
                               staticPipe(D=0.01, l=10,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{-50,-26},{-70,-6}})));
  AixLib.Fluid.Sensors.MassFlowRate  massFlowSensorPrim(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-54,-2},{-34,18}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
    Q_flow=1.6e3,
    T_ref=343.15,
    alpha=-0.5)
    annotation (Placement(transformation(extent={{-42,28},{-22,48}})));
  AixLib.Fluid.Movers.Pump
                         pump1(
    ControlStrategy=2,
    V_flow_max=12,
    Head_max=10,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{66,0},{86,20}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureMixedTop(redeclare package
      Medium = Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{38,0},{58,20}})));
  AixLib.Fluid.FixedResistances.StaticPipe
                               staticPipe1(D=0.01, l=10,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={92,-26})));
  AixLib.Fluid.Actuators.Valves.SimpleValve
                                 simpleValve(redeclare package Medium = Medium,
      m_flow_small=1e-4)
    annotation (Placement(transformation(extent={{70,-74},{50,-54}})));
  AixLib.Fluid.Sensors.MassFlowRate  massFlowSensor1Sec(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{2,-66},{-18,-46}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureBottom(redeclare package
      Medium = Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{10,-46},{30,-26}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
      T=273.15+20)
    annotation (Placement(transformation(extent={{-32,-96},{-12,-76}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    thermalConductor(G=1.6e3/8)
    annotation (Placement(transformation(extent={{-4,-96},{16,-76}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-70,34})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={76,36})));
  Modelica.Blocks.Sources.Step step(
    startTime=12000,
    height=0.5,
    offset=0.2)
    annotation (Placement(transformation(extent={{48,-42},{68,-22}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureMixedBottom(redeclare
      package Medium = Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-8,-26},{-28,-6}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureTop(redeclare package Medium =
        Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={2,10})));
equation
  connect(pump.port_b, massFlowSensorPrim.port_a) annotation (Line(
      points={{-60,8},{-54,8}},
      color={0,127,255}));
  connect(pipe.port_a, massFlowSensorPrim.port_b) annotation (Line(
      points={{-30,8},{-34,8}},
      color={0,127,255}));
  connect(fixedHeatFlow.port, pipe.heatport) annotation (Line(
      points={{-22,38},{-20,38},{-20,13}},
      color={191,0,0}));
  connect(temperatureMixedTop.port_b, pump1.port_a) annotation (Line(
      points={{58,10},{66,10}},
      color={0,127,255}));
  connect(pump1.port_b, staticPipe1.port_a) annotation (Line(
      points={{86,10},{92,10},{92,-16}},
      color={0,127,255}));
  connect(staticPipe1.port_b, simpleValve.port_a) annotation (Line(
      points={{92,-36},{92,-64},{70,-64}},
      color={0,127,255}));
  connect(simpleValve.port_b, pipe1.port_a) annotation (Line(
      points={{50,-64},{40,-64},{40,-56},{30,-56}},
      color={0,127,255}));
  connect(pipe1.port_b, massFlowSensor1Sec.port_a) annotation (Line(
      points={{10,-56},{2,-56}},
      color={0,127,255}));
  connect(massFlowSensor1Sec.port_b, temperatureBottom.port_a)
    annotation (Line(
      points={{-18,-56},{-28,-56},{-28,-36},{10,-36}},
      color={0,127,255}));
  connect(thermalConductor.port_a, fixedTemperature.port) annotation (
      Line(
      points={{-4,-86},{-12,-86}},
      color={191,0,0}));
  connect(thermalConductor.port_b, pipe1.heatport) annotation (Line(
      points={{16,-86},{20,-86},{20,-61}},
      color={191,0,0}));
  connect(pump1.IsNight, booleanExpression1.y) annotation (Line(
      points={{76,20.2},{76,25}},
      color={255,0,255}));
  connect(pump.IsNight, booleanExpression.y) annotation (Line(
      points={{-70,18.2},{-70,23}},
      color={255,0,255}));
  connect(step.y, simpleValve.opening) annotation (Line(
      points={{69,-32},{76,-32},{76,-56},{60,-56}},
      color={0,0,127}));
  connect(staticPipe.port_a, temperatureMixedBottom.port_b) annotation (
      Line(
      points={{-50,-16},{-28,-16}},
      color={0,127,255}));
  connect(staticPipe.port_b, pump.port_a) annotation (Line(
      points={{-70,-16},{-92,-16},{-92,8},{-80,8}},
      color={0,127,255}));
  connect(boundary_p.ports[1], pump.port_a) annotation (Line(
      points={{-94,18},{-94,10},{-80,10},{-80,8}},
      color={0,127,255}));
  connect(pipe.port_b, temperatureTop.port_a) annotation (Line(
      points={{-10,8},{-10,10},{-8,10}},
      color={0,127,255}));
  connect(temperatureTop.port_b, hydraulicSeparator.port_a_primary) annotation (
     Line(
      points={{12,10},{18,9}},
      color={0,127,255}));
  connect(temperatureMixedTop.port_a, hydraulicSeparator.port_b_secondary)
    annotation (Line(
      points={{38,10},{38,9}},
      color={0,127,255}));
  connect(hydraulicSeparator.port_b_primary, temperatureMixedBottom.port_a)
    annotation (Line(
      points={{18,-1},{18,-2},{18,-16},{-8,-16}},
      color={0,127,255}));
  connect(hydraulicSeparator.port_a_secondary, temperatureBottom.port_b)
    annotation (Line(
      points={{38,-1},{38,-2},{38,-36},{30,-36}},
      color={0,127,255}));
  annotation (Documentation(info="<html>
<p>This model shows the usage of a Hydraulic Separator within a simple heating circuit. The primary circuit consists of a tank, a pump, a boiler (represented by a pipe with prescribed heat-flux), a pipe and some sensors. The secondary circuit consists of a pump, a static pipe, a valve and a radiator (represented by a pipe with heat-transfer to the outside). Between the two circuit lies the Hydraulic Separator. The example shows that the model of the Hydraulic Separator works in consistence with ones expactation. There is mixing of the fluids between bottom and top of the Hydraulic Separator depending on the mass flowrates in the circuits. If the mass-flows are the same and no mass is exchanged between top and bottom, there is still a small amount of heat transported via conduction. </p>
</html>", revisions="<html>
<p>26.11.2014, by <i>Roozbeh Sangi</i>: implemented </p>
</html>"),    experiment(StopTime=20000));
end HydraulicSeparator;
