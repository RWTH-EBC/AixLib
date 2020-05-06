within AixLib.Controls.HeatPump.SecurityControls;
model AntiFreeze "Model to prevent source from freezing"
  extends BaseClasses.PartialSecurityControl;

  parameter Boolean use_antFre=true
    "True if anti freeze control is part of security control" annotation(choices(checkBox=true));
  parameter Modelica.SIunits.ThermodynamicTemperature TAntFre=276.15
    "Limit temperature for anti freeze control"
    annotation (Dialog(enable=use_antFre));
  parameter Real dTHys=2
    "Hysteresis interval width";
  Modelica.Blocks.Sources.BooleanConstant booConAntFre(final k=true) if not
    use_antFre
    annotation (Placement(transformation(extent={{2,-36},{16,-22}})));
  Modelica.Blocks.Logical.Hysteresis       hysteresis(
    final uLow=TAntFre,
    final pre_y_start=true,
    final uHigh=TAntFre + dTHys) if
       use_antFre
    annotation (Placement(transformation(extent={{-62,-18},{-38,6}})));
                           //assume that the initial temperature is high enough.
  Modelica.Blocks.Math.Min min if use_antFre
    annotation (Placement(transformation(extent={{-104,-24},{-84,-4}})));

equation
  connect(nSet,swiErr.u1)  annotation (Line(points={{-136,20},{32,20},{32,8},{84,
          8}},    color={0,0,127}));
  connect(booConAntFre.y, swiErr.u2) annotation (Line(
      points={{16.7,-29},{16.7,-28},{42,-28},{42,0},{84,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(hysteresis.y, swiErr.u2) annotation (Line(
      points={{-36.8,-6},{6,-6},{6,0},{84,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(modeSet, modeOut) annotation (Line(points={{-136,-20},{-114,-20},{
          -114,-64},{96,-64},{96,-20},{130,-20}}, color={255,0,255}));
  connect(min.y, hysteresis.u) annotation (Line(points={{-83,-14},{-72,-14},{-72,
          -6},{-64.4,-6}}, color={0,0,127}));
  connect(sigBusHP.T_flow_co, min.u1) annotation (Line(
      points={{-134.915,-68.925},{-134.915,-38},{-112,-38},{-112,-8},{-106,-8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));

  connect(sigBusHP.T_ret_ev, min.u2) annotation (Line(
      points={{-134.915,-68.925},{-134.915,-38},{-112,-38},{-112,-20},{-106,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(hysteresis.y, not1.u) annotation (Line(points={{-36.8,-6},{-21,-6},{-21,
          -63}}, color={255,0,255}));
  connect(booConAntFre.y, not1.u) annotation (Line(points={{16.7,-29},{36,-29},
          {36,-56},{-22,-56},{-22,-60},{-21,-63}}, color={255,0,255}));
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This models takes the minimum of the two temperatures evaporator
  outlet and condenser inlet. If this minimal temperature falls below
  the given lower boundary, the hystereses will trigger an error and
  cause the device to switch off.
</p>
<h4>
  Assumptions
</h4>
<p>
  Assuming that the outlet temperature of an evaporator is always lower
  than the inlet temperature(for the condenser vice versa).
</p>
</html>"));
end AntiFreeze;
