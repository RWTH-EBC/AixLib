within AixLib.Systems.EONERC_Testhall.Controller;
model ControlDHS
  BaseClass.DistributeBus distributeBus_DHS annotation (Placement(
        transformation(extent={{-114,-36},{-74,6}}), iconTransformation(extent=
            {{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=3000,
    k=0.002) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,68})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    n=2,
    f=0.05,
    x_start={0,0})
    annotation (Placement(transformation(extent={{62,-24},{42,-4}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));
  Modelica.Blocks.Continuous.LimPID PID_rpmSet(
    yMin=0,
    Td=0.5,
    yMax=4800,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=3000,
    k=0.2)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-64,72})));
  Modelica.Blocks.Sources.Constant dp_set(k=0.25e5)
    "probaby between 0.1e5 and 0.25e5"              annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-98,72})));
  Modelica.Blocks.Math.Feedback dp_act annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-64,44})));
  Modelica.Blocks.Math.Max maxTSupSet
    annotation (Placement(transformation(extent={{18,62},{30,74}})));
equation
  connect(PID_Valve.y, criticalDamping.u) annotation (Line(points={{73,68},{78,
          68},{78,-14},{64,-14}},
                                color={0,0,127}));
  connect(criticalDamping.y, distributeBus_DHS.bus_dhs.valveSet) annotation (
      Line(points={{41,-14},{-26.5,-14},{-26.5,-14.895},{-93.9,-14.895}},
                                                                   color={0,0,
          127}));
  connect(booleanExpression1.y, distributeBus_DHS.bus_dhs_pump.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
          255,0,255}));
  connect(PID_Valve.u_m, distributeBus_DHS.bus_dhs_pump.TFwrdOutMea)
    annotation (Line(points={{62,56},{62,6},{-26,6},{-26,-14.895},{-93.9,
          -14.895}}, color={0,0,127}));
  connect(dp_set.y, PID_rpmSet.u_s)
    annotation (Line(points={{-87,72},{-76,72}}, color={0,0,127}));
  connect(dp_act.y, PID_rpmSet.u_m)
    annotation (Line(points={{-64,49.4},{-64,60}}, color={0,0,127}));
  connect(dp_act.u1, distributeBus_DHS.bus_dhs_pump.p_sup) annotation (Line(
        points={{-64,39.2},{-64,-14.895},{-93.9,-14.895}}, color={0,0,127}));
  connect(dp_act.u2, distributeBus_DHS.bus_dhs_pump.p_ret) annotation (Line(
        points={{-68.8,44},{-93.9,44},{-93.9,-14.895}}, color={0,0,127}));
  connect(PID_rpmSet.y, distributeBus_DHS.bus_dhs_pump.pumpBus.rpmSet)
    annotation (Line(points={{-53,72},{-48,72},{-48,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(maxTSupSet.y, PID_Valve.u_s)
    annotation (Line(points={{30.6,68},{50,68}}, color={0,0,127}));
  connect(maxTSupSet.u1, distributeBus_DHS.bus_cph_throttle.T_sup_set)
    annotation (Line(points={{16.8,71.6},{16.8,72},{-28,72},{-28,-14.895},{
          -93.9,-14.895}}, color={0,0,127}));
  connect(maxTSupSet.u2, distributeBus_DHS.bus_cca.T_sup_set) annotation (Line(
        points={{16.8,64.4},{16.8,66},{-28,66},{-28,-14.895},{-93.9,-14.895}},
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
           false)),
    experiment(
      StopTime=400000,
      __Dymola_NumberOfIntervals=200,
      __Dymola_Algorithm="Dassl"));
end ControlDHS;
