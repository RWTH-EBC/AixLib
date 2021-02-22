within AixLib.Systems.EONERC_MainBuilding.Examples;
model EONERC_MainBuilding_simple
  "Energy system of main building with controller"
  extends Modelica.Icons.Example;
  BaseClasses.MainBus bus
    annotation (Placement(transformation(extent={{0,68},{20,88}})));
  BaseClasses.EnergyCounter energyCounter
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  MainBuildingEnergySystem_simple mainBuildingEnergySystem_simple
    annotation (Placement(transformation(extent={{-62,-74},{64,20}})));
  annotation (experiment(StopTime=31536000, Interval=59.9999616));
end EONERC_MainBuilding_simple;
