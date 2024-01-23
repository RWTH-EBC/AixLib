within AixLib.Fluid.DistrictHeatingCooling.Supplies.Examples;
model IdealPlantRevHP
   extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  ClosedLoop.IdealPlantRevHP                                        idealPlantRevHP(
    redeclare package Medium = Medium, m_flow_nominal=5,
    dT_heatSource=5,
    dT_heatSink=5,
    Q_flow_nominal_HP=20000,
    Q_flow_nominal_CH=-20000)
    annotation (Placement(transformation(extent={{-92,4},{-72,24}})));
  Demands.ClosedLoop.SubstationHeatingCoolingVarDeltaT substation1(redeclare
      package Medium = Medium,
    heatDemand_max=10000,
    coolingDemand_max=-15000,
    deltaT_heatingSet(displayUnit="K") = 5,
    deltaT_coolingSet(displayUnit="K") = 5,
    m_flow_nominal=5)          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-16,-16})));
  Demands.ClosedLoop.SubstationHeatingCoolingVarDeltaT substation2(redeclare
      package Medium = Medium,
    heatDemand_max=10000,
    coolingDemand_max=-15000,
    deltaT_heatingSet(displayUnit="K") = 5,
    deltaT_coolingSet(displayUnit="K") = 5,
    m_flow_nominal=5)          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-16})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe plugFlowPipe(
    dh=0.2,
    length=5,
    m_flow_nominal=5,
    dIns=0.001,
    kIns=0.04,
    redeclare package Medium = Medium,
    nPorts=2)  annotation (Placement(transformation(extent={{-46,4},{-26,24}})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe plugFlowPipe1(
    dh=0.2,
    length=5,
    m_flow_nominal=5,
    dIns=0.001,
    kIns=0.04,
    redeclare package Medium = Medium,
    nPorts=1)  annotation (Placement(transformation(extent={{-2,6},{18,26}})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe plugFlowPipe2(
    dh=0.2,
    length=5,
    m_flow_nominal=5,
    dIns=0.001,
    kIns=0.04,
    redeclare package Medium = Medium,
    nPorts=1)
    annotation (Placement(transformation(extent={{20,-54},{0,-34}})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe plugFlowPipe3(
    dh=0.2,
    length=5,
    m_flow_nominal=5,
    dIns=0.001,
    kIns=0.04,
    redeclare package Medium = Medium,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,-54},{-60,-34}})));
  Modelica.Blocks.Sources.Constant T_setHotLine(k=16 + 273.15)
    annotation (Placement(transformation(extent={{-126,58},{-106,78}})));
  Modelica.Blocks.Sources.Constant T_setColdLine(k=22 + 273.15)
    annotation (Placement(transformation(extent={{-126,28},{-106,48}})));
  Modelica.Blocks.Sources.Constant dT_coolingGrid(k=4)
    annotation (Placement(transformation(extent={{-62,60},{-42,80}})));
  Modelica.Blocks.Sources.Constant dT_heatingGrid(k=4)
    annotation (Placement(transformation(extent={{-34,60},{-14,80}})));
  Modelica.Blocks.Sources.Constant T_heatSupply(k=55 + 273.15)
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Blocks.Sources.Constant T_coldSupply(k=12 + 273.15)
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Blocks.Sources.Constant heatDemand(k=10000)
    annotation (Placement(transformation(extent={{-126,-92},{-106,-72}})));
  Modelica.Blocks.Sources.Step coldDemand(
    height=10000,
    offset=5000,
    startTime=86400)
    annotation (Placement(transformation(extent={{-92,-92},{-72,-72}})));
  Modelica.Blocks.Sources.Constant sourceTemperature(k=273.15 + 15)
    annotation (Placement(transformation(extent={{-126,-18},{-106,2}})));
  Sensors.TemperatureTwoPort senTem(m_flow_nominal=2, redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-152,4},{-132,24}})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
