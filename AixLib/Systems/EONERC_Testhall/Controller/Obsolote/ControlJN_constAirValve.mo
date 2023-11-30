within AixLib.Systems.EONERC_Testhall.Controller.Obsolote;
model ControlJN_constAirValve
  BaseClass.DistributeBus distributeBus_JN annotation (Placement(transformation(
          extent={{-64,-18},{-24,24}}), iconTransformation(extent={{78,-22},{
            118,20}})));
  Modelica.Blocks.Sources.Constant AirValve_Set(k=1)           annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={38,-30})));
  Modelica.Blocks.Sources.Constant T_Set_Hall_Circ(k=50 + 273.15) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={76,28})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=250,
    k=0.001) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={36,28})));
equation
  connect(AirValve_Set.y, distributeBus_JN.bus_jn.Hall_AirValve) annotation (
      Line(points={{27,-30},{-43.9,-30},{-43.9,3.105}}, color={0,0,127}));
  connect(PID_Valve.u_s,T_Set_Hall_Circ. y)
    annotation (Line(points={{48,28},{65,28}}, color={0,0,127}));
  connect(PID_Valve.y, distributeBus_JN.bus_jn.valveSet) annotation (Line(
        points={{25,28},{-43.9,28},{-43.9,3.105}},           color={0,0,127}));
  connect(PID_Valve.u_m, distributeBus_JN.bus_jn.TFwrdOutMea) annotation (Line(
        points={{36,16},{36,3.105},{-43.9,3.105}}, color={0,0,127}));
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
end ControlJN_constAirValve;
