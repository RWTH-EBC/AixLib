within AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization;
model ThermalZone_OneRoom
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
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/Weatherdata_benchmark_new.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  Modelica.Blocks.Sources.Constant InfiltrationRate(k=0.15) "Infiltration rate"
    annotation (Placement(transformation(extent={{-24,-60},{-4,-40}})));
  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-76,-18},{-42,14}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));

  BaseClasses.thermalZone_Benchmark thermalZone_OneRoom(redeclare package
      Medium = AixLib.Media.Air)
    annotation (Placement(transformation(extent={{0,-22},{44,20}})));
  Modelica.Blocks.Sources.Constant IntGains(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,-50})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,0},{-59,0},{-59,-2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, thermalZone_OneRoom.ventTemp) annotation (Line(
      points={{-59,-2},{-50,-2},{-50,-10},{-2,-10},{-2,-9.19},{-2.86,-9.19}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, thermalZone_OneRoom.weaBus) annotation (Line(
      points={{-59,-2},{0,-2},{0,-1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(InfiltrationRate.y, thermalZone_OneRoom.ventRate) annotation (Line(
        points={{-3,-50},{6.6,-50},{6.6,-18.64}}, color={0,0,127}));
  connect(IntGains.y, thermalZone_OneRoom.intGains[1]) annotation (Line(points={
          {51,-50},{40,-50},{40,-46},{39.6,-46},{39.6,-20.32}}, color={0,0,127}));
  connect(IntGains.y, thermalZone_OneRoom.intGains[2]) annotation (Line(points={
          {51,-50},{40,-50},{40,-44},{39.6,-44},{39.6,-18.64}}, color={0,0,127}));
  connect(IntGains.y, thermalZone_OneRoom.intGains[3]) annotation (Line(points={
          {51,-50},{40,-50},{40,-44},{39.6,-44},{39.6,-16.96}}, color={0,0,127}));
  annotation (experiment(
      StopTime=4838400,
      Interval=1800,
      Tolerance=1e-06));
end ThermalZone_OneRoom;
