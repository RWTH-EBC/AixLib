within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Examples;
model ModularConsumerTest
  extends Modelica.Icons.Example;


  AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.ConsumerDistributorModule
    modularConsumer(
    n_consumers=2,
    demandType={1,1},
    TInSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
    TInSet={343.15,343.15},
    TOutSetSou=AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant,
    TOutSet={323.15,323.15},
    hasPump={true,true},
    hasFeedback={false,true},
    functionality="Q_flow_input",
    Q_flow_fixed={10000,10000},
    T_fixed={273.15,273.15},
    k_ControlConsumerPump={0.1,0.1},
    Ti_ControlConsumerPump={10,10},
    dp_nominalConPump={10000,10000},
    capacity={1,1},
    Q_flow_nom={10000,10000},
    dT_nom={20,20},
    dp_Valve={1000,1000},
    k_ControlConsumerValve={0.01,0.01},
    Ti_ControlConsumerValve={10,10},
    T_start={333.15,333.15})
    annotation (Placement(transformation(extent={{24,-14},{72,34}})));

  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = AixLib.Media.Water,
    nPorts=1)
    annotation (Placement(transformation(extent={{-154,2},{-130,26}})));
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
  Modelica.Blocks.Sources.Constant TSetGenerator(k=273.15 + 80) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,76})));
  Modelica.Blocks.Sources.Sine sineHeatDemand1(
    amplitude=5000,
    f=1/3600,
    offset=5000)
    annotation (Placement(transformation(extent={{14,74},{34,94}})));
  Modelica.Blocks.Sources.Sine sineHeatDemand2(
    amplitude=3000,
    f=1/3600,
    offset=4000,
    startTime=1800)
    annotation (Placement(transformation(extent={{92,74},{72,94}})));
  Interfaces.ConsumerControlBus consumerControlBus(nConsumers=2)
    annotation (Placement(transformation(extent={{38,48},{58,68}})));
equation
  connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(points={{-54,38},
          {-54,30},{-68,30},{-68,14}},     color={191,0,0}));
  connect(PID.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-21,76},{-8,76},{-8,54},{-54,54}},
                                                          color={0,0,127}));
  connect(TSetGenerator.y, PID.u_s) annotation (Line(points={{-77,76},{-44,76}},
                                   color={0,0,127}));
  connect(modularConsumer.consumerControlBus,consumerControlBus)  annotation (
      Line(
      points={{48,34},{48,58}},
      color={255,204,51},
      thickness=0.5));
  connect(sineHeatDemand1.y,consumerControlBus. Q_flowSet[1]) annotation (Line(
        points={{35,84},{48.05,84},{48.05,58.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sineHeatDemand2.y,consumerControlBus. Q_flowSet[2]) annotation (Line(
        points={{71,84},{48.05,84},{48.05,58.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(consumerControlBus.TInDisMea, PID.u_m) annotation (Line(
      points={{48.05,58.05},{14,58.05},{14,38},{-32,38},{-32,64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(modularConsumer.port_b, volume.ports[1]) annotation (Line(points={{72,
          10},{108,10},{108,-60},{-78,-60},{-78,4},{-59.3333,4}}, color={0,127,
          255}));
  connect(volume.ports[2], modularConsumer.port_a) annotation (Line(points={{
          -58,4},{-58,-2},{14,-2},{14,10},{24,10}}, color={0,127,255}));
  connect(bou.ports[1], volume.ports[3]) annotation (Line(points={{-130,14},{
          -78,14},{-78,4},{-58,4}}, color={0,127,255}));
  annotation (experiment(StopTime=12000, __Dymola_Algorithm="Dassl"));
end ModularConsumerTest;
