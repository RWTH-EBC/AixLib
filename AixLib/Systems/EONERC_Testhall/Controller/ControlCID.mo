within AixLib.Systems.EONERC_Testhall.Controller;
model ControlCID
  BaseClass.DistributeBus distributeBus_CID annotation (Placement(
        transformation(extent={{-114,-36},{-74,6}}), iconTransformation(extent=
            {{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_cid_m_flow(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=3040,
    Ti=1,
    k=20)    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-38,64})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=0.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,64})));
  Modelica.Blocks.Sources.Constant T_Set_Hall_Circ(k=50 + 273.15) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,68})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=100,
    k=0.05)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,68})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    n=2,
    f=0.05,
    x_start={0,0})
    annotation (Placement(transformation(extent={{26,14},{6,34}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));
  Modelica.Blocks.Continuous.LimPID PID_AirValve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1000,
    k=0.1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-8,-50})));
  Modelica.Blocks.Sources.Constant RoomTemp_set(k=20 + 273.15) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-50})));
equation
  connect(m_flow_set.y,PID_cid_m_flow. u_s)
    annotation (Line(points={{-77,64},{-50,64}}, color={0,0,127}));
  connect(PID_Valve.u_s, T_Set_Hall_Circ.y)
    annotation (Line(points={{50,68},{33,68}}, color={0,0,127}));
  connect(PID_Valve.y, criticalDamping.u) annotation (Line(points={{73,68},{84,
          68},{84,24},{28,24}}, color={0,0,127}));
  connect(PID_cid_m_flow.y, distributeBus_CID.bus_cid.pumpBus.rpmSet)
    annotation (Line(points={{-27,64},{-22,64},{-22,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(booleanExpression1.y, distributeBus_CID.bus_cid.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
          255,0,255}));
  connect(PID_Valve.u_m, distributeBus_CID.bus_cid.TFwrdOutMea) annotation (
      Line(points={{62,56},{62,44},{-22,44},{-22,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(criticalDamping.y, distributeBus_CID.bus_cid.valveSet) annotation (
      Line(points={{5,24},{-22,24},{-22,-14.895},{-93.9,-14.895}}, color={0,0,
          127}));
  connect(RoomTemp_set.y, PID_AirValve.u_s)
    annotation (Line(points={{19,-50},{4,-50}}, color={0,0,127}));
  connect(PID_cid_m_flow.u_m, distributeBus_CID.bus_cid.mflow) annotation (Line(
        points={{-38,52},{-38,-14.895},{-93.9,-14.895}}, color={0,0,127}));
  connect(PID_AirValve.u_m, distributeBus_CID.bus_cid.RoomTemp) annotation (
      Line(points={{-8,-62},{-8,-68},{-68,-68},{-68,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(PID_AirValve.y, distributeBus_CID.bus_cid.Office_Air_Valve)
    annotation (Line(points={{-19,-50},{-68,-50},{-68,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
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
end ControlCID;
