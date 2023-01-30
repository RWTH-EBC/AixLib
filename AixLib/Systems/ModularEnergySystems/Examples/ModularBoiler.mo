within AixLib.Systems.ModularEnergySystems.Examples;
model ModularBoiler
  extends Modelica.Icons.Example;
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  package MediumWater = AixLib.Media.Water;

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(min=0) = 0.5
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.Volume V_Water = 0.1;
  parameter Boolean Boiler=true;

  Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=1)
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Fluid.Sensors.TemperatureTwoPort senTReturn(
    redeclare package Medium = MediumWater,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-34})));
  Fluid.Sensors.TemperatureTwoPort senTFlow(
    redeclare package Medium = MediumWater,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,-30})));
  Fluid.MixingVolumes.MixingVolume              vol(
    redeclare package Medium = MediumWater,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    mSenFac=mSenFac,
    allowFlowReversal=false,
    V=V_Water,
    m_flow_nominal=m_flow_nominal,
    nPorts=2)
    annotation (Placement(transformation(extent={{-8,-60},{8,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-34,-74})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=-30000,
    f=1/3600,
    offset=-50000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,-90})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=0,
        origin={11,59})));
  Modelica.Blocks.Sources.RealExpression TSpeicher(y=60 + 273.15)
    annotation (Placement(transformation(extent={{-94,26},{-62,46}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=2.5)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0)
    annotation (Placement(transformation(extent={{-62,42},{-50,62}})));
  Modelica.Blocks.Sources.RealExpression PLR(y=1)
    annotation (Placement(transformation(extent={{-60,58},{-48,78}})));
  Interfaces.BoilerControlBus          boilerControlBus  if Boiler
    annotation (Placement(transformation(extent={{44,22},{64,42}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{62,-62},{82,-42}})));
equation
  connect(senTFlow.port_b, vol.ports[1]) annotation (Line(points={{44,-40},{44,-60},
          {-0.8,-60}}, color={0,127,255}));
  connect(vol.ports[2], senTReturn.port_a) annotation (Line(points={{0.8,-60},{-60,
          -60},{-60,-44}}, color={0,127,255}));
  connect(sine.y,heater. Q_flow)
    annotation (Line(points={{47,-90},{-34,-90},{-34,-84}},
                                                      color={0,0,127}));
  connect(heater.port, vol.heatPort)
    annotation (Line(points={{-34,-64},{-34,-52},{-8,-52}}, color={191,0,0}));
  if Boiler then
    connect(modularBoiler.port_b, senTFlow.port_a)
      annotation (Line(points={{10,0},{44,0},{44,-20}}, color={0,127,255}));
    connect(modularBoiler.port_a, senTReturn.port_b)
      annotation (Line(points={{-10,0},{-60,0},{-60,-24}}, color={0,127,255}));
    connect(bou.ports[1], modularBoiler.port_a)
      annotation (Line(points={{-92,0},{-10,0}}, color={0,127,255}));
    connect(boilerControlBus, modularBoiler.boilerControlBus)
      annotation (Line(
        points={{54,32},{54,16},{42,16},{42,10},{-0.2,10}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(boilerControlBus.PLR,switch1. y) annotation (Line(
      points={{54.05,32.05},{54.05,80},{28,80},{28,59},{20.9,59}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  else
  end if;
  connect(TSpeicher.y,onOffController. reference)
    annotation (Line(points={{-60.4,36},{-52,36}},     color={0,0,127}));
  connect(onOffController.y,switch1. u2) annotation (Line(points={{-29,30},{-22,
          30},{-22,59},{0.2,59}},       color={255,0,255}));
  connect(zero.y,switch1. u3) annotation (Line(points={{-49.4,52},{-24,52},{-24,
          51.8},{0.2,51.8}},          color={0,0,127}));
  connect(PLR.y,switch1. u1) annotation (Line(points={{-47.4,68},{0.2,68},{0.2,66.2}},
                         color={0,0,127}));
  connect(temperatureSensor.T, onOffController.u) annotation (Line(points={{83,-52},
          {92,-52},{92,18},{-80,18},{-80,24},{-52,24}}, color={0,0,127}));
  connect(vol.heatPort, temperatureSensor.port) annotation (Line(points={{-8,-52},
          {-8,-68},{62,-68},{62,-52}}, color={191,0,0}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularBoiler;
