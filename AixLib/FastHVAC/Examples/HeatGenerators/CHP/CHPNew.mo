within AixLib.FastHVAC.Examples.HeatGenerators.CHP;
model CHPNew
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
  Modelica.Blocks.Sources.Ramp P_elRel(
    height=0.8,
    duration=36000,
    offset=0.2) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-44,-38})));
  Components.HeatGenerators.CHP.CHPDynCleaned cHPDyn(param=Data.CHP.Kirsch(),
      withController=true)
    annotation (Placement(transformation(extent={{-14,-82},{26,-42}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{-128,48},{-108,68}})));
  Modelica.Blocks.Sources.BooleanPulse booleanOnOffCHP1(
                                                       width=50, period=
        36000) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-220,54})));
  Modelica.Blocks.Logical.Timer timer1
    annotation (Placement(transformation(extent={{-126,-4},{-106,16}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=cHPDyn.param.tauQ_th)
    annotation (Placement(transformation(extent={{-92,58},{-72,78}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold=cHPDyn.t_stopTh)
    annotation (Placement(transformation(extent={{-90,4},{-70,24}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-50,48},{-30,68}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
    annotation (Placement(transformation(extent={{-90,34},{-70,54}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=0)
    annotation (Placement(transformation(extent={{-90,-22},{-70,-2}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-162,-4},{-142,16}})));
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
  connect(temperatureSensor_before.enthalpyPort_b, cHPDyn.enthalpyPort_a1)
    annotation (Line(points={{-24.8,-61.07},{-18.4,-61.07},{-18.4,-62},{-14,-62}},
        color={176,0,0}));
  connect(cHPDyn.enthalpyPort_b1, temperatureSensor_after.enthalpyPort_a)
    annotation (Line(points={{26,-62.4},{34,-62.4},{34,-61.07},{42.96,-61.07}},
        color={176,0,0}));
  connect(P_elRel.y, cHPDyn.P_elRel) annotation (Line(points={{-33,-38},{-12.4,
          -38},{-12.4,-42.4}}, color={0,0,127}));
  connect(timer.y, lessThreshold.u) annotation (Line(points={{-107,58},{-102,58},
          {-102,68},{-94,68}}, color={0,0,127}));
  connect(booleanOnOffCHP1.y, cHPDyn.OnOff) annotation (Line(points={{-209,54},
          {-104,54},{-104,26},{12.4,26},{12.4,-42.4}}, color={255,0,255}));
  connect(booleanOnOffCHP1.y, timer.u) annotation (Line(points={{-209,54},{-170,
          54},{-170,58},{-130,58}}, color={255,0,255}));
  connect(lessThreshold.y, and1.u1) annotation (Line(points={{-71,68},{-62,68},
          {-62,58},{-52,58}}, color={255,0,255}));
  connect(timer.y, greaterThreshold.u) annotation (Line(points={{-107,58},{-100,
          58},{-100,44},{-92,44}}, color={0,0,127}));
  connect(greaterThreshold.y, and1.u2) annotation (Line(points={{-69,44},{-66,
          44},{-66,46},{-52,46},{-52,50}}, color={255,0,255}));
  connect(and1.y, cHPDyn.Start) annotation (Line(points={{-29,58},{-18,58},{-18,
          -24},{-8.4,-24},{-8.4,-40.4}}, color={255,0,255}));
  connect(timer1.y, greaterThreshold1.u) annotation (Line(points={{-105,6},{-98,
          6},{-98,-12},{-92,-12}}, color={0,0,127}));
  connect(timer1.y, lessThreshold1.u) annotation (Line(points={{-105,6},{-98,6},
          {-98,14},{-92,14}}, color={0,0,127}));
  connect(lessThreshold1.y, and2.u1) annotation (Line(points={{-69,14},{-54,14},
          {-54,10},{-52,10}}, color={255,0,255}));
  connect(greaterThreshold1.y, and2.u2) annotation (Line(points={{-69,-12},{
          -54.5,-12},{-54.5,2},{-52,2}}, color={255,0,255}));
  connect(and2.y, cHPDyn.Stop) annotation (Line(points={{-29,10},{0.4,10},{0.4,
          -42.4}}, color={255,0,255}));
  connect(not1.y, timer1.u)
    annotation (Line(points={{-141,6},{-128,6}}, color={255,0,255}));
  connect(booleanOnOffCHP1.y, not1.u) annotation (Line(points={{-209,54},{-164,
          54},{-164,6}}, color={255,0,255}));
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
end CHPNew;
