within AixLib.Systems.EONERC_Testhall.Controller;
model ControlCCA_Heizkurve "Information out of Unterlagen\\Heizlastberechnung\\Heizkurve_BKT"
  BaseClass.DistributeBus           distributeBus_CCA annotation (Placement(
        transformation(extent={{-114,-36},{-74,6}}), iconTransformation(extent=
            {{78,-22},{118,20}})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=3600) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-34,16})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    n=2,
    f=0.001,
    x_start={0,0})
    annotation (Placement(transformation(extent={{-2,-64},{-22,-44}})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    Ti=2000,
    k=0.01)  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={56,-64})));

  Modelica.Blocks.Interfaces.RealInput T_amb annotation (Placement(
        transformation(extent={{186,-84},{146,-44}}), iconTransformation(extent={{-126,
            -20},{-86,20}})));
  HeatCurve heatCurve(
    u_lower=17,
    t_sup_upper=48,
    x=-0.5,
    b=24)
    annotation (Placement(transformation(extent={{126,-74},{106,-54}})));
equation
  connect(booleanExpression1.y, distributeBus_CCA.bus_cca.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-70,-33},{-70,-14.895},{-93.9,-14.895}},
        color={255,0,255}));
  connect(criticalDamping.y, distributeBus_CCA.bus_cca.valveSet) annotation (
      Line(points={{-23,-54},{-66,-54},{-66,-14.895},{-93.9,-14.895}}, color={0,
          0,127}));
  connect(PID_Valve.u_m, distributeBus_CCA.bus_cca.TFwrdOutMea) annotation (
      Line(points={{56,-52},{56,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(PID_Valve.y, criticalDamping.u) annotation (Line(points={{45,-64},{8,-64},
          {8,-54},{0,-54}}, color={0,0,127}));
  connect(T_amb, heatCurve.T_amb)
    annotation (Line(points={{166,-64},{128,-64}}, color={0,0,127}));
  connect(heatCurve.T_sup, PID_Valve.u_s)
    annotation (Line(points={{105.2,-64},{68,-64}}, color={0,0,127}));
  connect(m_flow_set.y, distributeBus_CCA.bus_cca.pumpBus.rpmSet) annotation (
      Line(points={{-45,16},{-68,16},{-68,-14.895},{-93.9,-14.895}}, color={0,0,
          127}));
  connect(heatCurve.T_sup, distributeBus_CCA.bus_cca.T_sup_set) annotation (
      Line(points={{105.2,-64},{82,-64},{82,-14.895},{-93.9,-14.895}}, color={0,
          0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{160,100}}),                                  graphics={
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
           false, extent={{-100,-100},{160,100}})));
end ControlCCA_Heizkurve;
