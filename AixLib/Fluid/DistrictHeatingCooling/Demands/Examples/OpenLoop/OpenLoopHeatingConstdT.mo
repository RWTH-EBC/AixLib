within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.OpenLoop;
model OpenLoopHeatingConstdT
  import AixLib;
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  FixedResistances.PlugFlowPipe plugFlowPipe(
    length=100,
    nPorts=1,
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    kIns=0.04,
    dh=0.05,
    dIns=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,12})));
  FixedResistances.PlugFlowPipe plugFlowPipe1(
    length=100,
    nPorts=1,
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    kIns=0.04,
    dh=0.05,
    dIns=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={62,12})));
  Modelica.Blocks.Sources.Constant TGroundSet(k=10 + 273.15)
    "Set ground temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-84,-78})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TGround
    "Ground temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-84,-42})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop.VarTSupplyDpFixedTempDifference
    demand(
    Q_flow_nominal=7000,
    dTDesign=20,
    redeclare package Medium = Medium) "varTSupplyDpFixedTempDifference"
    annotation (Placement(transformation(extent={{14,-60},{-6,-40}})));
  AixLib.Fluid.DistrictHeatingCooling.Supplies.Controllers.Temperature.ControllerTFlexibilityElectricHeating
    controllerTFlexibilityElectricHeating(T_maxNetwork=373.15)
    annotation (Placement(transformation(extent={{-46,54},{-26,66}})));
  Modelica.Blocks.Sources.BooleanTable booleanTable(table={0,86400 + 28800,
        86400 + 36000,86400 + 54000,86400 + 64800}, startValue=true)
    annotation (Placement(transformation(extent={{-98,44},{-78,64}})));
  Modelica.Blocks.Sources.Constant const1(k=90 + 273.15)
    annotation (Placement(transformation(extent={{-98,74},{-78,94}})));
  AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop.SourceIdealElectricityFlexibility
                                                                    sourceIdealElectricityFlexibility(
    redeclare package Medium = Medium,
    Q_maxHeater=15000,
    m_flow_nominal=5,
    Q_maxElectricHeater=25000,
    pReturn=12000000000,
    TReturn=343.15)
    annotation (Placement(transformation(extent={{-8,26},{12,46}})));
  Modelica.Blocks.Sources.Constant const(k=3e5)
    annotation (Placement(transformation(extent={{-28,20},{-20,28}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=2000,
    f=86400,
    offset=5000,
    startTime=0) annotation (Placement(transformation(extent={{42,-38},{34,-30}})));
equation
  connect(TGround.port, plugFlowPipe.heatPort)
    annotation (Line(points={{-84,-32},{-84,12},{-64,12}}, color={191,0,0}));
  connect(TGroundSet.y, TGround.T)
    annotation (Line(points={{-84,-67},{-84,-54},{-84,-54}}, color={0,0,127}));
  connect(plugFlowPipe.port_a, demand.port_b)
    annotation (Line(points={{-54,2},{-54,-50},{-6,-50}}, color={0,127,255}));
  connect(plugFlowPipe1.ports_b[1], demand.port_a)
    annotation (Line(points={{62,2},{62,-50},{14,-50}}, color={0,127,255}));
  connect(booleanTable.y,controllerTFlexibilityElectricHeating. electricitySignal)
    annotation (Line(points={{-77,54},{-58,54},{-58,63},{-47.8,63}},      color=
         {255,0,255}));
  connect(const1.y,controllerTFlexibilityElectricHeating. T_setNormalOperation)
    annotation (Line(points={{-77,84},{-56,84},{-56,56},{-47.8,56}},  color={0,0,
          127}));
  connect(sourceIdealElectricityFlexibility.port_b, plugFlowPipe1.port_a)
    annotation (Line(points={{12,36},{62,36},{62,22}}, color={0,127,255}));
  connect(plugFlowPipe.ports_b[1], sourceIdealElectricityFlexibility.port_a)
    annotation (Line(points={{-54,22},{-54,36},{-6.18182,36}}, color={0,127,255}));
  connect(const.y, sourceIdealElectricityFlexibility.dpIn) annotation (Line(
        points={{-19.6,24},{-16,24},{-16,29},{-6.72727,29}}, color={0,0,127}));
  connect(controllerTFlexibilityElectricHeating.y,
    sourceIdealElectricityFlexibility.TIn) annotation (Line(points={{-25,62},{
          -14,62},{-14,43},{-6.72727,43}}, color={0,0,127}));
  connect(controllerTFlexibilityElectricHeating.T_setElectricHeater,
    sourceIdealElectricityFlexibility.Tset_electricHeater) annotation (Line(
        points={{-25,65},{-18,65},{-18,39.8},{-6.54545,39.8}}, color={0,0,127}));
  connect(sine.y, demand.Q_flow_input) annotation (Line(points={{33.6,-34},{24,
          -34},{24,-42},{14.8,-42}}, color={0,0,127}));
  connect(TGround.port, plugFlowPipe1.heatPort) annotation (Line(points={{-84,
          -32},{-30,-32},{-30,-78},{80,-78},{80,12},{72,12},{72,12}}, color={
          191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=172800, Interval=60),
    Documentation(revisions="<html><ul>
  <li>October 23, 2018, by Tobias Blacha:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Simple example of a heating network with electric heating element for
  flexible use of renewable electricity. The substation model with
  fixed temperature difference is used here.
</p>
</html>"));
end OpenLoopHeatingConstdT;
