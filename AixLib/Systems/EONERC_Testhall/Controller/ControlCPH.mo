within AixLib.Systems.EONERC_Testhall.Controller;
model ControlCPH
  BaseClasses.DistributeBus distributeBus_CPH annotation (Placement(
        transformation(extent={{-114,-36},{-74,6}}), iconTransformation(
          extent={{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_cph_m_flow(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=2540,
    Ti=1,
    k=20)    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-38,64})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=0.23) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,64})));
  Modelica.Blocks.Sources.Constant T_Set_Hall_Circ(k=45 + 273.15) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,68})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=2000,
    k=0.1)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,68})));
  Modelica.Blocks.Sources.Constant Set_ValveThrottle(k=0.655)
                                                          annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-2,-60})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    n=2,
    f=0.05,
    x_start={0,0})
    annotation (Placement(transformation(extent={{26,14},{6,34}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));
equation
  connect(PID_cph_m_flow.y, distributeBus_CPH.bus_cph.pumpBus.rpmSet)
    annotation (Line(points={{-27,64},{-6,64},{-6,-14.895},{-93.9,-14.895}},
                                                                          color=
         {0,0,127}));
  connect(m_flow_set.y, PID_cph_m_flow.u_s)
    annotation (Line(points={{-77,64},{-50,64}}, color={0,0,127}));
  connect(PID_Valve.u_s, T_Set_Hall_Circ.y)
    annotation (Line(points={{50,68},{33,68}}, color={0,0,127}));
  connect(PID_Valve.u_m, distributeBus_CPH.bus_cph.TFwrdOutMea) annotation (
      Line(points={{62,56},{62,44},{-74,44},{-74,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(criticalDamping.y, distributeBus_CPH.bus_cph.valveSet) annotation (
      Line(points={{5,24},{-6,24},{-6,-14.895},{-93.9,-14.895}},
                                                              color={0,0,127}));
  connect(booleanExpression1.y, distributeBus_CPH.bus_cph.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
          255,0,255}));
  connect(PID_Valve.y, criticalDamping.u) annotation (Line(points={{73,68},{84,
          68},{84,24},{28,24}}, color={0,0,127}));
  connect(Set_ValveThrottle.y, distributeBus_CPH.bus_cph_throttle.valveSet)
    annotation (Line(points={{-13,-60},{-93.9,-60},{-93.9,-14.895}}, color={0,0,
          127}));
  connect(PID_cph_m_flow.u_m, distributeBus_CPH.bus_cph.mflow) annotation (Line(
        points={{-38,52},{-38,-16},{-93.9,-16},{-93.9,-14.895}}, color={0,0,127}));
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
end ControlCPH;
