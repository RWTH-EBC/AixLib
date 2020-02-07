within AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization;
model HighOrderModel_MultipleRooms
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
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDiffTilWall[3](
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
    transformation(extent={{-85,2},{-51,34}}),   iconTransformation(
    extent={{-110,-10},{-90,10}})));
  AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization.BaseClasses.HighOrderModel_Benchmark_Workshop
    highOrderModel_Benchmark_Workshop(
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
    annotation (Placement(transformation(extent={{70,70},{102,102}})));

  AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization.BaseClasses.ConvRealtoRad
    convRealtoRad[25]
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

  Modelica.Thermal.HeatTransfer.Components.Convection convection[5] annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={18,60})));
  Modelica.Blocks.Sources.Constant HeatTransferCoefficient[5](k={30*1170,30*720,
        30*80,30*160,1450*30})
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={11,89})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-17,91})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=0,
        origin={29,-55})));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-13,-53})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-52,-92})));
  BaseClasses.HighOrderModel_Benchmark_OpenplanOffice
    highOrderModel_Benchmark_OpenplanOffice(
    Room_Lenght=30,
    Room_Height=3,
    Room_Width=50,
    Win_Area=66.66,
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=100000,
    TOutAirLimit=373.15,
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009())
    annotation (Placement(transformation(extent={{68,-74},{100,-44}})));
  BaseClasses.HighOrderModel_Benchmark_Canteen highOrderModel_Benchmark_Canteen(
    Room_Lenght=30,
    Room_Height=3,
    Room_Width=20,
    Win_Area=20,
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=500000,
    TOutAirLimit=373.15,
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009())
    annotation (Placement(transformation(extent={{70,32},{102,62}})));
  BaseClasses.HighOrderModel_Benchmark_ConferenceRoom
    highOrderModel_Benchmark_ConferenceRoom(
    Room_Lenght=5,
    Room_Height=3,
    Room_Width=10,
    Win_Area=20,
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=10000,
    TOutAirLimit=373.15,
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009())
    annotation (Placement(transformation(extent={{68,-2},{100,28}})));
  BaseClasses.HighOrderModel_Benchmark_MultipersonOffice
    highOrderModel_Benchmark_MultipersonOffice(
    Room_Lenght=5,
    Room_Height=3,
    Room_Width=20,
    Win_Area=40,
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=10000,
    TOutAirLimit=373.15,
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009())
    annotation (Placement(transformation(extent={{68,-36},{100,-8}})));
protected
  Modelica.Blocks.Sources.Constant AER(final k=0.15) "Air Exchange Rate"
                                                       annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-10,-92})));
