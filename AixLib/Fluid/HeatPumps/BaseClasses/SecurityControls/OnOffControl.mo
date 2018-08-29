within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls;
block OnOffControl
  "Controlls if the minimal runtime, stoptime and max. runs per hour are inside given boundaries"
  extends BaseClasses.PartialSecurityControl;
  Modelica.Blocks.Logical.GreaterThreshold
                                  nSetGreaterNull(final threshold=Modelica.Constants.eps)
                                                  "True if device is set on"
    annotation (Placement(transformation(extent={{-102,56},{-86,72}})));
  parameter Boolean useMinRunTime
    "False if minimal runtime of HP is not considered";
  parameter Modelica.SIunits.Time minRunTime(displayUnit="min")
    "Mimimum runtime of heat pump"
    annotation (Dialog(enable=useMinRunTim));
  parameter Boolean useMinLocTime
    "False if minimal locktime of HP is not considered";
  parameter Modelica.SIunits.Time minLocTime(displayUnit="min")
    "Minimum lock time of heat pump"
    annotation (Dialog(enable=useMinLocTim));
  parameter Boolean useRunPerHou
    "False if maximal runs per hour of HP are not considered";
  parameter Real maxRunPerHou "Maximal number of on/off cycles in one hour"
    annotation (Dialog(enable=useRunPerHour));

  Modelica.Blocks.Logical.GreaterThreshold
                                  nIsGreaterNull(final threshold=Modelica.Constants.eps)
    "True if the device is still on"
    annotation (Placement(transformation(extent={{-106,-36},{-90,-20}})));
  Modelica.Blocks.MathBoolean.Or or1(nu=3)
    annotation (Placement(transformation(extent={{56,12},{68,24}})));
  Modelica.Blocks.Logical.Switch SwiSta
    "If the minimal runtime is not reached, the compressor speed should still be controllable"
    annotation (Placement(transformation(extent={{-92,-2},{-72,18}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-66,60},{-58,68}})));
  Modelica.Blocks.Logical.And andRun
    annotation (Placement(transformation(extent={{24,40},{36,52}})));
  Modelica.Blocks.Logical.Pre pre1
    annotation (Placement(transformation(extent={{-84,-34},{-72,-22}})));
  Modelica.Blocks.Logical.And andIsOn "True if the device is already on"
    annotation (Placement(transformation(extent={{30,72},{42,84}})));
  BaseClasses.RunPerHouBoundary runPerHouBoundary(final maxRunPer_h=
        maxRunPerHou, final delayTime=3600) if useRunPerHou
    annotation (Placement(transformation(extent={{-42,-72},{-10,-40}})));
  BaseClasses.TimeControl locTimControl(final minRunTime=minLocTime) if
    useMinLocTime
    annotation (Placement(transformation(extent={{-42,-30},{-10,0}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-64,-20},{-54,-10}})));
  BaseClasses.TimeControl runTimControl(final minRunTime=minRunTime) if
    useMinRunTime
    annotation (Placement(transformation(extent={{-42,22},{-10,52}})));
  Modelica.Blocks.Logical.And andLoc
    annotation (Placement(transformation(extent={{26,-42},{38,-30}})));

  Modelica.Blocks.Sources.BooleanConstant booleanConstantRunPerHou(final k=true) if not
    useRunPerHou
    annotation (Placement(transformation(extent={{-4,-88},{10,-74}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstantLocTim(final k=true) if not
    useMinLocTime
    annotation (Placement(transformation(extent={{-4,-36},{10,-22}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstantRunTim(final k=true) if not
    useMinRunTime
    annotation (Placement(transformation(extent={{0,16},{14,30}})));
equation
  connect(andRun.y, SwiSta.u2) annotation (Line(points={{36.6,46},{48,46},{48,12},
          {-54,12},{-54,-4},{-100,-4},{-100,8},{-94,8}},
                                               color={255,0,255}));
  connect(SwiSta.y,swiErr.u1)  annotation (Line(points={{-71,8},{84,8}},
                   color={0,0,127}));
  connect(or1.y,swiErr.u2)
    annotation (Line(points={{68.9,18},{76,18},{76,0},{84,0}}, color={255,0,255}));
  connect(pre1.u,nIsGreaterNull. y)
    annotation (Line(points={{-85.2,-28},{-89.2,-28}},
                                                     color={255,0,255}));
  connect(andRun.u1, not2.y) annotation (Line(points={{22.8,46},{-2,46},{-2,64},
          {-57.6,64}},         color={255,0,255}));
  connect(andRun.y, or1.u[1]) annotation (Line(points={{36.6,46},{48,46},{48,20.8},
          {56,20.8}},   color={255,0,255}));
  connect(not2.u,nSetGreaterNull. y)
    annotation (Line(points={{-66.8,64},{-85.2,64}}, color={255,0,255}));
  connect(andIsOn.u1,nSetGreaterNull. y) annotation (Line(points={{28.8,78},{
          -74,78},{-74,64},{-85.2,64}},                 color={255,0,255}));
  connect(andIsOn.y, or1.u[2]) annotation (Line(points={{42.6,78},{48,78},{48,
          18},{56,18}},     color={255,0,255}));
  connect(pre1.y, andIsOn.u2) annotation (Line(points={{-71.4,-28},{-71.4,74},{
          28,74},{28,73.2},{28.8,73.2}},  color={255,0,255}));
  connect(pre1.y, runPerHouBoundary.u) annotation (Line(points={{-71.4,-28},{-71.4,
          -56},{-45.2,-56}},       color={255,0,255}));
  connect(pre1.y, not1.u) annotation (Line(points={{-71.4,-28},{-71.4,-14},{-66,
          -14},{-66,-15},{-65,-15}}, color={255,0,255}));
  connect(not1.y, locTimControl.u)
    annotation (Line(points={{-53.5,-15},{-45.2,-15}}, color={255,0,255}));
  connect(runTimControl.y, andRun.u2) annotation (Line(points={{-8.4,37},{-2,37},
          {-2,41.2},{22.8,41.2}},color={255,0,255},
      pattern=LinePattern.Dash));
  connect(runTimControl.u, pre1.y) annotation (Line(points={{-45.2,37},{-45.2,
          36},{-71.4,36},{-71.4,-28}}, color={255,0,255}));
  connect(nSet, SwiSta.u3) annotation (Line(points={{-136,0},{-113.5,0},{-113.5,
          0},{-94,0}},        color={0,0,127}));
  connect(andLoc.y, or1.u[3]) annotation (Line(points={{38.6,-36},{48,-36},{48,
          16},{52,16},{52,15.2},{56,15.2}}, color={255,0,255}));
  connect(locTimControl.y, andLoc.u1) annotation (Line(points={{-8.4,-15},{-8.4,
          -6},{24.8,-6},{24.8,-36}},   color={255,0,255},
      pattern=LinePattern.Dash));
  connect(runPerHouBoundary.y, andLoc.u2) annotation (Line(points={{-8.4,-56},{6,
          -56},{6,-40.8},{24.8,-40.8}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanConstantRunPerHou.y, andLoc.u2) annotation (Line(
      points={{10.7,-81},{16,-81},{16,-40.8},{24.8,-40.8}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanConstantLocTim.y, andLoc.u1) annotation (Line(
      points={{10.7,-29},{10.7,-18},{24.8,-18},{24.8,-36}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanConstantRunTim.y, andRun.u2) annotation (Line(
      points={{14.7,23},{14.7,41.2},{22.8,41.2}},
      color={255,0,255},
      pattern=LinePattern.Dash));

  connect(nSet, nSetGreaterNull.u) annotation (Line(points={{-136,0},{-120,0},{
          -120,64},{-103.6,64}}, color={0,0,127}));
  connect(nOut, nIsGreaterNull.u) annotation (Line(points={{130,0},{140,0},{140,
          -104},{-116,-104},{-116,-28},{-107.6,-28}}, color={0,0,127}));
  connect(nOut, SwiSta.u1) annotation (Line(points={{130,0},{140,0},{140,100},{
          -114,100},{-114,16},{-94,16}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>Checks if the nSet value is legal by checking if the device can either be turned on or off, depending on which state it was in.</p>
<p>E.g. If it is turned on, and the new nSet value is 0, it will only turn off if current runtime is longer than the minimal runtime. Else it will keep the current rotating speed.</p>
</html>"));
end OnOffControl;
