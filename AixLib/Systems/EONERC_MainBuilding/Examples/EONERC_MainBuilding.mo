within AixLib.Systems.EONERC_MainBuilding.Examples;
model EONERC_MainBuilding "Energy system of main building with controller"
  extends Modelica.Icons.Example;
  MainBuildingEnergySystem mainBuildingEnergySystem
    annotation (Placement(transformation(extent={{-80,-80},{80,40}})));
  BaseClasses.MainBus bus
    annotation (Placement(transformation(extent={{0,68},{20,88}})));
  BaseClasses.EnergyCounter energyCounter
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Controller.EonERCModeControl.EonERCModeBasedControl eonERCModeBasedControl
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
equation
  connect(mainBuildingEnergySystem.mainBus, bus) annotation (Line(
      points={{10,40},{10,58},{10,58},{10,78}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(energyCounter.mainBus, mainBuildingEnergySystem.mainBus) annotation (
      Line(
      points={{49.9,67.6},{49.9,58},{10,58},{10,40}},
      color={255,204,51},
      thickness=0.5));
  connect(eonERCModeBasedControl.bus, mainBuildingEnergySystem.mainBus)
    annotation (Line(
      points={{-39.2,70.1},{10.4,70.1},{10.4,40},{10,40}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=172800, Interval=60),
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=true,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    __Dymola_experimentSetupOutput(
      states=false,
      derivatives=false,
      auxiliaries=false,
      events=false));
end EONERC_MainBuilding;
