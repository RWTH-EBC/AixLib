within AixLib.Systems.EONERC_MainBuilding.Examples;
model EONERC_MainBuilding2Zones
  "Energy system of main building with controller"
  extends Modelica.Icons.Example;
  MainBuilding2Zones benchmarkBuilding2Zones
    annotation (Placement(transformation(extent={{-80,-80},{80,40}})));
  BaseClasses.MainBus2ZoneMainBuilding
                      bus
    annotation (Placement(transformation(extent={{-18,70},{2,90}}),
        iconTransformation(extent={{0,68},{20,88}})));
  Controller.MainBuilding2ZonesControl mainBuilding2ZonesControl
    annotation (Placement(transformation(extent={{-60,52},{-40,80}})));
  BaseClasses.EnergyCounter2Zones energyCounter2Zones
    annotation (Placement(transformation(extent={{40,58},{60,78}})));
equation
  connect(benchmarkBuilding2Zones.mainBus, bus) annotation (Line(
      points={{-8,39.1111},{-8,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(mainBuilding2ZonesControl.bus, benchmarkBuilding2Zones.mainBus)
    annotation (Line(
      points={{-39.2,70.1},{-8,70.1},{-8,39.1111}},
      color={255,204,51},
      thickness=0.5));
  connect(energyCounter2Zones.mainBus, benchmarkBuilding2Zones.mainBus)
    annotation (Line(
      points={{49.9,65.6},{49.9,54},{-8,54},{-8,39.1111}},
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
end EONERC_MainBuilding2Zones;
