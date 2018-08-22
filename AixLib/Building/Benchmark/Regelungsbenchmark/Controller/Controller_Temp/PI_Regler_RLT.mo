within AixLib.Building.Benchmark.Regelungsbenchmark.Controller.Controller_Temp;
model PI_Regler_RLT
  Modelica.Blocks.Continuous.LimPID PID_RLT_Conferenceroom_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Openplanoffice_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Canteen_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Multipersonoffice_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Workshop_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Conferenceroom_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{-30,-80},{-10,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Openplanoffice_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{-80,-80},{-60,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Canteen_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{-80,-40},{-60,-60}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Multipersonoffice_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{20,-80},{40,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Workshop_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 70)
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 10)
    annotation (Placement(transformation(extent={{-126,-100},{-106,-80}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Central_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Central_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-54,-54},{-46,-46}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-54,-94},{-46,-86}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-4,-54},{4,-46}})));
  Modelica.Blocks.Math.Gain gain3(k=-1)
    annotation (Placement(transformation(extent={{-4,-94},{4,-86}})));
  Modelica.Blocks.Math.Gain gain4(k=-1)
    annotation (Placement(transformation(extent={{46,-54},{54,-46}})));
  Modelica.Blocks.Math.Gain gain5(k=-1)
    annotation (Placement(transformation(extent={{46,-94},{54,-86}})));
