within AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans;
model Pump_Test
  Model.BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  Model.BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Sources.RealExpression Senken(y=1)
    annotation (Placement(transformation(extent={{-60,-66},{-40,-46}})));
  Modelica.Blocks.Sources.RealExpression Verteiler(y=1)
    annotation (Placement(transformation(extent={{-60,-42},{-40,-22}})));
  Modelica.Blocks.Sources.RealExpression Aircooler(y=1)
    annotation (Placement(transformation(extent={{-60,-14},{-40,6}})));
  Modelica.Blocks.Sources.RealExpression Hotwater_Generation(y=1)
    annotation (Placement(transformation(extent={{-60,6},{-40,26}})));
  Modelica.Blocks.Sources.RealExpression Heatpump_pumps(y=1)
    annotation (Placement(transformation(extent={{-60,34},{-40,54}})));
equation
  connect(Senken.y, controlBus.Pump_RLT_Central_hot_y) annotation (Line(points=
          {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_OpenPlanOffice_hot_y) annotation (Line(
        points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_ConferenceRoom_hot_y) annotation (Line(
        points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_MultiPersonOffice_hot_y) annotation (
      Line(points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_Canteen_hot_y) annotation (Line(points=
          {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_Workshop_hot_y) annotation (Line(points=
         {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_Central_cold_y) annotation (Line(points=
         {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_OpenPlanOffice_cold_y) annotation (Line(
        points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_ConferenceRoom_cold_y) annotation (Line(
        points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_MultiPersonOffice_cold_y) annotation (
      Line(points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_Canteen_cold_y) annotation (Line(points=
         {{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_RLT_Workshop_cold_y) annotation (Line(
        points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (Line(
        points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (Line(
        points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_TBA_MultiPersonOffice_y) annotation (Line(
        points={{-39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(points={{
          -39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Senken.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(points={{
          -39,-56},{0.1,-56},{0.1,-99.9}}, color={0,0,127}));
  connect(Verteiler.y, controlBus.Pump_Hotwater_y) annotation (Line(points={{
          -39,-32},{-20,-32},{-20,-32},{0.1,-32},{0.1,-99.9}}, color={0,0,127}));
  connect(Verteiler.y, controlBus.Pump_Warmwater_y) annotation (Line(points={{
          -39,-32},{0,-32},{0,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(Verteiler.y, controlBus.Pump_Coldwater_y) annotation (Line(points={{
          -39,-32},{0.1,-32},{0.1,-99.9}}, color={0,0,127}));
  connect(Aircooler.y, controlBus.Pump_Aircooler_y) annotation (Line(points={
          {-39,-4},{0.1,-4},{0.1,-99.9}}, color={0,0,127}));
  connect(Hotwater_Generation.y, controlBus.Pump_Hotwater_CHP_y) annotation (
      Line(points={{-39,16},{0.1,16},{0.1,-99.9}}, color={0,0,127}));
  connect(Hotwater_Generation.y, controlBus.Pump_Hotwater_Boiler_y)
    annotation (Line(points={{-39,16},{0.1,16},{0.1,-99.9}}, color={0,0,127}));
  connect(Heatpump_pumps.y, controlBus.Pump_Coldwater_heatpump_y) annotation (
     Line(points={{-39,44},{0.1,44},{0.1,-99.9}}, color={0,0,127}));
  connect(Heatpump_pumps.y, controlBus.Pump_Warmwater_heatpump_1_y)
    annotation (Line(points={{-39,44},{0.1,44},{0.1,-99.9}}, color={0,0,127}));
  connect(Heatpump_pumps.y, controlBus.Pump_Warmwater_heatpump_2_y)
    annotation (Line(points={{-39,44},{0.1,44},{0.1,-99.9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pump_Test;
