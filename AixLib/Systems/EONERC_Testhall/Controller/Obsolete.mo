within AixLib.Systems.EONERC_Testhall.Controller;
package Obsolete
  model AirValveControl
    parameter Modelica.Units.SI.Temperature Temp_Set_Air
      "Set Temperature of Air Flow";
    parameter Real ki = 0.01 "P-value for the PI-Control";
    parameter Real ti = 1000 "I-value for the PI-Control";

    Modelica.Blocks.Interfaces.RealOutput Air_Valve_Opening
      "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-90},{120,-70}}),
          iconTransformation(extent={{100,-90},{120,-70}})));
    Modelica.Blocks.Interfaces.RealInput Air_Temp
      "Connector of first Boolean input signal" annotation (Placement(
          transformation(extent={{140,60},{100,100}}), iconTransformation(extent={
              {140,60},{100,100}})));
    Modelica.Blocks.Continuous.LimPID PID_Air_Flow_Valve(
      yMin=0,
      Td=0.5,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1,
      k=ki,
      Ti=ti) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={0,10})));
    Modelica.Blocks.Sources.Constant T_Set_Air(k=Temp_Set_Air) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-58,-12})));
    Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
      n=2,
      f=0.05,
      x_start={0,0})
      annotation (Placement(transformation(extent={{52,-90},{72,-70}})));
  equation
    connect(T_Set_Air.y, PID_Air_Flow_Valve.u_s) annotation (Line(points={{-47,-12},
            {-18,-12},{-18,10},{-12,10}}, color={0,0,127}));
    connect(criticalDamping.y, Air_Valve_Opening)
      annotation (Line(points={{73,-80},{110,-80}}, color={0,0,127}));
    connect(Air_Temp, PID_Air_Flow_Valve.u_m)
      annotation (Line(points={{120,80},{0,80},{0,22}}, color={0,0,127}));
    connect(PID_Air_Flow_Valve.y, criticalDamping.u) annotation (Line(points={{11,
            10},{44,10},{44,-80},{50,-80}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{100,80},{44,80},{2,80},{2,2},{2,-80},{100,-80}}, color={0,
                0,0}),
          Polygon(
            points={{-58,40},{2,0},{-58,-40},{-58,40}},
            lineColor={0,0,0},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{62,40},{2,0},{62,-40},{62,40}},
            lineColor={0,0,0},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end AirValveControl;

  model ControlDHS_n_const
    BaseClass.DistributeBus distributeBus_DHS annotation (Placement(
          transformation(extent={{-114,-36},{-74,6}}), iconTransformation(extent=
              {{78,-22},{118,20}})));
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

  model ControlJN_constHydrValve
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
    Modelica.Blocks.Sources.Constant ValveSet(k=0.5) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={40,60})));
    Modelica.Blocks.Continuous.LimPID PID_m_flow(
      yMin=0,
      Td=0.5,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=4350,
      Ti=1,
      k=30) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={0,12})));
    Modelica.Blocks.Sources.Constant m_flow_set(k=0.4)  annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={56,12})));
  equation
    connect(RoomTemp_set.y, PID_AirValve.u_s)
      annotation (Line(points={{33,-36},{18,-36}},color={0,0,127}));
    connect(PID_AirValve.y, distributeBus_JN.bus_jn.Hall_AirValve) annotation (
        Line(points={{-5,-36},{-56,-36},{-56,39.105},{-79.9,39.105}}, color={0,0,
            127}));
    connect(PID_AirValve.u_m, distributeBus_JN.bus_jn.TempHall) annotation (Line(
          points={{6,-48},{6,-54},{-79.9,-54},{-79.9,39.105}}, color={0,0,127}));
    connect(ValveSet.y, distributeBus_JN.bus_jn.valveSet) annotation (Line(points=
           {{29,60},{-54,60},{-54,39.105},{-79.9,39.105}}, color={0,0,127}));
    connect(m_flow_set.y, PID_m_flow.u_s)
      annotation (Line(points={{45,12},{12,12}}, color={0,0,127}));
    connect(PID_m_flow.y, distributeBus_JN.bus_jn.pumpBus.rpmSet) annotation (
        Line(points={{-11,12},{-34,12},{-34,39.105},{-79.9,39.105}}, color={0,0,
            127}));
    connect(PID_m_flow.u_m, distributeBus_JN.bus_jn.mflow) annotation (Line(
          points={{0,0},{0,-6},{-79.9,-6},{-79.9,39.105}}, color={0,0,127}));
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
  end ControlJN_constHydrValve;

  model ControlJN_constAirValve
    BaseClass.DistributeBus distributeBus_JN annotation (Placement(transformation(
            extent={{-64,-18},{-24,24}}), iconTransformation(extent={{78,-22},{
              118,20}})));
    Modelica.Blocks.Sources.Constant AirValve_Set(k=1)           annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={38,-30})));
    Modelica.Blocks.Sources.Constant T_Set_Hall_Circ(k=50 + 273.15) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={76,28})));
    Modelica.Blocks.Continuous.LimPID PID_Valve(
      yMin=0,
      Td=0.5,
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=250,
      k=0.001) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={36,28})));
  equation
    connect(AirValve_Set.y, distributeBus_JN.bus_jn.Hall_AirValve) annotation (
        Line(points={{27,-30},{-43.9,-30},{-43.9,3.105}}, color={0,0,127}));
    connect(PID_Valve.u_s,T_Set_Hall_Circ. y)
      annotation (Line(points={{48,28},{65,28}}, color={0,0,127}));
    connect(PID_Valve.y, distributeBus_JN.bus_jn.valveSet) annotation (Line(
          points={{25,28},{-43.9,28},{-43.9,3.105}},           color={0,0,127}));
    connect(PID_Valve.u_m, distributeBus_JN.bus_jn.TFwrdOutMea) annotation (Line(
          points={{36,16},{36,3.105},{-43.9,3.105}}, color={0,0,127}));
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
  end ControlJN_constAirValve;

  model ControlJN
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
    Modelica.Blocks.Sources.Constant T_Set_Hall_Circ(k=70 + 273.15) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={84,82})));
    Modelica.Blocks.Continuous.LimPID PID_Valve(
      yMin=0,
      Td=0.5,
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=250,
      k=0.1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={44,82})));
    Modelica.Blocks.Continuous.LimPID PID_m_flow(
      yMin=0,
      Td=0.5,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=4350,
      Ti=1,
      k=30) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-20,16})));
    Modelica.Blocks.Sources.Constant m_flow_set(k=0.4)  annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={36,16})));
  equation
    connect(RoomTemp_set.y, PID_AirValve.u_s)
      annotation (Line(points={{33,-36},{18,-36}},color={0,0,127}));
    connect(PID_AirValve.y, distributeBus_JN.bus_jn.Hall_AirValve) annotation (
        Line(points={{-5,-36},{-56,-36},{-56,39.105},{-79.9,39.105}}, color={0,0,
            127}));
    connect(PID_Valve.u_s,T_Set_Hall_Circ. y)
      annotation (Line(points={{56,82},{73,82}}, color={0,0,127}));
    connect(PID_Valve.y, distributeBus_JN.bus_jn.valveSet) annotation (Line(
          points={{33,82},{-79.9,82},{-79.9,39.105}},             color={0,0,127}));
    connect(PID_Valve.u_m, distributeBus_JN.bus_jn.TFwrdOutMea) annotation (Line(
          points={{44,70},{44,39.105},{-79.9,39.105}},
                                                     color={0,0,127}));
    connect(PID_AirValve.u_m, distributeBus_JN.bus_jn.TempHall) annotation (Line(
          points={{6,-48},{6,-54},{-79.9,-54},{-79.9,39.105}}, color={0,0,127}));
    connect(m_flow_set.y, PID_m_flow.u_s)
      annotation (Line(points={{25,16},{-8,16}}, color={0,0,127}));
    connect(PID_m_flow.y, distributeBus_JN.bus_jn.pumpBus.rpmSet) annotation (
        Line(points={{-31,16},{-54,16},{-54,39.105},{-79.9,39.105}}, color={0,0,
            127}));
    connect(PID_m_flow.u_m, distributeBus_JN.bus_jn.mflow) annotation (Line(
          points={{-20,4},{-20,-2},{-79.9,-2},{-79.9,39.105}}, color={0,0,127}));
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
  end ControlJN;

  model ControlCCA
    BaseClass.DistributeBus distributeBus_CCA annotation (Placement(
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

    Modelica.Blocks.Sources.Constant T_Sol(k=40 + 273.15) annotation (Placement(
          transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={102,-40})));
  equation
    connect(m_flow_set.y,PID_cca_m_flow. u_s)
      annotation (Line(points={{-77,64},{-56,64}}, color={0,0,127}));
    connect(booleanExpression1.y, distributeBus_CCA.bus_cca.pumpBus.onSet)
      annotation (Line(points={{-90,-33},{-70,-33},{-70,-14.895},{-93.9,-14.895}},
          color={255,0,255}));
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
    connect(PID_Valve.u_s, T_Sol.y) annotation (Line(points={{68,-64},{90,-64},{
            90,-40},{95.4,-40}}, color={0,0,127}));
    connect(PID_cca_m_flow.u_m, distributeBus_CCA.bus_cca.mflow)
      annotation (Line(points={{-44,52},{-44,-14.895},{-93.9,-14.895}},
                                                              color={0,0,127}));
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
  end ControlCCA;

  model ControlCID_constAirValve
    "Information out of Unterlagen\\Heizlastberechnung\\Heizkurve_BKT"
    BaseClass.DistributeBus distributeBus_CID annotation (Placement(
          transformation(extent={{-114,-36},{-74,6}}), iconTransformation(extent=
              {{78,-22},{118,20}})));
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

  model ControlCID_Heizkurve
    "Information out of Unterlagen\\Heizlastberechnung\\Heizkurve_BKT"
    BaseClass.DistributeBus distributeBus_CID annotation (Placement(
          transformation(extent={{-138,-36},{-98,6}}), iconTransformation(extent=
              {{78,-22},{118,20}})));
    Modelica.Blocks.Continuous.LimPID PID_cid_m_flow(
      yMin=0,
      Td=0.5,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=3040,
      Ti=1,
      k=20)    annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-62,64})));
    Modelica.Blocks.Sources.Constant m_flow_set(k=0.09) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-112,64})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-90,-44})));
    Modelica.Blocks.Continuous.LimPID PID_AirValve(
      yMin=0,
      Td=0.5,
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=2000,
      k=0.01)  annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-6,-50})));
    Modelica.Blocks.Sources.Constant RoomTemp_set(k=20 + 273.15) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={30,-50})));
    Modelica.Blocks.Continuous.LimPID PID_Valve(
      yMin=0,
      Td=0.5,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1,
      Ti=2000,
      k=0.001) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={-10,42})));
    HeatCurve heatCurve(x=-1.7935, b=58.16)
      annotation (Placement(transformation(extent={{40,32},{20,52}})));
    Modelica.Blocks.Interfaces.RealInput T_amb
      annotation (Placement(transformation(extent={{186,18},{146,58}}),
          iconTransformation(extent={{-112,-20},{-72,20}})));
  equation
    connect(m_flow_set.y,PID_cid_m_flow. u_s)
      annotation (Line(points={{-101,64},{-74,64}},color={0,0,127}));
    connect(PID_cid_m_flow.y, distributeBus_CID.bus_cid.pumpBus.rpmSet)
      annotation (Line(points={{-51,64},{-46,64},{-46,-14.895},{-117.9,-14.895}},
          color={0,0,127}));
    connect(booleanExpression1.y, distributeBus_CID.bus_cid.pumpBus.onSet)
      annotation (Line(points={{-90,-33},{-90,-14.895},{-117.9,-14.895}},color={
            255,0,255}));
    connect(RoomTemp_set.y, PID_AirValve.u_s)
      annotation (Line(points={{19,-50},{6,-50}}, color={0,0,127}));
    connect(PID_cid_m_flow.u_m, distributeBus_CID.bus_cid.mflow) annotation (Line(
          points={{-62,52},{-62,-14.895},{-117.9,-14.895}},color={0,0,127}));
    connect(PID_AirValve.u_m, distributeBus_CID.bus_cid.RoomTemp) annotation (
        Line(points={{-6,-62},{-6,-68},{-92,-68},{-92,-14.895},{-117.9,-14.895}},
          color={0,0,127}));
    connect(PID_AirValve.y, distributeBus_CID.bus_cid.Office_Air_Valve)
      annotation (Line(points={{-17,-50},{-92,-50},{-92,-14.895},{-117.9,-14.895}},
          color={0,0,127}));
    connect(PID_Valve.y, distributeBus_CID.bus_cid.valveSet) annotation (Line(
          points={{-21,42},{-30,42},{-30,-14.895},{-117.9,-14.895}},
                                                                color={0,0,127}));
    connect(PID_Valve.u_m, distributeBus_CID.bus_cid.TFwrdOutMea) annotation (
        Line(points={{-10,54},{-10,62},{-30,62},{-30,-14.895},{-117.9,-14.895}},
                                                                            color=
           {0,0,127}));
    connect(heatCurve.T_sup, PID_Valve.u_s)
      annotation (Line(points={{19.2,42},{2,42}}, color={0,0,127}));
    connect(heatCurve.T_amb, T_amb) annotation (Line(points={{42,42},{53,42},{53,
            38},{166,38}},
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
  end ControlCID_Heizkurve;

  model ControlCID
    BaseClass.DistributeBus distributeBus_CID annotation (Placement(
          transformation(extent={{-114,-36},{-74,6}}), iconTransformation(extent=
              {{78,-22},{118,20}})));
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
    Modelica.Blocks.Sources.Constant T_Set_Hall_Circ(k=50 + 273.15) annotation (
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
      k=0.005) annotation (Placement(transformation(
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
    Modelica.Blocks.Continuous.LimPID PID_AirValve(
      yMin=0,
      Td=0.5,
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=3000,
      k=0.1)   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-8,-50})));
    Modelica.Blocks.Sources.Constant RoomTemp_set(k=20 + 273.15) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={30,-50})));
  equation
    connect(m_flow_set.y,PID_cid_m_flow. u_s)
      annotation (Line(points={{-77,64},{-50,64}}, color={0,0,127}));
    connect(PID_Valve.u_s, T_Set_Hall_Circ.y)
      annotation (Line(points={{50,68},{33,68}}, color={0,0,127}));
    connect(PID_Valve.y, criticalDamping.u) annotation (Line(points={{73,68},{84,
            68},{84,24},{28,24}}, color={0,0,127}));
    connect(PID_cid_m_flow.y, distributeBus_CID.bus_cid.pumpBus.rpmSet)
      annotation (Line(points={{-27,64},{-22,64},{-22,-14.895},{-93.9,-14.895}},
          color={0,0,127}));
    connect(booleanExpression1.y, distributeBus_CID.bus_cid.pumpBus.onSet)
      annotation (Line(points={{-90,-33},{-90,-14.895},{-93.9,-14.895}}, color={
            255,0,255}));
    connect(PID_Valve.u_m, distributeBus_CID.bus_cid.TFwrdOutMea) annotation (
        Line(points={{62,56},{62,44},{-22,44},{-22,-14.895},{-93.9,-14.895}},
          color={0,0,127}));
    connect(criticalDamping.y, distributeBus_CID.bus_cid.valveSet) annotation (
        Line(points={{5,24},{-22,24},{-22,-14.895},{-93.9,-14.895}}, color={0,0,
            127}));
    connect(RoomTemp_set.y, PID_AirValve.u_s)
      annotation (Line(points={{19,-50},{4,-50}}, color={0,0,127}));
    connect(PID_cid_m_flow.u_m, distributeBus_CID.bus_cid.mflow) annotation (Line(
          points={{-38,52},{-38,-14.895},{-93.9,-14.895}}, color={0,0,127}));
    connect(PID_AirValve.u_m, distributeBus_CID.bus_cid.RoomTemp) annotation (
        Line(points={{-8,-62},{-8,-68},{-68,-68},{-68,-14.895},{-93.9,-14.895}},
          color={0,0,127}));
    connect(PID_AirValve.y, distributeBus_CID.bus_cid.Office_Air_Valve)
      annotation (Line(points={{-19,-50},{-68,-50},{-68,-14.895},{-93.9,-14.895}},
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
  end ControlCID;
end Obsolete;
