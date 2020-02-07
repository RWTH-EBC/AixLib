within AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization;
model HighOrderModel_OneRoom
extends Modelica.Icons.Example;
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilWall[3](
    til={1.5707963267949,1.5707963267949,1.5707963267949},
    each final lat=0.83845617265808,
    final azi={0,3.1415926535898,4.7123889803847})
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-60,-19},{-44,-2}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilRoof(
    each final outSkyCon=false,
    each final outGroCon=false,
    each final lat=0.83845617265808,
    final azi=0,
    final til=0)
    "Calculates diffuse solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-60,39},{-44,55}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTilRoof(
    each final lat=0.83845617265808,
    final azi=0,
    final til=0) "Calculates direct solar radiation on titled surface for roof"
    annotation (Placement(transformation(extent={{-60,80},{-44,97}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDiffTilWalll[3](
    til={1.5707963267949,1.5707963267949,1.5707963267949},
    lat=0.83828163973288,
    azi={0,3.1415926535898,4.7123889803847},
    outSkyCon=false,
    outGroCon=false)
    annotation (Placement(transformation(extent={{-60,-60},{-44,-44}})));
  AixLib.BoundaryConditions.WeatherData.Bus
                                     weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-87,2},{-53,34}}),   iconTransformation(
    extent={{-110,-10},{-90,10}})));
  AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization.BaseClasses.HighOrderModel_Benchmark_Workshop
    HighOrder_Room(
    Room_Lenght=30,
    Room_Height=3,
    Room_Width=30,
    Win_Area=60,
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=5000,
    TOutAirLimit=373.15,
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009())
    annotation (Placement(transformation(extent={{20,-8},{52,24}})));
  AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization.BaseClasses.ConvRealtoRad
    convRealtoRad[5]
    annotation (Placement(transformation(extent={{-22,6},{-2,26}})));
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
    annotation (Placement(transformation(extent={{-100,8},{-80,28}})));

  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={56,70})));
  Modelica.Blocks.Sources.Constant HeatTransferCoefficient(k=30*1260)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={93,71})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{28,86},{42,100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={63,-53})));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={93,-53})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-52,-92})));
protected
  Modelica.Blocks.Sources.Constant AER(final k=0.15) "Air Exchange Rate"
                                                       annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={92,-92})));
