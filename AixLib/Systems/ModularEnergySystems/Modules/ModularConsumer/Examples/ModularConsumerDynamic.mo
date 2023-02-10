within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Examples;
model ModularConsumerDynamic
  extends Modelica.Icons.Example;
  parameter Integer nConsumers = 2;
  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = AixLib.Media.Water,
    nPorts=1)
    annotation (Placement(transformation(extent={{-98,-8},{-74,16}})));
  Fluid.MixingVolumes.MixingVolume volume(
    redeclare package Medium = AixLib.Media.Water,
    T_start=353.15,
    final V=1,
    final m_flow_nominal=1,
    nPorts=3)                                                                                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-58,14})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-54,46})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=50,
    Ti=20,
    yMax=50000,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=PID.yMax/2)
            annotation (Placement(transformation(extent={{-42,66},{-22,86}})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        AixLib.Media.Water, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-40,-8},{-20,12}})));
  Modelica.Blocks.Sources.Constant TSetGenerator(k=273.15 + 80) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,76})));
  Modelica.Blocks.Sources.Sine sineHeatDemand1(
    amplitude=5000,
    f=1/3600,
    offset=5000)
    annotation (Placement(transformation(extent={{20,72},{40,92}})));
  Modelica.Blocks.Sources.Sine sineHeatDemand2(
    amplitude=3000,
    f=1/3600,
    offset=2000,
    startTime=1800)
    annotation (Placement(transformation(extent={{98,72},{78,92}})));
  Interfaces.ConsumerControlBus consumerControlBus(nConsumers=nConsumers)
    annotation (Placement(transformation(extent={{44,46},{64,66}})));
  ConsumerDistributorModule                 modularConsumer(
    n_consumers=nConsumers,
    demandType=fill(1, nConsumers),
    TInSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
    TInSet={343.15,333.15},
    hasPump=fill(true, nConsumers),
    hasFeedback=fill(true, nConsumers),
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
    annotation (Placement(transformation(extent={{16,-28},{76,32}})));

equation
  connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(points={{-54,38},
          {-54,30},{-68,30},{-68,14}},     color={191,0,0}));
  connect(bou.ports[1], volume.ports[1]) annotation (Line(points={{-74,4},{
          -59.3333,4}},              color={0,127,255}));
  connect(PID.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-21,76},{-8,76},{-8,54},{-54,54}},
                                                          color={0,0,127}));
  connect(volume.ports[2], senTem.port_a) annotation (Line(points={{-58,4},{-58,
          2},{-40,2}},                                  color={0,127,255}));
  connect(senTem.T, PID.u_m) annotation (Line(points={{-30,13},{-32,13},{-32,64}},
                         color={0,0,127}));
  connect(TSetGenerator.y, PID.u_s) annotation (Line(points={{-77,76},{-44,76}},
                                   color={0,0,127}));
  connect(sineHeatDemand1.y, consumerControlBus.Q_flowSet[1]) annotation (Line(
        points={{41,82},{54.05,82},{54.05,56.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sineHeatDemand2.y, consumerControlBus.Q_flowSet[2]) annotation (Line(
        points={{77,82},{54.05,82},{54.05,56.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTem.port_b, modularConsumer.port_a)
    annotation (Line(points={{-20,2},{16,2}}, color={0,127,255}));
  connect(modularConsumer.port_b, volume.ports[3]) annotation (Line(points={{76,2},{
          86,2},{86,4},{96,4},{96,-68},{-56.6667,-68},{-56.6667,4}},     color={
          0,127,255}));
  connect(modularConsumer.consumerControlBus, consumerControlBus) annotation (
      Line(
      points={{46,32},{46,42},{54,42},{54,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (experiment(StopTime=12000, __Dymola_Algorithm="Dassl"));
end ModularConsumerDynamic;
