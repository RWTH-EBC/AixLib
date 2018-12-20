within AixLib.FastHVAC.Examples.HeatGenerators.HeatPump;
model ValidationHeatPump2

  extends Modelica.Icons.Example;
  FastHVAC.Components.Sinks.Vessel vessel_co
    annotation (Placement(transformation(extent={{72,-56},{94,-38}})));
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{26,-82},{44,-64}})));
  FastHVAC.Components.Pumps.FluidSource fluidSource(medium=
        FastHVAC.Media.WaterSimple())
    annotation (Placement(transformation(extent={{-50,-44},{-30,-24}})));
  Components.HeatGenerators.HeatPump2                  heatPump2_1
    annotation (Placement(transformation(extent={{-13,-16},{13,16}},
        rotation=-90,
        origin={3,-2})));
  FastHVAC.Components.Pumps.FluidSource fluidSource1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={44,50})));
  FastHVAC.Components.Sinks.Vessel vessel_ev annotation (Placement(
        transformation(
        extent={{-11,-9},{11,9}},
        rotation=180,
        origin={-35,57})));


  Modelica.Blocks.Sources.Ramp TsuSourceRamp1(
    startTime=1000,
    height=25,
    offset=278,
    duration=36000)
    annotation (Placement(transformation(extent={{-98,-32},{-78,-12}})));
  Modelica.Blocks.Sources.BooleanPulse    booleanConstant1(
                                                          period=10000)
    annotation (Placement(transformation(extent={{-92,64},{-72,84}})));
  Modelica.Blocks.Sources.Constant dotm_ev2(k=0.5)
    annotation (Placement(transformation(extent={{-98,-94},{-78,-74}})));
  Modelica.Blocks.Sources.Constant T2(k=308.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={82,38})));
  Modelica.Blocks.Sources.Constant dotm_co2(k=0.5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={82,84})));
equation
  connect(temperatureSensor.enthalpyPort_b,vessel_co. enthalpyPort_a)
    annotation (Line(
      points={{43.1,-73.09},{67.55,-73.09},{67.55,-47},{75.3,-47}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(dotm_ev2.y, fluidSource.dotm) annotation (Line(
      points={{-77,-84},{-66,-84},{-66,-36.6},{-48,-36.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TsuSourceRamp1.y, fluidSource.T_fluid) annotation (Line(
      points={{-77,-22},{-66,-22},{-66,-29.8},{-48,-29.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T2.y, fluidSource1.T_fluid) annotation (Line(
      points={{71,38},{66,38},{66,45.8},{52,45.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotm_co2.y, fluidSource1.dotm) annotation (Line(
      points={{71,84},{66,84},{66,52.6},{52,52.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fluidSource1.enthalpyPort_b, heatPump2_1.enthalpyPort_a) annotation (
      Line(points={{34,49},{28,49},{28,11},{11,11}}, color={176,0,0}));
  connect(heatPump2_1.enthalpyPort_a1, fluidSource.enthalpyPort_b) annotation (
      Line(points={{-5,-15},{-6,-15},{-6,-16},{-30,-16},{-30,-33}}, color={176,
          0,0}));
  connect(temperatureSensor.enthalpyPort_a, heatPump2_1.enthalpyPort_b)
    annotation (Line(points={{27.08,-73.09},{27.08,-15},{11,-15}}, color={176,0,
          0}));
  connect(booleanConstant1.y, heatPump2_1.modeSet) annotation (Line(points={{
          -71,74},{0,74},{0,13.08},{0.333333,13.08}}, color={255,0,255}));
  connect(vessel_ev.enthalpyPort_a, heatPump2_1.enthalpyPort_b1) annotation (
      Line(points={{-27.3,57},{-27.3,58},{-5,58},{-5,11}}, color={176,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,96},{28,82}},
          lineColor={0,0,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.Solid,
          textString="FastHVAC")}),
    experiment(StopTime=72000, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end ValidationHeatPump2;
