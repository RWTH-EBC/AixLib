within AixLib.Systems.EONERC_Testhall.Controller;
model ControlJN
  .Testhall.BaseClass.DistributeBus distributeBus_JN annotation (Placement(
        transformation(extent={{-100,18},{-60,60}}), iconTransformation(extent=
            {{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_AirValve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1500,
    k=0.02)  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={6,4})));
  Modelica.Blocks.Sources.Constant RoomTemp_set(k=20 + 273.15) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={44,4})));
equation
  connect(RoomTemp_set.y, PID_AirValve.u_s)
    annotation (Line(points={{33,4},{18,4}},    color={0,0,127}));
  connect(PID_AirValve.y, distributeBus_JN.bus_jn.valveSet) annotation (Line(
        points={{-5,4},{-79.9,4},{-79.9,39.105}}, color={0,0,127}));
  connect(PID_AirValve.u_m, distributeBus_JN.bus_jn.TempHall) annotation (Line(
        points={{6,-8},{6,-14},{-79.9,-14},{-79.9,39.105}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{20,100},{100,0},{20,-100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}), Diagram(coordinateSystem(preserveAspectRatio=
           false)));
end ControlJN;
