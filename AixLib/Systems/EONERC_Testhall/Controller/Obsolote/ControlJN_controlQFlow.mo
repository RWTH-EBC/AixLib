within AixLib.Systems.EONERC_Testhall.Controller.Obsolote;
model ControlJN_controlQFlow
  BaseClass.DistributeBus distributeBus_JN annotation (Placement(transformation(
          extent={{-100,18},{-60,60}}), iconTransformation(extent={{78,-22},{
            118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_AirValve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1000,
    k=0.001) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={6,-36})));
  Modelica.Blocks.Sources.Constant RoomTemp_set(k=20 + 273.15) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={44,-36})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=250,
    k=0.1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={44,74})));
  Modelica.Blocks.Interfaces.RealInput QFlow annotation (Placement(
        transformation(extent={{122,54},{82,94}}),    iconTransformation(extent={{-126,
            -20},{-86,20}})));
  Modelica.Blocks.Math.Feedback deltaT
    annotation (Placement(transformation(extent={{-26,38},{-6,58}})));
  Modelica.Blocks.Math.Gain cp(k=4.18*1000)
    annotation (Placement(transformation(extent={{0,44},{8,52}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{16,42},{24,50}})));
  Modelica.Blocks.Continuous.LimPID PID_m_flow(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=4350,
    Ti=1,
    k=30) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={20,10})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=0.4)  annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={76,10})));
equation
  connect(RoomTemp_set.y, PID_AirValve.u_s)
    annotation (Line(points={{33,-36},{18,-36}},color={0,0,127}));
  connect(PID_AirValve.y, distributeBus_JN.bus_jn.Hall_AirValve) annotation (
      Line(points={{-5,-36},{-56,-36},{-56,39.105},{-79.9,39.105}}, color={0,0,
          127}));
  connect(PID_Valve.y, distributeBus_JN.bus_jn.valveSet) annotation (Line(
        points={{33,74},{-79.9,74},{-79.9,39.105}},             color={0,0,127}));
  connect(PID_AirValve.u_m, distributeBus_JN.bus_jn.TempHall) annotation (Line(
        points={{6,-48},{6,-54},{-79.9,-54},{-79.9,39.105}}, color={0,0,127}));
  connect(PID_Valve.u_s, QFlow)
    annotation (Line(points={{56,74},{102,74}}, color={0,0,127}));
  connect(deltaT.u1, distributeBus_JN.bus_jn.TFwrdOutMea) annotation (Line(
        points={{-24,48},{-54,48},{-54,39.105},{-79.9,39.105}}, color={0,0,127}));
  connect(deltaT.u2, distributeBus_JN.bus_jn.TRtrnInMea) annotation (Line(
        points={{-16,40},{-16,34},{-54,34},{-54,39.105},{-79.9,39.105}}, color=
          {0,0,127}));
  connect(deltaT.y, cp.u)
    annotation (Line(points={{-7,48},{-0.8,48}}, color={0,0,127}));
  connect(cp.y, product.u1) annotation (Line(points={{8.4,48},{11.8,48},{11.8,
          48.4},{15.2,48.4}}, color={0,0,127}));
  connect(product.u2, distributeBus_JN.bus_jn.VFlowOutMea) annotation (Line(
        points={{15.2,43.6},{14,43.6},{14,30},{-54,30},{-54,39.105},{-79.9,
          39.105}}, color={0,0,127}));
  connect(product.y, PID_Valve.u_m)
    annotation (Line(points={{24.4,46},{44,46},{44,62}}, color={0,0,127}));
  connect(m_flow_set.y, PID_m_flow.u_s)
    annotation (Line(points={{65,10},{32,10}}, color={0,0,127}));
  connect(PID_m_flow.u_m, distributeBus_JN.bus_jn.mflow) annotation (Line(
        points={{20,-2},{20,-8},{-79.9,-8},{-79.9,39.105}}, color={0,0,127}));
  connect(PID_m_flow.y, distributeBus_JN.bus_jn.pumpBus.rpmSet) annotation (
      Line(points={{9,10},{-79.9,10},{-79.9,39.105}}, color={0,0,127}));
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
end ControlJN_controlQFlow;
