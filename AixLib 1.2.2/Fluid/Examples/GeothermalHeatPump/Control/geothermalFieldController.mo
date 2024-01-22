within AixLib.Fluid.Examples.GeothermalHeatPump.Control;
model geothermalFieldController
  "Controls the heat exchange with a heat or cold source by setting two valves"

  parameter Modelica.Units.SI.Temperature temperature_low=273.15 + 40
    "Lower temperature threshold for hysteresis";
  parameter Modelica.Units.SI.Temperature temperature_high=273.15 + 45
    "Upper temperature threshold for hysteresis";
  parameter Boolean warmSide=true
    "true = hysteresis with negation = for warm side";
  parameter Modelica.Units.SI.Time delayTime=10
    "Time delay between opening of valve 1 and 2";

  Modelica.Blocks.Logical.Switch switch
    "Switches between fully opened and fully closed"
    annotation (Placement(transformation(extent={{-28,-6},{-16,6}})));

  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=delayTime)
    "Delay that prevents that both valves react simultaneously"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={31,-45})));
  Modelica.Blocks.Math.Add add(k1=-1)
    "If one valve is fully openend, the other one must be fully closed"
                                      annotation (Placement(
        transformation(
        extent={{-7,-6.5},{7,6.5}},
        rotation=0,
        origin={5,-44.5})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=temperature_low, uHigh=
        temperature_high) "Checks if the temperature is too high or too low"
    annotation (Placement(transformation(extent={{-78,-6},{-66,6}})));
  Modelica.Blocks.Sources.Constant approxFullyClosed(k=0.00001)
    "Used for closing a valve almost fully" annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-52,-25})));
  Modelica.Blocks.Sources.Constant approxFullyOpened(k=0.99999)
    "Used for opening a valve almost fully" annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-50,26})));
  Modelica.Blocks.Interfaces.RealInput temperature(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Temperature of the controlled flow" annotation (Placement(
        transformation(
        origin={-100,0},
        extent={{14,-14},{-14,14}},
        rotation=180)));
  Modelica.Blocks.Interfaces.RealOutput valveOpening1(min=0, max=1)
    "Actuator position (0: closed, 1: open)" annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=0,
        origin={99,40}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={112,60})));
  Modelica.Blocks.Interfaces.RealOutput valveOpening2(min=0, max=1)
    "Actuator position (0: closed, 1: open)" annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=0,
        origin={99,-40}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={112,-60})));
  Modelica.Blocks.Logical.Switch switch1
    "Switches between delayed and direct opening"
    annotation (Placement(transformation(extent={{56,34},{68,46}})));
  Modelica.Blocks.Logical.Switch switch2
    "Switches between delayed and direct opening"
    annotation (Placement(transformation(extent={{60,-46},{72,-34}})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay1(
                                                  delayTime=delayTime)
    "Delay that prevents that both valves react simultaneously"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={29,51})));
  Modelica.Blocks.Sources.Constant fullOpening(k=1)
    "Used for opening a valve fully" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-26,-48})));
equation

  connect(approxFullyOpened.y, switch.u1) annotation (Line(points={{-43.4,26},{
          -38,26},{-38,4.8},{-29.2,4.8}}, color={0,0,127}));
  connect(switch.y, add.u1) annotation (Line(points={{-15.4,0},{-15.4,0},{-8,0},
          {-8,-40.6},{-3.4,-40.6}},
                  color={0,0,127}));
  connect(hysteresis.y, switch.u2)
    annotation (Line(points={{-65.4,0},{-65.4,0},{-29.2,0}},
                                                  color={255,0,255}));
  connect(temperature, hysteresis.u)
    annotation (Line(points={{-100,0},{-79.2,0}}, color={0,0,127}));
  connect(switch1.y, valveOpening1)
    annotation (Line(points={{68.6,40},{99,40}}, color={0,0,127}));
  connect(approxFullyClosed.y, switch.u3) annotation (Line(points={{-45.4,-25},
          {-44,-25},{-44,-4.8},{-29.2,-4.8}}, color={0,0,127}));
  connect(switch2.y, valveOpening2)
    annotation (Line(points={{72.6,-40},{99,-40}}, color={0,0,127}));
  connect(add.y, fixedDelay.u) annotation (Line(points={{12.7,-44.5},{12.7,-45},
          {22.6,-45}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2) annotation (Line(points={{-65.4,0},{-64,0},
          {-64,2},{-64,40},{54.8,40}}, color={255,0,255}));
  connect(hysteresis.y, switch2.u2) annotation (Line(points={{-65.4,0},{-64,0},
          {-64,-6},{-64,-60},{44,-60},{44,-40},{58.8,-40}}, color={255,0,255}));
  connect(fixedDelay.y, switch2.u3) annotation (Line(points={{38.7,-45},{48.35,
          -45},{48.35,-44.8},{58.8,-44.8}}, color={0,0,127}));
  connect(add.y, switch2.u1) annotation (Line(points={{12.7,-44.5},{12.7,-30},{
          22,-30},{58.8,-30},{58.8,-35.2}}, color={0,0,127}));
  connect(switch1.u1, fixedDelay1.y) annotation (Line(points={{54.8,44.8},{54.8,
          51},{36.7,51}}, color={0,0,127}));
  connect(fixedDelay1.u, switch.y) annotation (Line(points={{20.6,51},{-16,51},
          {-16,0},{-15.4,0}}, color={0,0,127}));
  connect(switch1.u3, switch.y) annotation (Line(points={{54.8,35.2},{-16,35.2},
          {-16,0},{-15.4,0}}, color={0,0,127}));
  connect(fullOpening.y, add.u2) annotation (Line(points={{-19.4,-48},{-3.4,-48},
          {-3.4,-48.4}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{-42,-4},{-34,4}})),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          textString="Edit Here",
          extent={{-118,36},{-114,12}},
          lineColor={217,67,180},
          pattern=LinePattern.Dot,
          lineThickness=1)}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
          Text(extent={{
              -56,28},{64,-24}},
              lineColor = {175, 175, 175}, textString = "%name")}),
    Documentation(info="<html><p>
  This is a model of a controller, which manipulates the opening of two
  valves. If the measured temperature drops below the lower thrshold,
  the first valve is fully closed and the second valve is fully opened.
  The opposite constellation applies if the temperature exceeds the
  higher threshold. To avoid zero mass flow rates, the opening is only
  close 0. Additionally, a delay can be set so that the valves do not
  react simultaneously (opened valve is closed first). It can be used
  in <a href=
  \"modelica://AixLib.Fluid.Examples.GeothermalHeatPump.Components.GeothermalHeatPump\">
  AixLib.Fluid.Examples.GeothermalHeatPump.Components.GeothermalHeatPump</a>.
</p>
<ul>
  <li>May 24, 2017, by Alexander Kümpel:<br/>
    Delay improved.
  </li>
  <li>May 19, 2017, by Marc Baranski:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end geothermalFieldController;
