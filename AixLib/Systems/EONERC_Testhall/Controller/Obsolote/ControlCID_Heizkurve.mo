within AixLib.Systems.EONERC_Testhall.Controller.Obsolote;
model ControlCID_Heizkurve
  "Information out of Unterlagen\\Heizlastberechnung\\Heizkurve_BKT"
  BaseClass.DistributeBus distributeBus_CID annotation (Placement(
        transformation(extent={{-138,-36},{-98,6}}), iconTransformation(extent=
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
        origin={-62,64})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=0.09) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-112,64})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));
  Modelica.Blocks.Continuous.LimPID PID_AirValve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=2000,
    k=0.01)  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-6,-50})));
  Modelica.Blocks.Sources.Constant RoomTemp_set(k=20 + 273.15) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-50})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    Ti=2000,
    k=0.001) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-10,42})));
  HeatCurve heatCurve(x=-1.7935, b=58.16)
    annotation (Placement(transformation(extent={{40,32},{20,52}})));
  Modelica.Blocks.Interfaces.RealInput T_amb
    annotation (Placement(transformation(extent={{186,18},{146,58}}),
        iconTransformation(extent={{-112,-20},{-72,20}})));
equation
  connect(m_flow_set.y,PID_cid_m_flow. u_s)
    annotation (Line(points={{-101,64},{-74,64}},color={0,0,127}));
  connect(PID_cid_m_flow.y, distributeBus_CID.bus_cid.pumpBus.rpmSet)
    annotation (Line(points={{-51,64},{-46,64},{-46,-14.895},{-117.9,-14.895}},
        color={0,0,127}));
  connect(booleanExpression1.y, distributeBus_CID.bus_cid.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-117.9,-14.895}},color={
          255,0,255}));
  connect(RoomTemp_set.y, PID_AirValve.u_s)
    annotation (Line(points={{19,-50},{6,-50}}, color={0,0,127}));
  connect(PID_cid_m_flow.u_m, distributeBus_CID.bus_cid.mflow) annotation (Line(
        points={{-62,52},{-62,-14.895},{-117.9,-14.895}},color={0,0,127}));
  connect(PID_AirValve.u_m, distributeBus_CID.bus_cid.RoomTemp) annotation (
      Line(points={{-6,-62},{-6,-68},{-92,-68},{-92,-14.895},{-117.9,-14.895}},
        color={0,0,127}));
  connect(PID_AirValve.y, distributeBus_CID.bus_cid.Office_Air_Valve)
    annotation (Line(points={{-17,-50},{-92,-50},{-92,-14.895},{-117.9,-14.895}},
        color={0,0,127}));
  connect(PID_Valve.y, distributeBus_CID.bus_cid.valveSet) annotation (Line(
        points={{-21,42},{-30,42},{-30,-14.895},{-117.9,-14.895}},
                                                              color={0,0,127}));
  connect(PID_Valve.u_m, distributeBus_CID.bus_cid.TFwrdOutMea) annotation (
      Line(points={{-10,54},{-10,62},{-30,62},{-30,-14.895},{-117.9,-14.895}},
                                                                          color=
         {0,0,127}));
  connect(heatCurve.T_sup, PID_Valve.u_s)
    annotation (Line(points={{19.2,42},{2,42}}, color={0,0,127}));
  connect(heatCurve.T_amb, T_amb) annotation (Line(points={{42,42},{53,42},{53,
          38},{166,38}},
                    color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {160,120}}),                                        graphics={
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
           false, extent={{-140,-140},{160,120}})));
end ControlCID_Heizkurve;
