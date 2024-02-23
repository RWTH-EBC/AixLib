within AixLib.Fluid.Actuators.Valves.Examples;
model MixingValveForwardDirection
    extends Modelica.Icons.Example;
    package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  inner AixLib.Utilities.Sources.BaseParameters baseParameters
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  AixLib.Fluid.Sources.Boundary_pT boundary_ph(
              nPorts=1,
    redeclare package Medium = Medium,
    p=150000)
    annotation (Placement(transformation(extent={{-100,80},{-80,60}})));
  AixLib.Fluid.Sources.Boundary_pT boundary_ph1(nPorts=1, redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{84,-10},{64,10}})));
  AixLib.Fluid.Sources.Boundary_pT boundary_ph2(         nPorts=1,
    redeclare package Medium = Medium,
    p=150000)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-80}})));
  AixLib.Obsolete.Year2021.Fluid.Actuators.Valves.MixingValve mixingValveFiltered(
    filteredOpening=true,
    riseTime=100,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureSensor1(redeclare package Medium =
               Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-54,60},{-34,80}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureSensor2(redeclare package Medium =
               Medium,
    tau=1,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-54,-80},{-34,-60}})));
  AixLib.Fluid.Sensors.MassFlowRate  massFlowSensor1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  AixLib.Fluid.Sensors.MassFlowRate  massFlowSensor2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Blocks.Sources.Step step(startTime=100, height=0.7)
    annotation (Placement(transformation(extent={{38,-54},{18,-34}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                        temperatureSensorMixed(redeclare
      package                                                                    Medium =
                       Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
  AixLib.Fluid.Sensors.MassFlowRate  massFlowSensorMixed(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{34,-10},{54,10}})));
equation
  connect(temperatureSensor2.port_b, massFlowSensor2.port_a) annotation (Line(
      points={{-34,-70},{-20,-70}},
      color={0,127,255}));
  connect(temperatureSensor1.port_b, massFlowSensor1.port_a) annotation (Line(
      points={{-34,70},{-20,70}},
      color={0,127,255}));
  connect(massFlowSensor1.port_b, mixingValveFiltered.port_3) annotation (Line(
      points={{0,70},{0,38},{-24,38},{-24,10}},
      color={0,127,255}));
  connect(massFlowSensor2.port_b, mixingValveFiltered.port_1) annotation (Line(
      points={{0,-70},{0,-54},{-68,-54},{-68,0},{-34,0}},
      color={0,127,255}));
  connect(step.y, mixingValveFiltered.opening) annotation (Line(
      points={{17,-44},{-44,-44},{-44,-7},{-32,-7}},
      color={0,0,127}));
  connect(mixingValveFiltered.port_2, temperatureSensorMixed.port_a)
    annotation (Line(
      points={{-14,0},{-2,0}},
      color={0,127,255}));
  connect(temperatureSensorMixed.port_b, massFlowSensorMixed.port_a)
    annotation (Line(
      points={{18,0},{34,0}},
      color={0,127,255}));
  connect(temperatureSensor1.port_a, boundary_ph.ports[1]) annotation (Line(
      points={{-54,70},{-80,70}},
      color={0,127,255}));
  connect(massFlowSensorMixed.port_b, boundary_ph1.ports[1]) annotation (Line(
      points={{54,0},{64,0}},
      color={0,127,255}));
  connect(temperatureSensor2.port_a, boundary_ph2.ports[1]) annotation (Line(
      points={{-54,-70},{-80,-70}},
      color={0,127,255}));
  annotation (Documentation(info="<html><p>
  This model shows the usage of a MixingValve in its design-direction.
  The results are consistent with ones expectation of the function of a
  mixing valve. A step on the opening of the valve is applied after
  some time, which changes the the ratio between the two inflowing
  streams.
</p>
</html>",
        revisions="<html><p>
  26.11.2014, by <i>Roozbeh Sangi</i>: implemented
</p>
</html>"),    experiment(StopTime=1000));
end MixingValveForwardDirection;
