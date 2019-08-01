within AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp;
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
  Model.BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Conferenceroom_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
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
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{-80,-40},{-60,-60}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Multipersonoffice_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{20,-80},{40,-100}})));
  Modelica.Blocks.Continuous.LimPID PID_TBA_Workshop_Cold(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=0,
    yMin=-1)
           annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
  Model.BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-126,80},{-106,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-126,-100},{-106,-80}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-44,-40})));
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
  TBA_Hysteresis Openplanoffice
    annotation (Placement(transformation(extent={{-60,4},{-40,24}})));
  TBA_Hysteresis Conferenceroom
    annotation (Placement(transformation(extent={{-24,4},{-4,24}})));
  TBA_Hysteresis Multipersonoffice
    annotation (Placement(transformation(extent={{10,4},{30,24}})));
  TBA_Hysteresis Workshop
    annotation (Placement(transformation(extent={{10,-24},{30,-4}})));
  TBA_Hysteresis Canteen
    annotation (Placement(transformation(extent={{-60,-24},{-40,-4}})));
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
  connect(gain2.u, PID_TBA_Canteen_Cold.y) annotation (Line(points={{-44,-44.8},
          {-44,-44.8},{-44,-50},{-59,-50}},
                                          color={0,0,127}));
  connect(gain1.u, PID_TBA_Openplanoffice_Cold.y) annotation (Line(points={{-52,
          -84.8},{-52,-90},{-59,-90}}, color={0,0,127}));
  connect(gain3.u, PID_TBA_Conferenceroom_Cold.y)
    annotation (Line(points={{-4,-84.8},{-4,-90},{-9,-90}}, color={0,0,127}));
  connect(gain4.u, PID_TBA_Multipersonoffice_Cold.y)
    annotation (Line(points={{50,-80.8},{50,-90},{41,-90}}, color={0,0,127}));
  connect(gain5.u, PID_TBA_Workshop_Cold.y)
    annotation (Line(points={{51.2,-50},{41,-50}}, color={0,0,127}));
  connect(Openplanoffice.RoomTemp, measureBus.RoomTemp_Openplanoffice)
    annotation (Line(points={{-60,14},{-64,14},{-64,0.1},{-99.9,0.1}}, color={0,
          0,127}));
  connect(Openplanoffice.y_pump, controlBus.Pump_TBA_OpenPlanOffice_y)
    annotation (Line(points={{-60,10},{-64,10},{-64,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(Openplanoffice.Cold, gain1.y) annotation (Line(points={{-48,4},{-48,0},
          {-70,0},{-70,-30},{-52,-30},{-52,-75.6}}, color={0,0,127}));
  connect(Openplanoffice.warm, PID_TBA_Openplanoffice_Warm.y)
    annotation (Line(points={{-48,24},{-48,90},{-59,90}}, color={0,0,127}));
  connect(Openplanoffice.WarmCold, controlBus.Valve_TBA_WarmCold_OpenPlanOffice_1)
    annotation (Line(points={{-39,11},{-34,11},{-34,0},{100,0}},       color={0,
          0,127}));
  connect(Openplanoffice.Tempvalve, controlBus.Valve_TBA_Cold_OpenPlanOffice_Temp)
    annotation (Line(points={{-39,17},{-34,17},{-34,0},{100,0}},       color={0,
          0,127}));
  connect(Conferenceroom.warm, PID_TBA_Conferenceroom_Warm.y) annotation (Line(
        points={{-12,24},{-12,30},{0,30},{0,90},{-9,90}}, color={0,0,127}));
  connect(Multipersonoffice.warm, PID_TBA_Multipersonoffice_Warm.y) annotation (
     Line(points={{22,24},{22,30},{50,30},{50,90},{41,90}}, color={0,0,127}));
  connect(Canteen.warm, PID_TBA_Canteen_Warm.y) annotation (Line(points={{-48,
          -4},{-48,-4},{-48,0},{-70,0},{-70,30},{-54,30},{-54,50},{-59,50}},
        color={0,0,127}));
  connect(PID_TBA_Workshop_Warm.y, Workshop.warm) annotation (Line(points={{41,
          50},{50,50},{50,0},{22,0},{22,-4}}, color={0,0,127}));
  connect(gain3.y, Conferenceroom.Cold) annotation (Line(points={{-4,-75.6},{-4,
          -30},{-12,-30},{-12,4}}, color={0,0,127}));
  connect(gain2.y, Canteen.Cold) annotation (Line(points={{-44,-35.6},{-44,-36},
          {-44,-36},{-44,-36},{-44,-30},{-48,-30},{-48,-24}}, color={0,0,127}));
  connect(gain5.y, Workshop.Cold) annotation (Line(points={{60.4,-50},{62,-50},
          {62,-28},{22,-28},{22,-24}}, color={0,0,127}));
  connect(gain4.y, Multipersonoffice.Cold) annotation (Line(points={{50,-71.6},
          {50,0},{22,0},{22,4},{22,4}}, color={0,0,127}));
  connect(Canteen.RoomTemp, measureBus.RoomTemp_Canteen) annotation (Line(
        points={{-60,-14},{-64,-14},{-64,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(Conferenceroom.RoomTemp, measureBus.RoomTemp_Conferenceroom)
    annotation (Line(points={{-24,14},{-28,14},{-28,0.1},{-99.9,0.1}}, color={0,
          0,127}));
  connect(Multipersonoffice.RoomTemp, measureBus.RoomTemp_Multipersonoffice)
    annotation (Line(points={{10,14},{4,14},{4,0.1},{-99.9,0.1}}, color={0,0,
          127}));
  connect(Workshop.RoomTemp, measureBus.RoomTemp_Workshop) annotation (Line(
        points={{10,-14},{4,-14},{4,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(Conferenceroom.y_pump, controlBus.Pump_TBA_ConferenceRoom_y)
    annotation (Line(points={{-24,10},{-28,10},{-28,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(Multipersonoffice.y_pump, controlBus.Pump_TBA_MultiPersonOffice_y)
    annotation (Line(points={{10,10},{4,10},{4,0},{52,0},{52,0.1},{100.1,0.1}},
        color={0,0,127}));
  connect(Workshop.y_pump, controlBus.Pump_TBA_Workshop_y) annotation (Line(
        points={{10,-18},{4,-18},{4,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Canteen.y_pump, controlBus.Pump_TBA_Canteen_y) annotation (Line(
        points={{-60,-18},{-64,-18},{-64,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Canteen.Tempvalve, controlBus.Valve_TBA_Cold_Canteen_Temp)
    annotation (Line(points={{-39,-11},{-34,-11},{-34,0},{100,0}},       color=
          {0,0,127}));
  connect(Workshop.Tempvalve, controlBus.Valve_TBA_Cold_Workshop_Temp)
    annotation (Line(points={{31,-11},{36,-11},{36,0},{100,0}},       color={0,
          0,127}));
  connect(Multipersonoffice.Tempvalve, controlBus.Valve_TBA_Cold_MultiPersonOffice_Temp)
    annotation (Line(points={{31,17},{36,17},{36,0},{100,0}},       color={0,0,
          127}));
  connect(Conferenceroom.Tempvalve, controlBus.Valve_TBA_Cold_ConferenceRoom_Temp)
    annotation (Line(points={{-3,17},{0,17},{0,0},{100,0}},       color={0,0,
          127}));
  connect(Canteen.WarmCold, controlBus.Valve_TBA_WarmCold_canteen_1)
    annotation (Line(points={{-39,-17},{-34,-17},{-34,0},{100,0}},       color=
          {0,0,127}));
  connect(Conferenceroom.WarmCold, controlBus.Valve_TBA_WarmCold_conferenceroom_1)
    annotation (Line(points={{-3,11},{0,11},{0,0},{100,0}},       color={0,0,
          127}));
  connect(Multipersonoffice.WarmCold, controlBus.Valve_TBA_WarmCold_multipersonoffice_1)
    annotation (Line(points={{31,11},{36,11},{36,0},{100,0}},       color={0,0,
          127}));
  connect(Workshop.WarmCold, controlBus.Valve_TBA_WarmCold_workshop_1)
    annotation (Line(points={{31,-17},{36,-17},{36,0},{100,0}},       color={0,
          0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PID_Regler_TBA;
