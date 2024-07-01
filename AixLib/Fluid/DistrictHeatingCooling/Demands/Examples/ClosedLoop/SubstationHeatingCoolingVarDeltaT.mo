within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationHeatingCoolingVarDeltaT "Small example of substation for buildings with heating and cooling demand equipped with 
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
  Modelica.Blocks.Sources.Constant SupplyTemperatureHeaingSet(k=323.15)
    annotation (Placement(transformation(extent={{54,80},{34,100}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingVarDeltaT
    substationHeatingCooling(
    redeclare package Medium = Medium,
    heatDemand_max=4000,
    coolingDemand_max=-2000,
    deltaT_coolingSet(displayUnit="K") = 4,
    deltaT_heatingSet(displayUnit="K") = 4)
    annotation (Placement(transformation(extent={{-24,8},{10,32}})));
  Modelica.Blocks.Sources.TimeTable ColdDemand(table=[0,0; 3600,0; 3600,1500;
        7200,1500; 7200,2000; 10800,1000; 14400,0; 18000,0; 18000,2000])
    annotation (Placement(transformation(extent={{-80,48},{-60,68}})));
  Modelica.Blocks.Sources.TimeTable HeatDemand(table=[0,2000; 3600,2000; 3600,0;
        7200,0; 7200,3000; 10800,4000; 14400,4000; 14400,2500; 18000,2500])
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
equation
  connect(SourceTemperatureColdLine.y, SourceCold.T_in) annotation (Line(points=
         {{97,28},{94,28},{94,-2},{86,-2}}, color={0,0,127}));
  connect(substationHeatingCooling.T_supplyHeatingSet,
    SupplyTemperatureHeaingSet.y) annotation (Line(points={{9.43333,30.8706},{
          14,30.8706},{14,90},{33,90}},
                                     color={0,0,127}));
  connect(SupplyTemperatureCoolingSet.y, substationHeatingCooling.T_supplyCoolingSet)
    annotation (Line(points={{-59,86},{-30,86},{-30,17.0353},{-24,17.0353}},
        color={0,0,127}));
  connect(SourceTemperatureHotLine.y, SourceHot.T_in) annotation (Line(points={
          {-93,-32},{-92,-32},{-92,-4},{-88,-4}}, color={0,0,127}));
  connect(SourceHot.ports[1], senTem.port_a)
    annotation (Line(points={{-66,-8},{-56,-8}}, color={0,127,255}));
  connect(senTem.port_b, substationHeatingCooling.port_a) annotation (Line(
        points={{-36,-8},{-30,-8},{-30,20.7059},{-24,20.7059}},
                                                    color={0,127,255}));
  connect(substationHeatingCooling.port_b, senTemColdLine.port_a) annotation (
      Line(points={{10,20.7059},{16,20.7059},{16,-6},{24,-6}}, color={0,127,255}));
  connect(senTemColdLine.port_b, SourceCold.ports[1])
    annotation (Line(points={{44,-6},{64,-6}}, color={0,127,255}));
  connect(ColdDemand.y,substationHeatingCooling.coolingDemand)
    annotation (Line(points={{-59,58},{-46,58},{-46,13.6471},{-24,13.6471}},
                                                   color={0,0,127}));
  connect(substationHeatingCooling.heatDemand, HeatDemand.y) annotation (Line(
        points={{9.43333,27.4824},{20,27.4824},{20,58},{33,58}},
                                                             color={0,0,127}));
  connect(dT_coolingGridSet.y, substationHeatingCooling.deltaT_coolingGridSet)
    annotation (Line(points={{-59,28},{-52,28},{-52,10.2588},{-24,10.2588}},
        color={0,0,127}));
  connect(substationHeatingCooling.deltaT_heatingGridSet, dT_heatingGridSet.y)
    annotation (Line(points={{9.43333,24.3765},{9.43333,24},{24,24},{24,28},{35,
          28}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,
            100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-007),
    Documentation(revisions="<html><ul>
  <li>
    <i>February 20, 2024</i> by Rahul Karuvingal:<br/>
    Revised to make it compatible with MSL 4.0.0 and Aixlib 1.3.2.
  </li>
  <li>
    <i>April 15, 2020</i> by Tobias Blacha:<br/>
    Added documentaion
  </li>
</ul>
</html>", info="<html><p>
  This example shows a simple example of a closed loop substation with
  heat pump and chiller (variable temperature difference on network and
  building sides) <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingVarDeltaT\">
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingVarDeltaT</a>.
  It illustrates the settings needed in the demand model to work in a
  bidirectional low-temperature network.
</p>
</html>"));
end SubstationHeatingCoolingVarDeltaT;
