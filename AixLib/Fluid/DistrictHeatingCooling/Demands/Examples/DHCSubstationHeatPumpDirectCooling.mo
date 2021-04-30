within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples;
model DHCSubstationHeatPumpDirectCooling
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
    annotation (Placement(transformation(extent={{-50,36},{-30,56}})));
  Modelica.Blocks.Sources.TimeTable heatDemand(table=[0,2000; 3600,2000; 3600,0;
        7200,0; 7200,3000; 10800,4000; 14400,4000; 14400,2500; 18000,2500])
    annotation (Placement(transformation(extent={{58,36},{38,56}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.DHCSubstationHeatPumpDirectCooling
    DHCsubstationHeatingDirectCooling(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=2,
    heaDem_max=4000,
    deltaT_heaSecSet=283.15,
    T_heaSecSet=328.15,
    T_heaPriSet=295.15,
    T_cooPriSet=285.15)
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
  connect(DHCsubstationHeatingDirectCooling.port_b, senTem1.port_a)
    annotation (Line(points={{30,14},{42,14}}, color={0,127,255}));
  connect(senTem.port_b, DHCsubstationHeatingDirectCooling.port_a)
    annotation (Line(points={{-28,14},{-18,14}}, color={0,127,255}));
  connect(coolingDemand.y, DHCsubstationHeatingDirectCooling.cooDem)
    annotation (Line(points={{-29,46},{-26,46},{-26,20},{-19.8,20}}, color={0,0,
          127}));
  connect(DHCsubstationHeatingDirectCooling.heaDem, heatDemand.y) annotation (
      Line(points={{29.4,22.8},{34,22.8},{34,46},{37,46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-007),
    Documentation(info="<html><p>
  This is an ClosedLoop example of <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingDirectCooling\">
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingDirectCooling</a>
  which is a simple substation model using for fixed return
  temperatures and actual supply temperatures to calculate the mass
  flow rates for heating and cooling.
</p>
</html>"));
end DHCSubstationHeatPumpDirectCooling;
