within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationHeatingDirectCooling
  import AixLib;
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT    coo(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1)      "Cool pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-56,-44})));
  AixLib.Fluid.Sources.Boundary_pT    coo1(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1)      "Cool pipe" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={44,70})));
  Modelica.Blocks.Sources.Constant const(k=289.15)
    annotation (Placement(transformation(extent={{-52,72},{-32,92}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-56,-18},{-36,2}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{22,2},{42,22}})));
  Modelica.Blocks.Sources.Constant
                               const1(k=293.15)
    annotation (Placement(transformation(extent={{-96,-84},{-76,-64}})));
  Modelica.Blocks.Sources.TimeTable timeTable1(table=[0,0; 3600,0; 3600,1500;
        7200,1500; 7200,2000; 10800,1000; 14400,0; 18000,0; 18000,2000])
    annotation (Placement(transformation(extent={{-98,2},{-78,22}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0,2000; 3600,2000; 3600,0;
        7200,0; 7200,3000; 10800,4000; 14400,4000; 14400,2500; 18000,2500])
    annotation (Placement(transformation(extent={{76,-30},{56,-10}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingDirectCooling
    substationHeatingDirectCooling(
    heatDemand_max=4000,
    coolingDemand_max=-2500,
    deltaT_heatingSet(displayUnit="K") = 10,
    deltaT_coolingGridSet(displayUnit="K") = 4,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=2,
    deltaT_heatingGridSet(displayUnit="K") = 4,
    T_supplyHeatingSet=318.15)
    annotation (Placement(transformation(extent={{-34,-2},{14,30}})));

equation
  connect(const1.y, coo.T_in)
    annotation (Line(points={{-75,-74},{-60,-74},{-60,-56}}, color={0,0,127}));
  connect(senTem1.port_b, coo1.ports[1])
    annotation (Line(points={{42,12},{44,12},{44,60}}, color={0,127,255}));
  connect(coo.ports[1], senTem.port_a)
    annotation (Line(points={{-56,-34},{-56,-8}}, color={0,127,255}));
  connect(const.y, coo1.T_in) annotation (Line(points={{-31,82},{4,82},{4,82},{
          40,82}}, color={0,0,127}));
  connect(substationHeatingDirectCooling.port_b, senTem1.port_a) annotation (
      Line(points={{14,14},{18,14},{18,12},{22,12}}, color={0,127,255}));
  connect(senTem.port_b, substationHeatingDirectCooling.port_a)
    annotation (Line(points={{-36,-8},{-36,14},{-34,14}}, color={0,127,255}));
  connect(timeTable1.y, substationHeatingDirectCooling.coolingDemand)
    annotation (Line(points={{-77,12},{-52,12},{-52,20},{-23.6,20}}, color={0,0,
          127}));
  connect(substationHeatingDirectCooling.heatDemand, timeTable.y) annotation (
      Line(points={{5.2,22.8},{30.6,22.8},{30.6,-20},{55,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-007));
end SubstationHeatingDirectCooling;
