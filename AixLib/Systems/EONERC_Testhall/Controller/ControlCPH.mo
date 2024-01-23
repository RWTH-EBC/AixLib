within AixLib.Systems.EONERC_Testhall.Controller;
model ControlCPH


  Subsystems.BaseClasses.HallHydraulicBus distributeBus_CPH annotation (
      Placement(transformation(extent={{-114,-36},{-74,6}}), iconTransformation(
          extent={{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=250,
    k=0.01)  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,68})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));

  Modelica.Blocks.Sources.Constant n_const(k=0.6*4250) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-44,32})));
  Modelica.Blocks.Sources.Constant ThrottSet(k=0.665) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={20,-60})));
  HeatCurve heatCurve(x=-1.481, b=60)
    annotation (Placement(transformation(extent={{82,54},{62,74}})));
  Modelica.Blocks.Interfaces.RealInput T_amb
    annotation (Placement(transformation(extent={{130,44},{90,84}}),
        iconTransformation(extent={{-124,-20},{-84,20}})));
equation
  connect(booleanExpression1.y, distributeBus_CPH.bus_cph.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
          255,0,255}));
  connect(PID_Valve.y, distributeBus_CPH.bus_cph.valveSet) annotation (Line(
        points={{19,68},{6,68},{6,-14.895},{-93.9,-14.895}},   color={0,0,127}));
  connect(n_const.y, distributeBus_CPH.bus_cph.pumpBus.rpmSet) annotation (Line(
        points={{-55,32},{-68,32},{-68,-14.895},{-93.9,-14.895}},
                                                      color={0,0,127}));
  connect(PID_Valve.u_m, distributeBus_CPH.bus_cph_throttle.TFwrdOutMea)
    annotation (Line(points={{30,56},{30,-14.895},{-93.9,-14.895}}, color={0,0,
          127}));
  connect(ThrottSet.y, distributeBus_CPH.bus_cph_throttle.valveSet) annotation (
     Line(points={{9,-60},{-93.9,-60},{-93.9,-14.895}}, color={0,0,127}));
  connect(heatCurve.T_sup, PID_Valve.u_s)
    annotation (Line(points={{80,75.4},{52,75.4},{52,68},{42,68}},
                                                 color={0,0,127}));
  connect(T_amb,heatCurve. T_amb)
    annotation (Line(points={{110,64},{98,64},{98,56},{84,56}},
                                                color={0,0,127}));
  connect(heatCurve.T_sup, distributeBus_CPH.bus_cph_throttle.T_sup_set)
    annotation (Line(points={{80,75.4},{50,75.4},{50,-14.895},{-93.9,-14.895}},
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
end ControlCPH;