equation
  connect(AER.y, HighOrder_Room.AER) annotation (Line(points={{83.2,-92},{18,-92},
          {18,-56},{18.4,-56},{18.4,0}},
                                      color={0,0,127}));
  connect(convRealtoRad[1].SolarRadiation, HighOrder_Room.SolarRadiationPort[1])
    annotation (Line(points={{-2,17.2},{6,17.2},{6,18},{18.4,18},{18.4,16.32}},
        color={255,128,0}));
  connect(convRealtoRad[2].SolarRadiation, HighOrder_Room.SolarRadiationPort[2])
    annotation (Line(points={{-2,17.2},{18,17.2},{18,18},{14,18},{14,16.96},{18.4,
          16.96}},                                                 color={255,128,
          0}));
  connect(convRealtoRad[3].SolarRadiation, HighOrder_Room.SolarRadiationPort[3])
    annotation (Line(points={{-2,17.2},{6,17.2},{6,17.6},{18.4,17.6}}, color={255,
          128,0}));
  connect(convRealtoRad[4].SolarRadiation, HighOrder_Room.SolarRadiationPort[4])
    annotation (Line(points={{-2,17.2},{6,17.2},{6,18},{18.4,18},{18.4,18.24}},
        color={255,128,0}));
        connect(convRealtoRad[5].SolarRadiation, HighOrder_Room.SolarRadiationPort[5]);
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,18},{-76,18},{-76,20},{-70,20},{-70,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, HDifTilRoof.weaBus) annotation (Line(
      points={{-70,18},{-70,48},{-60,48},{-60,47}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, HDirTilRoof.weaBus) annotation (Line(
      points={{-70,18},{-70,88.5},{-60,88.5}},
      color={255,204,51},
      thickness=0.5));
  connect(convection.fluid, HighOrder_Room.Therm_outside) annotation (Line(
        points={{56,60},{56,34},{19.2,34},{19.2,23.52}},color={191,0,0}));
  connect(HeatTransferCoefficient.y, convection.Gc)
    annotation (Line(points={{85.3,71},{66,71},{66,70}}, color={0,0,127}));
  connect(TSoil.y, prescribedTemperature1.T)
    annotation (Line(points={{85.3,-53},{71.4,-53}},   color={0,0,127}));
  connect(prescribedTemperature.port, convection.solid) annotation (Line(points={{42,93},
          {62,93},{62,80},{56,80}},         color={191,0,0}));

  connect(prescribedTemperature1.port, HighOrder_Room.Therm_ground) annotation (
     Line(points={{56,-53},{30.88,-53},{30.88,-7.36}},
                                                    color={191,0,0}));
  connect(weaBus.TDryBul, prescribedTemperature.T) annotation (Line(
      points={{-70,18},{-70,100},{26,100},{26,96},{26.6,96},{26.6,93}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDiffTilWalll[1].weaBus) annotation (Line(
      points={{-70,18},{-72,18},{-72,-52},{-60,-52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDiffTilWalll[2].weaBus) annotation (Line(
      points={{-70,18},{-72,18},{-72,-52},{-60,-52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDiffTilWalll[3].weaBus) annotation (Line(
      points={{-70,18},{-72,18},{-72,-52},{-60,-52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDirTilWall[1].weaBus) annotation (Line(
      points={{-70,18},{-72,18},{-72,-10.5},{-60,-10.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDirTilWall[2].weaBus) annotation (Line(
      points={{-70,18},{-72,18},{-72,-10},{-66,-10},{-66,-10.5},{-60,-10.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDirTilWall[3].weaBus) annotation (Line(
      points={{-70,18},{-72,18},{-72,-10},{-66,-10},{-66,-10.5},{-60,-10.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.winSpe, HighOrder_Room.WindSpeedPort) annotation (Line(
      points={{-70,18},{-72,18},{-72,-32},{10,-32},{10,12.8},{18.4,12.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const2.y, convRealtoRad[1].Dummy) annotation (Line(points={{-43.2,-92},
          {-32,-92},{-32,7},{-22,7}}, color={0,0,127}));
  connect(HDifTilRoof.H, convRealtoRad[5].DiffRad) annotation (Line(points={{-43.2,
          47},{-32,47},{-32,25},{-22,25}}, color={0,0,127}));
  connect(HDirTilRoof.H, convRealtoRad[5].DirRad) annotation (Line(points={{-43.2,
          88.5},{-38,88.5},{-38,88},{-32,88},{-32,16},{-22,16}}, color={0,0,127}));
  connect(HDirTilWall[1].H, convRealtoRad[3].DirRad) annotation (Line(points={{-43.2,
          -10.5},{-32,-10.5},{-32,16},{-22,16}}, color={0,0,127}));
  connect(HDiffTilWalll[1].H, convRealtoRad[3].DiffRad) annotation (Line(points=
         {{-43.2,-52},{-32,-52},{-32,25},{-22,25}}, color={0,0,127}));
           connect(HDirTilWall[2].H, convRealtoRad[1].DirRad) annotation (Line(points={{-43.2,
          -10.5},{-32,-10.5},{-32,16},{-22,16}}, color={0,0,127}));
  connect(HDiffTilWalll[2].H, convRealtoRad[1].DiffRad);
   connect(HDirTilWall[3].H, convRealtoRad[4].DirRad) annotation (Line(points={{-43.2,
          -10.5},{-32,-10.5},{-32,16},{-22,16}}, color={0,0,127}));
  connect(HDiffTilWalll[3].H, convRealtoRad[4].DiffRad);
   connect(const2.y, convRealtoRad[2].Dummy) annotation (Line(points={{-43.2,-92},
          {-32,-92},{-32,7},{-22,7}}, color={0,0,127}));
           connect(const2.y, convRealtoRad[3].Dummy) annotation (Line(points={{-43.2,-92},
          {-32,-92},{-32,7},{-22,7}}, color={0,0,127}));
           connect(const2.y, convRealtoRad[4].Dummy) annotation (Line(points={{-43.2,-92},
          {-32,-92},{-32,7},{-22,7}}, color={0,0,127}));
           connect(const2.y, convRealtoRad[5].Dummy) annotation (Line(points={{-43.2,-92},
          {-32,-92},{-32,7},{-22,7}}, color={0,0,127}));
           connect(const2.y, convRealtoRad[2].DirRad) annotation (Line(points={{-43.2,
          -92},{-32,-92},{-32,16},{-22,16}},
                                      color={0,0,127}));
           connect(const2.y, convRealtoRad[2].DiffRad) annotation (Line(points={{-43.2,
          -92},{-32,-92},{-32,25},{-22,25}},
                                      color={0,0,127}));

  annotation (                     experiment(StopTime=4838400, Interval=1800));
end HighOrderModel_OneRoom;
