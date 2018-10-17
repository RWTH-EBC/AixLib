within AixLib.Controls.HeatPump.SecurityControls;
model OnOffControl
  "Controlls if the minimal runtime, stoptime and max. runs per hour are inside given boundaries"
  parameter Boolean use_minRunTime
    "False if minimal runtime of HP is not considered" annotation(choices(checkBox=true));
  parameter Modelica.SIunits.Time minRunTime(displayUnit="min")
    "Mimimum runtime of heat pump"
    annotation (Dialog(enable=use_minRunTime));
  parameter Boolean use_minLocTime
    "False if minimal locktime of HP is not considered" annotation(choices(checkBox=true));
  parameter Modelica.SIunits.Time minLocTime(displayUnit="min")
    "Minimum lock time of heat pump"
    annotation (Dialog(enable=use_minLocTime));
  parameter Boolean use_runPerHou
    "False if maximal runs per hour of HP are not considered" annotation(choices(checkBox=true));
  parameter Real maxRunPerHou "Maximal number of on/off cycles in one hour"
    annotation (Dialog(enable=use_runPerHou));
  parameter Boolean pre_n_start=true "Start value of pre(n) at initial time";
  Modelica.Blocks.Logical.GreaterThreshold
                                  nSetGreaterZero(final threshold=Modelica.Constants.eps)
                                                  "True if device is set on"
    annotation (Placement(transformation(extent={{-110,56},{-94,72}})));
  Modelica.Blocks.Logical.GreaterThreshold
                                  nIsGreaterZero(final threshold=Modelica.Constants.eps)
    "True if the device is still on"
    annotation (Placement(transformation(extent={{-108,-50},{-92,-34}})));
  Modelica.Blocks.Logical.And andRun
    annotation (Placement(transformation(extent={{18,72},{30,84}})));
  Modelica.Blocks.Logical.Pre pre1(final pre_u_start=pre_n_start)
    annotation (Placement(transformation(extent={{-84,-48},{-72,-36}})));
  BaseClasses.RunPerHouBoundary runPerHouBoundary(final maxRunPer_h=
        maxRunPerHou, final delayTime=3600) if use_runPerHou
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  BaseClasses.TimeControl locTimControl(final minRunTime=minLocTime) if
    use_minLocTime
    annotation (Placement(transformation(extent={{-40,-24},{-20,-4}})));
  Modelica.Blocks.Logical.Not notIsOn
    annotation (Placement(transformation(extent={{-66,-22},{-58,-14}})));
  BaseClasses.TimeControl runTimControl(final minRunTime=minRunTime) if
    use_minRunTime
    annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
  Modelica.Blocks.Logical.And andLoc
    annotation (Placement(transformation(extent={{28,-66},{40,-54}})));

  Modelica.Blocks.Sources.BooleanConstant booleanConstantRunPerHou(final k=true) if not
    use_runPerHou
    annotation (Placement(transformation(extent={{0,-90},{14,-76}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstantLocTim(final k=true) if not
    use_minLocTime
    annotation (Placement(transformation(extent={{-34,-44},{-20,-30}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstantRunTim(final k=true) if not
    use_minRunTime
    annotation (Placement(transformation(extent={{-4,52},{10,66}})));
  Modelica.Blocks.Logical.Not notSetOn
    annotation (Placement(transformation(extent={{-66,72},{-56,82}})));
  Modelica.Blocks.Logical.And andTurnOff
    "Check if HP is on and is set to be turned off"
    annotation (Placement(transformation(extent={{-12,80},{0,92}})));
  Modelica.Blocks.Logical.And andTurnOn
    "Check if HP is Off and is set to be turned on"
    annotation (Placement(transformation(extent={{28,-90},{40,-78}})));
  Modelica.Blocks.Logical.And andIsOn
    "Check if both set and actual value are greater zero"
    annotation (Placement(transformation(extent={{16,12},{28,24}})));
  Modelica.Blocks.Interfaces.RealInput nSet
    "Set value relative speed of compressor. Analog from 0 to 1"
    annotation (Placement(transformation(extent={{-152,-16},{-120,16}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-152,-84},{-118,-54}})));
  Utilities.Logical.SmoothSwitch swinOutnSet
    "If any of the ornSet conditions is true, nSet will be passed. Else nOut will stay the same"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.MathBoolean.Or orSetN(nu=4)
    "Output is true if nSet value is correct"
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  Modelica.Blocks.Logical.And andIsOff
    "Check if both set and actual value are equal to zero"
    annotation (Placement(transformation(extent={{16,32},{28,44}})));
  Modelica.Blocks.Logical.And andLocOff
    annotation (Placement(transformation(extent={{52,-78},{64,-66}})));
equation
  connect(pre1.u,nIsGreaterZero. y)
    annotation (Line(points={{-85.2,-42},{-91.2,-42}},
                                                     color={255,0,255}));
  connect(pre1.y, runPerHouBoundary.u) annotation (Line(points={{-71.4,-42},{-71.4,
          -70},{-42,-70}},         color={255,0,255}));
  connect(pre1.y, notIsOn.u) annotation (Line(points={{-71.4,-42},{-71.4,-28},{-72,
          -28},{-72,-18},{-66.8,-18}}, color={255,0,255}));
  connect(notIsOn.y, locTimControl.u) annotation (Line(points={{-57.6,-18},{-50,
          -18},{-50,-14},{-42,-14}}, color={255,0,255}));
  connect(runTimControl.y, andRun.u2) annotation (Line(points={{-19,62},{-8,62},
          {-8,73.2},{16.8,73.2}},color={255,0,255},
      pattern=LinePattern.Dash));
  connect(runTimControl.u, pre1.y) annotation (Line(points={{-42,62},{-71.4,62},
          {-71.4,-42}},                color={255,0,255}));
  connect(locTimControl.y, andLoc.u1) annotation (Line(points={{-19,-14},{6,-14},
          {6,-60},{26.8,-60}},         color={255,0,255},
      pattern=LinePattern.Dash));
  connect(runPerHouBoundary.y, andLoc.u2) annotation (Line(points={{-19,-70},{6,
          -70},{6,-64.8},{26.8,-64.8}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanConstantRunPerHou.y, andLoc.u2) annotation (Line(
      points={{14.7,-83},{16,-83},{16,-64.8},{26.8,-64.8}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanConstantRunTim.y, andRun.u2) annotation (Line(
      points={{10.7,59},{10.7,73.2},{16.8,73.2}},
      color={255,0,255},
      pattern=LinePattern.Dash));

  connect(nSet,nSetGreaterZero. u) annotation (Line(points={{-136,0},{-120,0},{-120,
          64},{-111.6,64}}, color={0,0,127}));
  connect(nSetGreaterZero.y, notSetOn.u) annotation (Line(points={{-93.2,64},{-78,
          64},{-78,77},{-67,77}}, color={255,0,255}));
  connect(pre1.y, andIsOn.u2) annotation (Line(points={{-71.4,-42},{-71.4,12},{-72,
          12},{-72,14},{-42,14},{-42,13.2},{14.8,13.2}},
                                      color={255,0,255}));
  connect(nSetGreaterZero.y, andIsOn.u1) annotation (Line(points={{-93.2,64},{-86,
          64},{-86,18},{14.8,18}},                             color={255,0,255}));
  connect(nOut, nOut)
    annotation (Line(points={{130,0},{130,0}}, color={0,0,127}));
  connect(swinOutnSet.y, nOut)
    annotation (Line(points={{111,0},{130,0}}, color={0,0,127}));
  connect(nSet, swinOutnSet.u1) annotation (Line(points={{-136,0},{-120,0},{
          -120,98},{78,98},{78,8},{88,8}},
                                        color={0,0,127}));
  connect(andTurnOff.y, andRun.u1) annotation (Line(points={{0.6,86},{8,86},{8,78},
          {16.8,78}}, color={255,0,255}));
  connect(orSetN.y, swinOutnSet.u2)
    annotation (Line(points={{73.5,0},{88,0}}, color={255,0,255}));
  connect(notSetOn.y, andIsOff.u1) annotation (Line(points={{-55.5,77},{-50,77},
          {-50,42},{16,42},{16,38},{14.8,38}}, color={255,0,255}));
  connect(andIsOff.y, orSetN.u[1]) annotation (Line(points={{28.6,38},{40,38},{40,
          5.25},{52,5.25}}, color={255,0,255}));
  connect(andIsOn.y, orSetN.u[2]) annotation (Line(points={{28.6,18},{38,18},{38,
          1.75},{52,1.75}}, color={255,0,255}));
  connect(andRun.y, orSetN.u[3]) annotation (Line(points={{30.6,78},{46,78},{46,
          -1.75},{52,-1.75}}, color={255,0,255}));
  connect(andLoc.y, andLocOff.u1) annotation (Line(points={{40.6,-60},{46,-60},{
          46,-72},{50.8,-72}}, color={255,0,255}));
  connect(andTurnOn.y, andLocOff.u2) annotation (Line(points={{40.6,-84},{46,-84},
          {46,-76.8},{50.8,-76.8}}, color={255,0,255}));
  connect(andLocOff.y, orSetN.u[4]) annotation (Line(points={{64.6,-72},{64.6,-32},
          {40,-32},{40,-5.25},{52,-5.25}}, color={255,0,255}));
  connect(notSetOn.y, andTurnOff.u2) annotation (Line(points={{-55.5,77},{-50,77},
          {-50,81.2},{-13.2,81.2}}, color={255,0,255}));
  connect(pre1.y, andTurnOff.u1) annotation (Line(points={{-71.4,-42},{-72,-42},
          {-72,86},{-13.2,86}}, color={255,0,255}));
  connect(nSetGreaterZero.y, andTurnOn.u2) annotation (Line(points={{-93.2,64},{
          -86,64},{-86,-98},{24,-98},{24,-88.8},{26.8,-88.8}}, color={255,0,255}));
  connect(notIsOn.y, andTurnOn.u1) annotation (Line(points={{-57.6,-18},{-56,-18},
          {-56,-96},{22,-96},{22,-84},{26.8,-84}}, color={255,0,255}));
  connect(notIsOn.y, andIsOff.u2) annotation (Line(points={{-57.6,-18},{-56,-18},
          {-56,33.2},{14.8,33.2}}, color={255,0,255}));
  connect(sigBusHP.N,nIsGreaterZero. u) annotation (Line(
      points={{-134.915,-68.925},{-134.915,-42},{-109.6,-42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.N, swinOutnSet.u3) annotation (Line(
      points={{-134.915,-68.925},{-134.915,-104},{78,-104},{78,-8},{88,-8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(booleanConstantLocTim.y, andLoc.u1) annotation (Line(
      points={{-19.3,-37},{6,-37},{6,-60},{26.8,-60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  annotation (Documentation(info="<html>
<p>Checks if the nSet value is legal by checking if the device can either be turned on or off, depending on which state it was in.</p>
<p>E.g. If it is turned on, and the new nSet value is 0, it will only turn off if current runtime is longer than the minimal runtime. Else it will keep the current rotating speed.</p>
</html>"),
    Diagram(coordinateSystem(extent={{-120,-120},{120,100}})),
    Icon(coordinateSystem(extent={{-120,-120},{120,100}}), graphics={
        Polygon(
          points={{-42,20},{0,62},{-42,20}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,-26},{48,66}},
          lineColor={0,0,0},
          fillColor={91,91,91},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,-14},{36,54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,20},{60,-80}},
          lineColor={0,0,0},
          fillColor={91,91,91},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-30},{10,-70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-14,-40},{16,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-104,100},{106,76}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="%name"),
        Rectangle(
          extent={{-120,100},{120,-100}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.None)}));
end OnOffControl;
