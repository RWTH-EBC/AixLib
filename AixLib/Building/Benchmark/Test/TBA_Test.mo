within AixLib.Building.Benchmark.Test;
model TBA_Test
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
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
  BusSystem.Bus_measure measureBus1
    annotation (Placement(transformation(extent={{-4,54},{36,94}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
    annotation (Placement(transformation(extent={{84,38},{104,58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature[5](T=
        293.15)
    annotation (Placement(transformation(extent={{-76,32},{-56,52}})));
  Transfer.Transfer_TBA.Full_Transfer_TBA full_Transfer_TBA(
    riseTime_valve=1,
    dp_Valve_nominal_openplanoffice=100000,
    m_flow_nominal_openplanoffice=1,
    dp_Valve_nominal_conferenceroom=100000,
    m_flow_nominal_conferenceroom=1,
    dp_Valve_nominal_multipersonoffice=100000,
    m_flow_nominal_multipersonoffice=1,
    dp_Valve_nominal_canteen=100000,
    m_flow_nominal_canteen=1,
    dp_Valve_nominal_workshop=100000,
    m_flow_nominal_workshop=1)
    annotation (Placement(transformation(extent={{62,-8},{82,12}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={14,4})));
  Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = Medium_Water,
    m_flow=1) annotation (Placement(transformation(extent={{-36,2},{-16,22}})));
  Fluid.Sources.MassFlowSource_T boundary1(
    nPorts=1,
    redeclare package Medium = Medium_Water,
    m_flow=1)
    annotation (Placement(transformation(extent={{-42,-40},{-22,-20}})));
equation
  connect(realExpression.y, measureBus1.AirTemp) annotation (Line(points={{93,74},
          {44,74},{44,68},{16.1,68},{16.1,74.1}}, color={0,0,127}));
  connect(realExpression1.y, measureBus1.WaterInAir) annotation (Line(points={{105,
          48},{108,48},{108,74.1},{16.1,74.1}}, color={0,0,127}));
  connect(bou2.ports[1], full_Transfer_TBA.Fluid_out_cold) annotation (Line(
        points={{32,-18},{46,-18},{46,-6},{62,-6}}, color={0,127,255}));
  connect(fixedTemperature.port, full_Transfer_TBA.HeatPort_TBA) annotation (
      Line(points={{-56,42},{12,42},{12,40},{76,40},{76,12}}, color={191,0,0}));
  connect(full_Transfer_TBA.HeatPort_pumpsAndPipes, fixedTemperature.port)
    annotation (Line(points={{68,12},{68,24},{66,24},{66,30},{-56,30},{-56,42}},
        color={191,0,0}));
  connect(testcontroller.measureBus, measureBus1) annotation (Line(
      points={{-80,80},{-34,80},{-34,74},{16,74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(testcontroller.measureBus, full_Transfer_TBA.measureBus) annotation (
      Line(
      points={{-80,80},{-26,80},{-26,56},{98,56},{98,-2},{82,-2}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_TBA.controlBus, testcontroller.controlBus) annotation (
      Line(
      points={{82,6},{86,6},{86,72},{-80,72},{-80,76}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_TBA.Fluid_out_warm, bou1.ports[1]) annotation (Line(
        points={{62,0.6},{40,0.6},{40,0},{14,0}}, color={0,127,255}));
  connect(boundary.ports[1], full_Transfer_TBA.Fluid_in_warm) annotation (Line(
        points={{-16,12},{24,12},{24,4.6},{62,4.6}}, color={0,127,255}));
  connect(boundary1.ports[1], full_Transfer_TBA.Fluid_in_cold) annotation (Line(
        points={{-22,-30},{20,-30},{20,-2},{62,-2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TBA_Test;
