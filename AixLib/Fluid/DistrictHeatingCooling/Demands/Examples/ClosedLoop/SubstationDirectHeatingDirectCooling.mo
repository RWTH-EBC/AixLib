within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationDirectHeatingDirectCooling
  import AixLib;
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT warmLine(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Warm Line of network" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-66,-2})));
  AixLib.Fluid.Sources.Boundary_pT coldLine(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Cold line of network" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={84,42})));
  Modelica.Blocks.Sources.Constant T_coldLine(k=12 + 273.15)
    annotation (Placement(transformation(extent={{38,72},{58,92}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-48,4},{-28,24}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{42,4},{62,24}})));
  Modelica.Blocks.Sources.Constant T_warmLine(k=22 + 273.15)
    annotation (Placement(transformation(extent={{-98,-44},{-78,-24}})));
  Modelica.Blocks.Sources.TimeTable coolingDemand(table=[0,0; 3600,0; 3600,1500;
        7200,1500; 7200,2000; 10800,1000; 14400,0; 18000,0; 18000,2000])
    annotation (Placement(transformation(extent={{-82,36},{-62,56}})));
  Modelica.Blocks.Sources.TimeTable heatDemand(table=[0,2000; 3600,2000; 3600,0;
        7200,0; 7200,3000; 10800,4000; 14400,4000; 14400,2500; 18000,2500])
    annotation (Placement(transformation(extent={{58,38},{38,58}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationDirectHeatingDirectCooling
    SubstationDirectHeatingDirectCooling(
    heatDemand_max=4000,
    deltaT_heatingSet(displayUnit="K") = 10,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    deltaT_heatingGridSet(displayUnit="K") = 10,
    deltaT_coolingGridSet(displayUnit="K") = 10,
    m_flow_nominal=2,
    T_supplyHeatingSet=318.15)
    annotation (Placement(transformation(extent={{-18,-2},{30,30}})));

equation
  connect(T_warmLine.y, warmLine.T_in)
    annotation (Line(points={{-77,-34},{-70,-34},{-70,-14}}, color={0,0,127}));
  connect(senTem1.port_b, coldLine.ports[1])
    annotation (Line(points={{62,14},{84,14},{84,32}}, color={0,127,255}));
  connect(warmLine.ports[1], senTem.port_a)
    annotation (Line(points={{-66,8},{-66,14},{-48,14}}, color={0,127,255}));
  connect(T_coldLine.y, coldLine.T_in)
    annotation (Line(points={{59,82},{80,82},{80,54}}, color={0,0,127}));
  connect(SubstationDirectHeatingDirectCooling.port_b, senTem1.port_a)
    annotation (Line(points={{30,14},{42,14}}, color={0,127,255}));
  connect(senTem.port_b, SubstationDirectHeatingDirectCooling.port_a)
    annotation (Line(points={{-28,14},{-18,14}}, color={0,127,255}));
  connect(coolingDemand.y, SubstationDirectHeatingDirectCooling.coolingDemand)
    annotation (Line(points={{-61,46},{-12,46},{-12,22.6},{-7.6,22.6}}, color={0,
          0,127}));
  connect(heatDemand.y, SubstationDirectHeatingDirectCooling.heatDemand)
    annotation (Line(points={{37,48},{21.2,48},{21.2,24.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
  coordinateSystem(preserveAspectRatio=false)),
  experiment(StopTime=86400,Interval=60,Tolerance=1e-007),
  Documentation(info="<html>
  <p>This example shows a simple example of a closed loop substation model for bidirctional low-temperature networks for buildings with 
  direct heating and direct cooling <a href=\"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationDirectHeatingDirectCooling\">AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationDirectHeatingDirectCooling</a>. 
  It illustrates the settings needed to run the demand model.<p>
</html>", revisions="<html>
<ul>
    <li><i>February 20, 2024</i> by Rahul Karuvingal:<br/>
    Added documentation.
  </li>
    <li><i>February 20, 2024</i> by Rahul Karuvingal:<br/>
    Revised to make it compatible with MSL 4.0.0 and Aixlib 1.3.2.
  </li>
<li><i>April 15, 2020</i> by Tobias Blacha:<br/>
First Implementation </li>
</ul>
</html>"));
end SubstationDirectHeatingDirectCooling;
