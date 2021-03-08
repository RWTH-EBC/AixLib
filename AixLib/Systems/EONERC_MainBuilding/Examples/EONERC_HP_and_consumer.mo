within AixLib.Systems.EONERC_MainBuilding.Examples;
model EONERC_HP_and_consumer "Energy system of main building with controller"
  extends Modelica.Icons.Example;
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve2(k_pump=
        100, Td_pump=0)
    annotation (Placement(transformation(extent={{-52,8},{-34,28}})));
  Controller.HeatPumpSystemVolumeFlowControl
                                  heatPumpSystemVolumeFlowControl1
    annotation (Placement(transformation(extent={{-50,90},{-8,140}})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve1(k_pump=
        100, Ti_pump=130)
    annotation (Placement(transformation(extent={{-52,34},{-34,54}})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve3(k_pump=
        100, Td_pump=0)
    annotation (Placement(transformation(extent={{-52,60},{-34,80}})));
  BaseClasses.MainBus bus
    annotation (Placement(transformation(extent={{-4,22},{16,42}})));
  HeatPump_and_consumer heatPump_and_consumer
    annotation (Placement(transformation(extent={{-62,-102},{56,-14}})));
  BaseClasses.HeatpumpAndConsumerControllerBus heatpumpAndConsumerControllerBus
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(heatPumpSystemVolumeFlowControl1.heatPumpSystemBus1, bus.hpSystemBus)
    annotation (Line(
      points={{-8,115.156},{-8,74.578},{6.05,74.578},{6.05,32.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMixVflowConstValve3.hydraulicBus, bus.consLtcBus) annotation (Line(
      points={{-32.74,70.2},{6.05,70.2},{6.05,32.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMixVflowConstValve1.hydraulicBus, bus.consCold1Bus) annotation (
      Line(
      points={{-32.74,44.2},{-14.37,44.2},{-14.37,32.05},{6.05,32.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMixVflowConstValve2.hydraulicBus, bus.consCold2Bus) annotation (
      Line(
      points={{-32.74,18.2},{-13.37,18.2},{-13.37,32.05},{6.05,32.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatPump_and_consumer.mainBus, bus) annotation (Line(
      points={{4.375,-14},{4.375,8},{6,8},{6,32}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.pElHP,
    heatpumpAndConsumerControllerBus.pElHp) annotation (Line(points={{-51.68,
          138.438},{-51.68,139.219},{-99.95,139.219},{-99.95,0.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetHS,
    heatpumpAndConsumerControllerBus.mfSetHpCon) annotation (Line(points={{-51.89,
          129.063},{-51.89,128.531},{-99.95,128.531},{-99.95,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetFreeCool,
    heatpumpAndConsumerControllerBus.mfSetFreeCool) annotation (Line(points={{
          -51.89,91.5625},{-51.89,91.7813},{-99.95,91.7813},{-99.95,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMixVflowConstValve3.Mflowset, heatpumpAndConsumerControllerBus.mfSetLTC)
    annotation (Line(points={{-53.8,75.8},{-53.8,75.9},{-99.95,75.9},{-99.95,
          0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMixVflowConstValve1.Mflowset, heatpumpAndConsumerControllerBus.mfSetCold1)
    annotation (Line(points={{-53.8,49.8},{-53.8,49.9},{-99.95,49.9},{-99.95,
          0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMixVflowConstValve2.Mflowset, heatpumpAndConsumerControllerBus.mfSetCold2)
    annotation (Line(points={{-53.8,23.8},{-98.9,23.8},{-98.9,0.05},{-99.95,
          0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPump_and_consumer.Tair, heatpumpAndConsumerControllerBus.tAmb)
    annotation (Line(points={{-62,-58},{-99.95,-58},{-99.95,0.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetCS,
    heatpumpAndConsumerControllerBus.mfSetCsIn) annotation (Line(points={{-51.68,
          119.688},{-51.68,118.844},{-99.95,118.844},{-99.95,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetCold,
    heatpumpAndConsumerControllerBus.mfSetHpEva) annotation (Line(points={{-51.89,
          110.313},{-51.89,111.156},{-99.95,111.156},{-99.95,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetRecool,
    heatpumpAndConsumerControllerBus.mfSetReCool) annotation (Line(points={{-51.89,
          100.938},{-51.89,100.469},{-99.95,100.469},{-99.95,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (experiment(
      StopTime=21000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end EONERC_HP_and_consumer;
