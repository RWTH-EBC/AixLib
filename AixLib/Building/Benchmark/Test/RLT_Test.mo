within AixLib.Building.Benchmark.Test;
model RLT_Test
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
      replaceable package Medium_Air = AixLib.Media.Air
    "Medium in the component";
  Regelungsbenchmark.Controller.Testcontroller testcontroller
    annotation (Placement(transformation(extent={{-100,68},{-80,88}})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={32,-14})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=300)
    annotation (Placement(transformation(extent={{72,64},{92,84}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
    annotation (Placement(transformation(extent={{84,38},{104,58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature[5](T=293.15)
    annotation (Placement(transformation(extent={{-76,32},{-56,52}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={14,4})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium_Water,
    m_flow=1,
    nPorts=1) annotation (Placement(transformation(extent={{-36,2},{-16,22}})));
  Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Medium_Water,
    m_flow=1,
    nPorts=1)
    annotation (Placement(transformation(extent={{-42,-40},{-22,-20}})));
  BusSystem.measureBus measureBus1
    annotation (Placement(transformation(extent={{-4,54},{36,94}})));
  Transfer.Transfer_RLT.Full_Transfer_RLT full_Transfer_RLT(riseTime_valve=1)
    annotation (Placement(transformation(extent={{46,-4},{66,16}})));
  Fluid.Sources.MassFlowSource_T boundary2(
    m_flow=1,
    nPorts=1,
    redeclare package Medium = Medium_Air)
              annotation (Placement(transformation(extent={{-20,28},{0,48}})));
  Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = Medium_Air,
    p=100000,
    nPorts=10) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={60,54})));
equation
  connect(realExpression.y,measureBus1. AirTemp) annotation (Line(points={{93,74},
          {44,74},{44,68},{16.1,68},{16.1,74.1}}, color={0,0,127}));
  connect(realExpression1.y,measureBus1. WaterInAir) annotation (Line(points={{105,
          48},{108,48},{108,74.1},{16.1,74.1}}, color={0,0,127}));
  connect(testcontroller.measureBus, measureBus1) annotation (Line(
      points={{-80,80},{-34,80},{-34,74},{16,74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(boundary.ports[1], full_Transfer_RLT.Fluid_in_hot) annotation (Line(
        points={{-16,12},{16,12},{16,14},{46,14}}, color={0,127,255}));
  connect(bou1.ports[1], full_Transfer_RLT.Fluid_out_hot) annotation (Line(
        points={{14,0},{30,0},{30,10},{46,10}}, color={0,127,255}));
  connect(boundary1.ports[1], full_Transfer_RLT.Fluid_in_cold) annotation (Line(
        points={{-22,-30},{12,-30},{12,2},{46,2}}, color={0,127,255}));
  connect(full_Transfer_RLT.Fluid_out_cold, bou2.ports[1]) annotation (Line(
        points={{46,-2},{40,-2},{40,-18},{32,-18}}, color={0,127,255}));
  connect(full_Transfer_RLT.controlBus, testcontroller.controlBus) annotation (
      Line(
      points={{66.2,8.8},{72,8.8},{72,76},{-80,76}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_RLT.measureBus, measureBus1) annotation (Line(
      points={{66.2,3},{76,3},{76,74},{16,74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(boundary2.ports[1], full_Transfer_RLT.Air_in)
    annotation (Line(points={{0,38},{52,38},{52,16}}, color={0,127,255}));
  connect(full_Transfer_RLT.Air_out, bou3.ports[1:5]) annotation (Line(points={
          {60,16},{60,34},{60,50},{60.16,50}}, color={0,127,255}));
  connect(fixedTemperature.port, full_Transfer_RLT.heatPort)
    annotation (Line(points={{-56,42},{56,42},{56,16}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RLT_Test;
