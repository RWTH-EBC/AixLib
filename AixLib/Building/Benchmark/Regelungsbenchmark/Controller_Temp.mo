within AixLib.Building.Benchmark.Regelungsbenchmark;
package Controller_Temp
  model PI_Regler_RLT
    Modelica.Blocks.Continuous.LimPID PID_RLT_Conferenceroom_Hot(
      yMax=1,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.3,
      Ti=400)
             annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Openplanoffice_Hot(
      yMax=1,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.01,
      Ti=200)
             annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Canteen_Hot(
      yMax=1,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=200,
      k=0.01)
             annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Multipersonoffice_Hot(
      yMax=1,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=200,
      k=0.01)
             annotation (Placement(transformation(extent={{20,80},{40,100}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Workshop_Hot(
      yMax=1,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.01,
      Ti=200)
             annotation (Placement(transformation(extent={{20,40},{40,60}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Conferenceroom_Cold(
      yMax=0,
      yMin=-1,
      k=0.3,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=400)
             annotation (Placement(transformation(extent={{-30,-80},{-10,-100}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Openplanoffice_Cold(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      yMax=0,
      yMin=-1,
      Ti=200)
             annotation (Placement(transformation(extent={{-80,-80},{-60,-100}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Canteen_Cold(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=0,
      yMin=-1,
      Ti=200,
      k=0.01)
             annotation (Placement(transformation(extent={{-80,-40},{-60,-60}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Multipersonoffice_Cold(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=0,
      yMin=-1,
      Ti=200,
      k=0.01)
             annotation (Placement(transformation(extent={{20,-80},{40,-100}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Workshop_Cold(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=0,
      yMin=-1,
      k=0.01,
      Ti=200)
             annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
      annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 22)
      annotation (Placement(transformation(extent={{-136,-100},{-116,-80}})));
    BusSystem.Bus_measure measureBus
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    BusSystem.Bus_Control controlBus
      annotation (Placement(transformation(extent={{80,-20},{120,20}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Central_Cold(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=0,
      yMin=-1,
      Ti=100,
      k=0.1) annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
    Modelica.Blocks.Continuous.LimPID PID_RLT_Central_Hot(
      yMax=1,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=100,
      k=0.1) annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{-56,-54},{-48,-46}})));
    Modelica.Blocks.Math.Gain gain1(k=-1)
      annotation (Placement(transformation(extent={{-56,-94},{-48,-86}})));
    Modelica.Blocks.Math.Gain gain2(k=-1)
      annotation (Placement(transformation(extent={{-6,-54},{2,-46}})));
    Modelica.Blocks.Math.Gain gain3(k=-1)
      annotation (Placement(transformation(extent={{-6,-94},{2,-86}})));
    Modelica.Blocks.Math.Gain gain4(k=-1)
      annotation (Placement(transformation(extent={{44,-54},{52,-46}})));
    Modelica.Blocks.Math.Gain gain5(k=-1)
      annotation (Placement(transformation(extent={{44,-94},{52,-86}})));
    RLT_Switch Openplanoffice
      annotation (Placement(transformation(extent={{-62,4},{-42,24}})));
    RLT_Switch Canteen
      annotation (Placement(transformation(extent={{-20,4},{0,24}})));
    RLT_Switch Central
      annotation (Placement(transformation(extent={{16,4},{36,24}})));
    RLT_Switch Conferenceroom
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    RLT_Switch Multipersonoffice
      annotation (Placement(transformation(extent={{60,24},{80,44}})));
    RLT_Switch Workshop
      annotation (Placement(transformation(extent={{60,-44},{80,-24}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 18.5)
      annotation (Placement(transformation(extent={{-136,-44},{-116,-24}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 16)
      annotation (Placement(transformation(extent={{-136,-64},{-116,-44}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=273.15 + 14)
      annotation (Placement(transformation(extent={{-136,40},{-116,60}})));
    Modelica.Blocks.Sources.RealExpression realExpression6(y=273.15 + 18)
      annotation (Placement(transformation(extent={{-136,22},{-116,42}})));
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
      annotation (Line(points={{-82,-90},{-115,-90}}, color={0,0,127}));
    connect(PID_RLT_Conferenceroom_Cold.u_s, realExpression3.y) annotation (Line(
          points={{-32,-90},{-42,-90},{-42,-70},{-100,-70},{-100,-90},{-115,-90}},
          color={0,0,127}));
    connect(PID_RLT_Multipersonoffice_Cold.u_s, realExpression3.y) annotation (
        Line(points={{18,-90},{10,-90},{10,-70},{-100,-70},{-100,-90},{-115,-90}},
          color={0,0,127}));
    connect(PID_RLT_Canteen_Cold.u_s, realExpression3.y) annotation (Line(points={{-82,-50},
            {-100,-50},{-100,-90},{-115,-90}},           color={0,0,127}));
    connect(PID_RLT_Canteen_Cold.y, gain.u)
      annotation (Line(points={{-59,-50},{-56.8,-50}}, color={0,0,127}));
    connect(PID_RLT_Openplanoffice_Cold.y, gain1.u)
      annotation (Line(points={{-59,-90},{-56.8,-90}}, color={0,0,127}));
    connect(PID_RLT_Central_Cold.y, gain2.u)
      annotation (Line(points={{-9,-50},{-6.8,-50}}, color={0,0,127}));
    connect(PID_RLT_Conferenceroom_Cold.y, gain3.u)
      annotation (Line(points={{-9,-90},{-6.8,-90}}, color={0,0,127}));
    connect(PID_RLT_Workshop_Cold.y, gain4.u)
      annotation (Line(points={{41,-50},{43.2,-50}}, color={0,0,127}));
    connect(PID_RLT_Multipersonoffice_Cold.y, gain5.u)
      annotation (Line(points={{41,-90},{43.2,-90}}, color={0,0,127}));
    connect(PID_RLT_Openplanoffice_Hot.y, Openplanoffice.hot)
      annotation (Line(points={{-59,90},{-52,90},{-52,24}}, color={0,0,127}));
    connect(gain1.y, Openplanoffice.cold) annotation (Line(points={{-47.6,-90},{
            -44,-90},{-44,-22},{-52,-22},{-52,4}}, color={0,0,127}));
    connect(PID_RLT_Canteen_Hot.y, Canteen.hot) annotation (Line(points={{-59,50},
            {-54,50},{-54,28},{-10,28},{-10,24}}, color={0,0,127}));
    connect(gain.y, Canteen.cold) annotation (Line(points={{-47.6,-50},{-44,-50},
            {-44,-22},{-10,-22},{-10,4}}, color={0,0,127}));
    connect(gain2.y, Central.cold) annotation (Line(points={{2.4,-50},{4,-50},{4,
            -22},{26,-22},{26,4}}, color={0,0,127}));
    connect(PID_RLT_Central_Hot.y, Central.hot) annotation (Line(points={{-9,50},
            {0,50},{0,28},{26,28},{26,24}}, color={0,0,127}));
    connect(PID_RLT_Conferenceroom_Hot.y, Conferenceroom.hot) annotation (Line(
          points={{-9,90},{0,90},{0,110},{70,110},{70,80}}, color={0,0,127}));
    connect(PID_RLT_Multipersonoffice_Hot.y, Multipersonoffice.hot) annotation (
        Line(points={{41,90},{50,90},{50,50},{70,50},{70,44}}, color={0,0,127}));
    connect(PID_RLT_Workshop_Hot.y, Workshop.hot) annotation (Line(points={{41,50},
            {50,50},{50,-18},{70,-18},{70,-24}}, color={0,0,127}));
    connect(gain4.y, Workshop.cold)
      annotation (Line(points={{52.4,-50},{70,-50},{70,-44}}, color={0,0,127}));
    connect(gain5.y, Multipersonoffice.cold) annotation (Line(points={{52.4,-90},
            {56,-90},{56,18},{70,18},{70,24}}, color={0,0,127}));
    connect(gain3.y, Conferenceroom.cold) annotation (Line(points={{2.4,-90},{4,
            -90},{4,-22},{50,-22},{50,56},{70,56},{70,60}}, color={0,0,127}));
    connect(Openplanoffice.Tempvalve_cold, controlBus.Valve_RLT_Cold_OpenPlanOffice)
      annotation (Line(points={{-41,11},{-34,11},{-34,0.1},{100.1,0.1}}, color={0,
            0,127}));
    connect(Openplanoffice.Tempvalve_Hot, controlBus.Valve_RLT_Hot_OpenPlanOffice)
      annotation (Line(points={{-41,17},{-34,17},{-34,0.1},{100.1,0.1}}, color={0,
            0,127}));
    connect(Canteen.Tempvalve_cold, controlBus.Valve_RLT_Cold_Canteen)
      annotation (Line(points={{1,11},{6,11},{6,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(Canteen.Tempvalve_Hot, controlBus.Valve_RLT_Hot_Canteen) annotation (
        Line(points={{1,17},{6,17},{6,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(Central.Tempvalve_cold, controlBus.Valve_RLT_Cold_Central)
      annotation (Line(points={{37,11},{42,11},{42,0.1},{100.1,0.1}}, color={0,0,
            127}));
    connect(Central.Tempvalve_Hot, controlBus.Valve_RLT_Hot_Central) annotation (
        Line(points={{37,17},{42,17},{42,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(Multipersonoffice.Tempvalve_cold, controlBus.Valve_RLT_Cold_MultiPersonOffice)
      annotation (Line(points={{81,31},{100.1,31},{100.1,0.1}}, color={0,0,127}));
    connect(Multipersonoffice.Tempvalve_Hot, controlBus.Valve_RLT_Hot_MultiPersonOffice)
      annotation (Line(points={{81,37},{100.1,37},{100.1,0.1}}, color={0,0,127}));
    connect(Conferenceroom.Tempvalve_cold, controlBus.Valve_RLT_Cold_ConferenceRoom)
      annotation (Line(points={{81,67},{100.1,67},{100.1,0.1}}, color={0,0,127}));
    connect(Conferenceroom.Tempvalve_Hot, controlBus.Valve_RLT_Hot_ConferenceRoom)
      annotation (Line(points={{81,73},{100.1,73},{100.1,0.1}}, color={0,0,127}));
    connect(Workshop.Tempvalve_Hot, controlBus.Valve_RLT_Hot_Workshop)
      annotation (Line(points={{81,-31},{100.1,-31},{100.1,0.1}}, color={0,0,127}));
    connect(Workshop.Tempvalve_cold, controlBus.Valve_RLT_Cold_Workshop)
      annotation (Line(points={{81,-37},{100.1,-37},{100.1,0.1}}, color={0,0,127}));
    connect(realExpression1.y, PID_RLT_Central_Cold.u_s) annotation (Line(points=
            {{-115,-34},{-36,-34},{-36,-50},{-32,-50}}, color={0,0,127}));
    connect(realExpression4.y, PID_RLT_Workshop_Cold.u_s) annotation (Line(points=
           {{-115,-54},{-108,-54},{-108,-32},{12,-32},{12,-50},{18,-50}}, color={
            0,0,127}));
    connect(realExpression6.y, PID_RLT_Central_Hot.u_s) annotation (Line(points={
            {-115,32},{-44,32},{-44,50},{-32,50},{-32,50}}, color={0,0,127}));
    connect(realExpression5.y, PID_RLT_Workshop_Hot.u_s) annotation (Line(points=
            {{-115,50},{-108,50},{-108,30},{8,30},{8,50},{18,50}}, color={0,0,127}));
    connect(PID_RLT_Openplanoffice_Cold.u_m, measureBus.RoomTemp_Openplanoffice)
      annotation (Line(points={{-70,-78},{-70,-74},{-99.9,-74},{-99.9,0.1}},
          color={0,0,127}));
    connect(PID_RLT_Conferenceroom_Cold.u_m, measureBus.RoomTemp_Conferenceroom)
      annotation (Line(points={{-20,-78},{-20,-74},{-99.9,-74},{-99.9,0.1}},
          color={0,0,127}));
    connect(PID_RLT_Multipersonoffice_Cold.u_m, measureBus.RoomTemp_Multipersonoffice)
      annotation (Line(points={{30,-78},{30,-74},{-99.9,-74},{-99.9,0.1}}, color=
            {0,0,127}));
    connect(PID_RLT_Openplanoffice_Hot.u_m, measureBus.RoomTemp_Openplanoffice)
      annotation (Line(points={{-70,78},{-70,74},{-99.9,74},{-99.9,0.1}}, color={
            0,0,127}));
    connect(PID_RLT_Conferenceroom_Hot.u_m, measureBus.RoomTemp_Conferenceroom)
      annotation (Line(points={{-20,78},{-20,74},{-99.9,74},{-99.9,0.1}}, color={
            0,0,127}));
    connect(PID_RLT_Multipersonoffice_Hot.u_m, measureBus.RoomTemp_Multipersonoffice)
      annotation (Line(points={{30,78},{30,74},{-99.9,74},{-99.9,0.1}}, color={0,
            0,127}));
    connect(PID_RLT_Canteen_Hot.u_m, measureBus.RoomTemp_Canteen) annotation (
        Line(points={{-70,38},{-70,36},{-99.9,36},{-99.9,0.1}}, color={0,0,127}));
    connect(PID_RLT_Central_Hot.u_m, measureBus.Air_RLT_Central_out) annotation (
        Line(points={{-20,38},{-20,38},{-20,36},{-99.9,36},{-99.9,0.1}}, color={0,
            0,127}));
    connect(PID_RLT_Workshop_Hot.u_m, measureBus.RoomTemp_Workshop) annotation (
        Line(points={{30,38},{30,34},{-100,34},{-100,18},{-99.9,18},{-99.9,0.1}},
                                                              color={0,0,127}));
    connect(PID_RLT_Canteen_Cold.u_m, measureBus.RoomTemp_Canteen) annotation (
        Line(points={{-70,-38},{-70,-28},{-99.9,-28},{-99.9,0.1}}, color={0,0,127}));
    connect(PID_RLT_Central_Cold.u_m, measureBus.Air_RLT_Central_out) annotation (
       Line(points={{-20,-38},{-20,-28},{-99.9,-28},{-99.9,0.1}}, color={0,0,127}));
    connect(PID_RLT_Workshop_Cold.u_m, measureBus.RoomTemp_Workshop) annotation (
        Line(points={{30,-38},{30,-28},{-99.9,-28},{-99.9,0.1}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PI_Regler_RLT;

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
    BusSystem.Bus_measure measureBus
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
    BusSystem.Bus_Control controlBus
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

  model TBA_Hysteresis
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 19, uHigh=273.15
           + 21)
      annotation (Placement(transformation(extent={{-40,-8},{-24,8}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=1)
      annotation (Placement(transformation(extent={{-44,-48},{-24,-28}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=0)
      annotation (Placement(transformation(extent={{-44,-32},{-24,-12}})));
    Modelica.Blocks.Interfaces.RealInput RoomTemp
      annotation (Placement(transformation(extent={{-114,-14},{-86,14}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{40,20},{60,40}})));
    Modelica.Blocks.Interfaces.RealOutput WarmCold
      "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
    Modelica.Blocks.Interfaces.RealOutput Tempvalve
      "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealInput warm
      "Connector of first Real input signal" annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=-90,
          origin={20,100})));
    Modelica.Blocks.Interfaces.RealInput Cold
      "Connector of first Real input signal" annotation (Placement(transformation(
          extent={{14,-14},{-14,14}},
          rotation=-90,
          origin={20,-100})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Blocks.Interfaces.RealInput y_pump
      "Connector of Boolean input signal"
      annotation (Placement(transformation(extent={{-114,-54},{-86,-26}})));
    Modelica.Blocks.Logical.Switch switch4
      annotation (Placement(transformation(extent={{0,-74},{20,-54}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=0.2, uHigh=0.3)
      annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=0.2, uHigh=0.3)
      annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  equation
    connect(hysteresis.u, RoomTemp) annotation (Line(points={{-41.6,0},{-70,0},{
            -70,1.77636e-015},{-100,1.77636e-015}}, color={0,0,127}));
    connect(realExpression4.y, switch2.u1)
      annotation (Line(points={{-23,-22},{38,-22}}, color={0,0,127}));
    connect(realExpression5.y, switch2.u3)
      annotation (Line(points={{-23,-38},{38,-38}}, color={0,0,127}));
    connect(hysteresis.y, switch2.u2) annotation (Line(points={{-23.2,0},{-12,0},
            {-12,-30},{38,-30}}, color={255,0,255}));
    connect(switch2.y, WarmCold)
      annotation (Line(points={{61,-30},{110,-30}}, color={0,0,127}));
    connect(switch1.y, Tempvalve)
      annotation (Line(points={{61,30},{110,30}}, color={0,0,127}));
    connect(warm, switch3.u1) annotation (Line(points={{20,100},{20,74},{-8,74},{
            -8,58},{-2,58}}, color={0,0,127}));
    connect(switch3.u3, switch2.u1) annotation (Line(points={{-2,42},{-2,42},{-8,
            42},{-8,-22},{-4,-22},{-4,-22},{38,-22}}, color={0,0,127}));
    connect(switch3.y, switch1.u1) annotation (Line(points={{21,50},{30,50},{30,
            38},{38,38}}, color={0,0,127}));
    connect(switch1.u2, switch2.u2) annotation (Line(points={{38,30},{-12,30},{
            -12,-30},{38,-30}}, color={255,0,255}));
    connect(Cold, switch4.u1) annotation (Line(points={{20,-100},{20,-80},{-12,
            -80},{-12,-56},{-2,-56}}, color={0,0,127}));
    connect(switch4.u3, switch2.u1) annotation (Line(points={{-2,-72},{-8,-72},{
            -8,-22},{38,-22}}, color={0,0,127}));
    connect(switch4.y, switch1.u3) annotation (Line(points={{21,-64},{30,-64},{30,
            22},{38,22}}, color={0,0,127}));
    connect(hysteresis1.y, switch3.u2)
      annotation (Line(points={{-29,50},{-2,50}}, color={255,0,255}));
    connect(hysteresis2.y, switch4.u2) annotation (Line(points={{-29,-70},{-16,
            -70},{-16,-64},{-2,-64}}, color={255,0,255}));
    connect(hysteresis2.u, y_pump) annotation (Line(points={{-52,-70},{-72,-70},{
            -72,-40},{-100,-40}}, color={0,0,127}));
    connect(hysteresis1.u, y_pump) annotation (Line(points={{-52,50},{-72,50},{
            -72,-40},{-100,-40}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TBA_Hysteresis;

  model RLT_Switch
    Modelica.Blocks.Interfaces.RealOutput Tempvalve_Hot
      "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealInput hot
      "Connector of first Real input signal" annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=-90,
          origin={0,100})));
    Modelica.Blocks.Interfaces.RealOutput Tempvalve_cold
      "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
    Modelica.Blocks.Interfaces.RealInput cold
      "Connector of first Real input signal" annotation (Placement(transformation(
          extent={{14,-14},{-14,14}},
          rotation=-90,
          origin={0,-100})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=10)
      annotation (Placement(transformation(extent={{50,20},{70,40}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=10)
      annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  equation
    connect(Tempvalve_cold, Tempvalve_cold)
      annotation (Line(points={{110,-30},{110,-30}}, color={0,0,127}));
    connect(firstOrder.y, Tempvalve_Hot)
      annotation (Line(points={{71,30},{110,30}}, color={0,0,127}));
    connect(firstOrder1.y, Tempvalve_cold) annotation (Line(points={{71,-30},{88,
            -30},{88,-30},{110,-30}}, color={0,0,127}));
    connect(hot, firstOrder.u) annotation (Line(points={{0,100},{0,100},{0,30},{
            48,30}}, color={0,0,127}));
    connect(cold, firstOrder1.u) annotation (Line(points={{-1.77636e-015,-100},{
            -1.77636e-015,-30},{48,-30}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end RLT_Switch;

  model PI_Regler_TBA_v2
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
    BusSystem.Bus_measure measureBus
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    BusSystem.Bus_Control controlBus
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

  model TBA_Hystersis_v2
    Modelica.Blocks.Interfaces.RealOutput Valve_Warm
      "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealInput warm
      "Connector of first Real input signal" annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=-90,
          origin={20,100})));
    Modelica.Blocks.Interfaces.RealInput Cold
      "Connector of first Real input signal" annotation (Placement(transformation(
          extent={{14,-14},{-14,14}},
          rotation=-90,
          origin={20,-100})));
    Modelica.Blocks.Interfaces.RealOutput Valve_Temp
      "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  equation
    connect(warm, Valve_Warm) annotation (Line(points={{20,100},{20,100},{20,30},
            {110,30}}, color={0,0,127}));
    connect(Cold, Valve_Temp)
      annotation (Line(points={{20,-100},{20,-30},{110,-30}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TBA_Hystersis_v2;

  model PI_Regler_RLT_test
    BusSystem.Bus_measure measureBus
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    BusSystem.Bus_Control controlBus
      annotation (Placement(transformation(extent={{80,-20},{120,20}})));
    Modelica.Blocks.Sources.Ramp ramp(
      duration=10,
      offset=0,
      startTime=2000)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  equation
    connect(ramp.y, controlBus.Valve_RLT_Hot_Central) annotation (Line(points={
            {21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Hot_OpenPlanOffice) annotation (Line(
          points={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Hot_ConferenceRoom) annotation (Line(
          points={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Hot_MultiPersonOffice) annotation (
        Line(points={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Hot_Canteen) annotation (Line(points={
            {21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Hot_Workshop) annotation (Line(points=
            {{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Cold_Central) annotation (Line(points=
            {{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Cold_OpenPlanOffice) annotation (Line(
          points={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Cold_ConferenceRoom) annotation (Line(
          points={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Cold_MultiPersonOffice) annotation (
        Line(points={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Cold_Canteen) annotation (Line(points=
            {{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_RLT_Cold_Workshop) annotation (Line(points
          ={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PI_Regler_RLT_test;

  model PI_Regler_TBA_Test
    BusSystem.Bus_measure measureBus
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    BusSystem.Bus_Control controlBus
      annotation (Placement(transformation(extent={{80,-20},{120,20}})));
    Modelica.Blocks.Sources.Ramp ramp(
      duration=10,
      offset=0,
      startTime=4000)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Blocks.Sources.Ramp ramp1(
      duration=10,
      offset=0,
      startTime=6000)
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
  equation
    connect(ramp.y, controlBus.Valve_TBA_OpenPlanOffice_Temp) annotation (Line(
          points={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_TBA_ConferenceRoom_Temp) annotation (Line(
          points={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_TBA_MultiPersonOffice_Temp) annotation (
        Line(points={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_TBA_Canteen_Temp) annotation (Line(points=
            {{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp.y, controlBus.Valve_TBA_Workshop_Temp) annotation (Line(points
          ={{21,0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
    connect(ramp1.y, controlBus.Valve_TBA_Warm_OpenPlanOffice) annotation (Line(
          points={{21,50},{100.1,50},{100.1,0.1}}, color={0,0,127}));
    connect(ramp1.y, controlBus.Valve_TBA_Warm_conferenceroom) annotation (Line(
          points={{21,50},{100.1,50},{100.1,0.1}}, color={0,0,127}));
    connect(ramp1.y, controlBus.Valve_TBA_Warm_multipersonoffice) annotation (
        Line(points={{21,50},{100.1,50},{100.1,0.1}}, color={0,0,127}));
    connect(ramp1.y, controlBus.Valve_TBA_Warm_canteen) annotation (Line(points
          ={{21,50},{100.1,50},{100.1,0.1}}, color={0,0,127}));
    connect(ramp1.y, controlBus.Valve_TBA_Warm_workshop) annotation (Line(
          points={{21,50},{100.1,50},{100.1,0.1}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PI_Regler_TBA_Test;
end Controller_Temp;
