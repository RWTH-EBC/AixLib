within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls;
block OnOffControl
  "Controlls if the minimal runtime, stoptime and max. runs per hour are inside given boundaries"
  extends BaseClasses.partialSecurityControl;
  Modelica.Blocks.Logical.Greater NSetGreaterNull "True if device is set on"
    annotation (Placement(transformation(extent={{-102,56},{-86,72}})));
  parameter Modelica.SIunits.Time minRunTime "Mimimum runtime of heat pump";
  parameter Modelica.SIunits.Time minLocTime "Minimum lock time of heat pump";
  parameter Real maxRunPer_h "Maximal number of on/off cycles in one hour";
  Modelica.Blocks.Logical.Greater NIsGreaterNull
    "True if the device is still on"
    annotation (Placement(transformation(extent={{-104,-36},{-88,-20}})));
  Modelica.Blocks.MathBoolean.Or or1(nu=3)
    annotation (Placement(transformation(extent={{56,12},{68,24}})));
  Modelica.Blocks.Logical.Switch SwiSta
    "If the minimal runtime is not reached, the compressor speed should still be controllable"
    annotation (Placement(transformation(extent={{-92,-2},{-72,18}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-66,60},{-58,68}})));
  Modelica.Blocks.Logical.And andRun
    annotation (Placement(transformation(extent={{8,40},{20,52}})));
  Modelica.Blocks.Logical.Pre pre1
    annotation (Placement(transformation(extent={{-84,-34},{-72,-22}})));
  Modelica.Blocks.Logical.And andIsOn "True if the device is already on"
    annotation (Placement(transformation(extent={{30,72},{42,84}})));
  BaseClasses.RunPerHouBoundary runPerHouBoundary(maxRunPer_h=maxRunPer_h,
      delayTime=3600)
    annotation (Placement(transformation(extent={{-42,-80},{-10,-48}})));
  BaseClasses.TimeControl locTimControl(final minRunTime=minLocTime)
    annotation (Placement(transformation(extent={{-42,-30},{-10,0}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-64,-20},{-54,-10}})));
  BaseClasses.TimeControl runTimControl(final minRunTime=minRunTime)
    annotation (Placement(transformation(extent={{-42,22},{-10,52}})));
  Modelica.Blocks.Logical.And andLoc
    annotation (Placement(transformation(extent={{26,-42},{38,-30}})));
equation
  connect(conZer.y, NSetGreaterNull.u2) annotation (Line(points={{70.6,-18},{78,
          -18},{78,-94},{-108,-94},{-108,57.6},{-103.6,57.6}},   color={0,0,
          127}));
  connect(NSetGreaterNull.u1, nSet) annotation (Line(points={{-103.6,64},{-118,
          64},{-118,37},{-135,37}}, color={0,0,127}));
  connect(conZer.y, NIsGreaterNull.u2) annotation (Line(points={{70.6,-18},{78,
          -18},{78,-94},{-108,-94},{-108,-34.4},{-105.6,-34.4}},    color={0,
          0,127}));
  connect(andRun.y, SwiSta.u2) annotation (Line(points={{20.6,46},{48,46},{48,
          12},{-54,12},{-54,-4},{-100,-4},{-100,8},{-94,8}},
                                               color={255,0,255}));
  connect(SwiSta.y, SwiErr.u1) annotation (Line(points={{-71,8},{84,8}},
                   color={0,0,127}));
  connect(or1.y, SwiErr.u2)
    annotation (Line(points={{68.9,18},{76,18},{76,0},{84,0}}, color={255,0,255}));
  connect(pre1.u, NIsGreaterNull.y)
    annotation (Line(points={{-85.2,-28},{-87.2,-28}},
                                                     color={255,0,255}));
  connect(andRun.u1, not2.y) annotation (Line(points={{6.8,46},{-2,46},{-2,64},
          {-57.6,64}},         color={255,0,255}));
  connect(andRun.y, or1.u[1]) annotation (Line(points={{20.6,46},{48,46},{48,
          20.8},{56,20.8}},
                        color={255,0,255}));
  connect(not2.u, NSetGreaterNull.y)
    annotation (Line(points={{-66.8,64},{-85.2,64}}, color={255,0,255}));
  connect(andIsOn.u1, NSetGreaterNull.y) annotation (Line(points={{28.8,78},{
          -74,78},{-74,64},{-85.2,64}},                 color={255,0,255}));
  connect(andIsOn.y, or1.u[2]) annotation (Line(points={{42.6,78},{48,78},{48,
          18},{56,18}},     color={255,0,255}));
  connect(pre1.y, andIsOn.u2) annotation (Line(points={{-71.4,-28},{-71.4,74},{
          28,74},{28,73.2},{28.8,73.2}},  color={255,0,255}));
  connect(pre1.y, runPerHouBoundary.u) annotation (Line(points={{-71.4,-28},{
          -71.4,-64},{-45.2,-64}}, color={255,0,255}));
  connect(pre1.y, not1.u) annotation (Line(points={{-71.4,-28},{-71.4,-14},{-66,
          -14},{-66,-15},{-65,-15}}, color={255,0,255}));
  connect(not1.y, locTimControl.u)
    annotation (Line(points={{-53.5,-15},{-45.2,-15}}, color={255,0,255}));
  connect(runTimControl.y, andRun.u2) annotation (Line(points={{-8.4,37},{-2,37},
          {-2,41.2},{6.8,41.2}}, color={255,0,255}));
  connect(runTimControl.u, pre1.y) annotation (Line(points={{-45.2,37},{-45.2,
          36},{-71.4,36},{-71.4,-28}}, color={255,0,255}));
  connect(nSet, SwiSta.u3) annotation (Line(points={{-135,37},{-113.5,37},{
          -113.5,0},{-94,0}}, color={0,0,127}));
  connect(runPerHouBoundary.y, andLoc.u2) annotation (Line(points={{-8.4,-64},{
          12,-64},{12,-40.8},{24.8,-40.8}}, color={255,0,255}));
  connect(andLoc.y, or1.u[3]) annotation (Line(points={{38.6,-36},{48,-36},{48,
          16},{52,16},{52,15.2},{56,15.2}}, color={255,0,255}));
  connect(locTimControl.y, andLoc.u1) annotation (Line(points={{-8.4,-15},{-8.4,
          -14},{24.8,-14},{24.8,-36}}, color={255,0,255}));
  connect(NIsGreaterNull.u1, heatPumpControlBus.N) annotation (Line(points={{
          -105.6,-28},{-126,-28},{-126,-26.925},{-136.915,-26.925}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(SwiSta.u1, heatPumpControlBus.N) annotation (Line(points={{-94,16},{
          -114,16},{-114,-26.925},{-136.915,-26.925}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Documentation(info="<html>
<p>Checks if the nSet value is legal by checking if the device can either be turned on or off, depending on which state it was in.</p>
<p><br>E.g. If it is turned on, and the new nSet value is 0, it will only turn off if current runtime is longer than the minimal runtime. Else it will keep the current rotating speed.</p>
</html>"));
end OnOffControl;
