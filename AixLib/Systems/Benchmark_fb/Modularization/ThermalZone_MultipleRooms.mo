within AixLib.Systems.Benchmark_fb.Modularization;
model ThermalZone_MultipleRooms
   extends Modelica.Icons.Example;

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
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));

  Modelica.Blocks.Sources.Constant IntGains(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-80})));
  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-76,-16},{-42,16}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  BaseClasses.BaseClasses_ThermalZone.thermalZone_Benchmark
    thermalZone_Benchmark[5](redeclare package Medium = Media.Air, zoneParam={
        AixLib.Systems.Benchmark_fb.Modularization.BaseClasses.BaseClasses_ThermalZone.Records_ThermalZone.thermalZone_Benchmark_Workshop(),
        AixLib.Systems.Benchmark_fb.Modularization.BaseClasses.BaseClasses_ThermalZone.Records_ThermalZone.thermalZone_Benchmark_Canteen(),
        AixLib.Systems.Benchmark_fb.Modularization.BaseClasses.BaseClasses_ThermalZone.Records_ThermalZone.thermalZone_Benchmark_ConferenceRoom(),
        AixLib.Systems.Benchmark_fb.Modularization.BaseClasses.BaseClasses_ThermalZone.Records_ThermalZone.thermalZone_Benchmark_MultipersonOffice(),
        AixLib.Systems.Benchmark_fb.Modularization.BaseClasses.BaseClasses_ThermalZone.Records_ThermalZone.thermalZone_Benchmark_OpenplanOffice()})
    annotation (Placement(transformation(extent={{-36,-32},{40,32}})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,80},{-59,80},{-59,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(weaBus, thermalZone_Benchmark[1].weaBus) annotation (Line(
      points={{-59,0},{-36,0},{-36,0}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, thermalZone_Benchmark[2].weaBus) annotation (Line(
      points={{-59,0},{-50,0},{-50,0},{-36,0}},
      color={255,204,51},
      thickness=0.5));
  connect(IntGains.y, thermalZone_Benchmark[1].intGains[1]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-29.44},{32.4,-29.44}}, color={0,0,127}));
  connect(IntGains.y, thermalZone_Benchmark[1].intGains[2]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-54},{32.4,-54},{32.4,-26.88}}, color={0,
          0,127}));
  connect(IntGains.y, thermalZone_Benchmark[1].intGains[3]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-52},{32.4,-52},{32.4,-24.32}}, color={0,
          0,127}));
          connect(IntGains.y, thermalZone_Benchmark[2].intGains[1]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-29.44},{32.4,-29.44}}, color={0,0,127}));
  connect(IntGains.y, thermalZone_Benchmark[2].intGains[2]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-54},{32.4,-54},{32.4,-26.88}}, color={0,
          0,127}));
  connect(IntGains.y, thermalZone_Benchmark[2].intGains[3]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-52},{32.4,-52},{32.4,-24.32}}, color={0,
          0,127}));
  connect(weaBus, thermalZone_Benchmark[3].weaBus) annotation (Line(
      points={{-59,0},{-36,0}},
      color={255,204,51},
      thickness=0.5));
       connect(IntGains.y, thermalZone_Benchmark[3].intGains[1]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-29.44},{32.4,-29.44}}, color={0,0,127}));
  connect(IntGains.y, thermalZone_Benchmark[3].intGains[2]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-54},{32.4,-54},{32.4,-26.88}}, color={0,
          0,127}));
  connect(IntGains.y, thermalZone_Benchmark[3].intGains[3]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-52},{32.4,-52},{32.4,-24.32}}, color={0,
          0,127}));
  connect(weaBus, thermalZone_Benchmark[4].weaBus) annotation (Line(
      points={{-59,0},{-36,0}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, thermalZone_Benchmark[5].weaBus) annotation (Line(
      points={{-59,0},{-54,0},{-54,-2},{-36,-2},{-36,0}},
      color={255,204,51},
      thickness=0.5));
      connect(IntGains.y, thermalZone_Benchmark[4].intGains[1]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-29.44},{32.4,-29.44}}, color={0,0,127}));
  connect(IntGains.y, thermalZone_Benchmark[4].intGains[2]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-54},{32.4,-54},{32.4,-26.88}}, color={0,
          0,127}));
  connect(IntGains.y, thermalZone_Benchmark[4].intGains[3]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-52},{32.4,-52},{32.4,-24.32}}, color={0,
          0,127}));
          connect(IntGains.y, thermalZone_Benchmark[5].intGains[1]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-29.44},{32.4,-29.44}}, color={0,0,127}));
  connect(IntGains.y, thermalZone_Benchmark[5].intGains[2]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-54},{32.4,-54},{32.4,-26.88}}, color={0,
          0,127}));
  connect(IntGains.y, thermalZone_Benchmark[5].intGains[3]) annotation (Line(
        points={{-79,-80},{32,-80},{32,-52},{32.4,-52},{32.4,-24.32}}, color={0,
          0,127}));
    annotation (Line(points={{11,-16},{10,-16},{10,16.4}}, color={0,0,127}),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=4838400, Interval=300));
end ThermalZone_MultipleRooms;
