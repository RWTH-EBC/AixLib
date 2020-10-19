within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationHeatingCooling_DC_CH_HP_HeatStorage "Small example of substation for buildings with heating and cooling demand equipped with 
  heat pump and chiller in closed loop low-temperature dhc network with variable temperature 
  difference on network side"

  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT SourceHot(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Hot line" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-76,-8})));
  AixLib.Fluid.Sources.Boundary_pT SourceCold(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "cold line" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={74,-6})));
  Modelica.Blocks.Sources.Constant SourceTemperatureColdLine(k=289.15)
    annotation (Placement(transformation(extent={{118,18},{98,38}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-56,-18},{-36,2}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemColdLine(redeclare package
      Medium = Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{24,-16},{44,4}})));
  Modelica.Blocks.Sources.Constant SourceTemperatureHotLine(k=293.15)
    annotation (Placement(transformation(extent={{-114,-42},{-94,-22}})));
  Modelica.Blocks.Sources.Constant SupplyTemperatureCoolingSet(k=285.15)
    annotation (Placement(transformation(extent={{-80,76},{-60,96}})));
  Modelica.Blocks.Sources.TimeTable ColdDemand(table=[0,0; 3600,0; 3600,1500;
        7200,1500; 7200,2000; 10800,1000; 14400,0; 18000,0; 18000,2000])
    annotation (Placement(transformation(extent={{-80,48},{-60,68}})));
  Modelica.Blocks.Sources.TimeTable HeatDemand(table=[0,2000; 3600,2000; 10800,
        2000; 14400,4000; 14400,2500; 18000,2500])
    annotation (Placement(transformation(extent={{54,48},{34,68}})));
  Modelica.Blocks.Sources.Ramp  dT_coolingGridSet(
    height=2,
    duration=7200,
    offset=3,
    startTime=10800)
              annotation (Placement(transformation(extent={{-80,18},{-60,38}})));
  Modelica.Blocks.Sources.Ramp  dT_heatingGridSet(
    height=-3,
    duration=10800,
    offset=7,
    startTime=7200)
              annotation (Placement(transformation(extent={{56,18},{36,38}})));
  Modelica.Blocks.Sources.TimeTable renElec(table=[0,0; 3600,0; 10800,0; 10800,
        2000; 14400,2000; 14400,0; 24000,0; 24000,0])
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
equation
  connect(SourceTemperatureColdLine.y, SourceCold.T_in) annotation (Line(points=
         {{97,28},{94,28},{94,-2},{86,-2}}, color={0,0,127}));
  connect(SourceTemperatureHotLine.y, SourceHot.T_in) annotation (Line(points={
          {-93,-32},{-92,-32},{-92,-4},{-88,-4}}, color={0,0,127}));
  connect(SourceHot.ports[1], senTem.port_a)
    annotation (Line(points={{-66,-8},{-56,-8}}, color={0,127,255}));
  connect(senTem.port_b, substationHeatingCooling.port_a) annotation (Line(
        points={{-36,-8},{-30,-8},{-30,23.4286},{-24,23.4286}},
                                                    color={0,127,255}));
  connect(substationHeatingCooling.port_b, senTemColdLine.port_a) annotation (
      Line(points={{10,23.4286},{16,23.4286},{16,-6},{24,-6}}, color={0,127,255}));
  connect(senTemColdLine.port_b, SourceCold.ports[1])
    annotation (Line(points={{44,-6},{64,-6}}, color={0,127,255}));
  connect(substationHeatingCooling.heatDemand, HeatDemand.y) annotation (Line(
        points={{47.7091,29.9429},{20,29.9429},{20,58},{33,58}},
                                                             color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,
            100}})),
    experiment(
      StopTime=864000,
      Interval=60,
      Tolerance=1e-07),
    Documentation(revisions="<html><ul>
  <li>
    <i>April 15, 2020</i> ,by Tobias Blacha:<br/>
    Add documentaion
  </li>
</ul>
</html>", info="<html>
<p>
  This example shows a simple example of a closed loop substation with
  heat pump and chiller (variable temperature difference on network and
  building sides) <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingVarDeltaT\">
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingVarDeltaT</a>.
  It illustrates the settings needed in the demand model to work in a
  bidirectional low-temperature network.
</p>
</html>"));
end SubstationHeatingCooling_DC_CH_HP_HeatStorage;
