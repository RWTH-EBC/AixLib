within AixLib.Systems.EONERC_MainBuilding.Examples;
model EONERC_MainBuilding_simple
  "Energy system of main building with controller"
  extends Modelica.Icons.Example;
  BaseClasses.MainBus bus
    annotation (Placement(transformation(extent={{6,90},{26,110}})));
  BaseClasses.EnergyCounter energyCounter
    annotation (Placement(transformation(extent={{58,56},{78,76}})));
  MainBuildingEnergySystem_simple mainBuildingEnergySystem_simple
    annotation (Placement(transformation(extent={{-54,-100},{72,-6}})));
  Controller.EON_ERC_simple_FlowControl eON_ERC_simple_FlowControl
    annotation (Placement(transformation(extent={{-54,42},{-18,86}})));
  BaseClasses.SimpleERCBus ctrlBus
    annotation (Placement(transformation(extent={{-108,-10},{-88,10}})));
equation
  connect(eON_ERC_simple_FlowControl.mainBus, mainBuildingEnergySystem_simple.mainBus)
    annotation (Line(
      points={{-18,64},{16,64},{16,-6},{16.875,-6}},
      color={255,204,51},
      thickness=0.5));
  connect(bus, mainBuildingEnergySystem_simple.mainBus) annotation (Line(
      points={{16,100},{16,5},{16.875,5},{16.875,-6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(energyCounter.mainBus, bus) annotation (Line(
      points={{67.9,63.6},{15.95,63.6},{15.95,100},{16,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(eON_ERC_simple_FlowControl.simpleERCBus, ctrlBus) annotation (Line(
      points={{-54,64},{-78,64},{-78,0},{-98,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrlBus.tAmb, mainBuildingEnergySystem_simple.Tair) annotation (Line(
      points={{-97.95,0.05},{-78,0.05},{-78,-53},{-54,-53}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (experiment(StopTime=31536000, Interval=59.9999616));
end EONERC_MainBuilding_simple;
