within AixLib.Controls.HeatPump.SecurityControls;
model AntiFreeze "Model to prevent source from freezing"
  extends BaseClasses.PartialSecurityControl;

  parameter Boolean use_antFre=true
    "True if anti freeze control is part of security control" annotation(choices(checkBox=true));
  parameter Modelica.SIunits.ThermodynamicTemperature TAntFre=276.15
    "Limit temperature for anti freeze control"
    annotation (Dialog(enable=use_antFre));
  Modelica.Blocks.Sources.BooleanConstant booConAntFre(final k=true) if not
    use_antFre
    annotation (Placement(transformation(extent={{2,-36},{16,-22}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(final threshold=TAntFre) if
       use_antFre
    annotation (Placement(transformation(extent={{-62,-20},{-36,6}})));
  Modelica.Blocks.Math.Min min if use_antFre
    annotation (Placement(transformation(extent={{-98,-24},{-78,-4}})));
equation
  connect(nSet,swiErr.u1)  annotation (Line(points={{-136,20},{32,20},{32,8},{84,
          8}},    color={0,0,127}));
  connect(booConAntFre.y, swiErr.u2) annotation (Line(
      points={{16.7,-29},{16.7,-28},{42,-28},{42,0},{84,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(greaterThreshold.y, swiErr.u2) annotation (Line(
      points={{-34.7,-7},{6,-7},{6,0},{84,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(modeSet, modeOut) annotation (Line(points={{-136,-20},{-114,-20},{
          -114,-64},{96,-64},{96,-20},{130,-20}}, color={255,0,255}));
  connect(min.y, greaterThreshold.u) annotation (Line(points={{-77,-14},{-72,
          -14},{-72,-7},{-64.6,-7}}, color={0,0,127}));
  connect(sigBusHP.T_flow_co, min.u1) annotation (Line(
      points={{-134.915,-68.925},{-134.915,-38},{-112,-38},{-112,-8},{-100,-8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));

  connect(sigBusHP.T_ret_ev, min.u2) annotation (Line(
      points={{-134.915,-68.925},{-134.915,-38},{-112,-38},{-112,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(greaterThreshold.y, not1.u) annotation (Line(points={{-34.7,-7},{-21,
          -7},{-21,-63}}, color={255,0,255}));
  connect(booConAntFre.y, not1.u) annotation (Line(points={{16.7,-29},{36,-29},
          {36,-56},{-22,-56},{-22,-60},{-21,-63}}, color={255,0,255}));
end AntiFreeze;
