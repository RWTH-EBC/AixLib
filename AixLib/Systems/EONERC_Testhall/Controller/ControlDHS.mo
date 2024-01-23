within AixLib.Systems.EONERC_Testhall.Controller;
model ControlDHS
  Subsystems.BaseClasses.HallHydraulicBus distributeBus_DHS annotation (
      Placement(transformation(extent={{80,-20},{120,20}}), iconTransformation(
          extent={{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=Ti_valve,
    k=k_valve)
             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,70})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
  Modelica.Blocks.Continuous.LimPID PID_rpmSet(
    yMin=0,
    Td=0.5,
    yMax=4800,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=Ti_pump,
    k=k_pump)
             annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={0,-70})));
  Modelica.Blocks.Sources.Constant dp_set(k=0.25e5)
    "probaby between 0.1e5 and 0.25e5"              annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-70})));
  Modelica.Blocks.Math.Feedback dp_act annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-30})));
  Modelica.Blocks.Math.Max maxTSupSet
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  parameter Real k_valve=0.002 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti_valve=3000
    "Time constant of Integrator block";
  parameter Real k_pump=0.2 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti_pump=3000
    "Time constant of Integrator block";
equation
  connect(booleanExpression1.y, distributeBus_DHS.bus_dhs_pump.pumpBus.onSet)
    annotation (Line(points={{-79,0},{-79,0.1},{100.1,0.1}},           color={
          255,0,255}));
  connect(PID_Valve.u_m, distributeBus_DHS.bus_dhs_pump.TFwrdOutMea)
    annotation (Line(points={{0,58},{0,0},{50,0},{50,0.1},{100.1,0.1}},
                     color={0,0,127}));
  connect(dp_set.y, PID_rpmSet.u_s)
    annotation (Line(points={{-39,-70},{-12,-70}},
                                                 color={0,0,127}));
  connect(dp_act.y, PID_rpmSet.u_m)
    annotation (Line(points={{-1.55431e-15,-39},{-1.55431e-15,-58},{0,-58}},
                                                   color={0,0,127}));
  connect(dp_act.u1, distributeBus_DHS.bus_dhs_pump.p_sup) annotation (Line(
        points={{1.33227e-15,-22},{1.33227e-15,0.1},{100.1,0.1}},
                                                           color={0,0,127}));
  connect(dp_act.u2, distributeBus_DHS.bus_dhs_pump.p_ret) annotation (Line(
        points={{8,-30},{100.1,-30},{100.1,0.1}},       color={0,0,127}));
  connect(PID_rpmSet.y, distributeBus_DHS.bus_dhs_pump.pumpBus.rpmSet)
    annotation (Line(points={{11,-70},{100,-70},{100,0.1},{100.1,0.1}},
        color={0,0,127}));
  connect(maxTSupSet.y, PID_Valve.u_s)
    annotation (Line(points={{-39,70},{-12,70}}, color={0,0,127}));
  connect(maxTSupSet.u1, distributeBus_DHS.bus_cph_throttle.T_sup_set)
    annotation (Line(points={{-62,76},{-72,76},{-72,0},{14,0},{14,0.1},{100.1,
          0.1}},           color={0,0,127}));
  connect(maxTSupSet.u2, distributeBus_DHS.bus_cca.T_sup_set) annotation (Line(
        points={{-62,64},{-72,64},{-72,0},{14,0},{14,0.1},{100.1,0.1}},
        color={0,0,127}));
  connect(PID_Valve.y, distributeBus_DHS.bus_dhs.valveSet) annotation (Line(
        points={{11,70},{100.1,70},{100.1,0.1}}, color={0,0,127}));
  annotation (Icon(graphics={
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
          textString="Control")}), experiment(
      StopTime=400000,
      __Dymola_NumberOfIntervals=200,
      __Dymola_Algorithm="Dassl"));
end ControlDHS;
