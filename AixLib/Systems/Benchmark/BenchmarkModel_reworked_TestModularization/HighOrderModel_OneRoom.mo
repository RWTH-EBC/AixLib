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
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/Weathdata_benchmark_old.mat"))
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
  Modelica.Blocks.Sources.Constant Gc(k=25*11.5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,36})));
  ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows southFacingWindows(
    Room_Lenght=30,
    Room_Height=3,
    Room_Width=30,
    Win_Area=180,
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=10000,
    TOutAirLimit=10273.15,
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009())
    annotation (Placement(transformation(extent={{-32,-4},{-12,16}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=2000,
    width=50,
    period=86400,
    startTime=28800)
    annotation (Placement(transformation(extent={{2,-84},{22,-64}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={36,-56})));
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
  connect(preTemFloor.port, southFacingWindows.Therm_ground) annotation (Line(
        points={{-23,-24},{-26,-24},{-26,-3.6},{-25.2,-3.6}},
                                                          color={191,0,0}));
  connect(const2.y, southFacingWindows.AER) annotation (Line(points={{-63,-48},
          {-52,-48},{-52,-26},{-42,-26},{-42,1},{-33,1}},
                                color={0,0,127}));
  connect(weather.WindSpeed, southFacingWindows.WindSpeedPort) annotation (Line(
        points={{-67,96},{-42,96},{-42,9},{-33,9}}, color={0,0,127}));
  connect(theConRoof.solid, southFacingWindows.Therm_outside) annotation (Line(
        points={{-33,32},{-32,32},{-32,15.7},{-32.5,15.7}},
                                                     color={191,0,0}));
  connect(SolarRadiation_North5, southFacingWindows.SolarRadiationPort[1])
    annotation (Line(points={{-70,70},{-56,70},{-56,11.2},{-33,11.2}},
                                                                  color={255,
          128,0}));
  connect(SolarRadiation_East, southFacingWindows.SolarRadiationPort[2])
    annotation (Line(points={{-70,50},{-56,50},{-56,11.6},{-33,11.6}},
                                                                  color={255,
          128,0}));
  connect(SolarRadiation_South, southFacingWindows.SolarRadiationPort[3])
    annotation (Line(points={{-70,30},{-56,30},{-56,12},{-33,12}},
                                                              color={255,128,0}));
  connect(SolarRadiation_West, southFacingWindows.SolarRadiationPort[4])
    annotation (Line(points={{-70,10},{-56,10},{-56,12},{-32,12},{-32,12.4},{
          -33,12.4}},                                               color={255,
          128,0}));
  connect(SolarRadiation_Hor, southFacingWindows.SolarRadiationPort[5])
    annotation (Line(points={{-70,-8},{-56,-8},{-56,12.8},{-33,12.8}},
                                                                    color={255,
          128,0}));
  connect(pulse.y, perRad.Q_flow) annotation (Line(points={{23,-74},{24,-74},{
          24,-56},{26,-56}}, color={0,0,127}));
  connect(perRad.port, southFacingWindows.thermRoom)
    annotation (Line(points={{46,-56},{46,8.3},{-24.9,8.3}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=4838400, Interval=3600));
end HighOrderModel_OneRoom;
