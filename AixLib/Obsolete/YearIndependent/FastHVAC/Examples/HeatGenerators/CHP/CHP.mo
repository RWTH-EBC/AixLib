within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.HeatGenerators.CHP;
model CHP
 extends Modelica.Icons.Example;
  FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
  FastHVAC.Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{68,-8},{88,10}})));
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_before
    annotation (Placement(transformation(extent={{-44,-6},{-28,8}})));
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_after
    annotation (Placement(transformation(extent={{38,-6},{54,8}})));
  Modelica.Blocks.Sources.Constant T_source(k=313.15)
    annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
  Modelica.Blocks.Sources.Constant dotm_source(k=0.04)
    annotation (Placement(transformation(extent={{-100,-28},{-80,-8}})));
  Modelica.Blocks.Sources.BooleanPulse booleanOnOffCHP(width=50, period=
        36000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-36,42})));
  FastHVAC.Components.HeatGenerators.CHP.CHP_PT1 cHP_PT1_1(
    param=FastHVAC.Data.CHP.Ecopower_3_0(),
    selectable=true,
    sigma(start=0.4),
    T0=293.15)
    annotation (Placement(transformation(extent={{-14,-18},{24,20}})));
  Modelica.Blocks.Sources.Ramp P_elRel(
    height=0.8,
    duration=36000,
    offset=0.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,42})));
equation
  connect(fluidSource.enthalpyPort_b, temperatureSensor_before.enthalpyPort_a)
    annotation (Line(
      points={{-52,1},{-51,1},{-51,0.93},{-43.04,0.93}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(temperatureSensor_after.enthalpyPort_b, vessel.enthalpyPort_a)
    annotation (Line(
      points={{53.2,0.93},{61.6,0.93},{61.6,1},{71,1}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(T_source.y, fluidSource.T_fluid) annotation (Line(
      points={{-79,22},{-74,22},{-74,4},{-72,4},{-72,4.2},{-70,4.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotm_source.y, fluidSource.dotm) annotation (Line(
      points={{-79,-18},{-70,-18},{-70,-2.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatureSensor_before.enthalpyPort_b, cHP_PT1_1.enthalpyPort_a)
    annotation (Line(
      points={{-28.8,0.93},{-21.4,0.93},{-21.4,1},{-14,1}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(cHP_PT1_1.enthalpyPort_b, temperatureSensor_after.enthalpyPort_a)
    annotation (Line(
      points={{24,1},{32,1},{32,0.93},{38.96,0.93}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(booleanOnOffCHP.y, cHP_PT1_1.onOff) annotation (Line(
      points={{-25,42},{-2.6,42},{-2.6,18.48}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(P_elRel.y, cHP_PT1_1.P_elRel) annotation (Line(
      points={{29,42},{14.5,42},{14.5,18.48}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=72000, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end CHP;
