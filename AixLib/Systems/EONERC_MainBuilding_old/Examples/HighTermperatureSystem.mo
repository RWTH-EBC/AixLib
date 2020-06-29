within AixLib.Systems.EONERC_MainBuilding_old.Examples;
model HighTermperatureSystem "Example of the high temperature system"
  extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);
  HighTemperatureSystem highTemperatureSystem(
    redeclare package Medium = Medium,
    T_amb=293.15,
    m_flow_nominal=2,
    T_start=313.15)
    annotation (Placement(transformation(extent={{-100,-80},{40,20}})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={82,0})));
  Fluid.Sources.MassFlowSource_T        boundary3(
    redeclare package Medium = Medium,
    m_flow=2,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,-20})));
  Controller.CtrHighTemperatureSystem ctrHighTemperatureSystem
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
equation
  connect(boundary3.ports[1], highTemperatureSystem.port_a)
    annotation (Line(points={{70,-20},{40,-20}}, color={0,127,255}));
  connect(boundary2.ports[1], highTemperatureSystem.port_b)
    annotation (Line(points={{72,0},{40,0}}, color={0,127,255}));
  connect(ctrHighTemperatureSystem.highTemperatureSystemBus,
    highTemperatureSystem.hTCBus) annotation (Line(
      points={{-40,50.1},{-24.0769,50.1},{-24.0769,19.5}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=7200));
end HighTermperatureSystem;
