within AixLib.Building.Benchmark.Regelungsbenchmark.Controller.Controller_PumpsAndFans;
model Pump_Basis
  BusSystem.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  BusSystem.Bus_Control controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-60,-64},{-40,-44}})));
equation
  connect(realExpression.y, controlBus.Pump_Hotwater_y) annotation (Line(points=
         {{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Warmwater_y) annotation (Line(
        points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Coldwater_y) annotation (Line(
        points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Coldwater_heatpump_y) annotation (
      Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Warmwater_heatpump_y) annotation (
      Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Aircooler_y) annotation (Line(
        points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Hotwater_CHP_y) annotation (Line(
        points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_Hotwater_Boiler_y) annotation (Line(
        points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (
      Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (
      Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_MultiPersonOffice_y)
    annotation (Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(
        points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(
        points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_Central_hot_y) annotation (Line(
        points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_OpenPlanOffice_hot_y)
    annotation (Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_ConferenceRoom_hot_y)
    annotation (Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_MultiPersonOffice_hot_y)
    annotation (Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_Canteen_hot_y) annotation (Line(
        points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_Workshop_hot_y) annotation (
      Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_Central_cold_y) annotation (
      Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_OpenPlanOffice_cold_y)
    annotation (Line(points={{-39,-54},{-20,-54},{-20,-54},{0,-54},{0,-76},{0.1,
          -76},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_ConferenceRoom_cold_y)
    annotation (Line(points={{-39,-54},{-18,-54},{-18,-54},{0,-54},{0,-76},{0.1,
          -76},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_MultiPersonOffice_cold_y)
    annotation (Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_Canteen_cold_y) annotation (
      Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  connect(realExpression.y, controlBus.Pump_RLT_Workshop_cold_y) annotation (
      Line(points={{-39,-54},{0.1,-54},{0.1,-99.9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pump_Basis;
