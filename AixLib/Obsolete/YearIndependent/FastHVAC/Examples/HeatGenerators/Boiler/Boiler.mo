within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.HeatGenerators.Boiler;
model Boiler

 extends Modelica.Icons.Example;
  FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-56,-12},{-36,8}})));
  FastHVAC.Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{72,-10},{92,8}})));
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_before
    annotation (Placement(transformation(extent={{-24,-8},{-8,6}})));
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_after
    annotation (Placement(transformation(extent={{42,-8},{58,6}})));
  Modelica.Blocks.Sources.Constant T_source(k=283.15)
    annotation (Placement(transformation(extent={{-84,10},{-64,30}})));
  Modelica.Blocks.Sources.Constant dotm_source(k=0.038)
    annotation (Placement(transformation(extent={{-84,-30},{-64,-10}})));
  Modelica.Blocks.Sources.BooleanPulse booleanOnOffBoiler(width=50, period=
        36000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={46,30})));
  Modelica.Blocks.Sources.Ramp dotQ_rel(
    height=0.8,
    duration=36000,
    offset=0.2)
    annotation (Placement(transformation(extent={{-28,20},{-8,40}})));
  FastHVAC.Components.HeatGenerators.Boiler.Boiler boiler
    annotation (Placement(transformation(extent={{-6,-20},{34,18}})));
equation

  connect(fluidSource.enthalpyPort_b, temperatureSensor_before.enthalpyPort_a)
    annotation (Line(
      points={{-36,-1},{-35,-1},{-35,-1.07},{-23.04,-1.07}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(temperatureSensor_after.enthalpyPort_b, vessel.enthalpyPort_a)
    annotation (Line(
      points={{57.2,-1.07},{75.6,-1.07},{75.6,-1},{75,-1}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(T_source.y, fluidSource.T_fluid) annotation (Line(
      points={{-63,20},{-58,20},{-58,2},{-56,2},{-56,2.2},{-54,2.2}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(dotm_source.y, fluidSource.dotm) annotation (Line(
      points={{-63,-20},{-54,-20},{-54,-4.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatureSensor_before.enthalpyPort_b, boiler.enthalpyPort_a1)
    annotation (Line(
      points={{-8.8,-1.07},{4,-1.07},{4,-1.38}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(boiler.enthalpyPort_b1, temperatureSensor_after.enthalpyPort_a)
    annotation (Line(
      points={{24,-1},{24,-1.07},{42.96,-1.07}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(boiler.dotQ_rel, dotQ_rel.y) annotation (Line(
      points={{9.975,12.3238},{9.975,30},{-7,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boiler.onOff_boiler, booleanOnOffBoiler.y) annotation (Line(
      points={{20,12.3},{20,30},{35,30}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics),
    experiment(StopTime=72000, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end Boiler;
