within AixLib.Systems.EONERC_MainBuilding;
model MainBuildingEnergySystem
  "Energy system of E.ON ERC main building"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-190,-14})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,60})));
  Fluid.Sources.MassFlowSource_T        boundary3(
    redeclare package Medium = Medium,
    m_flow=4,
    T=292.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,84})));
  HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-74},{50,-26}})));
  SwitchingUnit switchingUnit(redeclare package Medium = Medium, m_flow_nominal=
       2) annotation (Placement(transformation(extent={{20,40},{60,88}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=4,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,16})));
  BaseClasses.SWUBus sWUBus1
    annotation (Placement(transformation(extent={{28,88},{48,108}})));
  BaseClasses.HeatPumpSystemBus heatPumpSystemBus1
    annotation (Placement(transformation(extent={{-18,-26},{2,-6}})));
  HeatExchangerSystem heatExchangerSystem(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-150,-26},{-80,22}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-190,16})));
  Fluid.Sources.Boundary_pT          boundary4(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-96,52})));
  Fluid.Sources.Boundary_pT          boundary6(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-74,52})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBusHTC1
    annotation (Placement(transformation(extent={{-144,24},{-124,44}})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBusLTC1
    annotation (Placement(transformation(extent={{-124,24},{-104,44}})));
equation
  connect(boundary2.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{-20,60},{20,60}}, color={0,127,255}));
  connect(boundary3.ports[1], switchingUnit.port_a1)
    annotation (Line(points={{-20,84},{20,84}}, color={0,127,255}));
  connect(switchingUnit.port_a2, heatpumpSystem.port_b1) annotation (Line(
        points={{60,60},{80,60},{80,-52.6667},{50,-52.6667}}, color={0,127,255}));
  connect(heatpumpSystem.port_a1, switchingUnit.port_b1) annotation (Line(
        points={{50,-42},{94,-42},{94,84},{60,84}}, color={0,127,255}));
  connect(vol.ports[1], switchingUnit.port_a3) annotation (Line(points={{42,26},
          {36,26},{36,40},{32,40}}, color={0,127,255}));
  connect(vol.ports[2], switchingUnit.port_b3) annotation (Line(points={{38,26},
          {46,26},{46,40},{48,40}}, color={0,127,255}));
  connect(switchingUnit.sWUBus, sWUBus1) annotation (Line(
      points={{39.8,88.4},{39.8,93.2},{38,93.2},{38,98}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatpumpSystem.heatPumpSystemBus, heatPumpSystemBus1) annotation (
      Line(
      points={{-5,-26},{-6,-26},{-6,-18},{-8,-18},{-8,-16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatpumpSystem.fluidportBottom1, heatExchangerSystem.port_b3)
    annotation (Line(points={{-60,-52.6667},{-86,-52.6667},{-86,-25.52},{-85,
          -25.52}}, color={0,127,255}));
  connect(heatpumpSystem.fluidportTop1, heatExchangerSystem.port_a2)
    annotation (Line(points={{-60,-42},{-95,-42},{-95,-26}}, color={0,127,255}));
  connect(boundary.ports[1], heatExchangerSystem.port_b1) annotation (Line(
        points={{-180,-14},{-166,-14},{-166,-6.8},{-150,-6.8}}, color={0,127,
          255}));
  connect(boundary1.ports[1], heatExchangerSystem.port_a1) annotation (Line(
        points={{-180,16},{-166,16},{-166,2.8},{-150,2.8}}, color={0,127,255}));
  connect(boundary4.ports[1], heatExchangerSystem.port_b2)
    annotation (Line(points={{-96,42},{-96,22},{-95,22}}, color={0,127,255}));
  connect(boundary6.ports[1], heatExchangerSystem.port_a3) annotation (Line(
        points={{-74,42},{-80,42},{-80,22},{-85,22}}, color={0,127,255}));
  connect(heatExchangerSystem.hydraulicBusHTC, hydraulicBusHTC1) annotation (
      Line(
      points={{-130,22},{-132,22},{-132,34},{-134,34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatExchangerSystem.hydraulicBusLTC, hydraulicBusLTC1) annotation (
      Line(
      points={{-105,22},{-110,22},{-110,34},{-114,34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Diagram(coordinateSystem(extent={{-200,-100},{100,100}})), Icon(
        coordinateSystem(extent={{-200,-100},{100,100}})),
    experiment(StopTime=86400));
end MainBuildingEnergySystem;
