within AixLib.Building.Benchmark.Regelungsbenchmark.Controller.Controller_Temp;
model PID_Regler_TBA
  Modelica.Blocks.Continuous.LimPID PID_TBA_Conferenceroom_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Openplanoffice_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Canteen_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Multipersonoffice_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Workshop_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Conferenceroom_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-30,-80},{-10,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Openplanoffice_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-80,-80},{-60,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Canteen_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-80,-40},{-60,-60}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Multipersonoffice_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{20,-80},{40,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Workshop_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-126,80},{-106,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-126,-100},{-106,-80}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=19, uHigh=21)
    annotation (Placement(transformation(extent={{-46,10},{-34,22}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-18,18},{-10,26}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=0)
    annotation (Placement(transformation(extent={{-80,-26},{-60,-6}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=1)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-18,6},{-10,14}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=19, uHigh=21)
    annotation (Placement(transformation(extent={{4,10},{16,22}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{32,6},{40,14}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{32,18},{40,26}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=19, uHigh=21)
    annotation (Placement(transformation(extent={{-46,-20},{-34,-8}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{-18,-24},{-10,-16}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{-18,-12},{-10,-4}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=19, uHigh=21)
    annotation (Placement(transformation(extent={{4,-20},{16,-8}})));
  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{32,-24},{40,-16}})));
  Modelica.Blocks.Logical.Switch switch8
    annotation (Placement(transformation(extent={{32,-12},{40,-4}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis4(uLow=14, uHigh=16)
    annotation (Placement(transformation(extent={{54,34},{66,46}})));
  Modelica.Blocks.Logical.Switch switch9
    annotation (Placement(transformation(extent={{82,30},{90,38}})));
  Modelica.Blocks.Logical.Switch switch10
    annotation (Placement(transformation(extent={{82,42},{90,50}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-42,-42},{-34,-34}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-52,-80})));
  Modelica.Blocks.Math.Gain gain3(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-4,-80})));
  Modelica.Blocks.Math.Gain gain4(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={50,-76})));
  Modelica.Blocks.Math.Gain gain5(k=-1)
    annotation (Placement(transformation(extent={{52,-54},{60,-46}})));
equation
  connect(PID_TBA_Openplanoffice_Warm.u_m, measureBus.RoomTemp_Openplanoffice)
    annotation (Line(points={{-70,78},{-70,70},{-99.9,70},{-99.9,0.1}}, color={
          0,0,127}));
  connect(PID_TBA_Openplanoffice_Cold.u_m, measureBus.RoomTemp_Openplanoffice)
    annotation (Line(points={{-70,-78},{-70,-70},{-99.9,-70},{-99.9,0.1}},
        color={0,0,127}));
  connect(PID_TBA_Canteen_Cold.u_m, measureBus.RoomTemp_Canteen) annotation (
      Line(points={{-70,-38},{-70,-30},{-99.9,-30},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_TBA_Canteen_Warm.u_m, measureBus.RoomTemp_Canteen) annotation (
      Line(points={{-70,38},{-70,30},{-99.9,30},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_TBA_Conferenceroom_Warm.u_m, measureBus.RoomTemp_Conferenceroom)
    annotation (Line(points={{-20,78},{-20,70},{-99.9,70},{-99.9,0.1}}, color={
          0,0,127}));
  connect(PID_TBA_Multipersonoffice_Warm.u_m, measureBus.RoomTemp_Multipersonoffice)
    annotation (Line(points={{30,78},{30,70},{-99.9,70},{-99.9,0.1}}, color={0,
          0,127}));
  connect(PID_TBA_Workshop_Warm.u_m, measureBus.RoomTemp_Workshop) annotation (
      Line(points={{30,38},{30,30},{-99.9,30},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_TBA_Workshop_Cold.u_m, measureBus.RoomTemp_Workshop) annotation (
      Line(points={{30,-38},{30,-30},{-99.9,-30},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_TBA_Conferenceroom_Cold.u_m, measureBus.RoomTemp_Conferenceroom)
    annotation (Line(points={{-20,-78},{-20,-78},{-20,-70},{-99.9,-70},{-99.9,
          0.1}}, color={0,0,127}));
  connect(PID_TBA_Multipersonoffice_Cold.u_m, measureBus.RoomTemp_Multipersonoffice)
    annotation (Line(points={{30,-78},{30,-70},{-99.9,-70},{-99.9,0.1}}, color=
          {0,0,127}));
  connect(realExpression1.y, PID_TBA_Workshop_Cold.u_s)
    annotation (Line(points={{-9,-50},{18,-50}}, color={0,0,127}));
  connect(realExpression.y, PID_TBA_Workshop_Warm.u_s)
    annotation (Line(points={{-9,50},{18,50}}, color={0,0,127}));
  connect(realExpression2.y, PID_TBA_Openplanoffice_Warm.u_s)
    annotation (Line(points={{-105,90},{-82,90}}, color={0,0,127}));
  connect(PID_TBA_Conferenceroom_Warm.u_s, PID_TBA_Openplanoffice_Warm.u_s)
    annotation (Line(points={{-32,90},{-40,90},{-40,70},{-100,70},{-100,90},{
          -82,90}}, color={0,0,127}));
  connect(PID_TBA_Canteen_Warm.u_s, PID_TBA_Openplanoffice_Warm.u_s)
    annotation (Line(points={{-82,50},{-100,50},{-100,90},{-82,90}}, color={0,0,
          127}));
  connect(PID_TBA_Multipersonoffice_Warm.u_s, PID_TBA_Openplanoffice_Warm.u_s)
    annotation (Line(points={{18,90},{10,90},{10,70},{-100,70},{-100,90},{-82,
          90}}, color={0,0,127}));
  connect(PID_TBA_Openplanoffice_Cold.u_s, realExpression3.y)
    annotation (Line(points={{-82,-90},{-105,-90}}, color={0,0,127}));
  connect(PID_TBA_Conferenceroom_Cold.u_s, realExpression3.y) annotation (Line(
        points={{-32,-90},{-42,-90},{-42,-70},{-100,-70},{-100,-90},{-105,-90}},
        color={0,0,127}));
  connect(PID_TBA_Multipersonoffice_Cold.u_s, realExpression3.y) annotation (
      Line(points={{18,-90},{8,-90},{8,-70},{-100,-70},{-100,-90},{-105,-90}},
        color={0,0,127}));
  connect(PID_TBA_Canteen_Cold.u_s, realExpression3.y) annotation (Line(points=
          {{-82,-50},{-100,-50},{-100,-90},{-105,-90}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2) annotation (Line(points={{-33.4,16},{-28,16},
          {-28,22},{-18.8,22}}, color={255,0,255}));
  connect(switch2.u2, hysteresis.y) annotation (Line(points={{-18.8,10},{-28,10},
          {-28,16},{-33.4,16}}, color={255,0,255}));
  connect(switch1.u1, PID_TBA_Openplanoffice_Warm.y) annotation (Line(points={{
          -18.8,25.2},{-28,25.2},{-28,40},{-48,40},{-48,90},{-59,90}}, color={0,
          0,127}));
  connect(hysteresis.u, measureBus.RoomTemp_Openplanoffice) annotation (Line(
        points={{-47.2,16},{-50,16},{-50,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(switch2.u3, realExpression5.y) annotation (Line(points={{-18.8,6.8},{
          -54,6.8},{-54,10},{-59,10}}, color={0,0,127}));
  connect(switch2.u1, realExpression4.y) annotation (Line(points={{-18.8,13.2},
          {-26,13.2},{-26,4},{-56,4},{-56,-16},{-59,-16}}, color={0,0,127}));
  connect(hysteresis1.u, measureBus.RoomTemp_Conferenceroom) annotation (Line(
        points={{2.8,16},{-4,16},{-4,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(hysteresis2.u, measureBus.RoomTemp_Multipersonoffice) annotation (
      Line(points={{-47.2,-14},{-50,-14},{-50,0},{-74,0},{-74,0.1},{-99.9,0.1}},
        color={0,0,127}));
  connect(hysteresis3.u, measureBus.RoomTemp_Canteen) annotation (Line(points={
          {2.8,-14},{-4,-14},{-4,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(hysteresis4.u, measureBus.RoomTemp_Workshop) annotation (Line(points=
          {{52.8,40},{50,40},{50,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(switch5.u1, realExpression4.y) annotation (Line(points={{-18.8,-16.8},
          {-26,-16.8},{-26,4},{-56,4},{-56,-16},{-59,-16}}, color={0,0,127}));
  connect(switch5.u3, realExpression5.y) annotation (Line(points={{-18.8,-23.2},
          {-54,-23.2},{-54,6},{-54,6},{-54,10},{-59,10}}, color={0,0,127}));
  connect(switch6.u1, PID_TBA_Multipersonoffice_Warm.y) annotation (Line(points
        ={{-18.8,-4.8},{-24,-4.8},{-24,40},{2,40},{2,66},{54,66},{54,90},{41,90}},
        color={0,0,127}));
  connect(hysteresis1.y, switch4.u2) annotation (Line(points={{16.6,16},{22,16},
          {22,22},{31.2,22}}, color={255,0,255}));
  connect(switch3.u2, switch4.u2) annotation (Line(points={{31.2,10},{22,10},{
          22,22},{31.2,22}}, color={255,0,255}));
  connect(switch4.u1, PID_TBA_Conferenceroom_Warm.y) annotation (Line(points={{
          31.2,25.2},{6,25.2},{6,90},{-9,90}}, color={0,0,127}));
  connect(switch3.u1, realExpression4.y) annotation (Line(points={{31.2,13.2},{
          28,13.2},{28,4},{-56,4},{-56,-16},{-59,-16}}, color={0,0,127}));
  connect(switch3.u3, realExpression5.y) annotation (Line(points={{31.2,6.8},{
          18,6.8},{18,-26},{-54,-26},{-54,10},{-59,10}}, color={0,0,127}));
  connect(hysteresis3.y, switch8.u2) annotation (Line(points={{16.6,-14},{22,
          -14},{22,-8},{31.2,-8}}, color={255,0,255}));
  connect(switch7.u2, hysteresis3.y) annotation (Line(points={{31.2,-20},{22,
          -20},{22,-14},{16.6,-14}}, color={255,0,255}));
  connect(switch8.u1, PID_TBA_Canteen_Warm.y) annotation (Line(points={{31.2,
          -4.8},{2,-4.8},{2,34},{-50,34},{-50,50},{-59,50}}, color={0,0,127}));
  connect(switch7.u1, realExpression4.y) annotation (Line(points={{31.2,-16.8},
          {28,-16.8},{28,4},{-56,4},{-56,-16},{-59,-16}}, color={0,0,127}));
  connect(switch7.u3, realExpression5.y) annotation (Line(points={{31.2,-23.2},
          {28,-23.2},{28,-26},{-54,-26},{-54,10},{-59,10}}, color={0,0,127}));
  connect(hysteresis4.y, switch10.u2) annotation (Line(points={{66.6,40},{74,40},
          {74,46},{81.2,46}}, color={255,0,255}));
  connect(switch9.u2, switch10.u2) annotation (Line(points={{81.2,34},{74,34},{
          74,40},{74,40},{74,46},{81.2,46}}, color={255,0,255}));
  connect(switch10.u1, PID_TBA_Workshop_Warm.y) annotation (Line(points={{81.2,
          49.2},{60.6,49.2},{60.6,50},{41,50}}, color={0,0,127}));
  connect(switch9.u1, realExpression4.y) annotation (Line(points={{81.2,37.2},{
          70,37.2},{70,4},{-56,4},{-56,-16},{-59,-16}}, color={0,0,127}));
  connect(switch9.u3, realExpression5.y) annotation (Line(points={{81.2,30.8},{
          74,30.8},{74,-26},{-54,-26},{-54,10},{-59,10}}, color={0,0,127}));
  connect(switch1.y, controlBus.Valve_TBA_Cold_OpenPlanOffice_Temp) annotation
    (Line(points={{-9.6,22},{-6,22},{-6,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(switch2.y, controlBus.Valve_TBA_WarmCold_OpenPlanOffice_1)
    annotation (Line(points={{-9.6,10},{-6,10},{-6,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(switch6.y, controlBus.Valve_TBA_Cold_MultiPersonOffice_Temp)
    annotation (Line(points={{-9.6,-8},{-6,-8},{-6,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(switch5.y, controlBus.Valve_TBA_WarmCold_multipersonoffice_1)
    annotation (Line(points={{-9.6,-20},{-6,-20},{-6,0.1},{100.1,0.1}}, color={
          0,0,127}));
  connect(switch4.y, controlBus.Valve_TBA_Cold_ConferenceRoom_Temp) annotation
    (Line(points={{40.4,22},{46,22},{46,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(switch3.y, controlBus.Valve_TBA_WarmCold_conferenceroom_1)
    annotation (Line(points={{40.4,10},{46,10},{46,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(switch8.y, controlBus.Valve_TBA_Cold_Canteen_Temp) annotation (Line(
        points={{40.4,-8},{46,-8},{46,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(switch7.y, controlBus.Valve_TBA_WarmCold_canteen_1) annotation (Line(
        points={{40.4,-20},{46,-20},{46,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(switch10.y, controlBus.Valve_TBA_Cold_Workshop_Temp) annotation (Line(
        points={{90.4,46},{100.1,46},{100.1,0.1}}, color={0,0,127}));
  connect(switch9.y, controlBus.Valve_TBA_WarmCold_workshop_1) annotation (Line(
        points={{90.4,34},{100.1,34},{100.1,0.1}}, color={0,0,127}));
  connect(switch8.u3, gain2.y) annotation (Line(points={{31.2,-11.2},{26,-11.2},
          {26,-38},{-33.6,-38}}, color={0,0,127}));
  connect(gain2.u, PID_TBA_Canteen_Cold.y) annotation (Line(points={{-42.8,-38},
          {-46,-38},{-46,-50},{-59,-50}}, color={0,0,127}));
  connect(switch1.u3, gain1.y) annotation (Line(points={{-18.8,18.8},{-32,18.8},
          {-32,-2},{-52,-2},{-52,-75.6}}, color={0,0,127}));
  connect(gain1.u, PID_TBA_Openplanoffice_Cold.y) annotation (Line(points={{-52,
          -84.8},{-52,-90},{-59,-90}}, color={0,0,127}));
  connect(switch4.u3, gain3.y) annotation (Line(points={{31.2,18.8},{24,18.8},{
          24,-34},{-4,-34},{-4,-75.6}}, color={0,0,127}));
  connect(gain3.u, PID_TBA_Conferenceroom_Cold.y)
    annotation (Line(points={{-4,-84.8},{-4,-90},{-9,-90}}, color={0,0,127}));
  connect(switch6.u3, gain4.y) annotation (Line(points={{-18.8,-11.2},{-24,
          -11.2},{-24,-36},{2,-36},{2,-66},{50,-66},{50,-71.6}}, color={0,0,127}));
  connect(gain4.u, PID_TBA_Multipersonoffice_Cold.y)
    annotation (Line(points={{50,-80.8},{50,-90},{41,-90}}, color={0,0,127}));
  connect(switch10.u3, gain5.y) annotation (Line(points={{81.2,42.8},{76,42.8},
          {76,-50},{60.4,-50}}, color={0,0,127}));
  connect(gain5.u, PID_TBA_Workshop_Cold.y)
    annotation (Line(points={{51.2,-50},{41,-50}}, color={0,0,127}));
  connect(switch6.u2, hysteresis2.y) annotation (Line(points={{-18.8,-8},{-30,
          -8},{-30,-14},{-33.4,-14}}, color={255,0,255}));
  connect(switch5.u2, hysteresis2.y) annotation (Line(points={{-18.8,-20},{-30,
          -20},{-30,-14},{-33.4,-14}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PID_Regler_TBA;
