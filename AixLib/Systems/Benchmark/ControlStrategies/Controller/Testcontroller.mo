within AixLib.Systems.Benchmark.ControlStrategies.Controller;
model Testcontroller
  Model.BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{80,-40},{120,0}})));
  Model.BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{80,0},{120,40}})));
  Modelica.Blocks.Sources.RealExpression Pumps1(
                                               y=1)
    annotation (Placement(transformation(extent={{-66,-30},{-46,-10}})));
  Modelica.Blocks.Sources.RealExpression Valve_warm_Closed
    annotation (Placement(transformation(extent={{-66,0},{-46,20}})));
  Modelica.Blocks.Sources.RealExpression Valve_warm_Open(y=1)
    annotation (Placement(transformation(extent={{-68,24},{-48,44}})));
  Modelica.Blocks.Sources.RealExpression Valve_cold_Closed1
    annotation (Placement(transformation(extent={{-66,-78},{-46,-58}})));
  Modelica.Blocks.Sources.RealExpression Valve_cold_Open1(y=1)
    annotation (Placement(transformation(extent={{-68,-54},{-48,-34}})));
equation
  connect(Pumps1.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (Line(
        points={{-45,-20},{28,-20},{28,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps1.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (Line(
        points={{-45,-20},{28,-20},{28,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps1.y, controlBus.Pump_TBA_MultiPersonOffice_y) annotation (Line(
        points={{-45,-20},{26,-20},{26,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps1.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(points={{
          -45,-20},{28,-20},{28,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Pumps1.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(points={{
          -45,-20},{30,-20},{30,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(Valve_warm_Open.y, controlBus.Valve_TBA_Warm_OpenPlanOffice)
    annotation (Line(points={{-47,34},{46,34},{46,-19.9},{100.1,-19.9}}, color=
          {0,0,127}));
  connect(Valve_warm_Open.y, controlBus.Valve_TBA_Warm_conferenceroom)
    annotation (Line(points={{-47,34},{46,34},{46,-19.9},{100.1,-19.9}}, color=
          {0,0,127}));
  connect(Valve_warm_Closed.y, controlBus.Valve_TBA_Warm_multipersonoffice)
    annotation (Line(points={{-45,10},{-20,10},{-20,12},{6,12},{6,-19.9},{100.1,
          -19.9}}, color={0,0,127}));
  connect(Valve_warm_Closed.y, controlBus.Valve_TBA_Warm_canteen) annotation (
      Line(points={{-45,10},{-22,10},{-22,12},{10,12},{10,-20},{100.1,-20},{
          100.1,-19.9}}, color={0,0,127}));
  connect(Valve_warm_Closed.y, controlBus.Valve_TBA_Warm_workshop) annotation (
      Line(points={{-45,10},{-24,10},{-24,12},{8,12},{8,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Valve_cold_Closed1.y, controlBus.Valve_TBA_OpenPlanOffice_Temp)
    annotation (Line(points={{-45,-68},{46,-68},{46,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Valve_cold_Closed1.y, controlBus.Valve_TBA_ConferenceRoom_Temp)
    annotation (Line(points={{-45,-68},{46,-68},{46,-19.9},{100.1,-19.9}},
        color={0,0,127}));
  connect(Valve_cold_Open1.y, controlBus.Valve_TBA_MultiPersonOffice_Temp)
    annotation (Line(points={{-47,-44},{-32,-44},{-32,-46},{-12,-46},{-12,-19.9},
          {100.1,-19.9}}, color={0,0,127}));
  connect(Valve_cold_Open1.y, controlBus.Valve_TBA_Canteen_Temp) annotation (
      Line(points={{-47,-44},{-16,-44},{-16,-19.9},{100.1,-19.9}}, color={0,0,
          127}));
  connect(Valve_cold_Open1.y, controlBus.Valve_TBA_Workshop_Temp) annotation (
      Line(points={{-47,-44},{-34,-44},{-34,-42},{-16,-42},{-16,-19.9},{100.1,
          -19.9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Testcontroller;
