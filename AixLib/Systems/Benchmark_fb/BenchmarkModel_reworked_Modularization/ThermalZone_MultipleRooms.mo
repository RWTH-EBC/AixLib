within AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization;
model ThermalZone_MultipleRooms
   extends Modelica.Icons.Example;
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone[5](
    redeclare package Medium = Media.Air,
    zoneParam={BaseClasses.DataBase_ThermalZone.thermalZone_Benchmark_Workshop(),
    AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization.BaseClasses.DataBase_ThermalZone.thermalZone_Benchmark_Canteen(),
    AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization.BaseClasses.DataBase_ThermalZone.thermalZone_Benchmark_ConferenceRoom(),
    AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization.BaseClasses.DataBase_ThermalZone.thermalZone_Benchmark_MultipersonOffice(),
    AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization.BaseClasses.DataBase_ThermalZone.thermalZone_Benchmark_OpenplanOffice()},
    each internalGainsMode=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

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

  Modelica.Blocks.Sources.Constant IntGains(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={56,-12})));
  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-76,-18},{-42,14}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,0},{-59,0},{-59,-2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(IntGains.y,thermalZone[1]. intGains[1])
    annotation (Line(points={{45,-12},{8,-12},{8,-9.2}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[1]. intGains[2])
    annotation (Line(points={{45,-12},{8,-12},{8,-8.4}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[1]. intGains[3])
    annotation (Line(points={{45,-12},{8,-12},{8,-7.6}},   color={0,0,127}));
    connect(IntGains.y,thermalZone[2]. intGains[1])
    annotation (Line(points={{45,-12},{8,-12},{8,-9.2}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[2]. intGains[2])
    annotation (Line(points={{45,-12},{8,-12},{8,-8.4}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[2]. intGains[3])
    annotation (Line(points={{45,-12},{8,-12},{8,-7.6}},   color={0,0,127}));
    connect(IntGains.y,thermalZone[3]. intGains[1])
    annotation (Line(points={{45,-12},{8,-12},{8,-9.2}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[3]. intGains[2])
    annotation (Line(points={{45,-12},{8,-12},{8,-8.4}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[3]. intGains[3])
    annotation (Line(points={{45,-12},{8,-12},{8,-7.6}},   color={0,0,127}));
    connect(IntGains.y,thermalZone[4]. intGains[1])
    annotation (Line(points={{45,-12},{8,-12},{8,-9.2}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[4]. intGains[2])
    annotation (Line(points={{45,-12},{8,-12},{8,-8.4}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[4]. intGains[3]);
    connect(IntGains.y,thermalZone[5]. intGains[1])
    annotation (Line(points={{45,-12},{8,-12},{8,-9.2}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[5]. intGains[2])
    annotation (Line(points={{45,-12},{8,-12},{8,-8.4}},   color={0,0,127}));
  connect(IntGains.y,thermalZone[5]. intGains[3])
    annotation (Line(points={{45,-12},{8,-12},{8,-7.6}},   color={0,0,127}));

  connect(weaBus, thermalZone[1].weaBus) annotation (Line(
      points={{-59,-2},{-48,-2},{-48,-4},{-10,-4},{-10,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, thermalZone[2].weaBus) annotation (Line(
      points={{-59,-2},{-48,-2},{-48,-4},{-10,-4},{-10,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, thermalZone[3].weaBus) annotation (Line(
      points={{-59,-2},{-44,-2},{-44,-4},{-10,-4},{-10,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, thermalZone[4].weaBus) annotation (Line(
      points={{-59,-2},{-10,-2},{-10,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, thermalZone[5].weaBus) annotation (Line(
      points={{-59,-2},{-10,-2},{-10,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
    annotation (Line(points={{11,-16},{10,-16},{10,16.4}}, color={0,0,127}),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ThermalZone_MultipleRooms;
