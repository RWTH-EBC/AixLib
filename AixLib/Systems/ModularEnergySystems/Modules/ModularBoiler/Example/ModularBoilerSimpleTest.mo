within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoilerSimpleTest
  "Example for ModularBoiler - With Pump and simple Pump regulation"
  extends Modelica.Icons.Example;
  parameter Integer k=2 "number of consumers";
  package MediumWater = AixLib.Media.Water;

  ModularBoilerSingle modularBoiler_simple(
    QNom=50000,
    m_flowVar=false,
    TStart=353.15,
    hasFeedback=true,
    dp_Valve=10000,
    use_HeaCur=false,
    redeclare package Medium = MediumWater,
    Advanced=false)
    annotation (Placement(transformation(extent={{-34,-30},{26,30}})));
  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-14},{-72,10}})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Sources.Constant TFlowSet(k=273 + 80) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-86,40})));
  Modelica.Blocks.Sources.BooleanConstant isOnSet(k=true) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,76})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = AixLib.Media.Water,
    T_start=323.15,
    m_flow_nominal=modularBoiler_simple.m_flow_nominal,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(extent={{64,0},{84,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{28,42},{48,62}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=-5000,
    f=4/86400,
    offset=-25000)
    annotation (Placement(transformation(extent={{18,76},{38,96}})));
equation
  connect(boilerControlBus, modularBoiler_simple.boilerControlBus) annotation (
      Line(
      points={{0,62},{0,29.4},{-4,29.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bou.ports[1], modularBoiler_simple.port_a) annotation (Line(points={{
          -72,-2},{-70,-2},{-70,0},{-34,0}}, color={0,127,255}));
  connect(TFlowSet.y, boilerControlBus.TFlowSet) annotation (Line(points={{-75,
          40},{0.05,40},{0.05,62.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(isOnSet.y, boilerControlBus.isOn) annotation (Line(points={{-77,76},{
          0.05,76},{0.05,62.05}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler_simple.port_b, vol.ports[1]) annotation (Line(points={{
          26,0},{38,0},{38,-6},{73,-6},{73,0}}, color={0,127,255}));
  connect(vol.ports[2], modularBoiler_simple.port_a) annotation (Line(points={{
          75,0},{62,0},{62,-82},{-34,-82},{-34,0}}, color={0,127,255}));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation (Line(points={{48,
          52},{62,52},{62,46},{64,46},{64,10}}, color={191,0,0}));
  connect(sine.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{39,86},{
          20,86},{20,52},{28,52}}, color={0,0,127}));
annotation (
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end ModularBoilerSimpleTest;
