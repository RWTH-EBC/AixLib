within AixLib.Systems.EONERC_MainBuilding;
model MainBuildingEnergySystem
  "Energy system of E.ON ERC main building"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    nPorts=1,
    T=303.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-116,20})));
  Fluid.Sources.MassFlowSource_T        boundary5(
    redeclare package Medium = Medium,
    nPorts=1,
    m_flow=1,
    T=300.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-116,-20})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={100,-8})));
  Fluid.Sources.MassFlowSource_T        boundary3(
    redeclare package Medium = Medium,
    m_flow=4,
    T=291.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,16})));
  HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-62,-30},{48,26}})));
equation
  connect(boundary5.ports[1], heatpumpSystem.fluidportBottom1) annotation (Line(
        points={{-106,-20},{-80,-20},{-80,-5.11111},{-62,-5.11111}},
                                                               color={0,127,255}));
  connect(boundary.ports[1], heatpumpSystem.fluidportTop1) annotation (Line(
        points={{-106,20},{-80,20},{-80,7.33333},{-62,7.33333}},
                                                           color={0,127,255}));
  connect(heatpumpSystem.port_a1, boundary3.ports[1]) annotation (Line(points={{48,
          7.33333},{64,7.33333},{64,16},{90,16}},
                                               color={0,127,255}));
  connect(boundary2.ports[1], heatpumpSystem.port_b1) annotation (Line(points={{90,-8},
          {72,-8},{72,-14},{48,-14},{48,-5.11111}},     color={0,127,255}));
end MainBuildingEnergySystem;
