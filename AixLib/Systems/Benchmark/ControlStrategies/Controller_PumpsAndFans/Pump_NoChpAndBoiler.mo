within AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans;
model Pump_NoChpAndBoiler
  Model.BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  Model.BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Sources.RealExpression Senken(y=1)
    annotation (Placement(transformation(extent={{-60,-66},{-40,-46}})));
  Modelica.Blocks.Sources.RealExpression Verteiler(y=1)
    annotation (Placement(transformation(extent={{-60,-42},{-40,-22}})));
  Modelica.Blocks.Continuous.LimPID Aircooler(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=200,
    k=0.01,
    yMax=0,
    yMin=-1) annotation (Placement(transformation(extent={{-68,28},{-56,40}})));
  Modelica.Blocks.Sources.RealExpression Heatpump1(y=273.15 + 9)
    annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-48,30},{-40,38}})));
  Modelica.Blocks.Sources.RealExpression Heatpump2(y=0.1)
    annotation (Placement(transformation(extent={{-90,-2},{-70,18}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-28,18},{-8,38}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-64,56},{-52,68}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-24,52},{-4,72}})));
  Modelica.Blocks.Sources.RealExpression Verteiler1(
                                                   y=1)
    annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
  Modelica.Blocks.Sources.RealExpression Verteiler2(y=0.1)
    annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
  Modelica.Blocks.Sources.RealExpression Pump_Generation_Hot(y=0)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{48,34},{68,54}})));
  Modelica.Blocks.Sources.RealExpression Heatpump3(y=1)
    annotation (Placement(transformation(extent={{8,60},{28,80}})));
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
  connect(Heatpump1.y, Aircooler.u_s)
    annotation (Line(points={{-79,34},{-69.2,34}}, color={0,0,127}));
  connect(Aircooler.y, gain1.u)
    annotation (Line(points={{-55.4,34},{-48.8,34}}, color={0,0,127}));
  connect(gain1.y, max.u1)
    annotation (Line(points={{-39.6,34},{-30,34}}, color={0,0,127}));
  connect(Heatpump2.y, max.u2) annotation (Line(points={{-69,8},{-49.5,8},{
          -49.5,22},{-30,22}}, color={0,0,127}));
  connect(or1.y, switch1.u2)
    annotation (Line(points={{-51.4,62},{-26,62}}, color={255,0,255}));
  connect(switch1.y, controlBus.Pump_Coldwater_heatpump_y)
    annotation (Line(points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
  connect(Verteiler1.y, switch1.u1) annotation (Line(points={{-79,76},{-38,76},
          {-38,70},{-26,70}}, color={0,0,127}));
  connect(Verteiler2.y, switch1.u3) annotation (Line(points={{-79,48},{-40,48},
          {-40,54},{-26,54}}, color={0,0,127}));
  connect(Pump_Generation_Hot.y, controlBus.Pump_Hotwater_CHP_y) annotation (
      Line(points={{-39,-10},{0.1,-10},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_Generation_Hot.y, controlBus.Pump_Hotwater_Boiler_y)
    annotation (Line(points={{-39,-10},{0.1,-10},{0.1,-99.9}}, color={0,0,127}));
  connect(Aircooler.u_m, measureBus.Aircooler) annotation (Line(points={{-62,
          26.8},{-62,22},{-72,22},{-72,84},{0.1,84},{0.1,100.1}}, color={0,0,
          127}));
  connect(or1.u2, controlBus.OnOff_heatpump_2) annotation (Line(points={{
          -65.2,57.2},{-72,57.2},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
  connect(or1.u1, controlBus.OnOff_heatpump_1) annotation (Line(points={{
          -65.2,62},{-72,62},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
  connect(switch1.y, controlBus.Pump_Warmwater_heatpump_1_y) annotation (Line(
        points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
  connect(switch1.y, controlBus.Pump_Warmwater_heatpump_2_y) annotation (Line(
        points={{-3,62},{0,62},{0,-99.9},{0.1,-99.9}}, color={0,0,127}));
  connect(switch3.u3, max.y) annotation (Line(points={{46,36},{36,36},{36,28},
          {-7,28}}, color={0,0,127}));
  connect(Heatpump3.y,switch3. u1) annotation (Line(points={{29,70},{36,70},{
          36,52},{46,52}}, color={0,0,127}));
  connect(switch3.y, controlBus.Pump_Aircooler_y) annotation (Line(points={{
          69,44},{78,44},{78,12},{0.1,12},{0.1,-99.9}}, color={0,0,127}));
  connect(switch3.u2, controlBus.OnOff_Aircooler_small) annotation (Line(
        points={{46,44},{0.1,44},{0.1,-99.9}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pump_NoChpAndBoiler;
