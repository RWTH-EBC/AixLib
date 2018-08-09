within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationHeatingCoolingFixDeltaT
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
  Modelica.Blocks.Sources.Constant
                               const2(k=285.15)
    annotation (Placement(transformation(extent={{-58,34},{-38,54}})));
  Modelica.Blocks.Sources.Constant const3(k=323.15)
    annotation (Placement(transformation(extent={{96,28},{76,48}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingFixDeltaT
    substationHeatingCooling(
    redeclare package Medium = Medium,
    deltaT_coolingGridSet(displayUnit="K") = 4,
    deltaT_coolingSet(displayUnit="K") = 4,
    HeatDemand_max=4000,
    CoolingDemand_max=-2000,
    deltaT_heatingSet(displayUnit="K") = 4,
    deltaT_heatingGridSet(displayUnit="K") = 4)
    annotation (Placement(transformation(extent={{-22,-10},{16,16}})));
  Modelica.Blocks.Sources.TimeTable timeTable1(table=[0,0; 3600,0; 3600,1500;
        7200,1500; 7200,2000; 10800,1000; 14400,0; 18000,0; 18000,2000])
    annotation (Placement(transformation(extent={{-98,2},{-78,22}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0,2000; 3600,2000; 3600,0;
        7200,0; 7200,3000; 10800,4000; 14400,4000; 14400,2500; 18000,2500])
    annotation (Placement(transformation(extent={{76,-30},{56,-10}})));
equation
  connect(const.y, coo1.T_in)
    annotation (Line(points={{-31,82},{40,82}}, color={0,0,127}));
  connect(substationHeatingCooling.T_supplyHeatingSet, const3.y)
    annotation (Line(points={{9.03333,13.8875},{14,13.8875},{14,38},{75,38}},
                                                                    color={
          0,0,127}));
  connect(const2.y, substationHeatingCooling.T_supplyCoolingSet)
    annotation (Line(points={{-37,44},{-32,44},{-32,42},{-30,42},{-30,13.5625},
          {-13.7667,13.5625}},
                      color={0,0,127}));
  connect(const1.y, coo.T_in)
    annotation (Line(points={{-75,-74},{-60,-74},{-60,-56}}, color={0,0,127}));
  connect(coo.ports[1], senTem.port_a)
    annotation (Line(points={{-56,-34},{-56,-8}}, color={0,127,255}));
  connect(senTem.port_b, substationHeatingCooling.port_a) annotation (Line(
        points={{-36,-8},{-30,-8},{-30,3},{-22,3}}, color={0,127,255}));
  connect(substationHeatingCooling.port_b, senTem1.port_a) annotation (Line(
        points={{16,3},{16,12},{22,12}},         color={0,127,255}));
  connect(senTem1.port_b, coo1.ports[1])
    annotation (Line(points={{42,12},{44,12},{44,60}}, color={0,127,255}));
  connect(timeTable1.y, substationHeatingCooling.CoolingDemand)
    annotation (Line(points={{-77,12},{-46,12},{-46,7.875},{-13.7667,7.875}},
                                                   color={0,0,127}));
  connect(substationHeatingCooling.HeatDemand, timeTable.y) annotation (
      Line(points={{9.03333,10.15},{12,10.15},{12,-20},{55,-20}},
                                                            color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-007));
end SubstationHeatingCoolingFixDeltaT;
