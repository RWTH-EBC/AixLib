within AixLib.ThermalZones.ReducedOrder.Examples;
model MyMultizoneEquipped "Illustrates the use of Multizone Equipped"
   import AixLib;
  extends Modelica.Icons.Example;
  parameter Integer numZones=2 "Number of zones";



  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-82,48},{-62,68}})));

  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation,
    tableName="Internals",
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/LowOrder_ExampleData/Internals_Input_6Zone_SIA.txt"),
    columns=2:(1 + 3*numZones))
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{72,-42},{56,-26}})));

  Modelica.Blocks.Sources.CombiTimeTable tableTSet(
    tableOnFile=true,
    tableName="Tset",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/LowOrder_ExampleData/Tset_6Zone.txt"),
    columns=2:(1 + numZones))
    "Set points for heater"
    annotation (Placement(transformation(extent={{72,-66},{56,-50}})));

  Modelica.Blocks.Sources.Constant const[numZones](each k=0)
    "Set point for cooler"
    annotation (Placement(transformation(extent={{72,-90},{56,-74}})));
  Modelica.Blocks.Sources.CombiTimeTable tableOpeningHours(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="OpeningHours",
    columns=2:16,
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Output_Schwimmbad_Modell/Hallenbad/OpeningHours_Hallenbad.txt"))  "Boundary condition: Opening Hours of swiming pools"
    annotation (Placement(transformation(extent={{-72,-4},{-56,12}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[numZones]
    "Radiative heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{-34,-62},{-14,-42}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=500,
    freqHz=1/86400,
    offset=500)
    "Sinusoidal excitation for additional internal gains"
    annotation (Placement(transformation(extent={{-110,-72},{-90,-52}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1[numZones]
    "Convective heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{-34,-84},{-14,-64}})));
  Modelica.Blocks.Math.Gain gain(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{-76,-58},{-64,-46}})));
  Modelica.Blocks.Math.Gain gain1(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{-76,-80},{-64,-68}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=numZones)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-50,-52})));
  Modelica.Blocks.Routing.Replicator replicator1(nout=numZones)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-50,-74})));
  AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone thermalZone( zoneParam={Output_Schwimmbad_Modell.Hallenbad.Hallenbad_DataBase.Hallenbad_Schwimmhalle(),
        Output_Schwimmbad_Modell.Hallenbad.Hallenbad_DataBase.Hallenbad_Aufsichtsraum()},numZones=numZones)
    annotation (Placement(transformation(extent={{-2,12},{18,32}})));
equation
  connect(gain.y,replicator. u)
    annotation (Line(points={{-63.4,-52},{-57.2,-52}}, color={0,0,127}));
  connect(sine.y,gain. u) annotation (Line(points={{-89,-62},{-82,-62},{-82,-52},
          {-77.2,-52}}, color={0,0,127}));
  connect(sine.y,gain1. u) annotation (Line(points={{-89,-62},{-82,-62},{-82,-74},
          {-77.2,-74}}, color={0,0,127}));
  connect(gain1.y,replicator1. u)
    annotation (Line(points={{-63.4,-74},{-57.2,-74}}, color={0,0,127}));
  connect(replicator1.y,prescribedHeatFlow1. Q_flow)
    annotation (Line(points={{-43.4,-74},{-34,-74}}, color={0,0,127}));
  connect(replicator.y,prescribedHeatFlow. Q_flow) annotation (Line(points={{-43.4,
          -52},{-34,-52}},             color={0,0,127}));

  connect(prescribedHeatFlow.port, thermalZone.port_a[:, 1]) annotation (Line(
        points={{-14,-52},{-14,-16},{18,-16},{18,19.6}}, color={191,0,0}));
  connect(prescribedHeatFlow1.port, thermalZone.port_a1[:, 1]) annotation (Line(
        points={{-14,-74},{30,-74},{30,18},{24,18},{24,17.8},{18,17.8}}, color={
          191,0,0}));

  connect(tableInternalGains.y, thermalZone.intGains) annotation (Line(points={{
          55.2,-34},{26,-34},{26,19.2},{-3,19.2}}, color={0,0,127}));
  connect(tableTSet.y, thermalZone.TSetHeat) annotation (Line(points={{55.2,-58},
          {26,-58},{26,16.2},{-2.8,16.2}}, color={0,0,127}));
  connect(const.y, thermalZone.TSetCool) annotation (Line(points={{55.2,-82},{26,
          -82},{26,13.4},{-2.8,13.4}}, color={0,0,127}));
  connect(tableOpeningHours.y, thermalZone.openingHours) annotation (Line(
        points={{-55.2,4},{-28,4},{-28,22.2},{-2.8,22.2}}, color={0,0,127}));
  connect(weaDat.weaBus, thermalZone.weaBus) annotation (Line(
      points={{-62,58},{-44,58},{-44,21.8},{2,21.8}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{100,100}})));
end MyMultizoneEquipped;
