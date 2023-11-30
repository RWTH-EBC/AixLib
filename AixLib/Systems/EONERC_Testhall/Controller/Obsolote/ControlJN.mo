within AixLib.Systems.EONERC_Testhall.Controller.Obsolote;
model ControlJN
  BaseClass.DistributeBus distributeBus_JN annotation (Placement(transformation(
          extent={{-100,18},{-60,60}}), iconTransformation(extent={{78,-22},{
            118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_AirValve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1000,
    k=0.001) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={6,-36})));
  Modelica.Blocks.Sources.Constant RoomTemp_set(k=20 + 273.15) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={44,-36})));
  Modelica.Blocks.Sources.Constant T_Set_Hall_Circ(k=70 + 273.15) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={84,82})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=250,
    k=0.1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={44,82})));
  Modelica.Blocks.Continuous.LimPID PID_m_flow(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=4350,
    Ti=1,
    k=30) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-20,16})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=0.4)  annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={36,16})));
equation
  connect(RoomTemp_set.y, PID_AirValve.u_s)
    annotation (Line(points={{33,-36},{18,-36}},color={0,0,127}));
  connect(PID_AirValve.y, distributeBus_JN.bus_jn.Hall_AirValve) annotation (
      Line(points={{-5,-36},{-56,-36},{-56,39.105},{-79.9,39.105}}, color={0,0,
          127}));
  connect(PID_Valve.u_s,T_Set_Hall_Circ. y)
    annotation (Line(points={{56,82},{73,82}}, color={0,0,127}));
  connect(PID_Valve.y, distributeBus_JN.bus_jn.valveSet) annotation (Line(
        points={{33,82},{-79.9,82},{-79.9,39.105}},             color={0,0,127}));
  connect(PID_Valve.u_m, distributeBus_JN.bus_jn.TFwrdOutMea) annotation (Line(
        points={{44,70},{44,39.105},{-79.9,39.105}},
                                                   color={0,0,127}));
  connect(PID_AirValve.u_m, distributeBus_JN.bus_jn.TempHall) annotation (Line(
        points={{6,-48},{6,-54},{-79.9,-54},{-79.9,39.105}}, color={0,0,127}));
  connect(m_flow_set.y, PID_m_flow.u_s)
    annotation (Line(points={{25,16},{-8,16}}, color={0,0,127}));
  connect(PID_m_flow.y, distributeBus_JN.bus_jn.pumpBus.rpmSet) annotation (
      Line(points={{-31,16},{-54,16},{-54,39.105},{-79.9,39.105}}, color={0,0,
          127}));
  connect(PID_m_flow.u_m, distributeBus_JN.bus_jn.mflow) annotation (Line(
        points={{-20,4},{-20,-2},{-79.9,-2},{-79.9,39.105}}, color={0,0,127}));
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
