within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationHeatingCoolingVarDeltaT
  import InterFlexModels;
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
  Modelica.Blocks.Sources.Constant
                               const2(k=285.15)
    annotation (Placement(transformation(extent={{-58,34},{-38,54}})));
  Modelica.Blocks.Sources.Constant const3(k=323.15)
    annotation (Placement(transformation(extent={{96,28},{76,48}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationHeatingCoolingVarDeltaT
    substationHeatingCooling(
    redeclare package Medium = Medium,
    deltaT_coolingSet(displayUnit="K") = 4,
    HeatDemand_max=4000,
    CoolingDemand_max=-2000,
    deltaT_heatingSet(displayUnit="K") = 4)
    annotation (Placement(transformation(extent={{-22,-10},{8,22}})));
  Modelica.Blocks.Sources.TimeTable timeTable1(table=[0,0; 3600,0; 3600,-1500;
        7200,-1500; 7200,-2000; 10800,-1000; 14400,0; 18000,0; 18000,-2000])
    annotation (Placement(transformation(extent={{-98,2},{-78,22}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0,2000; 3600,2000; 3600,0;
        7200,0; 7200,3000; 10800,4000; 14400,4000; 14400,2500; 18000,2500])
    annotation (Placement(transformation(extent={{76,-30},{56,-10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    period=7200,
    nperiod=12,
    amplitude=2,
    offset=3)
    annotation (Placement(transformation(extent={{-40,-44},{-20,-24}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    amplitude=5,
    period=7200,
    nperiod=12,
    offset=5) annotation (Placement(transformation(extent={{40,-48},{20,-28}})));
equation
  connect(const.y, coo1.T_in)
    annotation (Line(points={{-31,82},{40,82}}, color={0,0,127}));
  connect(substationHeatingCooling.T_supplyHeatingSet, const3.y)
    annotation (Line(points={{7.5,20.4941},{14,20.4941},{14,38},{75,38}},
                                                                    color={
          0,0,127}));
  connect(const2.y, substationHeatingCooling.T_supplyCoolingSet)
    annotation (Line(points={{-37,44},{-32,44},{-32,42},{-30,42},{-30,20.4941},
          {-22,20.4941}},
                      color={0,0,127}));
  connect(const1.y, coo.T_in)
    annotation (Line(points={{-75,-74},{-60,-74},{-60,-56}}, color={0,0,127}));
  connect(coo.ports[1], senTem.port_a)
    annotation (Line(points={{-56,-34},{-56,-8}}, color={0,127,255}));
  connect(senTem.port_b, substationHeatingCooling.port_a) annotation (Line(
        points={{-36,-8},{-30,-8},{-30,6.94118},{-22,6.94118}},
                                                    color={0,127,255}));
  connect(substationHeatingCooling.port_b, senTem1.port_a) annotation (Line(
        points={{8,6.94118},{16,6.94118},{16,12},{22,12}},
                                                 color={0,127,255}));
  connect(senTem1.port_b, coo1.ports[1])
    annotation (Line(points={{42,12},{44,12},{44,60}}, color={0,127,255}));
  connect(timeTable1.y,substationHeatingCooling.coolingDemand)
    annotation (Line(points={{-77,12},{-46,12},{-46,15.9765},{-22,15.9765}},
                                                   color={0,0,127}));
  connect(substationHeatingCooling.heatDemand, timeTable.y) annotation (
      Line(points={{7.5,15.9765},{12,15.9765},{12,-20},{55,-20}},
                                                            color={0,0,127}));
  connect(substationHeatingCooling.deltaT_coolingGridSet, pulse.y) annotation (
      Line(points={{-22,11.4588},{-22,-14.1882},{-19,-14.1882},{-19,-34}},
        color={0,0,127}));
  connect(substationHeatingCooling.deltaT_heatingGridSet, pulse1.y) annotation (
     Line(points={{7.5,11.8353},{7.5,-14.4},{19,-14.4},{19,-38}},
                                                                color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-007));
end SubstationHeatingCoolingVarDeltaT;
