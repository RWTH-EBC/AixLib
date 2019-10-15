within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrderModel_OneRoom "Single instance of high order room with input paramaters"
   extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={42,-32})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-34})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    tableOnFile=true,
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,
        200; 50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200;
        61200,0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,
        0,0,0; 86400,0,0,0],
    tableName="final",
    fileName="D:/sciebo_fb/BA/InternalLoads_v2.mat",
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Table with profiles for persons (radiative and convective) and machines
    (convective)"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={58,-88})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={78,-34})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={-23,-30})));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
    rotation=0,  origin={-76,-80})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={12,8})));
  Modelica.Blocks.Sources.Constant const2(k=0.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-74,-48})));
  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather
                             weather(
    tableName="SimYearVar",
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
        "modelica://AixLib/Resources/weatherdata/SimYear_Variante3_angepasst.mat"))
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
equation
  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{58,-79.2},{42,-79.2},{42,-42}},
    color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{58,-79.2},{58,-60},{60,-60},{60,-44}},
                                                            color={0,0,127}));
  connect(intGai.y[3],macConv. Q_flow)
    annotation (Line(points={{58,-79.2},{78,-79.2},{78,-44}},
    color={0,0,127}));
  connect(TSoil.y,preTemFloor. T)
  annotation (Line(points={{-71.6,-80},{-23,-80},{-23,-37.2}},
                                                            color={0,0,127}));
  connect(perRad.port,thermalCollector. port_a[1]) annotation (Line(points={{42,-22},
          {42,8},{22,8}},                   color={191,0,0}));
  connect(perCon.port,thermalCollector. port_a[1])
    annotation (Line(points={{60,-24},{54,-24},{54,8},{22,8}},
                                                 color={191,0,0}));
  connect(macConv.port,thermalCollector. port_a[2]) annotation (Line(points={{78,-24},
          {78,8},{22,8}},                   color={191,0,0}));
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
  connect(thermalCollector.port_b, southFacingWindows.thermRoom) annotation (
      Line(points={{2,8},{54,8},{54,8.3},{-24.9,8.3}},     color={191,0,0}));
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=15552000, Interval=300));
end HighOrderModel_OneRoom;
