within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Examples;
model ModularConsumer
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
    hasFeedback={true,true},
    functionality="Q_flow_fixed",
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
    annotation (Placement(transformation(extent={{36,-22},{84,26}})));

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
equation
  connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(points={{-54,38},
          {-54,30},{-68,30},{-68,14}},     color={191,0,0}));
  connect(modularConsumer.port_b, volume.ports[1]) annotation (Line(points={{84,2},{
          88,2},{88,-28},{-59.3333,-28},{-59.3333,4}},
        color={0,127,255}));
  connect(bou.ports[1], volume.ports[2]) annotation (Line(points={{-74,4},{-58,
          4}},                       color={0,127,255}));
  connect(PID.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-21,76},{-8,76},{-8,54},{-54,54}},
                                                          color={0,0,127}));
  connect(volume.ports[3], senTem.port_a) annotation (Line(points={{-56.6667,4},
          {-56.6667,2},{-40,2}},                        color={0,127,255}));
  connect(senTem.port_b, modularConsumer.port_a) annotation (Line(points={{-20,2},
          {36,2}},                      color={0,127,255}));
  connect(senTem.T, PID.u_m) annotation (Line(points={{-30,13},{-32,13},{-32,64}},
                         color={0,0,127}));
  connect(TSetGenerator.y, PID.u_s) annotation (Line(points={{-77,76},{-44,76}},
                                   color={0,0,127}));
  annotation (experiment(StopTime=12000, __Dymola_Algorithm="Dassl"));
end ModularConsumer;
