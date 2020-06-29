within AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp;
model PI_Regler_TBA_v2
  Modelica.Blocks.Continuous.LimPID PID_TBA_Conferenceroom_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=200,
    k=0.01)
           annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Openplanoffice_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=200)
           annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Canteen_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=200)
           annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Multipersonoffice_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=200)
           annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Workshop_Warm(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=200)
           annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Conferenceroom_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=0,
    yMin=-1,
    Ti=200,
    k=0.01)
           annotation (Placement(transformation(extent={{-30,-80},{-10,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Openplanoffice_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{-80,-80},{-60,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Canteen_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    yMax=0,
    yMin=-1,
    Ti=200)
           annotation (Placement(transformation(extent={{-80,-40},{-60,-60}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Multipersonoffice_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    yMax=0,
    yMin=-1,
    Ti=200)
           annotation (Placement(transformation(extent={{20,-80},{40,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Workshop_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    yMax=0,
    yMin=-1,
    Ti=200)
           annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 14)
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 16)
    annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-126,80},{-106,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 22)
    annotation (Placement(transformation(extent={{-126,-100},{-106,-80}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-40,-40})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-48,-80})));
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
  Model.BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Model.BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  TBA_Hystersis_v2 Openplanoffice
    annotation (Placement(transformation(extent={{-60,6},{-40,26}})));
  TBA_Hystersis_v2 Conferenceroom
    annotation (Placement(transformation(extent={{-20,6},{0,26}})));
  TBA_Hystersis_v2 Multipersonoffice
    annotation (Placement(transformation(extent={{20,6},{40,26}})));
  TBA_Hystersis_v2 Canteen
    annotation (Placement(transformation(extent={{-40,-26},{-20,-6}})));
  TBA_Hystersis_v2 Workshop
    annotation (Placement(transformation(extent={{0,-26},{20,-6}})));
equation
  connect(PID_TBA_Openplanoffice_Warm.u_m,measureBus. RoomTemp_Openplanoffice)
    annotation (Line(points={{-70,78},{-70,70},{-99.9,70},{-99.9,0.1}}, color={
          0,0,127}));
  connect(PID_TBA_Openplanoffice_Cold.u_m,measureBus. RoomTemp_Openplanoffice)
    annotation (Line(points={{-70,-78},{-70,-70},{-99.9,-70},{-99.9,0.1}},
        color={0,0,127}));
  connect(PID_TBA_Canteen_Cold.u_m,measureBus. RoomTemp_Canteen) annotation (
      Line(points={{-70,-38},{-70,-30},{-99.9,-30},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_TBA_Canteen_Warm.u_m,measureBus. RoomTemp_Canteen) annotation (
      Line(points={{-70,38},{-70,30},{-99.9,30},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_TBA_Conferenceroom_Warm.u_m,measureBus. RoomTemp_Conferenceroom)
    annotation (Line(points={{-20,78},{-20,70},{-99.9,70},{-99.9,0.1}}, color={
          0,0,127}));
  connect(PID_TBA_Multipersonoffice_Warm.u_m,measureBus. RoomTemp_Multipersonoffice)
    annotation (Line(points={{30,78},{30,70},{-99.9,70},{-99.9,0.1}}, color={0,
          0,127}));
  connect(PID_TBA_Workshop_Warm.u_m,measureBus. RoomTemp_Workshop) annotation (
      Line(points={{30,38},{30,30},{-99.9,30},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_TBA_Workshop_Cold.u_m,measureBus. RoomTemp_Workshop) annotation (
      Line(points={{30,-38},{30,-30},{-99.9,-30},{-99.9,0.1}}, color={0,0,127}));
  connect(PID_TBA_Conferenceroom_Cold.u_m,measureBus. RoomTemp_Conferenceroom)
    annotation (Line(points={{-20,-78},{-20,-78},{-20,-70},{-99.9,-70},{-99.9,
          0.1}}, color={0,0,127}));
  connect(PID_TBA_Multipersonoffice_Cold.u_m,measureBus. RoomTemp_Multipersonoffice)
    annotation (Line(points={{30,-78},{30,-70},{-99.9,-70},{-99.9,0.1}}, color=
          {0,0,127}));
  connect(realExpression1.y,PID_TBA_Workshop_Cold. u_s)
    annotation (Line(points={{-9,-50},{18,-50}}, color={0,0,127}));
  connect(realExpression.y,PID_TBA_Workshop_Warm. u_s)
    annotation (Line(points={{-9,50},{18,50}}, color={0,0,127}));
  connect(realExpression2.y,PID_TBA_Openplanoffice_Warm. u_s)
    annotation (Line(points={{-105,90},{-82,90}}, color={0,0,127}));
  connect(PID_TBA_Conferenceroom_Warm.u_s,PID_TBA_Openplanoffice_Warm. u_s)
    annotation (Line(points={{-32,90},{-40,90},{-40,70},{-100,70},{-100,90},{
          -82,90}}, color={0,0,127}));
  connect(PID_TBA_Canteen_Warm.u_s,PID_TBA_Openplanoffice_Warm. u_s)
    annotation (Line(points={{-82,50},{-100,50},{-100,90},{-82,90}}, color={0,0,
          127}));
  connect(PID_TBA_Multipersonoffice_Warm.u_s,PID_TBA_Openplanoffice_Warm. u_s)
    annotation (Line(points={{18,90},{10,90},{10,70},{-100,70},{-100,90},{-82,
          90}}, color={0,0,127}));
  connect(PID_TBA_Openplanoffice_Cold.u_s,realExpression3. y)
    annotation (Line(points={{-82,-90},{-105,-90}}, color={0,0,127}));
  connect(PID_TBA_Conferenceroom_Cold.u_s,realExpression3. y) annotation (Line(
        points={{-32,-90},{-42,-90},{-42,-70},{-100,-70},{-100,-90},{-105,-90}},
        color={0,0,127}));
  connect(PID_TBA_Multipersonoffice_Cold.u_s,realExpression3. y) annotation (
      Line(points={{18,-90},{8,-90},{8,-70},{-100,-70},{-100,-90},{-105,-90}},
        color={0,0,127}));
  connect(PID_TBA_Canteen_Cold.u_s,realExpression3. y) annotation (Line(points=
          {{-82,-50},{-100,-50},{-100,-90},{-105,-90}}, color={0,0,127}));
  connect(gain2.u,PID_TBA_Canteen_Cold. y) annotation (Line(points={{-40,-44.8},
          {-40,-44.8},{-40,-50},{-59,-50}},
                                          color={0,0,127}));
  connect(gain1.u,PID_TBA_Openplanoffice_Cold. y) annotation (Line(points={{-48,
          -84.8},{-48,-90},{-59,-90}}, color={0,0,127}));
  connect(gain3.u,PID_TBA_Conferenceroom_Cold. y)
    annotation (Line(points={{-4,-84.8},{-4,-90},{-9,-90}}, color={0,0,127}));
  connect(gain4.u,PID_TBA_Multipersonoffice_Cold. y)
    annotation (Line(points={{50,-80.8},{50,-90},{41,-90}}, color={0,0,127}));
  connect(gain5.u,PID_TBA_Workshop_Cold. y)
    annotation (Line(points={{51.2,-50},{41,-50}}, color={0,0,127}));
  connect(Openplanoffice.warm, PID_TBA_Openplanoffice_Warm.y)
    annotation (Line(points={{-48,26},{-48,90},{-59,90}}, color={0,0,127}));
  connect(Conferenceroom.warm, PID_TBA_Conferenceroom_Warm.y) annotation (Line(
        points={{-8,26},{-8,34},{0,34},{0,90},{-9,90}}, color={0,0,127}));
  connect(Multipersonoffice.warm, PID_TBA_Multipersonoffice_Warm.y) annotation (
     Line(points={{32,26},{32,34},{54,34},{54,90},{41,90}}, color={0,0,127}));
  connect(Canteen.warm, PID_TBA_Canteen_Warm.y) annotation (Line(points={{-28,
          -6},{-28,-2},{-34,-2},{-34,4},{-34,50},{-59,50}}, color={0,0,127}));
  connect(Workshop.warm, PID_TBA_Workshop_Warm.y) annotation (Line(points={{12,
          -6},{12,-2},{52,-2},{52,50},{41,50}}, color={0,0,127}));
  connect(Openplanoffice.Valve_Warm, controlBus.Valve_TBA_Warm_OpenPlanOffice)
    annotation (Line(points={{-39,19},{-36,19},{-36,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(Conferenceroom.Valve_Warm, controlBus.Valve_TBA_Warm_conferenceroom)
    annotation (Line(points={{1,19},{6,19},{6,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Multipersonoffice.Valve_Warm, controlBus.Valve_TBA_Warm_multipersonoffice)
    annotation (Line(points={{41,19},{46,19},{46,0.1},{100.1,0.1}}, color={0,0,
          127}));
  connect(Canteen.Valve_Warm, controlBus.Valve_TBA_Warm_canteen) annotation (
      Line(points={{-19,-13},{-16,-13},{-16,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Workshop.Valve_Warm, controlBus.Valve_TBA_Warm_workshop) annotation (
      Line(points={{21,-13},{28,-13},{28,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Openplanoffice.Valve_Temp, controlBus.Valve_TBA_OpenPlanOffice_Temp)
    annotation (Line(points={{-39,13},{-36,13},{-36,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(Conferenceroom.Valve_Temp, controlBus.Valve_TBA_ConferenceRoom_Temp)
    annotation (Line(points={{1,13},{6,13},{6,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Multipersonoffice.Valve_Temp, controlBus.Valve_TBA_MultiPersonOffice_Temp)
    annotation (Line(points={{41,13},{46,13},{46,0.1},{100.1,0.1}}, color={0,0,
          127}));
  connect(Canteen.Valve_Temp, controlBus.Valve_TBA_Canteen_Temp) annotation (
      Line(points={{-19,-19},{-16,-19},{-16,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Workshop.Valve_Temp, controlBus.Valve_TBA_Workshop_Temp) annotation (
      Line(points={{21,-19},{28,-19},{28,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(gain2.y, Canteen.Cold) annotation (Line(points={{-40,-35.6},{-40,-34},
          {-28,-34},{-28,-26}}, color={0,0,127}));
  connect(Openplanoffice.Cold, gain1.y)
    annotation (Line(points={{-48,6},{-48,-75.6}}, color={0,0,127}));
  connect(Conferenceroom.Cold, gain3.y) annotation (Line(points={{-8,6},{-6,6},
          {-6,-75.6},{-4,-75.6}}, color={0,0,127}));
  connect(Multipersonoffice.Cold, gain4.y) annotation (Line(points={{32,6},{32,
          -4},{50,-4},{50,-71.6}}, color={0,0,127}));
  connect(Workshop.Cold, gain5.y) annotation (Line(points={{12,-26},{38,-26},{
          38,-26},{64,-26},{64,-50},{60.4,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PI_Regler_TBA_v2;
