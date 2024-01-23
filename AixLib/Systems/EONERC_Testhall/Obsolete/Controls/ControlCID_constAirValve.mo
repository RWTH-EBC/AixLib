within AixLib.Systems.EONERC_Testhall.Obsolete.Controls;
model ControlCID_constAirValve
  "Information out of Unterlagen\\Heizlastberechnung\\Heizkurve_BKT"
  Subsystems.BaseClasses.Interfaces.HallHydraulicBus distributeBus_CID
    annotation (Placement(transformation(extent={{-114,-36},{-74,6}}),
        iconTransformation(extent={{78,-22},{118,20}})));
  Modelica.Blocks.Continuous.LimPID PID_cid_m_flow(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=3040,
    Ti=1,
    k=20)    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-38,64})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=0.09) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,64})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-44})));
  Modelica.Blocks.Sources.Constant AirValve_Set(k=1)           annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-32,-52})));
  Modelica.Blocks.Continuous.LimPID PID_Valve(
    yMin=0,
    Td=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    Ti=2000,
    k=0.001) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={14,42})));
  Modelica.Blocks.Math.Add y(k1=-1.7935)
                                        annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={72,38})));
  Modelica.Blocks.Sources.Constant b(k=58.156) annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={146,22})));
  Modelica.Blocks.Nonlinear.Limiter limiter(
    uMax=80,
    uMin=15,
    strict=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={98,60})));
  Modelica.Blocks.Interfaces.RealInput T_amb annotation (Placement(
        transformation(extent={{170,50},{130,90}}),   iconTransformation(extent={{-126,
            -20},{-86,20}})));
  Modelica.Blocks.Math.Add addtoC
    annotation (Placement(transformation(extent={{128,80},{120,88}})));
  Modelica.Blocks.Sources.Constant toCelsius(k=-273.15) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={144,92})));
  Modelica.Blocks.Math.Add addtoK
    annotation (Placement(transformation(extent={{50,38},{42,46}})));
  Modelica.Blocks.Sources.Constant toKelvin(k=273.15) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={64,66})));
equation
  connect(m_flow_set.y,PID_cid_m_flow. u_s)
    annotation (Line(points={{-77,64},{-50,64}}, color={0,0,127}));
  connect(PID_cid_m_flow.y, distributeBus_CID.bus_cid.pumpBus.rpmSet)
    annotation (Line(points={{-27,64},{-22,64},{-22,-14.895},{-93.9,-14.895}},
        color={0,0,127}));
  connect(booleanExpression1.y, distributeBus_CID.bus_cid.pumpBus.onSet)
    annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
          255,0,255}));
  connect(PID_cid_m_flow.u_m, distributeBus_CID.bus_cid.mflow) annotation (Line(
        points={{-38,52},{-38,-14.895},{-93.9,-14.895}}, color={0,0,127}));
  connect(b.y,y. u2) annotation (Line(points={{139.4,22},{79.2,22},{79.2,34.4}},
                          color={0,0,127}));
  connect(PID_Valve.y, distributeBus_CID.bus_cid.valveSet) annotation (Line(
        points={{3,42},{-6,42},{-6,-14.895},{-93.9,-14.895}}, color={0,0,127}));
  connect(PID_Valve.u_m, distributeBus_CID.bus_cid.TFwrdOutMea) annotation (
      Line(points={{14,54},{14,62},{-6,62},{-6,-14.895},{-93.9,-14.895}}, color=
         {0,0,127}));
  connect(T_amb, addtoC.u2) annotation (Line(points={{150,70},{128.8,70},{128.8,
          81.6}}, color={0,0,127}));
  connect(toCelsius.y, addtoC.u1) annotation (Line(points={{139.6,92},{134,92},{
          134,86.4},{128.8,86.4}}, color={0,0,127}));
  connect(toKelvin.y, addtoK.u1) annotation (Line(points={{59.6,66},{52,66},{52,
          50},{54,50},{54,44.4},{50.8,44.4}}, color={0,0,127}));
  connect(addtoK.y, PID_Valve.u_s)
    annotation (Line(points={{41.6,42},{26,42}}, color={0,0,127}));
  connect(addtoC.y, limiter.u) annotation (Line(points={{119.6,84},{116,84},{116,
          60},{110,60}}, color={0,0,127}));
  connect(limiter.y, y.u1) annotation (Line(points={{87,60},{84,60},{84,41.6},{79.2,
          41.6}}, color={0,0,127}));
  connect(y.y, addtoK.u2) annotation (Line(points={{65.4,38},{65.4,39.6},{50.8,39.6}},
        color={0,0,127}));
  connect(AirValve_Set.y, distributeBus_CID.bus_cid.Office_Air_Valve)
    annotation (Line(points={{-43,-52},{-70,-52},{-70,-14.895},{-93.9,-14.895}},
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
end ControlCID_constAirValve;
