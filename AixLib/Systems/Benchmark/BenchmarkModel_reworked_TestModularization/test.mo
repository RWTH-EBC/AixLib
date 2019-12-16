within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model test
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
    HSou=AixLib.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor,
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.TemperaturesAndSkyCover,
    computeWetBulbTemperature=true,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/Weatherdata_benchmark_new.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-94,18},{-74,38}})));

  Modelica.Blocks.Sources.Constant const(k=0.15)
    "Infiltration rate"
    annotation (Placement(transformation(extent={{-92,-40},{-72,-20}})));
  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-78,-20},{-44,12}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));

  Benchmark_DataBase.thermalZone_2 thermalZone_2_1(redeclare package Medium =
        AixLib.Media.Air)
    annotation (Placement(transformation(extent={{-20,-6},{0,14}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="DIffDir",
    fileName="D:/sciebo_fb/Simulation/SimInput/DiffDir.mat",
    columns={2,3})
    annotation (Placement(transformation(extent={{-88,58},{-68,78}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-38,-60},{-18,-40}})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-74,28},{-61,28},{-61,-4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, thermalZone_2_1.ventTemp) annotation (Line(
      points={{-61,-4},{-50,-4},{-50,6},{-21.3,6},{-21.3,0.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, thermalZone_2_1.weaBus) annotation (Line(
      points={{-61,-4},{-46,-4},{-46,-2},{-20,-2},{-20,4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const.y, thermalZone_2_1.ventRate) annotation (Line(points={{-71,-30},
          {-17,-30},{-17,-4.4}}, color={0,0,127}));
  connect(combiTimeTable.y[1], weaDat.HDirNor_in) annotation (Line(points={{-67,
          68},{-62,68},{-62,17},{-95,17}}, color={0,0,127}));
  connect(combiTimeTable.y[2], weaDat.HDifHor_in) annotation (Line(points={{-67,
          68},{-64,68},{-64,28},{-95,28},{-95,20.4}}, color={0,0,127}));
  connect(const1.y, thermalZone_2_1.intGains[1]) annotation (Line(points={{-17,
          -50},{-16,-50},{-16,-44},{-2,-44},{-2,-5.2}}, color={0,0,127}));
  connect(const1.y, thermalZone_2_1.intGains[2]) annotation (Line(points={{-17,
          -50},{-14,-50},{-14,-42},{-2,-42},{-2,-4.4}}, color={0,0,127}));
  connect(const1.y, thermalZone_2_1.intGains[3]) annotation (Line(points={{-17,
          -50},{-12,-50},{-12,-40},{-2,-40},{-2,-3.6}}, color={0,0,127}));
  annotation (experiment(
      StopTime=4838400,
      Interval=3600,
      Tolerance=1e-06));
end test;
