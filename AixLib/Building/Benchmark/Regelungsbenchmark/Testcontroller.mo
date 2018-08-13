within AixLib.Building.Benchmark.Regelungsbenchmark;
model Testcontroller
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{80,-40},{120,0}})));
  Modelica.Blocks.Sources.RealExpression TSet_Boiler(y=273.15 + 95)
    annotation (Placement(transformation(extent={{-40,-78},{-60,-58}})));
  Modelica.Blocks.Sources.BooleanExpression Heatpump_small(y=false)
    annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
  Modelica.Blocks.Sources.BooleanExpression CHP(y=false)
    annotation (Placement(transformation(extent={{-100,-92},{-80,-72}})));
  Modelica.Blocks.Sources.BooleanExpression Boiler(y=false)
    annotation (Placement(transformation(extent={{-100,-78},{-80,-58}})));
  Modelica.Blocks.Sources.RealExpression ElSet_CHP(y=26)
    annotation (Placement(transformation(extent={{-40,-92},{-60,-72}})));
  Modelica.Blocks.Sources.RealExpression TSet_CHP(y=273.15 + 80)
    annotation (Placement(transformation(extent={{-40,-106},{-60,-86}})));
  Modelica.Blocks.Sources.RealExpression Pumps(y=0)
    annotation (Placement(transformation(extent={{24,-78},{4,-58}})));
  Modelica.Blocks.Sources.RealExpression Fan_RLT(y=0)
    annotation (Placement(transformation(extent={{20,-106},{40,-86}})));
  Modelica.Blocks.Sources.RealExpression Fan_Aircooler(y=0)
    annotation (Placement(transformation(extent={{80,-106},{60,-86}})));
  Modelica.Blocks.Sources.RealExpression Valve1(y=1)
    annotation (Placement(transformation(extent={{-100,86},{-80,106}})));
  Modelica.Blocks.Sources.RealExpression Valve2
    annotation (Placement(transformation(extent={{-100,72},{-80,92}})));
  Modelica.Blocks.Sources.RealExpression Valve3(y=1)
    annotation (Placement(transformation(extent={{-100,58},{-80,78}})));
  Modelica.Blocks.Sources.RealExpression Valve4(y=1)
    annotation (Placement(transformation(extent={{-100,44},{-80,64}})));
  Modelica.Blocks.Sources.RealExpression Valve5
    annotation (Placement(transformation(extent={{-40,86},{-60,106}})));
  Modelica.Blocks.Sources.RealExpression Valve6(y=0)
    annotation (Placement(transformation(extent={{-40,72},{-60,92}})));
  Modelica.Blocks.Sources.RealExpression Valve7(y=0)
    annotation (Placement(transformation(extent={{-40,58},{-60,78}})));
  Modelica.Blocks.Sources.RealExpression Valve8
    annotation (Placement(transformation(extent={{-40,44},{-60,64}})));
  Modelica.Blocks.Sources.RealExpression Valve_WarmCold_OPO
    annotation (Placement(transformation(extent={{-40,86},{-20,106}})));
  Modelica.Blocks.Sources.RealExpression X_OPO(y=0.01)
    annotation (Placement(transformation(extent={{20,86},{40,106}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{80,0},{120,40}})));
  Modelica.Blocks.Sources.RealExpression X_CR(y=0.01)
    annotation (Placement(transformation(extent={{20,72},{40,92}})));
  Modelica.Blocks.Sources.RealExpression X_MPO(y=0.01)
    annotation (Placement(transformation(extent={{20,58},{40,78}})));
  Modelica.Blocks.Sources.RealExpression X_C(y=0.01)
    annotation (Placement(transformation(extent={{20,44},{40,64}})));
  Modelica.Blocks.Sources.RealExpression X_W(y=0.01)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Sources.RealExpression X_Central(y=0.01)
    annotation (Placement(transformation(extent={{20,16},{40,36}})));
  Modelica.Blocks.Sources.RealExpression Valve_WarmCold_CR
    annotation (Placement(transformation(extent={{-40,72},{-20,92}})));
  Modelica.Blocks.Sources.RealExpression Valve_WarmCold_MPO
    annotation (Placement(transformation(extent={{-40,58},{-20,78}})));
  Modelica.Blocks.Sources.RealExpression Valve_WarmCold_C
    annotation (Placement(transformation(extent={{-40,44},{-20,64}})));
  Modelica.Blocks.Sources.RealExpression Valve_WarmCold_W
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.RealExpression Valve_Temp
    annotation (Placement(transformation(extent={{-40,2},{-20,22}})));
  Modelica.Blocks.Sources.BooleanExpression Heatpump_big(y=false)
    annotation (Placement(transformation(extent={{-100,-64},{-80,-44}})));
