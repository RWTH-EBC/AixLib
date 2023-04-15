within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoilerConsumerDynamicDemand
  "Example for ModularBoiler - With Pump and simple Pump regulation"
  extends Modelica.Icons.Example;
  parameter Integer nConsumers=2 "number of consumers";
  package MediumWater = AixLib.Media.Water;

  ModularBoiler modularBoiler(
    allowFlowReversal=false,
    TStart=343.15,
    QNom=40000,
    m_flowVar=true,
    hasFeedback=true,
    TRetNom=323.15,
    dp_Valve=10000,
    use_HeaCur=false,
    redeclare package Medium = MediumWater,
    Advanced=false)
    annotation (Placement(transformation(extent={{-54,-30},{6,30}})));
  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-14},{-72,10}})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  ModularConsumer.ConsumerDistributorModule modularConsumer(
    n_consumers=nConsumers,
    demandType=fill(1, nConsumers),
    TInSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
    TInSet={343.15,333.15},
    hasPump={false,true},
    hasFeedback={false,true},
    functionality="Q_flow_input",
    Q_flow_fixed(displayUnit="kW") = {15000,19000},
    T_fixed={333.15,333.15},
    TOutSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
    TOutSet={323.15,313.15},
    k_ControlConsumerPump=fill(0.1, nConsumers),
    Ti_ControlConsumerPump=fill(10, nConsumers),
    dp_nominalConPump=fill(0.1, nConsumers),
    capacity=fill(1, nConsumers),
    Q_flow_nom={10000,7000},
    dT_nom={20,20},
    dp_Valve(displayUnit="bar") = fill(0.01, nConsumers),
    k_ControlConsumerValve=fill(0.01, nConsumers),
    Ti_ControlConsumerValve=fill(10, nConsumers),
    allowFlowReversal=true,
    T_start=fill(273.15 + 70, nConsumers))
    annotation (Placement(transformation(extent={{24,-30},{84,30}})));

  Modelica.Blocks.Sources.Constant TFlowSet(k=273.15 + 70)
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-86,44})));
  Modelica.Blocks.Sources.BooleanConstant isOnSet(k=true) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,90})));
  Interfaces.ConsumerControlBus consumerControlBus(nConsumers=nConsumers)
    annotation (Placement(transformation(extent={{36,50},{56,70}})));
  Modelica.Blocks.Sources.Sine sineHeatDemand1(
    amplitude=5000,
    f=1/3600,
    offset=5000)
    annotation (Placement(transformation(extent={{12,76},{32,96}})));
  Modelica.Blocks.Sources.Sine sineHeatDemand2(
    amplitude=3000,
    f=1/3600,
    offset=4000,
    startTime=1800)
    annotation (Placement(transformation(extent={{90,76},{70,96}})));
equation
  connect(boilerControlBus, modularBoiler.boilerControlBus) annotation (Line(
      points={{0,60},{0,38},{-24,38},{-24,29.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler.port_b, modularConsumer.port_a)
    annotation (Line(points={{6,0},{24,0}},  color={0,127,255}));
  connect(modularConsumer.port_b, modularBoiler.port_a) annotation (Line(points={{84,0},{
          98,0},{98,-62},{-62,-62},{-62,0},{-54,0}},         color={0,127,255}));
  connect(TFlowSet.y, boilerControlBus.TFlowSet) annotation (Line(points={{-75,44},
          {0.05,44},{0.05,60.05}},                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(isOnSet.y, boilerControlBus.isOn) annotation (Line(points={{-79,90},{
          0.05,90},{0.05,60.05}},                       color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularConsumer.consumerControlBus, consumerControlBus) annotation (
      Line(
      points={{54,30},{54,48},{46,48},{46,60}},
      color={255,204,51},
      thickness=0.5));
  connect(bou.ports[1], modularBoiler.port_a)
    annotation (Line(points={{-72,-2},{-72,0},{-54,0}}, color={0,127,255}));
  connect(sineHeatDemand1.y, consumerControlBus.Q_flowSet[1]) annotation (Line(
        points={{33,86},{46.05,86},{46.05,60.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sineHeatDemand2.y, consumerControlBus.Q_flowSet[2]) annotation (Line(
        points={{69,86},{46.05,86},{46.05,60.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
annotation (
    experiment(StopTime=86400));
end ModularBoilerConsumerDynamicDemand;
