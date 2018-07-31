within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls;
block OperationalEnvelope
  "Block which computes an error if the current values are outside of the given operatinal envelope"
  extends BaseClasses.PartialSecurityControl;
  final parameter Boolean useOpeEnv
    "False to allow HP to run out of operational envelope";
  BaseClasses.BoundaryMap boundaryMap(
    tableLow=[-15,0; 30,0],
    tableUpp=[-15,55; 5,60; 30,60]) if useOpeEnv
    annotation (Placement(transformation(extent={{-62,-28},{-4,22}})));
  Modelica.Blocks.Sources.BooleanConstant booConOpeEnv(final k=true) if not useOpeEnv
    annotation (Placement(transformation(extent={{10,-36},{24,-22}})));

equation
  connect(boundaryMap.ERR,swiErr.u2)
    annotation (Line(points={{-1.36364,-3},{42,-3},{42,0},{84,0}},
                                               color={255,0,255}));
  connect(nSet,swiErr.u1)  annotation (Line(points={{-136,0},{40,0},{40,8},{84,8}},
                  color={0,0,127}));
  connect(boundaryMap.x_in, heatPumpControlBus.T_flow_ev) annotation (Line(
        points={{-60.4182,12},{-95.75,12},{-95.75,-68.925},{-134.915,-68.925}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundaryMap.y_in, heatPumpControlBus.T_ret_co) annotation (Line(
        points={{-60.4182,-18},{-96,-18},{-96,-68.925},{-134.915,-68.925}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(booConOpeEnv.y, swiErr.u2) annotation (Line(
      points={{24.7,-29},{24.7,-28},{42,-28},{42,0},{84,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
end OperationalEnvelope;
