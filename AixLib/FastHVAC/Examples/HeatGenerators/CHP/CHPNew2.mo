within AixLib.FastHVAC.Examples.HeatGenerators.CHP;
model CHPNew2
 extends Modelica.Icons.Example;
  FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-68,-72},{-48,-52}})));
  FastHVAC.Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{72,-70},{92,-52}})));
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_before
    annotation (Placement(transformation(extent={{-40,-68},{-24,-54}})));
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_after
    annotation (Placement(transformation(extent={{42,-68},{58,-54}})));
  Modelica.Blocks.Sources.Constant T_source(k=313.15)
    annotation (Placement(transformation(extent={{-96,-50},{-76,-30}})));
  Modelica.Blocks.Sources.Constant dotm_source(k=0.04)
    annotation (Placement(transformation(extent={{-96,-90},{-76,-70}})));
  Components.HeatGenerators.CHP.CHPDynCleaned cHPNew(withController=true)
    annotation (Placement(transformation(extent={{-14,-82},{26,-42}})));
  Modelica.Blocks.Sources.BooleanPulse booleanOnOffCHP1(
                                                       width=50, period=36000)
               annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-76,4})));
  Modelica.Blocks.Sources.Constant Pel(k=1)
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
  Modelica.Blocks.Sources.Ramp P_elRel(
    height=0.8,
    duration=36000,
    offset=0.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-44,-28})));
equation
  connect(fluidSource.enthalpyPort_b, temperatureSensor_before.enthalpyPort_a)
    annotation (Line(
      points={{-48,-61},{-47,-61},{-47,-61.07},{-39.04,-61.07}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(temperatureSensor_after.enthalpyPort_b, vessel.enthalpyPort_a)
    annotation (Line(
      points={{57.2,-61.07},{65.6,-61.07},{65.6,-61},{75,-61}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(T_source.y, fluidSource.T_fluid) annotation (Line(
      points={{-75,-40},{-70,-40},{-70,-58},{-68,-58},{-68,-57.8},{-66,-57.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotm_source.y, fluidSource.dotm) annotation (Line(
      points={{-75,-80},{-66,-80},{-66,-64.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatureSensor_before.enthalpyPort_b, cHPNew.enthalpyPort_a1)
    annotation (Line(points={{-24.8,-61.07},{-18.4,-61.07},{-18.4,-62},{-14,-62}},
        color={176,0,0}));
  connect(cHPNew.enthalpyPort_b1, temperatureSensor_after.enthalpyPort_a)
    annotation (Line(points={{26,-62.4},{34,-62.4},{34,-61.07},{42.96,-61.07}},
        color={176,0,0}));
  connect(booleanOnOffCHP1.y, cHPNew.OnOff) annotation (Line(points={{-65,4},{
          12.4,4},{12.4,-42.4}}, color={255,0,255}));
  connect(P_elRel.y, cHPNew.P_elRel) annotation (Line(points={{-33,-28},{-12.4,
          -28},{-12.4,-42.4}}, color={0,0,127}));
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
end CHPNew2;
