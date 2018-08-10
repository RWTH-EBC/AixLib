within AixLib.FastHVAC.Examples.HeatGenerators.CHP;
model CHPOldPEMFC
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
  Modelica.Blocks.Sources.BooleanPulse booleanOnOffCHP1(
                                                       width=50, period=36000)
               annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-86,0})));
  Modelica.Blocks.Sources.Constant T_source1(k=1)
    annotation (Placement(transformation(extent={{-44,0},{-24,20}})));
  Components.HeatGenerators.CHP.PEMFC pEMFC
    annotation (Placement(transformation(extent={{2,-64},{22,-44}})));
  Components.HeatGenerators.CHP.BaseClasses.StartStopController
    startStopController(StartTime=110, StopTime=330)
    annotation (Placement(transformation(extent={{-40,-38},{-20,-18}})));
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
  connect(booleanOnOffCHP1.y, startStopController.OnOff) annotation (Line(
        points={{-75,0},{-64,0},{-64,-2},{-48,-2},{-48,-28},{-40,-28}}, color={
          255,0,255}));
  connect(booleanOnOffCHP1.y, pEMFC.OnOff) annotation (Line(points={{-75,0},{
          -52,0},{-52,-46},{-16,-46},{-16,-56},{2,-56}}, color={255,0,255}));
  connect(startStopController.Start, pEMFC.Start) annotation (Line(points={{
          -18.8,-23.2},{-12,-23.2},{-12,-50},{2,-50}}, color={255,0,255}));
  connect(startStopController.Stop, pEMFC.Stop) annotation (Line(points={{-18.8,
          -32.2},{-18.8,-52.6},{2,-52.6}}, color={255,0,255}));
  connect(T_source1.y, pEMFC.u) annotation (Line(points={{-23,10},{-14,10},{-14,
          8},{-6,8},{-6,-46.6},{2,-46.6}}, color={0,0,127}));
  connect(temperatureSensor_before.enthalpyPort_b, pEMFC.enthalpyPort_a1)
    annotation (Line(points={{-24.8,-61.07},{-12.4,-61.07},{-12.4,-62.2},{1.4,
          -62.2}}, color={176,0,0}));
  connect(pEMFC.enthalpyPort_b1, temperatureSensor_after.enthalpyPort_a)
    annotation (Line(points={{22.2,-62.2},{32.1,-62.2},{32.1,-61.07},{42.96,
          -61.07}}, color={176,0,0}));
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
end CHPOldPEMFC;
