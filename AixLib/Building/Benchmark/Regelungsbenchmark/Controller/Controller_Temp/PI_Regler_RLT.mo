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
    yMax=0,
    yMin=-1,
    Ti=100,
    k=0.01)
           annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
  Modelica.Blocks.Continuous.LimPID PID_RLT_Central_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=100,
    k=0.01)
           annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
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
    annotation (Placement(transformation(extent={{-60,4},{-40,24}})));
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
  connect(PID_RLT_Openplanoffice_Hot.y, Openplanoffice.hot)
    annotation (Line(points={{-59,90},{-50,90},{-50,24}}, color={0,0,127}));
  connect(gain1.y, Openplanoffice.cold) annotation (Line(points={{-47.6,-90},{
          -44,-90},{-44,-22},{-50,-22},{-50,4}}, color={0,0,127}));
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
  connect(Openplanoffice.y_pump_cold, controlBus.Pump_RLT_OpenPlanOffice_cold_y)
    annotation (Line(points={{-60,11},{-66,11},{-66,10},{-66,10},{-66,0.1},{
          100.1,0.1}}, color={0,0,127}));
  connect(Openplanoffice.y_pump_hot, controlBus.Pump_RLT_OpenPlanOffice_hot_y)
    annotation (Line(points={{-60,17},{-66,17},{-66,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(Canteen.y_pump_cold, controlBus.Pump_RLT_Canteen_cold_y) annotation (
      Line(points={{-20,11},{-26,11},{-26,10},{-26,10},{-26,0.1},{100.1,0.1}},
        color={0,0,127}));
  connect(Canteen.y_pump_hot, controlBus.Pump_RLT_Canteen_hot_y) annotation (
      Line(points={{-20,17},{-26,17},{-26,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Central.y_pump_hot, controlBus.Pump_RLT_Central_hot_y) annotation (
      Line(points={{16,17},{10,17},{10,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Central.y_pump_cold, controlBus.Pump_RLT_Central_cold_y) annotation (
      Line(points={{16,11},{14,11},{14,12},{10,12},{10,0.1},{100.1,0.1}}, color=
         {0,0,127}));
  connect(Multipersonoffice.y_pump_cold, controlBus.Pump_RLT_MultiPersonOffice_cold_y)
    annotation (Line(points={{60,31},{58,31},{58,32},{52,32},{52,0.1},{100.1,
          0.1}}, color={0,0,127}));
  connect(Multipersonoffice.y_pump_hot, controlBus.Pump_RLT_MultiPersonOffice_hot_y)
    annotation (Line(points={{60,37},{58,37},{58,38},{52,38},{52,0.1},{100.1,
          0.1}}, color={0,0,127}));
  connect(Conferenceroom.y_pump_cold, controlBus.Pump_RLT_ConferenceRoom_cold_y)
    annotation (Line(points={{60,67},{58,67},{58,68},{52,68},{52,0.1},{100.1,
          0.1}}, color={0,0,127}));
  connect(Conferenceroom.y_pump_hot, controlBus.Pump_RLT_ConferenceRoom_hot_y)
    annotation (Line(points={{60,73},{52,73},{52,0.1},{100.1,0.1}}, color={0,0,
          127}));
  connect(Workshop.y_pump_hot, controlBus.Pump_RLT_Workshop_hot_y) annotation (
      Line(points={{60,-31},{52,-31},{52,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Workshop.y_pump_cold, controlBus.Pump_RLT_Workshop_cold_y)
    annotation (Line(points={{60,-37},{56,-37},{56,-38},{52,-38},{52,0.1},{
          100.1,0.1}}, color={0,0,127}));
  connect(Openplanoffice.Tempvalve_cold, controlBus.Valve_RLT_Cold_OpenPlanOffice)
    annotation (Line(points={{-39,11},{-34,11},{-34,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(Openplanoffice.Tempvalve_Hot, controlBus.Valve_RLT_Hot_OpenPlanOffice)
    annotation (Line(points={{-39,17},{-34,17},{-34,0.1},{100.1,0.1}}, color={0,
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PI_Regler_RLT;
