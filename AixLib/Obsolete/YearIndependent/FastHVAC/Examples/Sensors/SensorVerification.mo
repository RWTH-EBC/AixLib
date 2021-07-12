within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Sensors;
model SensorVerification
  extends Modelica.Icons.Example;

  Components.Sensors.MassFlowSensor massFlowFastHVAC
    annotation (Placement(transformation(extent={{-8,34},{14,56}})));
  Components.Sensors.TemperatureSensor TemperatureFastHVAC
    annotation (Placement(transformation(extent={{42,36},{60,54}})));
  Components.Pumps.FluidSource fluidSource1
    annotation (Placement(transformation(extent={{-54,34},{-34,54}})));
  Modelica.Blocks.Sources.Constant m_flow(k=2)
    annotation (Placement(transformation(extent={{-98,18},{-78,38}})));
  Modelica.Blocks.Sources.Constant T_fluid(k=333.15)
    annotation (Placement(transformation(extent={{-98,54},{-78,74}})));
  Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{76,34},{98,56}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-58,-48},{-38,-28}})));
  Modelica.Blocks.Sources.Constant T_fluid1(
                                           k=333.15)
    annotation (Placement(transformation(extent={{-98,-68},{-78,-48}})));
  Modelica.Blocks.Sources.Constant m_flow1(
                                          k=2)
    annotation (Placement(transformation(extent={{-98,-30},{-78,-10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TemperatureFluid(redeclare package
              Medium =
               Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{42,-48},{62,-28}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowFluid(redeclare package
      Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-10,-48},{10,-28}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Fluid.Sources.FixedBoundary
                                  Sink(
    nPorts=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,-38})));
equation
  connect(T_fluid.y, fluidSource1.T_fluid) annotation (Line(
      points={{-77,64},{-62,64},{-62,48.2},{-52,48.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fluidSource1.enthalpyPort_b, massFlowFastHVAC.enthalpyPort_a)
    annotation (Line(
      points={{-34,45},{-18,45},{-18,44.89},{-6.68,44.89}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(massFlowFastHVAC.enthalpyPort_b, TemperatureFastHVAC.enthalpyPort_a)
    annotation (Line(
      points={{12.9,44.89},{38.45,44.89},{38.45,44.91},{43.08,44.91}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(TemperatureFastHVAC.enthalpyPort_b, vessel.enthalpyPort_a)
    annotation (Line(
      points={{59.1,44.91},{76,44.91},{76,45},{79.3,45}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(m_flow1.y, boundary.m_flow_in) annotation (Line(
      points={{-77,-20},{-68,-20},{-68,-30},{-58,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_fluid1.y, boundary.T_in) annotation (Line(
      points={{-77,-58},{-68,-58},{-68,-34},{-60,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary.ports[1], massFlowFluid.port_a) annotation (Line(
      points={{-38,-38},{-10,-38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(massFlowFluid.port_b, TemperatureFluid.port_a) annotation (Line(
      points={{10,-38},{42,-38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TemperatureFluid.port_b, Sink.ports[1]) annotation (Line(
      points={{62,-38},{78,-38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(m_flow.y, fluidSource1.dotm) annotation (Line(
      points={{-77,28},{-62,28},{-62,41.4},{-52,41.4}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Text(
          extent={{78,94},{82,86}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Vessel model"),
        Rectangle(
          extent={{-100,-2},{100,-100}},
          lineColor={170,213,255},
          fillPattern=FillPattern.Solid,
          fillColor={170,213,255}),
        Rectangle(
          extent={{-100,100},{100,2}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,96},{26,82}},
          lineColor={0,0,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.Solid,
          textString="FastHVAC"),
        Text(
          extent={{-22,-4},{26,-18}},
          lineColor={0,0,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.Solid,
          textString="HVAC")}),
          Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Example of mass flow & temperature sensor. Compare to equivalent
  Fluid-/HVAC- based models.
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>December 16, 2014&#160;</i> by Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html> "));
end SensorVerification;
