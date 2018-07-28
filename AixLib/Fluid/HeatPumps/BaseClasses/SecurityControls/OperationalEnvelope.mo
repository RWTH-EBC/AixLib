within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls;
block OperationalEnvelope
  "Block which computes an error if the current values are outside of the given operatinal envelope"
  extends BaseClasses.PartialSecurityControl;
  BaseClasses.BoundaryMap boundaryMap(
    xMax=30,
    xMin=-15,
    tableLow=[-15,0; 30,0],
    tableUpp=[-15,55; 5,60; 30,60])
    annotation (Placement(transformation(extent={{-54,-22},{-4,22}})));
equation
  connect(boundaryMap.ERR,swiErr.u2)
    annotation (Line(points={{-1.5,0},{84,0}}, color={255,0,255}));
  connect(nSet,swiErr.u1)  annotation (Line(points={{-135,37},{40,37},{40,8},{
          84,8}}, color={0,0,127}));
  connect(boundaryMap.x_in, heatPumpControlBus.T_flow_ev) annotation (Line(
        points={{-57.5,13.2},{-95.75,13.2},{-95.75,-26.925},{-136.915,-26.925}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundaryMap.y_in, heatPumpControlBus.T_ret_co) annotation (Line(
        points={{-57.5,-13.2},{-96,-13.2},{-96,-26.925},{-136.915,-26.925}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
end OperationalEnvelope;
