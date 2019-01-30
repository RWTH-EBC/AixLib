within AixLib.Controls.HeatPump.SecurityControls;
block OperationalEnvelope
  "Block which computes an error if the current values are outside of the given operatinal envelope"
  extends BaseClasses.PartialSecurityControl;
  parameter Boolean use_opeEnv
    "False to allow HP to run out of operational envelope" annotation(choices(checkBox=true));
  parameter Boolean use_opeEnvFroRec=true
    "Use a the operational envelope given in the datasheet" annotation(choices(checkBox=true), Dialog(
        enable=use_opeEnv, descriptionLabel=true));
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable
    "Data Table of HP" annotation (choicesAllMatching = true,Dialog(enable=use_opeEnvFroRec and use_opeEnv));
  parameter Real tableLow[:,2] "Lower boundary of envelope"
    annotation (Dialog(enable=use_opeEnv and not use_opeEnvFroRec));
  parameter Real tableUpp[:,2] "Upper boundary of envelope" annotation (Dialog(enable=use_opeEnv and not use_opeEnvFroRec));
  Modelica.Blocks.Math.UnitConversions.To_degC toDegCT_ret_co annotation (
      extent=[-88,38; -76,50], Placement(transformation(extent={{-82,-24},{
            -70,-12}})));
  Modelica.Blocks.Math.UnitConversions.To_degC toDegCT_flow_ev annotation (
      extent=[-88,38; -76,50], Placement(transformation(extent={{-82,6},{-70,
            18}})));
  BaseClasses.BoundaryMap boundaryMap(final tableLow=tableLow, final tableUpp=
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
  connect(sigBusHP.T_flow_ev, toDegCT_flow_ev.u) annotation (Line(
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
  connect(sigBusHP.T_ret_co, toDegCT_ret_co.u) annotation (Line(
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
        coordinateSystem(extent={{-120,-100},{120,100}})));
end OperationalEnvelope;
