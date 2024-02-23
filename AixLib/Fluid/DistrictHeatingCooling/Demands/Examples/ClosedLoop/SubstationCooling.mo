within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationCooling "Small example of substation for buildings with only cooling demand equipped with 
  chiller in closed loop low-temperature dhc network"

  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT hotLine(
    redeclare package Medium = Medium,
    use_T_in=false,
    nPorts=1) "Return of substation, represents warm line of dhc network"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,-16})));
  AixLib.Fluid.Sources.Boundary_pT coldLine(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Cool pipe of dhc network" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={82,24})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/3600,
    startTime=0,
    amplitude=1000,
    offset=2000)
    annotation (Placement(transformation(extent={{-50,66},{-30,86}})));
  Modelica.Blocks.Sources.Ramp tempColdLine(
    height=5,
    duration=7200,
    offset=288.15,
    startTime=72000)
    annotation (Placement(transformation(extent={{44,46},{64,66}})));
  Modelica.Blocks.Sources.Step step(
    startTime=18000,
    height=-2,
    offset=283.15)
    annotation (Placement(transformation(extent={{-50,34},{-30,54}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemHotLine(redeclare package
      Medium = Medium, m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemColdLine(redeclare package
      Medium = Medium, m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationCooling substationCooling(
    coolingDemand_max=-3000,
    deltaT_coolingSet(displayUnit="K") = 6,
    deltaT_coolingGridSet(displayUnit="K") = 4,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{6,-10},{30,12}})));
equation
  connect(hotLine.ports[1], senTemHotLine.port_a)
    annotation (Line(points={{-68,-6},{-68,0},{-48,0}}, color={0,127,255}));
  connect(senTemHotLine.port_b, substationCooling.port_a)
    annotation (Line(points={{-28,0},{5.8,0}}, color={0,127,255}));
  connect(substationCooling.port_b, senTemColdLine.port_a)
    annotation (Line(points={{30,0},{40,0}}, color={0,127,255}));
  connect(coldLine.ports[1], senTemColdLine.port_b)
    annotation (Line(points={{82,14},{82,0},{60,0}}, color={0,127,255}));
  connect(sine.y, substationCooling.coolingDemand) annotation (Line(points={{-29,76},
          {0,76},{0,9.4},{5.4,9.4}},           color={0,0,127}));
  connect(step.y, substationCooling.T_supplyCoolingSet) annotation (Line(points={{-29,44},
          {-20,44},{-20,4.8},{5.4,4.8}},        color={0,0,127}));
  connect(tempColdLine.y, coldLine.T_in)
    annotation (Line(points={{65,56},{78,56},{78,36}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60),
    Documentation(info="<html>
<p>This example shows a simple example of a closed loop substation with chiller 
<a href=\"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationCooling\">AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationCooling</a>. 
It illustrates the settings needed in the demand model to work in a bidirectional
low-temperature network.<p>
</html>", revisions="<html>
<ul>
<li><i>February 20, 2024</i> by Rahul Karuvingal:<br/>
Revised to make it compatible with MSL 4.0.0 and Aixlib 1.3.2.
</li>
<li><i>April 15, 2020</i> by Tobias Blacha:<br/>
Add documentaion </li>
</ul>
</html>"));
end SubstationCooling;
