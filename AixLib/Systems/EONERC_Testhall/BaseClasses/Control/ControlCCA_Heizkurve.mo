within AixLib.Systems.EONERC_Testhall.BaseClasses.Control;
model ControlCCA_Heizkurve
  .Testhall.BaseClass.DistributeBus distributeBus_CCA annotation (Placement(
        transformation(extent={{-114,-36},{-74,6}}), iconTransformation(extent=
            {{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_cca_m_flow(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=3690,
    Ti=5,
    k=5)     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-44,64})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=1.7)  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,64})));
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
    Ti=1500,
    k=0.001) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={56,-64})));

  Modelica.Blocks.Math.Add y(k1=-0.741) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={114,-64})));
  Modelica.Blocks.Sources.Constant b(k=511.67) annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={144,-82})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=45 + 273.15, uMin=25 + 273.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={88,-64})));
  Modelica.Blocks.Interfaces.RealInput T_amb annotation (Placement(
        transformation(extent={{178,-56},{138,-16}}), iconTransformation(extent={{-126,
            -20},{-86,20}})));
equation
  connect(m_flow_set.y,PID_cca_m_flow. u_s)
    annotation (Line(points={{-77,64},{-56,64}}, color={0,0,127}));
  connect(booleanExpression1.y, distributeBus_CCA.bus_cca.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-70,-33},{-70,-14.895},{-93.9,-14.895}},
        color={255,0,255}));
  connect(PID_cca_m_flow.u_m, distributeBus_CCA.bus_cca.m_flow) annotation (
      Line(points={{-44,52},{-44,-14.895},{-93.9,-14.895}}, color={0,0,127}));
  connect(PID_cca_m_flow.y, distributeBus_CCA.bus_cca.pumpBus.rpmSet)
    annotation (Line(points={{-33,64},{-22,64},{-22,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(criticalDamping.y, distributeBus_CCA.bus_cca.valveSet) annotation (
      Line(points={{-23,-54},{-66,-54},{-66,-14.895},{-93.9,-14.895}}, color={0,
          0,127}));
  connect(PID_Valve.u_m, distributeBus_CCA.bus_cca.TFwrdOutMea) annotation (
      Line(points={{56,-52},{56,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(PID_Valve.y, criticalDamping.u) annotation (Line(points={{45,-64},{8,-64},
          {8,-54},{0,-54}}, color={0,0,127}));
  connect(b.y, y.u2) annotation (Line(points={{137.4,-82},{126,-82},{126,-67.6},
          {121.2,-67.6}}, color={0,0,127}));
  connect(y.y, limiter.u)
    annotation (Line(points={{107.4,-64},{100,-64}}, color={0,0,127}));
  connect(limiter.y, PID_Valve.u_s)
    annotation (Line(points={{77,-64},{68,-64}}, color={0,0,127}));
  connect(y.u1, T_amb) annotation (Line(points={{121.2,-60.4},{120,-60.4},{120,-36},
          {158,-36}}, color={0,0,127}));
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
