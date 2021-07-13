within AixLib.Controls.HeatPump.SafetyControls;
block OperationalEnvelope
  "Block which computes an error if the current values are outside of the given operatinal envelope"
  extends BaseClasses.PartialSafetyControl;
  extends BaseClasses.BoundaryMapIcon(final iconMin=-70,
  final iconMax=70);
 parameter Boolean use_opeEnv
  "False to allow HP to run out of operational envelope" annotation(choices(checkBox=true));

    Modelica.Blocks.Math.UnitConversions.To_degC toDegCT_ret_co annotation (
      extent=[-88,38; -76,50], Placement(transformation(extent={{-82,-24},{
            -70,-12}})));
  Modelica.Blocks.Math.UnitConversions.To_degC toDegCT_flow_ev annotation (
      extent=[-88,38; -76,50], Placement(transformation(extent={{-82,6},{-70,
            18}})));
  BaseClasses.BoundaryMap boundaryMap(                         final tableUpp=
        tableUpp,
    final use_opeEnvFroRec=use_opeEnvFroRec,
    final dataTable=dataTable) if
                     use_opeEnv
    annotation (Placement(transformation(extent={{-62,-28},{-4,22}})));
  Modelica.Blocks.Sources.BooleanConstant booConOpeEnv(final k=true) if not
    use_opeEnv
    annotation (Placement(transformation(extent={{10,-36},{24,-22}})));

equation
  connect(boundaryMap.noErr, swiErr.u2) annotation (Line(points={{-1.1,-3},{42,
          -3},{42,0},{84,0}},     color={255,0,255}));
  connect(nSet,swiErr.u1)  annotation (Line(points={{-136,20},{32,20},{32,8},
          {84,8}},color={0,0,127}));
  connect(booConOpeEnv.y, swiErr.u2) annotation (Line(
      points={{24.7,-29},{24.7,-28},{42,-28},{42,0},{84,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));

  connect(modeSet, modeOut) annotation (Line(points={{-136,-20},{-114,-20},{
          -114,-92},{114,-92},{114,-20},{130,-20}}, color={255,0,255}));
  connect(sigBusHP.TEvaInMea, toDegCT_flow_ev.u) annotation (Line(
      points={{-134.915,-68.925},{-98,-68.925},{-98,12},{-83.2,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundaryMap.x_in, toDegCT_flow_ev.y)
    annotation (Line(points={{-66.06,12},{-69.4,12}},   color={0,0,127}));
  connect(boundaryMap.y_in, toDegCT_ret_co.y)
    annotation (Line(points={{-66.06,-18},{-69.4,-18}},   color={0,0,127}));
  connect(sigBusHP.TConOutMea, toDegCT_ret_co.u) annotation (Line(
      points={{-134.915,-68.925},{-98,-68.925},{-98,-18},{-83.2,-18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundaryMap.noErr, not1.u) annotation (Line(points={{-1.1,-3},{42,-3},
          {42,-56},{-21,-56},{-21,-63}}, color={255,0,255}));
  connect(booConOpeEnv.y, not1.u) annotation (Line(points={{24.7,-29},{42,-29},
          {42,-56},{-21,-56},{-21,-63}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(extent={{-120,-100},{120,100}})), Icon(
        coordinateSystem(extent={{-120,-100},{120,100}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Model for checking if the given condenser return temperature and
  evaporator inlet temperature are in the given boundaries. If not, the
  heat pump will switch off.
</p>
</html>"));
end OperationalEnvelope;
