within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationHeatingCoolingVarDeltaT "Example of the SubstationHeatingCoolingVarDeltaT model"
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
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium, m_flow_nominal=2)
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
    deltaT_heatingSet(displayUnit="K") = 4,
    m_flow_nominal=5)
    annotation (Placement(transformation(extent={{-22,-10},{8,22}})));
  Modelica.Blocks.Sources.TimeTable ColdDemand(table=[0,0; 3600,0; 3600,1500;
        7200,1500; 7200,2000; 10800,1000; 14400,0; 18000,0; 18000,2000])
    annotation (Placement(transformation(extent={{-80,48},{-60,68}})));
  Modelica.Blocks.Sources.TimeTable HeatDemand(table=[0,2000; 3600,2000; 3600,0;
        7200,0; 7200,3000; 10800,4000; 14400,4000; 14400,2500; 18000,2500])
    annotation (Placement(transformation(extent={{54,48},{34,68}})));
  Modelica.Blocks.Sources.Pulse dT_coolingGridSet(
    period=7200,
    nperiod=12,
    amplitude=2,
    offset=3) annotation (Placement(transformation(extent={{-80,18},{-60,38}})));
  Modelica.Blocks.Sources.Pulse dT_heatingGridSet(
    amplitude=5,
    period=7200,
    nperiod=12,
    offset=5) annotation (Placement(transformation(extent={{56,18},{36,38}})));
equation
  connect(SourceTemperatureColdLine.y, SourceCold.T_in) annotation (Line(points=
         {{97,28},{94,28},{94,-2},{86,-2}}, color={0,0,127}));
  connect(substationHeatingCooling.T_supplyHeatingSet,
    SupplyTemperatureHeaingSet.y) annotation (Line(points={{7.5,20.4941},{14,
          20.4941},{14,90},{33,90}}, color={0,0,127}));
  connect(SupplyTemperatureCoolingSet.y, substationHeatingCooling.T_supplyCoolingSet)
    annotation (Line(points={{-59,86},{-30,86},{-30,20.4941},{-22,20.4941}},
        color={0,0,127}));
  connect(SourceTemperatureHotLine.y, SourceHot.T_in) annotation (Line(points={
          {-93,-32},{-92,-32},{-92,-4},{-88,-4}}, color={0,0,127}));
  connect(SourceHot.ports[1], senTem.port_a)
    annotation (Line(points={{-66,-8},{-56,-8}}, color={0,127,255}));
  connect(senTem.port_b, substationHeatingCooling.port_a) annotation (Line(
        points={{-36,-8},{-30,-8},{-30,6.94118},{-22,6.94118}},
                                                    color={0,127,255}));
  connect(substationHeatingCooling.port_b, senTem1.port_a) annotation (Line(
        points={{8,6.94118},{16,6.94118},{16,-6},{24,-6}},
                                                 color={0,127,255}));
  connect(senTem1.port_b, SourceCold.ports[1])
    annotation (Line(points={{44,-6},{64,-6}}, color={0,127,255}));
  connect(ColdDemand.y,substationHeatingCooling.coolingDemand)
    annotation (Line(points={{-59,58},{-46,58},{-46,15.9765},{-22,15.9765}},
                                                   color={0,0,127}));
  connect(substationHeatingCooling.heatDemand, HeatDemand.y) annotation (Line(
        points={{7.5,15.9765},{20,15.9765},{20,58},{33,58}}, color={0,0,127}));
  connect(dT_coolingGridSet.y, substationHeatingCooling.deltaT_coolingGridSet)
    annotation (Line(points={{-59,28},{-52,28},{-52,11.4588},{-22,11.4588}},
        color={0,0,127}));
  connect(substationHeatingCooling.deltaT_heatingGridSet, dT_heatingGridSet.y)
    annotation (Line(points={{7.5,11.8353},{7.5,12},{24,12},{24,28},{35,28}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,
            100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-007));
end SubstationHeatingCoolingVarDeltaT;
