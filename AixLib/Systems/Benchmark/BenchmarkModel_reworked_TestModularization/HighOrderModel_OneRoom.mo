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
    redeclare model RadOnTiltedSurface =
        BoundaryConditions.WeatherData.Old.WeatherTRY.RadiationOnTiltedSurface.RadOnTiltedSurf_Liu,
    Cloud_cover=true,
    Wind_dir=true,
    Wind_speed=true,
    Air_temp=true,
    Rel_hum=true,
    Mass_frac=true,
    Air_press=true,
    Latitude=48.0304,
    Longitude=9.3138,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor(),
    fileName=
        "D:/sciebo_fb/Simulation/SimInput/WeatherData/Benchmark_old/Weathdata_benchmark_old_2.mat",
    Sky_rad=true,
    Ter_rad=true)
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
    origin={-25,37})));
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
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009())
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));

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
    annotation (Line(points={{-25,42},{-30,42},{-30,50},{-31,50}},
                                                           color={191,0,0}));
  connect(weather.AirTemp, preTemRoof.T) annotation (Line(points={{-67,93},{
          -31.5,93},{-31.5,63.2},{-31,63.2}},
                                            color={0,0,127}));
  connect(Gc.y, theConRoof.Gc) annotation (Line(points={{-11,36},{-12,36},{-12,
          37},{-20,37}},
                    color={0,0,127}));
  connect(preTemFloor.port, hO_Room.Therm_ground) annotation (Line(points={{-23,
          -24},{-24,-24},{-24,-9.6},{-31.2,-9.6}}, color={191,0,0}));
  connect(theConRoof.solid, hO_Room.Therm_outside) annotation (Line(points={{-25,32},
          {-34,32},{-34,9.7},{-38.5,9.7}},     color={191,0,0}));
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=4838400, Interval=3600));
end HighOrderModel_OneRoom;
