within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrderModel_OneRoom "Single instance of high order room with input paramaters"
   extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={-23,-30})));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
    rotation=0,  origin={-76,-80})));
  Modelica.Blocks.Sources.Constant const2(k=0.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-74,-48})));
  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather
                             weather(
    DiffWeatherDataTime=1,
    tableName="Benchmark",
    Wind_dir=true,
    Wind_speed=true,
    Air_temp=true,
    Rel_hum=false,
    Mass_frac=true,
    Air_press=false,
    Latitude=48.0304,
    Longitude=9.3138,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor(),
    fileName=
        "D:/sciebo_fb/Simulation/SimInput/WeatherData/Benchmark_old/Weathdata_benchmark_old_2.mat")
    annotation (Placement(transformation(extent={{-98,80},{-68,100}})));

  Utilities.Interfaces.SolarRad_out SolarRadiation_East
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_South
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_West
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_Hor
    annotation (Placement(transformation(extent={{-80,-18},{-60,2}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_North5
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=-90,
    origin={-31,56})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={-33,37})));
  Modelica.Blocks.Sources.Constant Gc(k=30*1170) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,36})));
  Benchmark_DataBase.HO_Room hO_Room(
    Room_Lenght=30,
    Room_Height=3,
    Room_Width=30,
    Win_Area=60,
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=5000,
    TOutAirLimit=373.15,
    T0=293.15,
    T0_IW=293.15,
    T0_OW=293.15,
    T0_CE=293.15,
    T0_FL=293.15,
    T0_Air=293.15,
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009())
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-24})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={28,-26})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    tableOnFile=false,
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,
        200; 50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200;
        61200,0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,
        0,0,0; 86400,0,0,0],
    tableName="final",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Building/Benchmark/InternalLoads/InternalLoads_v2.mat"),

    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Table with profiles for persons (radiative and convective) and machines
    (convective)"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={28,-70})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={46,-26})));
equation
  connect(TSoil.y,preTemFloor. T)
  annotation (Line(points={{-71.6,-80},{-23,-80},{-23,-37.2}},
                                                            color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[2],SolarRadiation_East)
    annotation (Line(points={{-90.8,79},{-90.8,18},{-90,18},{-90,50},{-70,50}},
                     color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[1],SolarRadiation_North5)
    annotation (Line(points={{-90.8,79},{-90.8,16},{-90,16},{-90,70},{-70,70}},
                     color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[3],SolarRadiation_South)
    annotation (Line(points={{-90.8,79},{-90.8,18},{-90,18},{-90,30},{-70,30}},
                           color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[4],SolarRadiation_West)
    annotation (Line(points={{-90.8,79},{-90.8,18},{-90,18},{-90,10},{-70,10}},
                           color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[5],SolarRadiation_Hor)
    annotation (Line(points={{-90.8,79},{-90.8,18},{-90,18},{-90,-8},{-70,-8}},
                           color={255,128,0}));
  connect(theConRoof.fluid, preTemRoof.port)
    annotation (Line(points={{-33,42},{-30,42},{-30,50},{-31,50}},
                                                           color={191,0,0}));
  connect(weather.AirTemp, preTemRoof.T) annotation (Line(points={{-67,93},{
          -31.5,93},{-31.5,63.2},{-31,63.2}},
                                            color={0,0,127}));
  connect(Gc.y, theConRoof.Gc) annotation (Line(points={{-11,36},{-12,36},{-12,
          37},{-28,37}},
                    color={0,0,127}));
  connect(preTemFloor.port, hO_Room.Therm_ground) annotation (Line(points={{-23,
          -24},{-24,-24},{-24,-9.6},{-31.2,-9.6}}, color={191,0,0}));
  connect(theConRoof.solid, hO_Room.Therm_outside) annotation (Line(points={{-33,
          32},{-34,32},{-34,9.7},{-38.5,9.7}}, color={191,0,0}));
  connect(const2.y, hO_Room.AER) annotation (Line(points={{-63,-48},{-62,-48},{-62,
          -46},{-39,-46},{-39,-5}}, color={0,0,127}));
  connect(weather.WindSpeed, hO_Room.WindSpeedPort)
    annotation (Line(points={{-67,96},{-39,96},{-39,3}}, color={0,0,127}));
  connect(SolarRadiation_North5, hO_Room.SolarRadiationPort[1]) annotation (
      Line(points={{-70,70},{-58,70},{-58,68},{-48,68},{-48,5.2},{-39,5.2}},
        color={255,128,0}));
  connect(SolarRadiation_East, SolarRadiation_East)
    annotation (Line(points={{-70,50},{-70,50}}, color={255,128,0}));
  connect(SolarRadiation_East, hO_Room.SolarRadiationPort[2]) annotation (Line(
        points={{-70,50},{-54,50},{-54,5.6},{-39,5.6}}, color={255,128,0}));
  connect(SolarRadiation_South, hO_Room.SolarRadiationPort[3]) annotation (Line(
        points={{-70,30},{-56,30},{-56,6},{-39,6}}, color={255,128,0}));
  connect(SolarRadiation_West, SolarRadiation_West)
    annotation (Line(points={{-70,10},{-70,10}}, color={255,128,0}));
  connect(SolarRadiation_West, hO_Room.SolarRadiationPort[4]) annotation (Line(
        points={{-70,10},{-60,10},{-60,4},{-39,4},{-39,6.4}}, color={255,128,0}));
  connect(SolarRadiation_Hor, hO_Room.SolarRadiationPort[5]) annotation (Line(
        points={{-70,-8},{-62,-8},{-62,-4},{-39,-4},{-39,6.8}}, color={255,128,0}));
  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{28,-61.2},{10,-61.2},{10,-34}},
    color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{28,-61.2},{28,-36}},          color={0,0,127}));
  connect(intGai.y[3],macConv. Q_flow)
    annotation (Line(points={{28,-61.2},{46,-61.2},{46,-36}},
    color={0,0,127}));
  connect(perRad.port, hO_Room.thermRoom)
    annotation (Line(points={{10,-14},{10,2.3},{-30.9,2.3}}, color={191,0,0}));
  connect(perCon.port, hO_Room.thermRoom)
    annotation (Line(points={{28,-16},{28,2.3},{-30.9,2.3}}, color={191,0,0}));
  connect(macConv.port, hO_Room.starRoom)
    annotation (Line(points={{46,-16},{46,2.6},{-27.1,2.6}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=4838400, Interval=3600));
end HighOrderModel_OneRoom;
