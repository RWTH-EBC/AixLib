within AixLib.Systems.EONERC_Testhall.BaseClasses.Control;
model ControlDHS
  .Testhall.BaseClass.DistributeBus distributeBus_DHS annotation (Placement(
        transformation(extent={{-114,-36},{-74,6}}), iconTransformation(extent=
            {{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_pump(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=4800,
    Ti=1,
    k=20) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-44,72})));
  Modelica.Blocks.Sources.Constant T_Set_SupPrim(k=50 + 273.15) annotation (
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
    k=0.003) annotation (Placement(transformation(
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
  Modelica.Blocks.Sources.Constant m_flow_set(k=4.2) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-12,72})));
equation
  connect(PID_Valve.u_s, T_Set_SupPrim.y)
    annotation (Line(points={{50,68},{33,68}}, color={0,0,127}));
  connect(PID_Valve.y, criticalDamping.u) annotation (Line(points={{73,68},{84,
          68},{84,24},{28,24}}, color={0,0,127}));
  connect(criticalDamping.y, distributeBus_DHS.bus_dhs.valveSet) annotation (
      Line(points={{5,24},{-22,24},{-22,-14.895},{-93.9,-14.895}}, color={0,0,
          127}));
  connect(PID_pump.y, distributeBus_DHS.bus_dhs_pump.pumpBus.rpmSet)
    annotation (Line(points={{-55,72},{-68,72},{-68,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(booleanExpression1.y, distributeBus_DHS.bus_dhs_pump.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
          255,0,255}));
  connect(m_flow_set.y, PID_pump.u_s)
    annotation (Line(points={{-23,72},{-32,72}}, color={0,0,127}));
  connect(PID_pump.u_m, distributeBus_DHS.bus_dhs.mFlow) annotation (Line(
        points={{-44,60},{-44,-14.895},{-93.9,-14.895}}, color={0,0,127}));
  connect(PID_Valve.u_m, distributeBus_DHS.bus_dhs.T_RL) annotation (Line(
        points={{62,56},{62,38},{-42,38},{-42,-14.895},{-93.9,-14.895}}, color=
          {0,0,127}));
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
end ControlDHS;
