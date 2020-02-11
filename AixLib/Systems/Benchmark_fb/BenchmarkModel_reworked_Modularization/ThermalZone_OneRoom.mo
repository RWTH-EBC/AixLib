within AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization;
model ThermalZone_OneRoom
   extends Modelica.Icons.Example;
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone(
    redeclare package Medium = Media.Air,
    zoneParam=BaseClasses.DataBase_ThermalZone.thermalZone_Benchmark_Workshop(),
    internalGainsMode=1)
    annotation (Placement(transformation(extent={{-8,14},{12,34}})));

  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    pAtmSou=AixLib.BoundaryConditions.Types.DataSource.File,
    ceiHeiSou=AixLib.BoundaryConditions.Types.DataSource.File,
    totSkyCovSou=AixLib.BoundaryConditions.Types.DataSource.File,
    opaSkyCovSou=AixLib.BoundaryConditions.Types.DataSource.File,
    TDryBulSou=AixLib.BoundaryConditions.Types.DataSource.File,
    TDewPoiSou=AixLib.BoundaryConditions.Types.DataSource.File,
    TBlaSkySou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    relHumSou=AixLib.BoundaryConditions.Types.DataSource.File,
    winSpeSou=AixLib.BoundaryConditions.Types.DataSource.File,
    winDirSou=AixLib.BoundaryConditions.Types.DataSource.File,
    HInfHorSou=AixLib.BoundaryConditions.Types.DataSource.File,
    HSou=AixLib.BoundaryConditions.Types.RadiationDataSource.File,
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.TemperaturesAndSkyCover,
    computeWetBulbTemperature=true,
    filNam=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/weatherdata/Weatherdata_benchmark_new.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-76,-18},{-42,14}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Sources.Constant IntGains(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={22,-16})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,0},{-59,0},{-59,-2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus, thermalZone.weaBus) annotation (Line(
      points={{-59,-2},{-8,-2},{-8,24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(IntGains.y, thermalZone.intGains[1])
    annotation (Line(points={{11,-16},{10,-16},{10,14.8}}, color={0,0,127}));
  connect(IntGains.y, thermalZone.intGains[2])
    annotation (Line(points={{11,-16},{10,-16},{10,15.6}}, color={0,0,127}));
  connect(IntGains.y, thermalZone.intGains[3])
    annotation (Line(points={{11,-16},{10,-16},{10,16.4}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=4838400, Interval=1800));
end ThermalZone_OneRoom;
