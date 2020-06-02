within AixLib.Systems.Benchmark_fb.Comparison_HOM_ROM;
model HighOrderModel_MultipleRooms
  extends Modelica.Icons.Example;
  AixLib.BoundaryConditions.WeatherData.Bus
                                     weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-85,-16},{-51,16}}), iconTransformation(
    extent={{-110,-10},{-90,10}})));

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

  BaseClasses.BaseClasse_HighOrderModel.HighOrderModel_OpenplanOffice
    highOrderModel_OpenplanOffice
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  BaseClasses.BaseClasse_HighOrderModel.HighOrderModel_Workshop
    highOrderModel_Workshop
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  BaseClasses.BaseClasse_HighOrderModel.HighOrderModel_Canteen
    highOrderModel_Canteen
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  BaseClasses.BaseClasse_HighOrderModel.HighOrderModel_ConferenceRoom
    highOrderModel_ConferenceRoom
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  BaseClasses.BaseClasse_HighOrderModel.HighOrderModel_MultipersonOffice
    highOrderModel_MultipersonOffice
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,0},{-76,0},{-76,2},{-68,2},{-68,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(weaBus, highOrderModel_Workshop.weaBus) annotation (Line(
      points={{-68,0},{0,0},{0,80},{40,80}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, highOrderModel_Canteen.weaBus) annotation (Line(
      points={{-68,0},{0,0},{0,40},{40,40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, highOrderModel_OpenplanOffice.weaBus) annotation (Line(
      points={{-68,0},{0,0},{0,-80},{40,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, highOrderModel_ConferenceRoom.weaBus) annotation (Line(
      points={{-68,0},{40,0}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, highOrderModel_MultipersonOffice.weaBus) annotation (Line(
      points={{-68,0},{0,0},{0,-40},{40,-40}},
      color={255,204,51},
      thickness=0.5));
  annotation (                     experiment(StopTime=4838400, Interval=300),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                                   experiment(StopTime=4838400, Interval=1800),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                                   experiment(StopTime=4838400, Interval=1800),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighOrderModel_MultipleRooms;
