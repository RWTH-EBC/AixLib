within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationHeatingCoolingFixDeltaT "Small example of substation for buildings with heating and cooling demand equipped with 
  heat pump and chiller in closed loop low-temperature dhc network with fixed temperature 
  difference on network and building side"

  import AixLib;
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT HeatSource(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-56,-44})));
  AixLib.Fluid.Sources.Boundary_pT ColdSource(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Cold line" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,2})));
  Modelica.Blocks.Sources.Constant const(k=289.15)
    annotation (Placement(transformation(extent={{132,28},{112,48}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemHotLine(redeclare package
      Medium = Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-56,-18},{-36,2}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemColdLine(redeclare package
      Medium = Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{44,-8},{66,14}})));
  Modelica.Blocks.Sources.Constant
                               const1(k=293.15)
    annotation (Placement(transformation(extent={{-96,-84},{-76,-64}})));
  Modelica.Blocks.Sources.Constant
                               const2(k=285.15)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Constant const3(k=323.15)
    annotation (Placement(transformation(extent={{42,54},{22,74}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingFixDeltaT
    substationHeatingCooling(
    redeclare package Medium = Medium,
    deltaT_coolingGridSet(displayUnit="K") = 4,
    deltaT_coolingSet(displayUnit="K") = 6,
    deltaT_heatingSet(displayUnit="K") = 6,
    deltaT_heatingGridSet(displayUnit="K") = 4,
    coolingDemand_max=-20000,
    heatDemand_max=40000)
    annotation (Placement(transformation(extent={{-22,-8},{16,18}})));
  Modelica.Blocks.Sources.TimeTable ColdDemand(table=[0,0; 3600,0; 3600,1500;
        7200,1500; 7200,2000; 10800,1000; 14400,0; 18000,0; 18000,2000])
    annotation (Placement(transformation(extent={{-80,6},{-60,26}})));
  Modelica.Blocks.Sources.TimeTable HeatDemand(table=[0,2000; 3600,2000; 3600,0;
        7200,0; 7200,3000; 10800,4000; 14400,4000; 14400,2500; 18000,2500])
    annotation (Placement(transformation(extent={{42,20},{22,40}})));
equation
  connect(substationHeatingCooling.T_supplyHeatingSet, const3.y)
    annotation (Line(points={{16,15.8875},{14,15.8875},{14,64},{21,64}},
                                                                    color={
          0,0,127}));
  connect(const2.y, substationHeatingCooling.T_supplyCoolingSet)
    annotation (Line(points={{-59,50},{-32,50},{-32,15.725},{-22,15.725}},
                      color={0,0,127}));
  connect(const1.y, HeatSource.T_in)
    annotation (Line(points={{-75,-74},{-60,-74},{-60,-56}}, color={0,0,127}));
  connect(HeatSource.ports[1], senTemHotLine.port_a)
    annotation (Line(points={{-56,-34},{-56,-8}}, color={0,127,255}));
  connect(senTemHotLine.port_b, substationHeatingCooling.port_a) annotation (
      Line(points={{-36,-8},{-30,-8},{-30,5},{-22,5}}, color={0,127,255}));
  connect(substationHeatingCooling.heatDemand, HeatDemand.y) annotation (Line(
        points={{16,12.3125},{14,12.3125},{14,10},{18,10},{18,30},{21,30}},
        color={0,0,127}));
  connect(ColdDemand.y, substationHeatingCooling.coolingDemand) annotation (
      Line(points={{-59,16},{-42,16},{-42,11.9875},{-22,11.9875}},  color={0,0,
          127}));
  connect(substationHeatingCooling.port_b, senTemColdLine.port_a)
    annotation (Line(points={{16,5},{30,5},{30,3},{44,3}},
                                             color={0,127,255}));
  connect(senTemColdLine.port_b, ColdSource.ports[1])
    annotation (Line(points={{66,3},{72,3},{72,2},{80,2}}, color={0,127,255}));
  connect(const.y, ColdSource.T_in) annotation (Line(points={{111,38},{108,38},
          {108,6},{102,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{140,
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
  heat pump and chiller (const. temperature difference on network and
  building sides) <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingFixDeltaT\">
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingFixDeltaT</a>.
  It illustrates the settings needed in the demand model to work in a
  bidirectional low-temperature network.
</p>
</html>"));
end SubstationHeatingCoolingFixDeltaT;