equation
  connect(AER.y, highOrderModel_Benchmark_Workshop.AER) annotation (Line(points=
         {{-1.2,-92},{50,-92},{50,78},{68.4,78}}, color={0,0,127}));
  connect(convRealtoRad[1].SolarRadiation, highOrderModel_Benchmark_Workshop.SolarRadiationPort[
    1]) annotation (Line(points={{-2,17.2},{6,17.2},{6,18},{50,18},{50,96},{
          68.4,96},{68.4,94.32}}, color={255,128,0}));
  connect(convRealtoRad[2].SolarRadiation, highOrderModel_Benchmark_Workshop.SolarRadiationPort[
    2]) annotation (Line(points={{-2,17.2},{18,17.2},{18,18},{50,18},{50,96},{
          60,96},{60,94.96},{68.4,94.96}}, color={255,128,0}));
  connect(convRealtoRad[3].SolarRadiation, highOrderModel_Benchmark_Workshop.SolarRadiationPort[
    3]) annotation (Line(points={{-2,17.2},{50,17.2},{50,96},{60,96},{60,95.6},
          {68.4,95.6}}, color={255,128,0}));
  connect(convRealtoRad[4].SolarRadiation, highOrderModel_Benchmark_Workshop.SolarRadiationPort[
    4]) annotation (Line(points={{-2,17.2},{6,17.2},{6,18},{50,18},{50,96},{68,
          96},{68,96.24},{68.4,96.24}}, color={255,128,0}));
  connect(convRealtoRad[5].SolarRadiation, highOrderModel_Benchmark_Workshop.SolarRadiationPort[
    5]);
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,18},{-76,18},{-76,20},{-68,20},{-68,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, HDifTilRoof.weaBus) annotation (Line(
      points={{-68,18},{-68,48},{-60,48},{-60,47}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, HDirTilRoof.weaBus) annotation (Line(
      points={{-68,18},{-68,88.5},{-60,88.5}},
      color={255,204,51},
      thickness=0.5));
  connect(TSoil.y, prescribedTemperature1.T)
    annotation (Line(points={{-5.3,-53},{8,-53},{8,-55},{20.6,-55}},
                                                       color={0,0,127}));

  connect(prescribedTemperature1.port, highOrderModel_Benchmark_Workshop.Therm_ground)
    annotation (Line(points={{36,-55},{48,-55},{48,-56},{50,-56},{50,66},{78,66},
          {78,70.64},{80.88,70.64}}, color={191,0,0}));
  connect(weaBus.TDryBul, prescribedTemperature.T) annotation (Line(
      points={{-68,18},{-68,100},{-17,100},{-17,99.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDiffTilWall[1].weaBus) annotation (Line(
      points={{-68,18},{-72,18},{-72,-52},{-60,-52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDiffTilWall[2].weaBus) annotation (Line(
      points={{-68,18},{-72,18},{-72,-52},{-60,-52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDiffTilWall[3].weaBus) annotation (Line(
      points={{-68,18},{-72,18},{-72,-52},{-60,-52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDirTilWall[1].weaBus) annotation (Line(
      points={{-68,18},{-72,18},{-72,-10.5},{-60,-10.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDirTilWall[2].weaBus) annotation (Line(
      points={{-68,18},{-72,18},{-72,-10},{-66,-10},{-66,-10.5},{-60,-10.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDirTilWall[3].weaBus) annotation (Line(
      points={{-68,18},{-72,18},{-72,-10},{-66,-10},{-66,-10.5},{-60,-10.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.winSpe, highOrderModel_Benchmark_Workshop.WindSpeedPort)
    annotation (Line(
      points={{-68,18},{-72,18},{-72,-32},{50,-32},{50,90.8},{68.4,90.8}},
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
  connect(HDiffTilWall[1].H, convRealtoRad[3].DiffRad) annotation (Line(points={
          {-43.2,-52},{-32,-52},{-32,25},{-22,25}}, color={0,0,127}));
           connect(HDirTilWall[2].H, convRealtoRad[1].DirRad) annotation (Line(points={{-43.2,
          -10.5},{-32,-10.5},{-32,16},{-22,16}}, color={0,0,127}));
  connect(HDiffTilWall[2].H, convRealtoRad[1].DiffRad);
   connect(HDirTilWall[3].H, convRealtoRad[4].DirRad) annotation (Line(points={{-43.2,
          -10.5},{-32,-10.5},{-32,16},{-22,16}}, color={0,0,127}));
  connect(HDiffTilWall[3].H, convRealtoRad[4].DiffRad);

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

  connect(weaBus.winSpe, highOrderModel_Benchmark_OpenplanOffice.WindSpeedPort)
    annotation (Line(
      points={{-68,18},{-72,18},{-72,-32},{50,-32},{50,-54.5},{66.4,-54.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(prescribedTemperature1.port, highOrderModel_Benchmark_OpenplanOffice.Therm_ground)
    annotation (Line(points={{36,-55},{42,-55},{42,-54},{50,-54},{50,-74},{64,
          -74},{64,-73.4},{78.88,-73.4}},
                  color={191,0,0}));
  connect(AER.y, highOrderModel_Benchmark_OpenplanOffice.AER) annotation (Line(
        points={{-1.2,-92},{50,-92},{50,-66},{66.4,-66},{66.4,-66.5}},
                                                                    color={0,0,127}));
  connect(convRealtoRad[21].SolarRadiation,
    highOrderModel_Benchmark_OpenplanOffice.SolarRadiationPort[1]);
    connect(convRealtoRad[22].SolarRadiation,
    highOrderModel_Benchmark_OpenplanOffice.SolarRadiationPort[2]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,-50.6},{66.4,-50.6}},
        color={255,128,0}));
        connect(convRealtoRad[23].SolarRadiation,
    highOrderModel_Benchmark_OpenplanOffice.SolarRadiationPort[3]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,-50},{66.4,-50}},
        color={255,128,0}));
        connect(convRealtoRad[24].SolarRadiation,
    highOrderModel_Benchmark_OpenplanOffice.SolarRadiationPort[4]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,-49.4},{66.4,-49.4}},
        color={255,128,0}));
        connect(convRealtoRad[25].SolarRadiation,
    highOrderModel_Benchmark_OpenplanOffice.SolarRadiationPort[5]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,-48.8},{66.4,-48.8}},
        color={255,128,0}));
  connect(prescribedTemperature.port, convection[1].solid) annotation (Line(
        points={{-17,84},{-8,84},{-8,60},{8,60}}, color={191,0,0}));
  connect(prescribedTemperature.port, convection[2].solid) annotation (Line(
        points={{-17,84},{-8,84},{-8,60},{8,60}}, color={191,0,0}));
  connect(prescribedTemperature.port, convection[3].solid) annotation (Line(
        points={{-17,84},{-8,84},{-8,60},{8,60}}, color={191,0,0}));
  connect(prescribedTemperature.port, convection[4].solid) annotation (Line(
        points={{-17,84},{-8,84},{-8,60},{8,60}}, color={191,0,0}));
  connect(prescribedTemperature.port, convection[5].solid) annotation (Line(
        points={{-17,84},{-8,84},{-8,60},{8,60}}, color={191,0,0}));
  connect(HeatTransferCoefficient[1].y, convection[1].Gc) annotation (Line(
        points={{18.7,89},{26,89},{26,70},{18,70}}, color={0,0,127}));
  connect(HeatTransferCoefficient[2].y, convection[2].Gc) annotation (Line(
        points={{18.7,89},{26,89},{26,70},{18,70}}, color={0,0,127}));
  connect(HeatTransferCoefficient[3].y, convection[3].Gc) annotation (Line(
        points={{18.7,89},{26,89},{26,70},{18,70}}, color={0,0,127}));
  connect(HeatTransferCoefficient[4].y, convection[4].Gc) annotation (Line(
        points={{18.7,89},{26,89},{26,70},{18,70}}, color={0,0,127}));
  connect(HeatTransferCoefficient[5].y, convection[5].Gc) annotation (Line(
        points={{18.7,89},{26,89},{26,70},{18,70}}, color={0,0,127}));
  connect(convection[1].fluid, highOrderModel_Benchmark_Workshop.Therm_outside)
    annotation (Line(points={{28,60},{50,60},{50,101.52},{69.2,101.52}}, color=
          {191,0,0}));
  connect(convection[2].fluid, highOrderModel_Benchmark_Canteen.Therm_outside)
    annotation (Line(points={{28,60},{69.2,60},{69.2,61.55}}, color={191,0,0}));
  connect(convection[3].fluid, highOrderModel_Benchmark_ConferenceRoom.Therm_outside)
    annotation (Line(points={{28,60},{50,60},{50,27.55},{67.2,27.55}}, color={
          191,0,0}));
  connect(convection[5].fluid, highOrderModel_Benchmark_OpenplanOffice.Therm_outside)
    annotation (Line(points={{28,60},{50,60},{50,-44.45},{67.2,-44.45}}, color=
          {191,0,0}));
  connect(convection[4].fluid, highOrderModel_Benchmark_MultipersonOffice.Therm_outside)
    annotation (Line(points={{28,60},{50,60},{50,-8.42},{67.2,-8.42}}, color={
          191,0,0}));
  connect(prescribedTemperature1.port,
    highOrderModel_Benchmark_MultipersonOffice.Therm_ground) annotation (Line(
        points={{36,-55},{42,-55},{42,-54},{50,-54},{50,-35.44},{78.88,-35.44}},
        color={191,0,0}));
  connect(prescribedTemperature1.port, highOrderModel_Benchmark_ConferenceRoom.Therm_ground)
    annotation (Line(points={{36,-55},{50,-55},{50,-1.4},{78.88,-1.4}}, color={
          191,0,0}));
  connect(prescribedTemperature1.port, highOrderModel_Benchmark_Canteen.Therm_ground)
    annotation (Line(points={{36,-55},{42,-55},{42,-54},{50,-54},{50,32.6},{
          80.88,32.6}}, color={191,0,0}));
  connect(AER.y, highOrderModel_Benchmark_MultipersonOffice.AER) annotation (
      Line(points={{-1.2,-92},{50,-92},{50,-29},{66.4,-29}}, color={0,0,127}));
  connect(AER.y, highOrderModel_Benchmark_ConferenceRoom.AER) annotation (Line(
        points={{-1.2,-92},{50,-92},{50,5.5},{66.4,5.5}}, color={0,0,127}));
  connect(AER.y, highOrderModel_Benchmark_Canteen.AER) annotation (Line(points=
          {{-1.2,-92},{50,-92},{50,39.5},{68.4,39.5}}, color={0,0,127}));
  connect(weaBus.winSpe, highOrderModel_Benchmark_MultipersonOffice.WindSpeedPort)
    annotation (Line(
      points={{-68,18},{-72,18},{-72,-32},{50,-32},{50,-17.8},{66.4,-17.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.winSpe, highOrderModel_Benchmark_ConferenceRoom.WindSpeedPort)
    annotation (Line(
      points={{-68,18},{-72,18},{-72,-32},{50,-32},{50,17.5},{66.4,17.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.winSpe, highOrderModel_Benchmark_Canteen.WindSpeedPort)
    annotation (Line(
      points={{-68,18},{-72,18},{-72,-32},{50,-32},{50,52},{60,52},{60,51.5},{
          68.4,51.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(convRealtoRad[6].SolarRadiation, highOrderModel_Benchmark_Canteen.SolarRadiationPort[
    1]) annotation (Line(points={{-2,17.2},{6,17.2},{6,20},{50,20},{50,54.8},{68.4,
          54.8}}, color={255,128,0}));
        connect(convRealtoRad[7].SolarRadiation,
    highOrderModel_Benchmark_Canteen.SolarRadiationPort[2]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,55.4},{68.4,55.4}},
        color={255,128,0}));
        connect(convRealtoRad[8].SolarRadiation,
    highOrderModel_Benchmark_Canteen.SolarRadiationPort[3]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,56},{68.4,56}},
        color={255,128,0}));
        connect(convRealtoRad[9].SolarRadiation,
    highOrderModel_Benchmark_Canteen.SolarRadiationPort[4]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,56.6},{68.4,56.6}},
        color={255,128,0}));
        connect(convRealtoRad[10].SolarRadiation,
    highOrderModel_Benchmark_Canteen.SolarRadiationPort[5]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,57.2},{68.4,57.2}},
        color={255,128,0}));
        connect(convRealtoRad[11].SolarRadiation, highOrderModel_Benchmark_ConferenceRoom.SolarRadiationPort[
    1]) annotation (Line(points={{-2,17.2},{6,17.2},{6,20},{50,20},{50,20.8},{66.4,
          20.8}}, color={255,128,0}));

        connect(convRealtoRad[12].SolarRadiation,
    highOrderModel_Benchmark_ConferenceRoom.SolarRadiationPort[2]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,21.4},{66.4,21.4}},
        color={255,128,0}));
        connect(convRealtoRad[13].SolarRadiation,
    highOrderModel_Benchmark_ConferenceRoom.SolarRadiationPort[3]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,22},{66.4,22}},
        color={255,128,0}));
        connect(convRealtoRad[14].SolarRadiation,
    highOrderModel_Benchmark_ConferenceRoom.SolarRadiationPort[4]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,22.6},{66.4,22.6}},
        color={255,128,0}));
        connect(convRealtoRad[15].SolarRadiation,
    highOrderModel_Benchmark_ConferenceRoom.SolarRadiationPort[5]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,23.2},{66.4,23.2}},
        color={255,128,0}));
        connect(convRealtoRad[16].SolarRadiation, highOrderModel_Benchmark_MultipersonOffice.SolarRadiationPort[
    1]) annotation (Line(points={{-2,17.2},{6,17.2},{6,20},{50,20},{50,-14.72},{
          66.4,-14.72}},
                  color={255,128,0}));

        connect(convRealtoRad[17].SolarRadiation,
    highOrderModel_Benchmark_MultipersonOffice.SolarRadiationPort[2]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,-14.16},{66.4,-14.16}},
        color={255,128,0}));
        connect(convRealtoRad[18].SolarRadiation,
    highOrderModel_Benchmark_MultipersonOffice.SolarRadiationPort[3]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,-13.6},{66.4,-13.6}},
        color={255,128,0}));
        connect(convRealtoRad[19].SolarRadiation,
    highOrderModel_Benchmark_MultipersonOffice.SolarRadiationPort[4]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,-13.04},{66.4,-13.04}},
        color={255,128,0}));
        connect(convRealtoRad[20].SolarRadiation,
    highOrderModel_Benchmark_MultipersonOffice.SolarRadiationPort[5]) annotation (
      Line(points={{-2,17.2},{0,17.2},{0,16},{50,16},{50,-12.48},{66.4,-12.48}},
        color={255,128,0}));

        connect(convRealtoRad[6].Dummy,const2.y);
        connect(convRealtoRad[6].DirRad, HDirTilWall[2].H);
         connect(convRealtoRad[6].DiffRad, HDiffTilWall[2].H);
         connect(convRealtoRad[7].Dummy, const2.y);
        connect(convRealtoRad[7].DirRad, const2.y);
         connect(convRealtoRad[7].DiffRad, const2.y);
         connect(convRealtoRad[8].Dummy, const2.y);
        connect(convRealtoRad[8].DirRad, HDirTilWall[1].H);
         connect(convRealtoRad[8].DiffRad, HDiffTilWall[1].H);
         connect(convRealtoRad[9].Dummy,const2.y);
        connect(convRealtoRad[9].DirRad,const2.y);
         connect(convRealtoRad[9].DiffRad,const2.y);
         connect(convRealtoRad[10].Dummy,const2.y);
        connect(convRealtoRad[10].DirRad,HDirTilRoof.H);
         connect(convRealtoRad[10].DiffRad,HDifTilRoof.H);

           connect(convRealtoRad[11].Dummy,const2.y);
        connect(convRealtoRad[11].DirRad,HDirTilWall[2].H);
         connect(convRealtoRad[11].DiffRad,HDiffTilWall[2].H);
         connect(convRealtoRad[12].Dummy,const2.y);
        connect(convRealtoRad[12].DirRad,const2.y);
         connect(convRealtoRad[12].DiffRad,const2.y);
         connect(convRealtoRad[13].Dummy,const2.y);
        connect(convRealtoRad[13].DirRad,const2.y);
         connect(convRealtoRad[13].DiffRad,const2.y);
         connect(convRealtoRad[14].Dummy,const2.y);
        connect(convRealtoRad[14].DirRad,const2.y);
         connect(convRealtoRad[14].DiffRad,const2.y);
         connect(convRealtoRad[15].Dummy,const2.y);
        connect(convRealtoRad[15].DirRad,HDirTilRoof.H);
         connect(convRealtoRad[15].DiffRad,HDifTilRoof.H);

         connect(convRealtoRad[16].Dummy,const2.y);
        connect(convRealtoRad[16].DirRad,const2.y);
         connect(convRealtoRad[16].DiffRad,const2.y);
         connect(convRealtoRad[17].Dummy,const2.y);
        connect(convRealtoRad[17].DirRad,const2.y);
         connect(convRealtoRad[17].DiffRad,const2.y);
         connect(convRealtoRad[18].Dummy,const2.y);
        connect(convRealtoRad[18].DirRad,HDirTilWall[1].H);
         connect(convRealtoRad[18].DiffRad,HDiffTilWall[1].H);
         connect(convRealtoRad[19].Dummy,const2.y);
        connect(convRealtoRad[19].DirRad,const2.y);
         connect(convRealtoRad[19].DiffRad,const2.y);
         connect(convRealtoRad[20].Dummy,const2.y);
        connect(convRealtoRad[20].DirRad,HDirTilRoof.H);
         connect(convRealtoRad[20].DiffRad,HDifTilRoof.H);

         connect(convRealtoRad[21].Dummy,const2.y);
        connect(convRealtoRad[21].DirRad,HDirTilWall[2].H);
         connect(convRealtoRad[21].DiffRad,HDiffTilWall[2].H);
         connect(convRealtoRad[22].Dummy,const2.y);
        connect(convRealtoRad[22].DirRad,HDirTilWall[3].H);
         connect(convRealtoRad[22].DiffRad,HDiffTilWall[3].H);
         connect(convRealtoRad[23].Dummy,const2.y);
        connect(convRealtoRad[23].DirRad,HDirTilWall[1].H);
         connect(convRealtoRad[23].DiffRad,HDiffTilWall[1].H);
         connect(convRealtoRad[24].Dummy,const2.y);
        connect(convRealtoRad[24].DirRad,const2.y);
         connect(convRealtoRad[24].DiffRad,const2.y);
         connect(convRealtoRad[25].Dummy,const2.y);
        connect(convRealtoRad[25].DirRad,HDirTilRoof.H);
         connect(convRealtoRad[25].DiffRad,HDifTilRoof.H);
  annotation (                     experiment(StopTime=4838400, Interval=1800),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                                   experiment(StopTime=4838400, Interval=1800),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                                   experiment(StopTime=4838400, Interval=1800),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighOrderModel_MultipleRooms;
