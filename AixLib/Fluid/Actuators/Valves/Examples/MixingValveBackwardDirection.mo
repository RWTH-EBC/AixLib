within AixLib.Fluid.Actuators.Valves.Examples;
model MixingValveBackwardDirection
   extends Modelica.Icons.Example;
   package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  inner AixLib.Utilities.Sources.BaseParameters baseParameters
    annotation (Placement(transformation(extent={{76,58},{96,78}})));
  AixLib.Fluid.Sources.Boundary_pT boundary_ph(
    redeclare package Medium = Medium,
    p=150000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
  AixLib.Fluid.Sources.Boundary_pT boundary_ph1(nPorts=1, redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{90,20},{70,40}})));
  AixLib.Fluid.Sources.Boundary_pT boundary_ph2(nPorts=1, redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{92,-38},{72,-18}})));
  AixLib.Obsolete.Year2021.Fluid.Actuators.Valves.MixingValve mixingValveFiltered(
    filteredOpening=true,
    riseTime=100,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-6,-10},{-26,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureSensorMixed(redeclare
      package                                                                    Medium =
                       Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
  AixLib.Fluid.Sensors.MassFlowRate  massFlowSensorMixed(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureSensor1(redeclare package Medium =
               Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-8,20},{12,40}})));
  AixLib.Fluid.Sensors.MassFlowRate  massFlowSensor1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureSensor2(redeclare package Medium =
               Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{4,-38},{24,-18}})));
  AixLib.Fluid.Sensors.MassFlowRate  massFlowSensor2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{40,-38},{60,-18}})));
  Modelica.Blocks.Sources.Step step(startTime=100, height=0.7)
    annotation (Placement(transformation(extent={{42,-6},{22,14}})));
equation
  connect(temperatureSensorMixed.port_b, massFlowSensorMixed.port_a)
    annotation (Line(
      points={{-56,0},{-52,0}},
      color={0,127,255}));
  connect(massFlowSensorMixed.port_b, mixingValveFiltered.port_2) annotation (
      Line(
      points={{-32,0},{-26,0}},
      color={0,127,255}));
  connect(temperatureSensor1.port_b, massFlowSensor1.port_a) annotation (Line(
      points={{12,30},{40,30}},
      color={0,127,255}));
  connect(temperatureSensor2.port_b, massFlowSensor2.port_a) annotation (Line(
      points={{24,-28},{40,-28}},
      color={0,127,255}));
  connect(mixingValveFiltered.port_3, temperatureSensor1.port_a) annotation (
      Line(
      points={{-16,10},{-16,30},{-8,30}},
      color={0,127,255}));
  connect(mixingValveFiltered.port_1, temperatureSensor2.port_a) annotation (
      Line(
      points={{-6,0},{0,0},{0,-28},{4,-28}},
      color={0,127,255}));
  connect(mixingValveFiltered.opening, step.y) annotation (Line(
      points={{-8,-7},{4,-7},{4,4},{21,4}},
      color={0,0,127}));
  connect(massFlowSensor1.port_b, boundary_ph1.ports[1]) annotation (Line(
      points={{60,30},{70,30}},
      color={0,127,255}));
  connect(massFlowSensor2.port_b, boundary_ph2.ports[1]) annotation (Line(
      points={{60,-28},{72,-28}},
      color={0,127,255}));
  connect(temperatureSensorMixed.port_a, boundary_ph.ports[1]) annotation (Line(
      points={{-76,0},{-86,0}},
      color={0,127,255}));
  annotation (Documentation(info="<html><p>
  This model shows the usage of a MixingValve against its
  design-direction. The results show that it is possible to use the
  MixingValve against its design-direction. The valve will then split
  the incoming flow into two fractions according to the opening of the
  valve.
</p>
<p>
  26.11.2014, by <i>Roozbeh Sangi</i>: implemented
</p>
</html>"),    experiment(StopTime=1000));
end MixingValveBackwardDirection;