equation

  connect(dT_coolingGrid.y, substation1.deltaT_coolingGridSet);
  connect(dT_coolingGrid.y, substation2.deltaT_coolingGridSet);
  connect(dT_heatingGrid.y, substation1.deltaT_heatingGridSet);
  connect(dT_heatingGrid.y, substation2.deltaT_heatingGridSet);
  connect(T_heatSupply.y, substation1.T_supplyHeatingSet);
  connect(T_heatSupply.y, substation2.T_supplyHeatingSet);
  connect(T_coldSupply.y, substation1.T_supplyCoolingSet);
  connect(T_coldSupply.y, substation2.T_supplyCoolingSet);

  connect(heatDemand.y, substation1.heatDemand);
  connect(heatDemand.y, substation2.heatDemand);
  connect(coldDemand.y, substation1.coolingDemand);
  connect(coldDemand.y, substation2.coolingDemand);

  connect(T_setColdLine.y, idealPlantRevHP.T_heatingSet) annotation (Line(
        points={{-105,38},{-104,38},{-104,18.2},{-92.6,18.2}}, color={0,0,127}));
  connect(T_setHotLine.y, idealPlantRevHP.T_coolingSet) annotation (Line(points=
         {{-105,68},{-100,68},{-100,22},{-92.6,22}}, color={0,0,127}));
  connect(plugFlowPipe1.ports_b[1], substation2.port_a) annotation (Line(points={{18,16},
          {40.5882,16},{40.5882,-6}},         color={0,127,255}));
  connect(plugFlowPipe2.port_a, substation2.port_b) annotation (Line(points={{20,-44},
          {40.5882,-44},{40.5882,-26}},         color={0,127,255}));
  connect(plugFlowPipe.ports_b[1], plugFlowPipe1.port_a) annotation (Line(
        points={{-26,12},{-22,12},{-22,16},{-2,16}}, color={0,127,255}));
  connect(plugFlowPipe.ports_b[2], substation1.port_a) annotation (Line(points={{-26,16},
          {-30,16},{-30,12},{-15.4118,12},{-15.4118,-6}},           color={0,
          127,255}));
  connect(plugFlowPipe3.port_a, plugFlowPipe2.ports_b[1])
    annotation (Line(points={{-40,-44},{0,-44}}, color={0,127,255}));
  connect(substation1.port_b, plugFlowPipe3.port_a) annotation (Line(points={{
          -15.4118,-26},{-14,-26},{-14,-44},{-40,-44}}, color={0,127,255}));
  connect(senTem.port_a, plugFlowPipe3.ports_b[1]) annotation (Line(points={{
          -152,14},{-156,14},{-156,-44},{-60,-44}}, color={0,127,255}));
  connect(senTem.port_b, idealPlantRevHP.port_a)
    annotation (Line(points={{-132,14},{-92,14}}, color={0,127,255}));
  connect(idealPlantRevHP.port_b, senTem1.port_a) annotation (Line(points={{-72,
          14},{-70,14},{-70,40},{-70,40}}, color={0,127,255}));
  connect(senTem1.port_b, plugFlowPipe.port_a)
    annotation (Line(points={{-50,40},{-50,14},{-46,14}}, color={0,127,255}));
  connect(sourceTemperature.y, idealPlantRevHP.T_inlet_heatSource) annotation (
      Line(points={{-105,-8},{-100,-8},{-100,9.2},{-92.8,9.2}}, color={0,0,127}));
  connect(sourceTemperature.y, idealPlantRevHP.T_inlet_coldSource) annotation (
      Line(points={{-105,-8},{-100,-8},{-100,6.2},{-92.8,6.2}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{100,100}})),
    experiment(
      StopTime=172800,
      Interval=60,
      Tolerance=1e-05),
    Documentation(revisions="<html><ul>
  <li>October 23, 2018, by Tobias Blacha:<br/>
    Implemented for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 403</a>.
  </li>
</ul>
</html>"),
    __Dymola_experimentSetupOutput(equidistant=false));
end IdealPlantRevHP;
