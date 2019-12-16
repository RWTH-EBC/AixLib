within AixLib.Systems.EONERC_MainBuilding.Examples;
model EONERC_MainBuilding "Energy system of main building with controller"
  extends Modelica.Icons.Example;
  MainBuildingEnergySystem mainBuildingEnergySystem
    annotation (Placement(transformation(extent={{-80,-80},{80,40}})));
  Controller.EonERCModeControl.EonERCModeBasedControl eonERCModeBasedControl
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  BaseClasses.MainBus bus
    annotation (Placement(transformation(extent={{0,68},{20,88}})));
  BaseClasses.EnergyCounter energyCounter
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
equation
  connect(eonERCModeBasedControl.bus, mainBuildingEnergySystem.mainBus)
    annotation (Line(
      points={{-19.2,70.1},{-0.5,70.1},{-0.5,39.5}},
      color={255,204,51},
      thickness=0.5));
  connect(mainBuildingEnergySystem.mainBus, bus) annotation (Line(
      points={{-0.5,39.5},{-0.5,58},{10,58},{10,78}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(energyCounter.mainBus, mainBuildingEnergySystem.mainBus) annotation (
      Line(
      points={{49.9,67.6},{49.9,58},{-0.5,58},{-0.5,39.5}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=86400));
end EONERC_MainBuilding;
