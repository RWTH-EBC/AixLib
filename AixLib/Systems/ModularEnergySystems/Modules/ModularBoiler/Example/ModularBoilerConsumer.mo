within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoilerConsumer
  "Example for ModularBoiler - With Pump and simple Pump regulation"
  extends Modelica.Icons.Example;
  parameter Integer k=2 "number of consumers";
  package MediumWater = AixLib.Media.Water;

  ModularBoiler modularBoiler(
    QNom=50000,
    m_flowVar=true,
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
  ModularConsumer.ConsumerDistributorModule modularConsumer(
    n_consumers=1,
    demandType={1},
    TInSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
    TInSet={343.15},
    hasPump={true},
    hasFeedback={true},
    functionality="Q_flow_fixed",
    Q_flow_fixed={30000},
    T_fixed={333.15},
    TOutSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
    TOutSet={323.15},
    k_ControlConsumerPump={0.1},
    Ti_ControlConsumerPump={10},
    dp_nominalConPump={10000},
    capacity={1},
    Q_flow_nom={10000},
    dT_nom={20},
    dp_Valve(displayUnit="bar") = {1000},
    k_ControlConsumerValve={0.1},
    Ti_ControlConsumerValve={10},
    T_start={333.15})
    annotation (Placement(transformation(extent={{42,-16},{74,16}})));

  Modelica.Blocks.Sources.Constant TFlowSet(k=273 + 80) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,44})));
  Modelica.Blocks.Sources.BooleanConstant isOnSet(k=true) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,80})));
equation
  connect(boilerControlBus, modularBoiler.boilerControlBus) annotation (Line(
      points={{0,62},{0,29.4},{-4,29.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler.port_b, modularConsumer.port_a)
    annotation (Line(points={{26,0},{42,0}}, color={0,127,255}));
  connect(modularConsumer.port_b, modularBoiler.port_a) annotation (Line(points
        ={{74,0},{78,0},{78,-36},{-42,-36},{-42,0},{-34,0}}, color={0,127,255}));
  connect(bou.ports[1], modularBoiler.port_a) annotation (Line(points={{-72,-2},
          {-70,-2},{-70,0},{-34,0}}, color={0,127,255}));
  connect(TFlowSet.y, boilerControlBus.TFlowSet) annotation (Line(points={{-79,44},
          {0.05,44},{0.05,62.05}},                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(isOnSet.y, boilerControlBus.isOn) annotation (Line(points={{-79,80},{
          0.05,80},{0.05,62.05}},                       color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation (
    experiment(StopTime=86400));
end ModularBoilerConsumer;
