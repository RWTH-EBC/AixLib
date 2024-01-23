within AixLib.Systems.EONERC_Testhall.Obsolete.Controls;
model ControlDHS_n_const
  Subsystems.BaseClasses.Interfaces.HallHydraulicBus distributeBus_DHS
    annotation (Placement(transformation(extent={{-114,-36},{-74,6}}),
        iconTransformation(extent={{78,-22},{118,20}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));
  Modelica.Blocks.Sources.Constant nset(k=4800) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,70})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=3000,
    k=0.002) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={72,76})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    n=2,
    f=0.05,
    x_start={0,0})
    annotation (Placement(transformation(extent={{72,-16},{52,4}})));
  Modelica.Blocks.Math.Max maxTSupSet
    annotation (Placement(transformation(extent={{28,70},{40,82}})));
equation
  connect(booleanExpression1.y, distributeBus_DHS.bus_dhs_pump.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
          255,0,255}));
  connect(nset.y, distributeBus_DHS.bus_dhs_pump.pumpBus.rpmSet) annotation (
      Line(points={{-77,70},{-70,70},{-70,32},{-93.9,32},{-93.9,-14.895}},
                                                                     color={0,0,
          127}));
  connect(PID_Valve.y,criticalDamping. u) annotation (Line(points={{83,76},{88,
          76},{88,-6},{74,-6}}, color={0,0,127}));
  connect(criticalDamping.y, distributeBus_DHS.bus_dhs.valveSet) annotation (
      Line(points={{51,-6},{-16.5,-6},{-16.5,-14.895},{-93.9,-14.895}},
                                                                   color={0,0,
          127}));
  connect(PID_Valve.u_m, distributeBus_DHS.bus_dhs_pump.TFwrdOutMea)
    annotation (Line(points={{72,64},{72,14},{-16,14},{-16,-14.895},{-93.9,
          -14.895}}, color={0,0,127}));
  connect(maxTSupSet.y,PID_Valve. u_s)
    annotation (Line(points={{40.6,76},{60,76}}, color={0,0,127}));
  connect(maxTSupSet.u1, distributeBus_DHS.bus_cph_throttle.T_sup_set)
    annotation (Line(points={{26.8,79.6},{26.8,80},{-18,80},{-18,-14.895},{
          -93.9,-14.895}}, color={0,0,127}));
  connect(maxTSupSet.u2, distributeBus_DHS.bus_cca.T_sup_set) annotation (Line(
        points={{26.8,72.4},{26.8,74},{-18,74},{-18,-14.895},{-93.9,-14.895}},
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
end ControlDHS_n_const;
