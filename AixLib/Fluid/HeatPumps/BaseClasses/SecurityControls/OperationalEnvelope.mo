within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls;
block OperationalEnvelope
  "Block which computes an error if the current values are outside of the given operatinal envelope"
  extends BaseClasses.PartialSecurityControl;
  parameter Boolean useOpeEnv
    "False to allow HP to run out of operational envelope";
  BaseClasses.BoundaryMap boundaryMap(final tableLow=tableLow, final tableUpp=
        tableUpp) if                   useOpeEnv
    annotation (Placement(transformation(extent={{-62,-28},{-4,22}})));
  Modelica.Blocks.Sources.BooleanConstant booConOpeEnv(final k=true) if not useOpeEnv
    annotation (Placement(transformation(extent={{10,-36},{24,-22}})));

  parameter Real tableLow[:,2]=[-15,0; 30,0] "Lower boundary of envelope";
  parameter Real tableUpp[:,2]=[-15,55; 5,60; 30,60]
    "Upper boundary of envelope";
  Modelica.Blocks.Math.UnitConversions.To_degC toDegCT_ret_co annotation (
      extent=[-88,38; -76,50], Placement(transformation(extent={{-82,-24},{-70,
            -12}})));
  Modelica.Blocks.Math.UnitConversions.To_degC toDegCT_flow_ev annotation (
      extent=[-88,38; -76,50], Placement(transformation(extent={{-82,6},{-70,18}})));
equation
  connect(boundaryMap.noErr, swiErr.u2) annotation (Line(points={{-1.36364,-3},
          {42,-3},{42,0},{84,0}}, color={255,0,255}));
  connect(nSet,swiErr.u1)  annotation (Line(points={{-136,20},{32,20},{32,8},{
          84,8}}, color={0,0,127}));
  connect(booConOpeEnv.y, swiErr.u2) annotation (Line(
      points={{24.7,-29},{24.7,-28},{42,-28},{42,0},{84,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));

  connect(modeSet, modeOut) annotation (Line(points={{-136,-20},{-114,-20},{
          -114,-92},{114,-92},{114,-20},{130,-20}}, color={255,0,255}));
  connect(sigBusHP.T_flow_ev, toDegCT_flow_ev.u) annotation (Line(
      points={{-134.915,-68.925},{-98,-68.925},{-98,12},{-83.2,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundaryMap.x_in, toDegCT_flow_ev.y)
    annotation (Line(points={{-60.4182,12},{-69.4,12}}, color={0,0,127}));
  connect(boundaryMap.y_in, toDegCT_ret_co.y)
    annotation (Line(points={{-60.4182,-18},{-69.4,-18}}, color={0,0,127}));
  connect(sigBusHP.T_ret_co, toDegCT_ret_co.u) annotation (Line(
      points={{-134.915,-68.925},{-98,-68.925},{-98,-18},{-83.2,-18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
end OperationalEnvelope;
