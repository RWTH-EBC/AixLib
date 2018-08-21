within AixLib.Building.Benchmark.Regelungsbenchmark.Controller.Controller_PumpsAndFans;
model Pump_Basis
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-60,-142},{-40,-122}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Openplanoffice_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Conferenceroom_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-60,46},{-40,66}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Multipersonoffice_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-60,12},{-40,32}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Canteen_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-60,-22},{-40,-2}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Workshop_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-60,-56},{-40,-36}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Central_Hot(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Openplanoffice_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{60,80},{40,100}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Conferenceroom_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{60,46},{40,66}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Multipersonoffice_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{60,12},{40,32}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Canteen_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{60,-22},{40,-2}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Workshop_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{60,-56},{40,-36}})));
  Modelica.Blocks.Continuous.LimPID PID_Pump_RLT_Central_Cold(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20) annotation (Placement(transformation(extent={{60,-90},{40,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-120,-56},{-100,-36}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 19)
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 20)
    annotation (Placement(transformation(extent={{120,70},{100,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=273.15 + 15)
    annotation (Placement(transformation(extent={{120,-56},{100,-36}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=273.15 + 19)
    annotation (Placement(transformation(extent={{120,-90},{100,-70}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{32,52},{24,60}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{32,18},{24,26}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{32,-16},{24,-8}})));
  Modelica.Blocks.Math.Gain gain3(k=-1)
    annotation (Placement(transformation(extent={{32,-50},{24,-42}})));
  Modelica.Blocks.Math.Gain gain4(k=-1)
    annotation (Placement(transformation(extent={{32,86},{24,94}})));
  Modelica.Blocks.Math.Gain gain5(k=-1)
    annotation (Placement(transformation(extent={{32,-84},{24,-76}})));
equation
  connect(realExpression.y, controlBus.Pump_Hotwater_y) annotation (Line(points
        ={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Warmwater_y) annotation (Line(
        points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Coldwater_y) annotation (Line(
        points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Coldwater_heatpump_y) annotation (
      Line(points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Warmwater_heatpump_y) annotation (
      Line(points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Aircooler_y) annotation (Line(
        points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Hotwater_CHP_y) annotation (Line(
        points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (
      Line(points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (
      Line(points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_MultiPersonOffice_y)
    annotation (Line(points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(
        points={{-39,-132},{0.1,-132},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(
        points={{-39,-132},{-20,-132},{0,-132},{0,-132},{0,-100},{0,-99.9},{0.1,
          -99.9}}, color={0,0,127}));
  connect(PID_Pump_RLT_Central_Hot.y, controlBus.Pump_RLT_Central_hot_y)
    annotation (Line(points={{-39,-80},{0.1,-80},{0.1,-99.9}}, color={0,0,127}));
  connect(PID_Pump_RLT_Workshop_Hot.y, controlBus.Pump_RLT_Workshop_hot_y)
    annotation (Line(points={{-39,-46},{0.1,-46},{0.1,-99.9}}, color={0,0,127}));
  connect(PID_Pump_RLT_Canteen_Hot.y, controlBus.Pump_RLT_Canteen_hot_y)
    annotation (Line(points={{-39,-12},{0.1,-12},{0.1,-99.9}}, color={0,0,127}));
  connect(PID_Pump_RLT_Multipersonoffice_Hot.y, controlBus.Pump_RLT_MultiPersonOffice_hot_y)
    annotation (Line(points={{-39,22},{0.1,22},{0.1,-99.9}}, color={0,0,127}));
  connect(PID_Pump_RLT_Conferenceroom_Hot.y, controlBus.Pump_RLT_ConferenceRoom_hot_y)
    annotation (Line(points={{-39,56},{0.1,56},{0.1,-99.9}}, color={0,0,127}));
  connect(PID_Pump_RLT_Openplanoffice_Hot.y, controlBus.Pump_RLT_OpenPlanOffice_hot_y)
    annotation (Line(points={{-39,90},{0.1,90},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression6.y, PID_Pump_RLT_Central_Cold.u_s)
    annotation (Line(points={{99,-80},{62,-80}}, color={0,0,127}));
  connect(realExpression5.y, PID_Pump_RLT_Workshop_Cold.u_s)
    annotation (Line(points={{99,-46},{62,-46}}, color={0,0,127}));
  connect(realExpression1.y, PID_Pump_RLT_Workshop_Hot.u_s)
    annotation (Line(points={{-99,-46},{-62,-46}}, color={0,0,127}));
  connect(realExpression3.y, PID_Pump_RLT_Central_Hot.u_s)
    annotation (Line(points={{-99,-80},{-62,-80}}, color={0,0,127}));
  connect(realExpression2.y, PID_Pump_RLT_Openplanoffice_Hot.u_s) annotation (
      Line(points={{-99,80},{-80,80},{-80,90},{-62,90}}, color={0,0,127}));
  connect(PID_Pump_RLT_Conferenceroom_Hot.u_s, PID_Pump_RLT_Openplanoffice_Hot.u_s)
    annotation (Line(points={{-62,56},{-80,56},{-80,90},{-62,90}}, color={0,0,
          127}));
  connect(PID_Pump_RLT_Multipersonoffice_Hot.u_s,
    PID_Pump_RLT_Openplanoffice_Hot.u_s) annotation (Line(points={{-62,22},{-80,
          22},{-80,90},{-62,90}}, color={0,0,127}));
  connect(PID_Pump_RLT_Canteen_Hot.u_s, PID_Pump_RLT_Openplanoffice_Hot.u_s)
    annotation (Line(points={{-62,-12},{-80,-12},{-80,90},{-62,90}}, color={0,0,
          127}));
  connect(PID_Pump_RLT_Openplanoffice_Cold.u_s, realExpression4.y) annotation (
      Line(points={{62,90},{80,90},{80,80},{99,80}}, color={0,0,127}));
  connect(PID_Pump_RLT_Conferenceroom_Cold.u_s, realExpression4.y) annotation (
      Line(points={{62,56},{80,56},{80,80},{99,80}}, color={0,0,127}));
  connect(PID_Pump_RLT_Multipersonoffice_Cold.u_s, realExpression4.y)
    annotation (Line(points={{62,22},{80,22},{80,80},{99,80}}, color={0,0,127}));
  connect(PID_Pump_RLT_Canteen_Cold.u_s, realExpression4.y) annotation (Line(
        points={{62,-12},{80,-12},{80,80},{99,80}}, color={0,0,127}));
  connect(PID_Pump_RLT_Openplanoffice_Hot.u_m, measureBus.RoomTemp_Openplanoffice)
    annotation (Line(points={{-50,78},{-50,74},{0.1,74},{0.1,100.1}}, color={0,
          0,127}));
  connect(PID_Pump_RLT_Openplanoffice_Cold.u_m, measureBus.RoomTemp_Openplanoffice)
    annotation (Line(points={{50,78},{50,74},{0.1,74},{0.1,100.1}}, color={0,0,
          127}));
  connect(PID_Pump_RLT_Conferenceroom_Hot.u_m, measureBus.RoomTemp_Conferenceroom)
    annotation (Line(points={{-50,44},{-50,40},{0.1,40},{0.1,100.1}}, color={0,
          0,127}));
  connect(PID_Pump_RLT_Conferenceroom_Cold.u_m, measureBus.RoomTemp_Conferenceroom)
    annotation (Line(points={{50,44},{50,40},{0.1,40},{0.1,100.1}}, color={0,0,
          127}));
  connect(PID_Pump_RLT_Multipersonoffice_Hot.u_m, measureBus.RoomTemp_Multipersonoffice)
    annotation (Line(points={{-50,10},{-50,4},{0,4},{0,52},{0.1,52},{0.1,100.1}},
        color={0,0,127}));
  connect(PID_Pump_RLT_Multipersonoffice_Cold.u_m, measureBus.RoomTemp_Multipersonoffice)
    annotation (Line(points={{50,10},{50,4},{0.1,4},{0.1,100.1}}, color={0,0,
          127}));
  connect(PID_Pump_RLT_Canteen_Hot.u_m, measureBus.RoomTemp_Canteen)
    annotation (Line(points={{-50,-24},{-50,-30},{0.1,-30},{0.1,100.1}}, color=
          {0,0,127}));
  connect(PID_Pump_RLT_Canteen_Cold.u_m, measureBus.RoomTemp_Canteen)
    annotation (Line(points={{50,-24},{50,-30},{0.1,-30},{0.1,100.1}}, color={0,
          0,127}));
  connect(PID_Pump_RLT_Workshop_Hot.u_m, measureBus.RoomTemp_Workshop)
    annotation (Line(points={{-50,-58},{-50,-62},{0.1,-62},{0.1,100.1}}, color=
          {0,0,127}));
  connect(PID_Pump_RLT_Workshop_Cold.u_m, measureBus.RoomTemp_Workshop)
    annotation (Line(points={{50,-58},{50,-62},{0.1,-62},{0.1,100.1}}, color={0,
          0,127}));
  connect(PID_Pump_RLT_Openplanoffice_Cold.y, gain4.u)
    annotation (Line(points={{39,90},{32.8,90}}, color={0,0,127}));
  connect(PID_Pump_RLT_Conferenceroom_Cold.y, gain.u)
    annotation (Line(points={{39,56},{32.8,56}}, color={0,0,127}));
  connect(PID_Pump_RLT_Multipersonoffice_Cold.y, gain1.u)
    annotation (Line(points={{39,22},{32.8,22}}, color={0,0,127}));
  connect(PID_Pump_RLT_Canteen_Cold.y, gain2.u)
    annotation (Line(points={{39,-12},{32.8,-12}}, color={0,0,127}));
  connect(PID_Pump_RLT_Workshop_Cold.y, gain3.u)
    annotation (Line(points={{39,-46},{32.8,-46}}, color={0,0,127}));
  connect(PID_Pump_RLT_Central_Cold.y, gain5.u)
    annotation (Line(points={{39,-80},{32.8,-80}}, color={0,0,127}));
  connect(gain4.y, controlBus.Pump_RLT_OpenPlanOffice_cold_y) annotation (Line(
        points={{23.6,90},{0.1,90},{0.1,-99.9}}, color={0,0,127}));
  connect(gain.y, controlBus.Pump_RLT_ConferenceRoom_cold_y) annotation (Line(
        points={{23.6,56},{0.1,56},{0.1,-99.9}}, color={0,0,127}));
  connect(gain1.y, controlBus.Pump_RLT_MultiPersonOffice_cold_y) annotation (
      Line(points={{23.6,22},{0.1,22},{0.1,-99.9}}, color={0,0,127}));
  connect(gain2.y, controlBus.Pump_RLT_Canteen_cold_y) annotation (Line(points=
          {{23.6,-12},{0.1,-12},{0.1,-99.9}}, color={0,0,127}));
  connect(gain3.y, controlBus.Pump_RLT_Workshop_cold_y) annotation (Line(points
        ={{23.6,-46},{0.1,-46},{0.1,-99.9}}, color={0,0,127}));
  connect(gain5.y, controlBus.Pump_RLT_Central_cold_y) annotation (Line(points=
          {{23.6,-80},{0.1,-80},{0.1,-99.9}}, color={0,0,127}));
  connect(PID_Pump_RLT_Central_Cold.u_m, measureBus.Air_out) annotation (Line(
        points={{50,-92},{50,-100},{20,-100},{20,-72},{0.1,-72},{0.1,100.1}},
        color={0,0,127}));
  connect(PID_Pump_RLT_Central_Hot.u_m, measureBus.Air_out) annotation (Line(
        points={{-50,-92},{-50,-100},{-26,-100},{-26,-72},{0.1,-72},{0.1,100.1}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pump_Basis;
