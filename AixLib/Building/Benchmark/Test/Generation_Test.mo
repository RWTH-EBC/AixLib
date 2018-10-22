within AixLib.Building.Benchmark.Test;
model Generation_Test
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  Regelungsbenchmark.Controller.Testcontroller testcontroller
    annotation (Placement(transformation(extent={{-100,68},{-80,88}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=300)
    annotation (Placement(transformation(extent={{72,64},{92,84}})));
  BusSystem.Bus_measure measureBus1
    annotation (Placement(transformation(extent={{-4,54},{36,94}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
    annotation (Placement(transformation(extent={{64,-24},{84,-4}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-96,-48},{-76,-28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=
        293.15)
    annotation (Placement(transformation(extent={{-94,-78},{-74,-58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2[5](T=
        293.15)
    annotation (Placement(transformation(extent={{8,-36},{28,-16}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature3[5](T=
        293.15) annotation (Placement(transformation(extent={{32,-16},{52,4}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-12,-86})));
equation
  connect(generation.measureBus, testcontroller.measureBus) annotation (Line(
      points={{-28,-38},{-30,-38},{-30,80},{-80,80}},
      color={255,204,51},
      thickness=0.5));
  connect(testcontroller.controlBus, generation.controlBus) annotation (Line(
      points={{-80,76},{-20,76},{-20,-38}},
      color={255,204,51},
      thickness=0.5));
  connect(generation.measureBus, measureBus1) annotation (Line(
      points={{-28,-38},{-16,-38},{-16,74},{16,74}},
      color={255,204,51},
      thickness=0.5));
  connect(realExpression.y, measureBus1.AirTemp) annotation (Line(points={{93,74},
          {44,74},{44,68},{16.1,68},{16.1,74.1}}, color={0,0,127}));
  connect(realExpression1.y, measureBus1.WaterInAir) annotation (Line(points={{85,-14},
          {88,-14},{88,74.1},{16.1,74.1}},      color={0,0,127}));
  connect(generation.Fluid_out_hot, generation.Fluid_in_hot) annotation (Line(
        points={{-14,-40},{2,-40},{2,-44},{-14,-44}},
                                                color={0,127,255}));
  connect(fixedTemperature.port, generation.heatPort_Canteen) annotation (Line(
        points={{-76,-38},{-56,-38},{-56,-42},{-34,-42}},
                                                      color={191,0,0}));
  connect(fixedTemperature1.port, generation.heatPort_workshop) annotation (
      Line(points={{-74,-68},{-64,-68},{-64,-50},{-34,-50},{-34,-46}},
                                                                  color={191,0,
          0}));
  connect(generation.Fluid_out_warm, full_Transfer_TBA.Fluid_in_warm)
    annotation (Line(points={{-14,-46},{22,-46},{22,-47.4},{58,-47.4}}, color={
          0,127,255}));
  connect(generation.Fluid_in_cold, full_Transfer_TBA.Fluid_out_cold)
    annotation (Line(points={{-14,-52},{12,-52},{12,-54},{46,-54},{46,-58},{58,
          -58}}, color={0,127,255}));
  connect(generation.Fluid_out_cold, full_Transfer_TBA.Fluid_in_cold)
    annotation (Line(points={{-14,-56},{22,-56},{22,-54},{58,-54}}, color={0,
          127,255}));
  connect(full_Transfer_TBA.Fluid_out_warm, generation.Fluid_in_warm)
    annotation (Line(points={{58,-51.4},{22,-51.4},{22,-50},{-14,-50}}, color={
          0,127,255}));
  connect(full_Transfer_TBA.controlBus, testcontroller.controlBus) annotation (
      Line(
      points={{78,-46},{94,-46},{94,76},{-80,76}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_TBA.measureBus, measureBus1) annotation (Line(
      points={{78,-54},{94,-54},{94,40},{108,40},{108,58},{16,58},{16,74}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature2.port, full_Transfer_TBA.HeatPort_pumpsAndPipes)
    annotation (Line(points={{28,-26},{64,-26},{64,-40}}, color={191,0,0}));
  connect(fixedTemperature3.port, full_Transfer_TBA.HeatPort_TBA)
    annotation (Line(points={{52,-6},{72,-6},{72,-40}}, color={191,0,0}));
  connect(bou1.ports[1], full_Transfer_TBA.Fluid_in_cold) annotation (Line(
        points={{-12,-90},{10,-90},{10,-56},{22,-56},{22,-54},{58,-54}}, color=
          {0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_Test;
