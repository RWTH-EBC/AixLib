within AixLib.Fluid.DistrictHeatingCooling.Supplies.Examples;
model DHCSupplyHeaterCoolerStorage
   extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  ClosedLoop.DHCSupplyHeaterCoolerStorage DHCSupplyHeaterCoolerStorage(
    redeclare package Medium = Medium,
    m_flow_nominal=5,
    V_Tank=500)
    annotation (Placement(transformation(extent={{-92,4},{-72,24}})));
  Demands.ClosedLoop.DHCSubstationHeatPumpDirectCooling substation1(
                                                                   redeclare
      package                                                                        Medium =
                       Medium,
    m_flow_nominal=5,
    heaDem_max=10000,
    deltaT_heaSecSet=278.15,
    T_heaSecSet=328.15,
    T_heaPriSet=295.15,
    T_cooPriSet=289.15)        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-16,-14})));
  Demands.ClosedLoop.DHCSubstationHeatPumpDirectCooling substation2(
                                                                   redeclare
      package                                                                        Medium =
                       Medium,
    m_flow_nominal=5,
    heaDem_max=10000,
    deltaT_heaSecSet=278.15,
    T_heaSecSet=328.15,
    T_heaPriSet=295.15,
    T_cooPriSet=289.15)        annotation (Placement(transformation(
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
    nPorts=2)  annotation (Placement(transformation(extent={{-60,4},{-40,24}})));
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
  Modelica.Blocks.Sources.Constant T_HotLineSet(k=16 + 273.15)
    annotation (Placement(transformation(extent={{-126,58},{-106,78}})));
  Modelica.Blocks.Sources.Constant T_ColdLineSet(k=22 + 273.15)
    annotation (Placement(transformation(extent={{-126,28},{-106,48}})));
  Modelica.Blocks.Sources.Constant heaDem(k=10000)
    annotation (Placement(transformation(extent={{-126,-92},{-106,-72}})));
  Modelica.Blocks.Sources.Step colDem(
    height=10000,
    offset=5000,
    startTime=86400)
    annotation (Placement(transformation(extent={{-92,-92},{-72,-72}})));
equation

  connect(heaDem.y, substation1.heaDem);
  connect(heaDem.y, substation2.heaDem);
  connect(colDem.y, substation1.cooDem);
  connect(colDem.y, substation2.cooDem);

  connect(DHCSupplyHeaterCoolerStorage.port_b, plugFlowPipe.port_a)
    annotation (Line(points={{-72,14},{-60,14}}, color={0,127,255}));
  connect(T_ColdLineSet.y, DHCSupplyHeaterCoolerStorage.T_heaSet) annotation (
      Line(points={{-105,38},{-104,38},{-104,22},{-92.7273,22}}, color={0,0,127}));
  connect(T_HotLineSet.y, DHCSupplyHeaterCoolerStorage.T_cooSet) annotation (
      Line(points={{-105,68},{-100,68},{-100,19},{-92.7273,19}}, color={0,0,127}));
  connect(plugFlowPipe1.ports_b[1], substation2.port_a) annotation (Line(points={{18,16},
          {40,16},{40,-6}},                   color={0,127,255}));
  connect(plugFlowPipe2.port_a, substation2.port_b) annotation (Line(points={{20,-44},
          {40,-44},{40,-26}},                   color={0,127,255}));
  connect(plugFlowPipe.ports_b[1], plugFlowPipe1.port_a) annotation (Line(
        points={{-40,12},{-22,12},{-22,16},{-2,16}}, color={0,127,255}));
  connect(plugFlowPipe.ports_b[2], substation1.port_a) annotation (Line(points={{-40,16},
          {-16,16},{-16,-4}},                                       color={0,
          127,255}));
  connect(plugFlowPipe3.port_a, plugFlowPipe2.ports_b[1])
    annotation (Line(points={{-40,-44},{0,-44}}, color={0,127,255}));
  connect(substation1.port_b, plugFlowPipe3.port_a) annotation (Line(points={{-16,-24},
          {-16,-44},{-40,-44}},                         color={0,127,255}));
  connect(DHCSupplyHeaterCoolerStorage.port_a, plugFlowPipe3.ports_b[1])
    annotation (Line(points={{-92,14},{-128,14},{-128,-44},{-60,-44}}, color={0,
          127,255}));
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
end DHCSupplyHeaterCoolerStorage;