equation
  connect(realExpression2.y, PID_RLT_Openplanoffice_Hot.u_s)
    annotation (Line(points={{-119,90},{-82,90}}, color={0,0,127}));
  connect(PID_RLT_Conferenceroom_Hot.u_s, PID_RLT_Openplanoffice_Hot.u_s)
    annotation (Line(points={{-32,90},{-40,90},{-40,70},{-100,70},{-100,90},{-82,
          90}}, color={0,0,127}));
  connect(PID_RLT_Canteen_Hot.u_s, PID_RLT_Openplanoffice_Hot.u_s)
    annotation (Line(points={{-82,50},{-100,50},{-100,90},{-82,90}}, color={0,0,
          127}));
  connect(PID_RLT_Multipersonoffice_Hot.u_s, PID_RLT_Openplanoffice_Hot.u_s)
    annotation (Line(points={{18,90},{10,90},{10,70},{-100,70},{-100,90},{-82,90}},
        color={0,0,127}));
  connect(PID_RLT_Openplanoffice_Cold.u_s, realExpression3.y)
    annotation (Line(points={{-82,-90},{-105,-90}}, color={0,0,127}));
  connect(PID_RLT_Conferenceroom_Cold.u_s, realExpression3.y) annotation (Line(
        points={{-32,-90},{-42,-90},{-42,-70},{-100,-70},{-100,-90},{-105,-90}},
        color={0,0,127}));
  connect(PID_RLT_Multipersonoffice_Cold.u_s, realExpression3.y) annotation (
      Line(points={{18,-90},{10,-90},{10,-70},{-100,-70},{-100,-90},{-105,-90}},
        color={0,0,127}));
  connect(PID_RLT_Canteen_Cold.u_s, realExpression3.y) annotation (Line(points={
          {-82,-50},{-100,-50},{-100,-90},{-105,-90}}, color={0,0,127}));
  connect(PID_RLT_Canteen_Hot.y, controlBus.Valve_RLT_Hot_Canteen) annotation (
     Line(points={{-59,50},{-52,50},{-52,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(PID_RLT_Openplanoffice_Hot.y, controlBus.Valve_RLT_Hot_OpenPlanOffice)
    annotation (Line(points={{-59,90},{-52,90},{-52,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(PID_RLT_Conferenceroom_Hot.y, controlBus.Valve_RLT_Hot_ConferenceRoom)
    annotation (Line(points={{-9,90},{0,90},{0,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(PID_RLT_Central_Hot.y, controlBus.Valve_RLT_Hot_Central) annotation (
     Line(points={{-9,50},{0,50},{0,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(PID_RLT_Multipersonoffice_Hot.y, controlBus.Valve_RLT_Hot_MultiPersonOffice)
    annotation (Line(points={{41,90},{50,90},{50,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(PID_RLT_Workshop_Hot.y, controlBus.Valve_RLT_Hot_Workshop)
    annotation (Line(points={{41,50},{50,50},{50,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(PID_RLT_Canteen_Cold.y, gain.u)
    annotation (Line(points={{-59,-50},{-54.8,-50}}, color={0,0,127}));
  connect(PID_RLT_Openplanoffice_Cold.y, gain1.u)
    annotation (Line(points={{-59,-90},{-54.8,-90}}, color={0,0,127}));
  connect(PID_RLT_Central_Cold.y, gain2.u)
    annotation (Line(points={{-9,-50},{-4.8,-50}}, color={0,0,127}));
  connect(PID_RLT_Conferenceroom_Cold.y, gain3.u)
    annotation (Line(points={{-9,-90},{-4.8,-90}}, color={0,0,127}));
  connect(PID_RLT_Workshop_Cold.y, gain4.u)
    annotation (Line(points={{41,-50},{45.2,-50}}, color={0,0,127}));
  connect(PID_RLT_Multipersonoffice_Cold.y, gain5.u)
    annotation (Line(points={{41,-90},{45.2,-90}}, color={0,0,127}));
  connect(gain.y, controlBus.Valve_RLT_Cold_Canteen) annotation (Line(points={{
          -45.6,-50},{-44,-50},{-44,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(gain1.y, controlBus.Valve_RLT_Cold_OpenPlanOffice) annotation (Line(
        points={{-45.6,-90},{-44,-90},{-44,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(gain2.y, controlBus.Valve_RLT_Cold_Central) annotation (Line(points={
          {4.4,-50},{6,-50},{6,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(gain3.y, controlBus.Valve_RLT_Cold_ConferenceRoom) annotation (Line(
        points={{4.4,-90},{6,-90},{6,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(gain4.y, controlBus.Valve_RLT_Cold_Workshop) annotation (Line(points=
          {{54.4,-50},{58,-50},{58,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(gain5.y, controlBus.Valve_RLT_Cold_MultiPersonOffice) annotation (
      Line(points={{54.4,-90},{58,-90},{58,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(PID_RLT_Central_Cold.u_s, realExpression3.y) annotation (Line(points=
          {{-32,-50},{-38,-50},{-38,-30},{-100,-30},{-100,-90},{-105,-90}},
        color={0,0,127}));
  connect(PID_RLT_Workshop_Cold.u_s, realExpression3.y) annotation (Line(points=
         {{18,-50},{10,-50},{10,-30},{-100,-30},{-100,-90},{-105,-90}}, color={
          0,0,127}));
  connect(PID_RLT_Central_Hot.u_s, realExpression2.y) annotation (Line(points={
          {-32,50},{-40,50},{-40,30},{-100,30},{-100,90},{-119,90}}, color={0,0,
          127}));
  connect(PID_RLT_Workshop_Hot.u_s, realExpression2.y) annotation (Line(points=
          {{18,50},{12,50},{12,30},{-100,30},{-100,90},{-119,90}}, color={0,0,
          127}));
  connect(PID_RLT_Canteen_Cold.u_m, measureBus.RLT_canteen_cold_in) annotation (
     Line(points={{-70,-38},{-70,-26},{-99.9,-26},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_RLT_Central_Cold.u_m, measureBus.RLT_central_cold_in) annotation (
     Line(points={{-20,-38},{-20,-26},{-99.9,-26},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_RLT_Workshop_Cold.u_m, measureBus.RLT_workshop_cold_in)
    annotation (Line(points={{30,-38},{30,-26},{-99.9,-26},{-99.9,0.1}}, color=
          {0,0,127}));
  connect(PID_RLT_Openplanoffice_Cold.u_m, measureBus.RLT_openplanoffice_cold_in)
    annotation (Line(points={{-70,-78},{-70,-74},{-99.9,-74},{-99.9,0.1}},
        color={0,0,127}));
  connect(PID_RLT_Conferenceroom_Cold.u_m, measureBus.RLT_conferencerom_cold_in)
    annotation (Line(points={{-20,-78},{-20,-74},{-99.9,-74},{-99.9,0.1}},
        color={0,0,127}));
  connect(PID_RLT_Multipersonoffice_Cold.u_m, measureBus.RLT_multipersonoffice_cold_in)
    annotation (Line(points={{30,-78},{30,-74},{-99.9,-74},{-99.9,0.1}}, color=
          {0,0,127}));
  connect(PID_RLT_Openplanoffice_Hot.u_m, measureBus.RLT_openplanoffice_hot_in)
    annotation (Line(points={{-70,78},{-70,74},{-99.9,74},{-99.9,0.1}}, color={
          0,0,127}));
  connect(PID_RLT_Conferenceroom_Hot.u_m, measureBus.RLT_conferencerom_hot_in)
    annotation (Line(points={{-20,78},{-20,74},{-99.9,74},{-99.9,0.1}}, color={
          0,0,127}));
  connect(PID_RLT_Multipersonoffice_Hot.u_m, measureBus.RLT_multipersonoffice_hot_in)
    annotation (Line(points={{30,78},{30,74},{-99.9,74},{-99.9,0.1}}, color={0,
          0,127}));
  connect(PID_RLT_Canteen_Hot.u_m, measureBus.RLT_canteen_hot_in) annotation (
      Line(points={{-70,38},{-70,34},{-99.9,34},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_RLT_Central_Hot.u_m, measureBus.RLT_central_hot_in) annotation (
      Line(points={{-20,38},{-20,34},{-99.9,34},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_RLT_Workshop_Hot.u_m, measureBus.RLT_workshop_hot_in) annotation (
     Line(points={{30,38},{30,34},{-99.9,34},{-99.9,0.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PI_Regler_RLT;
