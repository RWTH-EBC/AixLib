within AixLib.HVAC.Valves;
package Examples
  extends Modelica.Icons.ExamplesPackage;
  model MixingValveForwardDirection
    import AixLib;
    inner AixLib.HVAC.BaseParameters baseParameters
      annotation (Placement(transformation(extent={{80,80},{100,100}})));
    AixLib.HVAC.Sources.Boundary_ph boundary_ph(
      use_h_in=false,
      h=25125,
      p=150000)
      annotation (Placement(transformation(extent={{-100,80},{-80,60}})));
    AixLib.HVAC.Sources.Boundary_ph boundary_ph1
      annotation (Placement(transformation(extent={{84,-10},{64,10}})));
    AixLib.HVAC.Sources.Boundary_ph boundary_ph2(p=150000, h=40000)
      annotation (Placement(transformation(extent={{-100,-60},{-80,-80}})));
    AixLib.HVAC.Valves.MixingValve          mixingValveFiltered(
        filteredOpening=true, riseTime=100)
      annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
    AixLib.HVAC.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{-44,60},{-24,80}})));
    AixLib.HVAC.Sensors.TemperatureSensor temperatureSensor2
      annotation (Placement(transformation(extent={{-44,-80},{-24,-60}})));
    AixLib.HVAC.Sensors.MassFlowSensor massFlowSensor1
      annotation (Placement(transformation(extent={{-20,60},{0,80}})));
    AixLib.HVAC.Sensors.MassFlowSensor massFlowSensor2
      annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
    Modelica.Blocks.Sources.Step step(startTime=100, height=0.7)
      annotation (Placement(transformation(extent={{38,-54},{18,-34}})));
    AixLib.HVAC.Sensors.TemperatureSensor temperatureSensorMixed
      annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
    AixLib.HVAC.Sensors.MassFlowSensor massFlowSensorMixed
      annotation (Placement(transformation(extent={{26,-10},{46,10}})));
  equation
    connect(temperatureSensor2.port_b, massFlowSensor2.port_a) annotation (Line(
        points={{-24,-70},{-20,-70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(temperatureSensor1.port_b, massFlowSensor1.port_a) annotation (Line(
        points={{-24,70},{-20,70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(massFlowSensor1.port_b, mixingValveFiltered.port_3) annotation (Line(
        points={{0,70},{0,38},{-24,38},{-24,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(massFlowSensor2.port_b, mixingValveFiltered.port_1) annotation (Line(
        points={{0,-70},{0,-54},{-68,-54},{-68,0},{-34,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(step.y, mixingValveFiltered.opening) annotation (Line(
        points={{17,-44},{-44,-44},{-44,-7},{-32,-7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(mixingValveFiltered.port_2, temperatureSensorMixed.port_a)
      annotation (Line(
        points={{-14,0},{-2,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(temperatureSensorMixed.port_b, massFlowSensorMixed.port_a)
      annotation (Line(
        points={{18,0},{26,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(massFlowSensorMixed.port_b, boundary_ph1.port_a) annotation (Line(
        points={{46,0},{64,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(boundary_ph.port_a, temperatureSensor1.port_a) annotation (Line(
        points={{-80,70},{-44,70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(boundary_ph2.port_a, temperatureSensor2.port_a) annotation (Line(
        points={{-80,-70},{-44,-70}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Documentation(info="<html>
<p>
This model shows the usage of a MixingValve in its design-direction. The results
are consistent with ones expectation of the function of a mixing valve. A step on
the opening of the valve is applied after some time, which changes the the ratio
between the two inflowing streams.
</p>
</html>", revisions="<html>
<p>26.11.2014, by <i>Roozbeh Sangi</i>: implemented </p>
</html>"),  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics),
      experiment(StopTime=1000),
      __Dymola_experimentSetupOutput);
  end MixingValveForwardDirection;

  model MixingValveBackwardDirection
    import AixLib;

    inner AixLib.HVAC.BaseParameters baseParameters
      annotation (Placement(transformation(extent={{76,58},{96,78}})));
    AixLib.HVAC.Sources.Boundary_ph boundary_ph(p=150000, h=110000)
      annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
    AixLib.HVAC.Sources.Boundary_ph boundary_ph1
      annotation (Placement(transformation(extent={{80,20},{60,40}})));
    AixLib.HVAC.Sources.Boundary_ph boundary_ph2
      annotation (Placement(transformation(extent={{82,-38},{62,-18}})));
    AixLib.HVAC.Valves.MixingValve          mixingValveFiltered(
        filteredOpening=true, riseTime=100)
      annotation (Placement(transformation(extent={{-8,-10},{-28,10}})));
    AixLib.HVAC.Sensors.TemperatureSensor temperatureSensorMixed
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    AixLib.HVAC.Sensors.MassFlowSensor massFlowSensorMixed
      annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
    AixLib.HVAC.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{2,20},{22,40}})));
    AixLib.HVAC.Sensors.MassFlowSensor massFlowSensor1
      annotation (Placement(transformation(extent={{32,20},{52,40}})));
    AixLib.HVAC.Sensors.TemperatureSensor temperatureSensor2
      annotation (Placement(transformation(extent={{4,-38},{24,-18}})));
    AixLib.HVAC.Sensors.MassFlowSensor massFlowSensor2
      annotation (Placement(transformation(extent={{34,-38},{54,-18}})));
    Modelica.Blocks.Sources.Step step(startTime=100, height=0.7)
      annotation (Placement(transformation(extent={{42,-6},{22,14}})));
  equation
    connect(boundary_ph.port_a, temperatureSensorMixed.port_a) annotation (Line(
        points={{-68,0},{-68,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(temperatureSensorMixed.port_b, massFlowSensorMixed.port_a)
      annotation (Line(
        points={{-48,0},{-48,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(massFlowSensorMixed.port_b, mixingValveFiltered.port_2) annotation (
        Line(
        points={{-28,0},{-28,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(temperatureSensor1.port_b, massFlowSensor1.port_a) annotation (Line(
        points={{22,30},{32,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(temperatureSensor2.port_b, massFlowSensor2.port_a) annotation (Line(
        points={{24,-28},{34,-28}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(massFlowSensor2.port_b, boundary_ph2.port_a) annotation (Line(
        points={{54,-28},{62,-28}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(massFlowSensor1.port_b, boundary_ph1.port_a) annotation (Line(
        points={{52,30},{60,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(mixingValveFiltered.port_3, temperatureSensor1.port_a) annotation (
        Line(
        points={{-18,10},{-18,30},{2,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(mixingValveFiltered.port_1, temperatureSensor2.port_a) annotation (
        Line(
        points={{-8,0},{0,0},{0,-28},{4,-28}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(mixingValveFiltered.opening, step.y) annotation (Line(
        points={{-10,-7},{4,-7},{4,4},{21,4}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Documentation(info="<html>
<p>
This model shows the usage of a MixingValve against its design-direction. The results
show that it is possible to use the MixingValve against its design-direction. The valve will
then split the incoming flow into two fractions according to the opening of the valve.
</p>
</html>",   revisions="<html>
<p>26.11.2014, by <i>Roozbeh Sangi</i>: implemented </p>
</html>"),  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics),
      experiment(StopTime=1000),
      __Dymola_experimentSetupOutput);
  end MixingValveBackwardDirection;
  annotation (Documentation(info="<html>
<p>This package contains two examples for MixingValve.</p>
</html>"));
end Examples;
