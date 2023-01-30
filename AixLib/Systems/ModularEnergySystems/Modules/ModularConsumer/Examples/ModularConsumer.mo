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
    hasPump={false,false},
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
    annotation (Placement(transformation(extent={{12,-18},{60,30}})));

  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = AixLib.Media.Water,
    nPorts=1)
    annotation (Placement(transformation(extent={{-158,0},{-134,24}})));
  Fluid.MixingVolumes.MixingVolume volume(
    redeclare package Medium = AixLib.Media.Water,
    T_start=353.15,
    final V=1,
    final m_flow_nominal=1,
    nPorts=3)                                                                                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-58,12})));
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
            annotation (Placement(transformation(extent={{-96,68},{-76,88}})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        AixLib.Media.Water, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-34,2},{-14,22}})));
  Modelica.Blocks.Sources.Constant TSetGenerator(k=273.15 + 80) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-176,76})));
equation
  connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(points={{-54,
          38},{-54,30},{-68,30},{-68,12}}, color={191,0,0}));
  connect(modularConsumer.port_b, volume.ports[1]) annotation (Line(points={{60,6},{
          80,6},{80,-90},{-26,-90},{-26,-38},{-72,-38},{-72,2},{-59.3333,2}},
        color={0,127,255}));
  connect(bou.ports[1], volume.ports[2]) annotation (Line(points={{-134,12},{
          -74,12},{-74,2},{-58,2}},  color={0,127,255}));
  connect(PID.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-75,78},{-54,78},{-54,54}}, color={0,0,127}));
  connect(volume.ports[3], senTem.port_a) annotation (Line(points={{-56.6667,
          2},{-56.6667,-2},{-40,-2},{-40,12},{-34,12}}, color={0,127,255}));
  connect(senTem.port_b, modularConsumer.port_a) annotation (Line(points={{
          -14,12},{2,12},{2,6},{12,6}}, color={0,127,255}));
  connect(senTem.T, PID.u_m) annotation (Line(points={{-24,23},{-24,42},{-86,
          42},{-86,66}}, color={0,0,127}));
  connect(TSetGenerator.y, PID.u_s) annotation (Line(points={{-165,76},{-120,
          76},{-120,78},{-98,78}}, color={0,0,127}));
  annotation (experiment(StopTime=12000, __Dymola_Algorithm="Dassl"));
end ModularConsumer;
