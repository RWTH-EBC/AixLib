within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoilerConsumer
  "Example for ModularBoiler - With Pump and simple Pump regulation"
  extends Modelica.Icons.Example;
  parameter Integer k=2 "number of consumers";
  package MediumWater = AixLib.Media.Water;

  AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ModularBoiler_wPump
    modularBoiler_wPump(
    QNom=10000,
    m_flowVar=true,
    redeclare package Medium = MediumWater,
    Advanced=false)
    annotation (Placement(transformation(extent={{-34,-30},{26,30}})));
  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-14},{-72,10}})));
  Modelica.Blocks.Sources.Constant PLR_const(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,92})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Sources.Constant dT_const(k=25) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,60})));
  ModularConsumer.ConsumerDistributorModule modularConsumer(n_consumers=1,
      functionality="Q_flow_fixed")
    annotation (Placement(transformation(extent={{68,-16},{100,16}})));
  Modelica.Blocks.Sources.Constant TConFLow(k=343.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-86,-44})));
  Modelica.Blocks.Sources.Constant TConReturn(k=323.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-86,-82})));
equation
  connect(boilerControlBus, modularBoiler_wPump.boilerControlBus)
   annotation (
      Line(
      points={{0,62},{0,29.4},{-4,29.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PLR_const.y, boilerControlBus.PLR) annotation (Line(points={{-81,92},
          {0.05,92},{0.05,62.05}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dT_const.y, boilerControlBus.DeltaTWater) annotation (Line(points={{-81,60},
          {-14,60},{-14,62.05},{0.05,62.05}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler_wPump.port_b, modularConsumer.port_a)
    annotation (Line(points={{26,0},{68,0}}, color={0,127,255}));
  connect(modularConsumer.port_b, modularBoiler_wPump.port_a) annotation (Line(
        points={{100,0},{124,0},{124,-92},{-34,-92},{-34,0}}, color={0,127,255}));
  connect(TConFLow.y, modularConsumer.T_Flow[1]) annotation (Line(points={{-75,
          -44},{-22,-44},{-22,-42},{40,-42},{40,-9.6},{68,-9.6}}, color={0,0,
          127}));
  connect(bou.ports[1], modularBoiler_wPump.port_a) annotation (Line(points={{
          -72,-2},{-70,-2},{-70,0},{-34,0}}, color={0,127,255}));
  connect(TConReturn.y, modularConsumer.T_Return[1]) annotation (Line(points={{
          -75,-82},{-8,-82},{-8,-72},{54,-72},{54,-14.4},{68,-14.4}}, color={0,
          0,127}));
annotation (
    experiment(StopTime=3600));
end ModularBoilerConsumer;