equation
  connect(Boiler.y, controlBus.OnOff_boiler) annotation (Line(points={{-79,-68},
          {-70,-68},{-70,-19.9},{100.1,-19.9}},
                                            color={255,0,255}));
  connect(Heatpump_small.y, controlBus.OnOff_heatpump) annotation (Line(points=
          {{-79,-96},{-70,-96},{-70,-20},{100,-20}}, color={255,0,255}));
  connect(TSet_Boiler.y, controlBus.TSet_boiler) annotation (Line(points={{-61,-68},
          {-70,-68},{-70,-19.9},{100.1,-19.9}},  color={0,0,127}));
  connect(ElSet_CHP.y, controlBus.ElSet_CHP) annotation (Line(points={{-61,-82},
          {-70,-82},{-70,-19.9},{100.1,-19.9}},
                                            color={0,0,127}));
  connect(TSet_CHP.y, controlBus.TSet_CHP) annotation (Line(points={{-61,-96},{
          -70,-96},{-70,-19.9},{100.1,-19.9}},
                                           color={0,0,127}));
  connect(Fan_RLT.y, controlBus.Fan_RLT) annotation (Line(points={{41,-96},{50,
          -96},{50,-19.9},{100.1,-19.9}},
                                      color={0,0,127}));
  connect(Fan_Aircooler.y, controlBus.Fan_Aircooler) annotation (Line(points={{59,-96},
          {50,-96},{50,-19.9},{100.1,-19.9}},     color={0,0,127}));
  connect(Valve4.y, controlBus.Valve4) annotation (Line(points={{-79,54},{-70,
          54},{-70,-19.9},{100.1,-19.9}},
                                      color={0,0,127}));
  connect(Valve3.y, controlBus.Valve3) annotation (Line(points={{-79,68},{-70,
          68},{-70,-19.9},{100.1,-19.9}},
                                      color={0,0,127}));
  connect(Valve2.y, controlBus.Valve2) annotation (Line(points={{-79,82},{-70,
          82},{-70,-19.9},{100.1,-19.9}},
                                      color={0,0,127}));
  connect(Valve1.y, controlBus.Valve1) annotation (Line(points={{-79,96},{-70,
          96},{-70,-19.9},{100.1,-19.9}},
                                      color={0,0,127}));
  connect(Valve8.y, controlBus.Valve8) annotation (Line(points={{-61,54},{-70,
          54},{-70,-19.9},{100.1,-19.9}},
                                      color={0,0,127}));
  connect(Valve7.y, controlBus.Valve7) annotation (Line(points={{-61,68},{-70,
          68},{-70,-19.9},{100.1,-19.9}},
                                      color={0,0,127}));
  connect(Valve6.y, controlBus.Valve6) annotation (Line(points={{-61,82},{-70,
          82},{-70,-19.9},{100.1,-19.9}},
                                      color={0,0,127}));
  connect(Valve5.y, controlBus.Valve5) annotation (Line(points={{-61,96},{-70,
          96},{-70,-19.9},{100.1,-19.9}},
                                      color={0,0,127}));
  connect(X_OPO.y, controlBus.X_OpenPlanOffice) annotation (Line(points={{41,96},
          {50,96},{50,-19.9},{100.1,-19.9}},
                                         color={0,0,127}));
  connect(CHP.y, controlBus.OnOff_CHP) annotation (Line(points={{-79,-82},{-70,
          -82},{-70,-19.9},{100.1,-19.9}},
                                       color={255,0,255}));
  connect(X_CR.y, controlBus.X_ConfernceRoom) annotation (Line(points={{41,82},
          {50,82},{50,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(X_MPO.y, controlBus.X_MultiPersonRoom) annotation (Line(points={{41,
          68},{50,68},{50,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(X_C.y, controlBus.X_Canteen) annotation (Line(points={{41,54},{50,54},
          {50,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(X_W.y, controlBus.X_Workshop) annotation (Line(points={{41,40},{50,40},
          {50,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(X_Central.y, controlBus.X_Central) annotation (Line(points={{41,26},{
          50,26},{50,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_WarmCold_OPO.y, controlBus.Valve_TBA_WarmCold_OpenPlanOffice_1)
    annotation (Line(points={{-19,96},{-10,96},{-10,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Valve_WarmCold_CR.y, controlBus.Valve_TBA_WarmCold_conferenceroom_1)
    annotation (Line(points={{-19,82},{-10,82},{-10,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Valve_WarmCold_MPO.y, controlBus.Valve_TBA_WarmCold_multipersonoffice_1)
    annotation (Line(points={{-19,68},{-10,68},{-10,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Valve_WarmCold_C.y, controlBus.Valve_TBA_WarmCold_canteen_1)
    annotation (Line(points={{-19,54},{-10,54},{-10,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Valve_WarmCold_W.y, controlBus.Valve_TBA_WarmCold_workshop_1)
    annotation (Line(points={{-19,40},{-10,40},{-10,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_TBA_Cold_OpenPlanOffice_Temp)
    annotation (Line(points={{-19,12},{-10,12},{-10,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Hot_Central) annotation (Line(
        points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Hot_OpenPlanOffice) annotation (
      Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Hot_ConferenceRoom) annotation (
      Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Hot_MultiPersonOffice) annotation
    (Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Hot_Canteen) annotation (Line(
        points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Hot_Workshop) annotation (Line(
        points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Cold_Central) annotation (Line(
        points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Cold_OpenPlanOffice) annotation (
      Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Cold_ConferenceRoom) annotation (
      Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Cold_MultiPersonOffice)
    annotation (Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Cold_Canteen) annotation (Line(
        points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_RLT_Cold_Workshop) annotation (Line(
        points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_TBA_Cold_ConferenceRoom_Temp)
    annotation (Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_TBA_Cold_MultiPersonOffice_Temp)
    annotation (Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_TBA_Cold_Canteen_Temp) annotation (
      Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_Temp.y, controlBus.Valve_TBA_Cold_Workshop_Temp) annotation (
      Line(points={{-19,12},{100.1,12},{100.1,-19.9}}, color={0,0,127}));
  connect(Heatpump_small.y, controlBus.OnOff_heatpump_small) annotation (Line(
        points={{-79,-96},{-70,-96},{-70,-19.9},{100.1,-19.9}}, color={255,0,
          255}));
  connect(Heatpump_big.y, controlBus.OnOff_heatpump_big) annotation (Line(
        points={{-79,-54},{-70,-54},{-70,-19.9},{100.1,-19.9}}, color={255,0,
          255}));
  connect(Pumps.y, controlBus.Pump_Hotwater_y) annotation (Line(points={{3,-68},
          {-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_Warmwater_y) annotation (Line(points={{3,-68},
          {-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_Coldwater_y) annotation (Line(points={{3,-68},
          {-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_Coldwater_heatpump_y) annotation (Line(
        points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_Warmwater_heatpump_y) annotation (Line(
        points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_Aircooler_y) annotation (Line(points={{3,-68},
          {-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_Hotwater_CHP_y) annotation (Line(points={{3,
          -68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_Central_hot_y) annotation (Line(points={
          {3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_OpenPlanOffice_hot_y) annotation (Line(
        points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_ConferenceRoom_hot_y) annotation (Line(
        points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_MultiPersonOffice_hot_y) annotation (
      Line(points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_Canteen_hot_y) annotation (Line(points={
          {3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_Workshop_hot_y) annotation (Line(points=
          {{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_Central_cold_y) annotation (Line(points=
          {{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_OpenPlanOffice_cold_y) annotation (Line(
        points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_ConferenceRoom_cold_y) annotation (Line(
        points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_MultiPersonOffice_cold_y) annotation (
      Line(points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_Canteen_cold_y) annotation (Line(points=
          {{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_RLT_Workshop_cold_y) annotation (Line(points
        ={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (Line(
        points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (Line(
        points={{3,-68},{-10,-68},{-10,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_TBA_MultiPersonOffice_y) annotation (Line(
        points={{3,-68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(points={{3,
          -68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(points={{3,
          -68},{-10,-68},{-10,-19.9},{100.1,-19.9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Testcontroller;
