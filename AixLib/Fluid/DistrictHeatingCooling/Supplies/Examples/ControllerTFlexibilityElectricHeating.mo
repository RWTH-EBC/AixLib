within AixLib.Fluid.DistrictHeatingCooling.Supplies.Examples;
model ControllerTFlexibilityElectricHeating
   extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.DistrictHeatingCooling.Supplies.Controllers.Temperature.ControllerTFlexibilityElectricHeating
    controllerTFlexibilityElectricHeating(T_maxNetwork=373.15)
    annotation (Placement(transformation(extent={{-90,32},{-70,44}})));
  AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop.SourceIdeal sourceIdeal(
    redeclare package Medium = Medium,
    pReturn=12000000000,
    TReturn=343.15)
    annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop.VarTSupplyDp
    varTSupplyDp(
    dTDesign=20,
    Q_flow_nominal=7000,
    redeclare package Medium = Medium,
    TReturn=343.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={24,-20})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop.VarTSupplyDp
    varTSupplyDp1(
    Q_flow_nominal=6500,
    dTDesign=20,
    redeclare package Medium = Medium,
    TReturn=343.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-20})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe plugFlowPipe(
    dh=0.2,
    length=5,
    m_flow_nominal=2,
    nPorts=2,
    dIns=0.001,
    kIns=0.04,
    redeclare package Medium = Medium)
               annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe plugFlowPipe1(
    dh=0.2,
    length=5,
    m_flow_nominal=2,
    nPorts=1,
    dIns=0.001,
    kIns=0.04,
    redeclare package Medium = Medium)
               annotation (Placement(transformation(extent={{38,2},{58,22}})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe plugFlowPipe2(
    dh=0.2,
    length=5,
    m_flow_nominal=2,
    nPorts=1,
    dIns=0.001,
    kIns=0.04,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{60,-58},{40,-38}})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe plugFlowPipe3(
    dh=0.2,
    length=5,
    m_flow_nominal=2,
    nPorts=1,
    dIns=0.001,
    kIns=0.04,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{0,-58},{-20,-38}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=2000,
    freqHz=86400,
    offset=5000,
    startTime=0) annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=2500,
    freqHz=86400,
    offset=4000,
    phase=0.5235987755983)
    annotation (Placement(transformation(extent={{56,30},{76,50}})));
  Modelica.Blocks.Sources.Constant const(k=3e5)
    annotation (Placement(transformation(extent={{-90,-22},{-70,-2}})));
  Modelica.Blocks.Sources.BooleanTable booleanTable(table={0,86400 + 28800,86400
         + 36000,86400 + 54000,86400 + 64800}, startValue=true)
    annotation (Placement(transformation(extent={{-142,22},{-122,42}})));
  Modelica.Blocks.Sources.Constant const1(k=90 + 273.15)
    annotation (Placement(transformation(extent={{-142,52},{-122,72}})));
equation
  connect(sourceIdeal.port_b, plugFlowPipe.port_a)
    annotation (Line(points={{-32,10},{-20,10}}, color={0,127,255}));
  connect(plugFlowPipe.ports_b[1], varTSupplyDp.port_a)
    annotation (Line(points={{0,8},{24,8},{24,-10}}, color={0,127,255}));
  connect(plugFlowPipe.ports_b[2], plugFlowPipe1.port_a)
    annotation (Line(points={{0,12},{38,12}}, color={0,127,255}));
  connect(plugFlowPipe1.ports_b[1], varTSupplyDp1.port_a)
    annotation (Line(points={{58,12},{80,12},{80,-10}}, color={0,127,255}));
  connect(varTSupplyDp1.port_b, plugFlowPipe2.port_a)
    annotation (Line(points={{80,-30},{80,-48},{60,-48}}, color={0,127,255}));
  connect(varTSupplyDp.port_b, plugFlowPipe3.port_a)
    annotation (Line(points={{24,-30},{24,-48},{0,-48}}, color={0,127,255}));
  connect(plugFlowPipe2.ports_b[1], plugFlowPipe3.port_a)
    annotation (Line(points={{40,-48},{0,-48}}, color={0,127,255}));
  connect(plugFlowPipe3.ports_b[1], sourceIdeal.port_a) annotation (Line(points={{-20,-48},
          {-92,-48},{-92,10},{-52,10}},           color={0,127,255}));
  connect(sine.y, varTSupplyDp.Q_flow_input)
    annotation (Line(points={{21,40},{32,40},{32,-9.2}}, color={0,0,127}));
  connect(sine1.y, varTSupplyDp1.Q_flow_input)
    annotation (Line(points={{77,40},{88,40},{88,-9.2}}, color={0,0,127}));
  connect(controllerTFlexibilityElectricHeating.y, sourceIdeal.TIn) annotation (
     Line(points={{-69,40},{-60,40},{-60,17},{-52.6,17}}, color={0,0,127}));
  connect(const.y, sourceIdeal.dpIn) annotation (Line(points={{-69,-12},{-60,
          -12},{-60,3},{-52.6,3}},
                              color={0,0,127}));
  connect(booleanTable.y, controllerTFlexibilityElectricHeating.electricitySignal)
    annotation (Line(points={{-121,32},{-102,32},{-102,41},{-91.8,41}},   color=
         {255,0,255}));
  connect(const1.y, controllerTFlexibilityElectricHeating.T_setNormalOperation)
    annotation (Line(points={{-121,62},{-100,62},{-100,34},{-91.8,34}},
                                                                      color={0,0,
          127}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-160,-100},{100,100}})),
    experiment(StopTime=172800, Interval=60),
    Documentation(revisions="<html><ul>
  <li>October 23, 2018, by Tobias Blacha:<br/>
    Implemented for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 403</a>.
  </li>
</ul>
</html>"));
end ControllerTFlexibilityElectricHeating;
