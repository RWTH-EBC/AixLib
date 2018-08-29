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
equation
  connect(boundaryMap.ERR,swiErr.u2)
    annotation (Line(points={{-1.36364,-3},{42,-3},{42,0},{84,0}},
                                               color={255,0,255}));
  connect(nSet,swiErr.u1)  annotation (Line(points={{-136,20},{32,20},{32,8},{
          84,8}}, color={0,0,127}));
  connect(booConOpeEnv.y, swiErr.u2) annotation (Line(
      points={{24.7,-29},{24.7,-28},{42,-28},{42,0},{84,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(sigBusHP.T_ret_co, boundaryMap.y_in) annotation (Line(
      points={{-134.915,-68.925},{-97.5,-68.925},{-97.5,-18},{-60.4182,-18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_flow_ev, boundaryMap.x_in) annotation (Line(
      points={{-134.915,-68.925},{-134.915,-70},{-98,-70},{-98,12},{-60.4182,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));

  connect(modeSet, modeOut) annotation (Line(points={{-136,-20},{-114,-20},{
          -114,-92},{114,-92},{114,-20},{130,-20}}, color={255,0,255}));
end OperationalEnvelope;
