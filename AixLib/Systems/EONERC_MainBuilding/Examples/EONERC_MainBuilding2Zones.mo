within AixLib.Systems.EONERC_MainBuilding.Examples;
model EONERC_MainBuilding2Zones
  "Energy system of main building with controller"
  import AixLib;
  extends Modelica.Icons.Example;
  MainBuilding2Zones benchmarkBuilding2Zones
    annotation (Placement(transformation(extent={{-80,-80},{80,40}})));
  AixLib.Systems.EONERC_MainBuilding.BaseClasses.MainBus2Zones bus annotation (
      Placement(transformation(extent={{-18,70},{2,90}}), iconTransformation(
          extent={{0,68},{20,88}})));
  Controller.MainBuilding2ZonesControl mainBuilding2ZonesControl
    annotation (Placement(transformation(extent={{-60,52},{-40,80}})));
  Modelica.Blocks.Interfaces.RealOutput Tair1
    annotation (Placement(transformation(extent={{-110,-108},{-90,-88}})));
  BaseClasses.EnergyCounter2Zones energyCounter2Zones
    annotation (Placement(transformation(extent={{20,72},{40,92}})));
equation
  connect(benchmarkBuilding2Zones.mainBus, bus) annotation (Line(
      points={{-8,39.1111},{-8,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(benchmarkBuilding2Zones.Tair, Tair1) annotation (Line(points={{-46.8,
          -82.2222},{-100,-82.2222},{-100,-98}}, color={0,0,127}));
  connect(mainBuilding2ZonesControl.bus, benchmarkBuilding2Zones.mainBus)
    annotation (Line(
      points={{-39.2,70.1},{-8,70.1},{-8,39.1111}},
      color={255,204,51},
      thickness=0.5));
  connect(benchmarkBuilding2Zones.mainBus, energyCounter2Zones.mainBus)
    annotation (Line(
      points={{-8,39.1111},{-8,74},{29.9,74},{29.9,79.6}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(
      StopTime=86400,
      Interval=59.9999616,
      __Dymola_Algorithm="Dassl"),
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
