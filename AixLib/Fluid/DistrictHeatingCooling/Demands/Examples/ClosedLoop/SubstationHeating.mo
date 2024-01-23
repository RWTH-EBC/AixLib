within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationHeating
  "Small example of substation for buildings with only heating demand equipped with 
  heat pump in closed loop low-temperature dhc network"

  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT hotLine(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Supply of substation, represents warm line of dhc network"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-54,0})));
  AixLib.Fluid.Sources.Boundary_pT coldLine(
    redeclare package Medium = Medium,
    use_T_in=false,
    nPorts=1) "Cool pipe of dhc network" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={84,0})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1000,
    freqHz=1/3600,
    offset=2000,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,72},{-60,92}})));
  Modelica.Blocks.Sources.Ramp tempHotLine(
    height=10,
    duration=7200,
    startTime=3600,
    offset=293.15)
    annotation (Placement(transformation(extent={{-94,10},{-74,30}})));
  Modelica.Blocks.Sources.Step step(
    height=10,
    offset=313.15,
    startTime=18000)
    annotation (Placement(transformation(extent={{-80,42},{-60,62}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeating
    substationHeating(
    redeclare package Medium = Medium,
    heatDemand_max=3000,
    deltaT_heatingSet(displayUnit="K") = 10,
    deltaT_heatingGridSet(displayUnit="K") = 5)
    annotation (Placement(transformation(extent={{4,-10},{28,12}})));
  Sensors.TemperatureTwoPort              senTemHotLine(redeclare package
      Medium = Medium, m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
  Sensors.TemperatureTwoPort              senTemColdLine(redeclare package
      Medium = Medium, m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(tempHotLine.y, hotLine.T_in) annotation (Line(points={{-73,20},{-70,20},
          {-70,4},{-66,4}}, color={0,0,127}));
  connect(sine.y, substationHeating.heatDemand) annotation (Line(points={{-59,82},
          {-2,82},{-2,9.4},{4.36923,9.4}},       color={0,0,127}));
  connect(substationHeating.T_supplyHeatingSet, step.y) annotation (Line(points={{4.36923,
          5},{-4,5},{-4,52},{-59,52}},                 color={0,0,127}));
  connect(senTemHotLine.port_b, substationHeating.port_a)
    annotation (Line(points={{-14,0},{4,0}}, color={0,127,255}));
  connect(hotLine.ports[1], senTemHotLine.port_a)
    annotation (Line(points={{-44,0},{-34,0}}, color={0,127,255}));
  connect(senTemColdLine.port_b, coldLine.ports[1])
    annotation (Line(points={{60,0},{74,0}}, color={0,127,255}));
  connect(substationHeating.port_b, senTemColdLine.port_a)
    annotation (Line(points={{28,0},{40,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60),
    Documentation(info="<html><p>
  This example shows a simple example of a closed loop substation with
  heat pump <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeating\">
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeating</a>.
  It illustrates the settings needed in the demand model to work in a
  bidirectional low-temperature network.
</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>April 15, 2020</i> ,by Tobias Blacha:<br/>
    Add documentaion
  </li>
</ul>
</html>"));
end SubstationHeating;
