within AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses;
model geothermalFieldController
  "Controls the heat exchange with a heat or cold source by setting two valves"

  parameter Modelica.SIunits.Temperature temperature_low=273.15 + 40
    "Lower temperature threshold for hysteresis";
  parameter Modelica.SIunits.Temperature temperature_high=273.15 + 45
    "Upper temperature threshold for hysteresis";
  parameter Boolean warmSide=true
    "true = hysteresis with negation = for warm side";
  parameter Modelica.SIunits.Time delayTime=10
    "Time delay between opening of valve 1 and 2";


  Modelica.Blocks.Logical.Switch switch
    "Switches between fully opened and fully closed"
    annotation (Placement(transformation(extent={{-4,-6},{8,6}})));

  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=delayTime)
    "Delay that prevents that both valves react simultaneously"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={61,-5})));
  Modelica.Blocks.Math.Add add(k1=-1)
    "If one valve is fully openend, the other one must be fully closed"
                                      annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={32,-5})));
  Modelica.Blocks.Sources.Constant fullOpening(k=1)
    "Used for opening a valve fully" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={4,-21})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=temperature_low, uHigh=
        temperature_high) "Checks if the temperature is too high or too low"
    annotation (Placement(transformation(extent={{-72,-6},{-60,6}})));
  Modelica.Blocks.Sources.Constant approxFullyClosed(k=0.00001)
    "Used for closing a valve almost fully" annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-26,-27})));
  Modelica.Blocks.Sources.Constant approxFullyOpened(k=0.99999)
    "Used for opening a valve almost fully" annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-26,26})));
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
equation


  connect(add.y, fixedDelay.u) annotation (Line(
      points={{40.8,-5},{52.6,-5}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(approxFullyClosed.y, switch.u3) annotation (Line(points={{-19.4,-27},{
          -14,-27},{-14,-4.8},{-5.2,-4.8}}, color={0,0,127}));
  connect(approxFullyOpened.y, switch.u1) annotation (Line(points={{-19.4,26},{-12,
          26},{-12,4.8},{-5.2,4.8}}, color={0,0,127}));
  connect(switch.y, add.u1) annotation (Line(points={{8.6,0},{12,0},{12,-0.2},{22.4,
          -0.2}}, color={0,0,127}));
  connect(fullOpening.y, add.u2) annotation (Line(points={{10.6,-21},{14,-21},{14,
          -9.8},{22.4,-9.8}}, color={0,0,127}));
  connect(hysteresis.y, switch.u2)
    annotation (Line(points={{-59.4,0},{-5.2,0}}, color={255,0,255}));
  connect(temperature, hysteresis.u)
    annotation (Line(points={{-100,0},{-73.2,0}}, color={0,0,127}));
  connect(switch.y, valveOpening1) annotation (Line(points={{8.6,0},{12,0},{12,40},
          {99,40}}, color={0,0,127}));
  connect(fixedDelay.y, valveOpening2) annotation (Line(points={{68.7,-5},{80,-5},
          {80,-40},{99,-40}}, color={0,0,127}));
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
          fillPattern=FillPattern.Solid),                                                                                                       Text(extent={{
              -56,28},{64,-24}},                                                                                                                                                      lineColor = {175, 175, 175}, textString = "%name")}),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is a model of a controller, which manipulates the opening of two valves. If the measured temperature drops below the lower thrshold, the first valve is fully closed and the second valve is fully opened. The opposite constellation applies if the temperature exceeds the higher threshold. To avoid zero mass flow rates, the opening is only close 0. Additionally, a delay can be set so that the valves do not react simultaneously. </span></p>
</html>", revisions="<html>
<ul>
<li>
May 19, 2017, by Marc Baranski:<br/>
First implementation.
</li>
</ul>
</html>"));
end geothermalFieldController;
