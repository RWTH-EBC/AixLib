within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrderModel_MultipleRooms  "Multiple instances of high order room with input paramaters"
  extends Modelica.Icons.Example;

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={42,-38})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-40})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    tableOnFile=false,
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
        50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
        0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
        86400,0,0,0],
    tableName="final",
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Building/Benchmark/InternalLoads/InternalLoads_v2.mat"),
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Table with profiles for persons (radiative and convective) and machines
    (convective)"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={60,-84})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={78,-40})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={-13,-30})));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
    rotation=0,  origin={-80,-66})));
  Modelica.Blocks.Sources.Constant const2(k=0.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-78,-40})));
  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather
                             weather(
    tableName="Benchmark",
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
    fileName="D:/sciebo_fb/BA/Simulation/SimInput/Weathdata_benchmark_old.mat",
    Sky_rad=true,
    Ter_rad=true)
    annotation (Placement(transformation(extent={{-98,80},{-68,100}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=-90,
    origin={-19,72})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={-19,45})));
  Modelica.Blocks.Sources.Constant Gc(k=25*11.5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={6,46})));
  ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows southFacingWindows [5](
    Room_Lenght={30,30,5,5,30},
    Room_Height={3,3,3,3,3},
    Room_Width={30,20,10,20,50},
    Win_Area={180,80,20,40,200},
    each use_sunblind=true,
    each ratioSunblind=0,
    each solIrrThreshold=100000,
    each TOutAirLimit=10273.15,
     each solar_absorptance_OW=0.48,
     each eps_out=25,
     each TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
     each TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
     each TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML())
    annotation (Placement(transformation(extent={{-20,-2},{0,18}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_East
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_South
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_West
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_Hor
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_North5
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation











  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{60,-75.2},{42,-75.2},{42,-48}},
    color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{60,-75.2},{60,-50}},          color={0,0,127}));
  connect(intGai.y[3],macConv. Q_flow)
    annotation (Line(points={{60,-75.2},{78,-75.2},{78,-50}},
    color={0,0,127}));
  connect(TSoil.y,preTemFloor. T)
  annotation (Line(points={{-75.6,-66},{-13,-66},{-13,-37.2}},
                                                            color={0,0,127}));
  connect(theConRoof.fluid,preTemRoof. port)
    annotation (Line(points={{-19,50},{-20,50},{-20,66},{-19,66}},
                                                           color={191,0,0}));
  connect(weather.AirTemp,preTemRoof. T) annotation (Line(points={{-67,93},{-18,
          93},{-18,79.2},{-19,79.2}},       color={0,0,127}));
  connect(Gc.y,theConRoof. Gc) annotation (Line(points={{-5,46},{-10,46},{-10,45},
          {-14,45}},color={0,0,127}));
  connect(preTemFloor.port, southFacingWindows[1].Therm_ground) annotation (
      Line(points={{-13,-24},{-14,-24},{-14,-1.6},{-13.2,-1.6}},
                                                             color={191,0,0}));
  connect(preTemFloor.port, southFacingWindows[2].Therm_ground) annotation (
      Line(points={{-13,-24},{-14,-24},{-14,-1.6},{-13.2,-1.6}},
        color={191,0,0}));
  connect(preTemFloor.port, southFacingWindows[3].Therm_ground) annotation (
      Line(points={{-13,-24},{-14,-24},{-14,-1.6},{-13.2,-1.6}},
                                                             color={191,0,0}));
  connect(preTemFloor.port, southFacingWindows[4].Therm_ground) annotation (
      Line(points={{-13,-24},{-14,-24},{-14,-1.6},{-13.2,-1.6}},
                                                             color={191,0,0}));
  connect(preTemFloor.port, southFacingWindows[5].Therm_ground) annotation (
      Line(points={{-13,-24},{-14,-24},{-14,-1.6},{-13.2,-1.6}},
                                                             color={191,0,0}));
  connect(theConRoof.solid, southFacingWindows[1].Therm_outside) annotation (
      Line(points={{-19,40},{-18,40},{-18,17.7},{-20.5,17.7}},
                                                        color={191,0,0}));
  connect(theConRoof.solid, southFacingWindows[2].Therm_outside) annotation (
      Line(points={{-19,40},{-18,40},{-18,17.7},{-20.5,17.7}},
                                                        color={191,0,0}));
  connect(theConRoof.solid, southFacingWindows[3].Therm_outside) annotation (
      Line(points={{-19,40},{-18,40},{-18,17.7},{-20.5,17.7}},
                                                        color={191,0,0}));
  connect(theConRoof.solid, southFacingWindows[4].Therm_outside) annotation (
      Line(points={{-19,40},{-18,40},{-18,17.7},{-20.5,17.7}},
                                                        color={191,0,0}));
  connect(theConRoof.solid, southFacingWindows[5].Therm_outside) annotation (
      Line(points={{-19,40},{-18,40},{-18,17.7},{-20.5,17.7}},
                                                        color={191,0,0}));
  connect(const2.y, southFacingWindows[1].AER) annotation (Line(points={{-67,-40},
          {-38,-40},{-38,3},{-21,3}},
                                   color={0,0,127}));
  connect(const2.y, southFacingWindows[2].AER) annotation (Line(points={{-67,-40},
          {-38,-40},{-38,3},{-21,3}},
                                   color={0,0,127}));
  connect(const2.y, southFacingWindows[3].AER) annotation (Line(points={{-67,-40},
          {-38,-40},{-38,3},{-21,3}},
                                   color={0,0,127}));
  connect(const2.y, southFacingWindows[4].AER) annotation (Line(points={{-67,-40},
          {-38,-40},{-38,3},{-21,3}},
                                   color={0,0,127}));
  connect(const2.y, southFacingWindows[5].AER) annotation (Line(points={{-67,-40},
          {-38,-40},{-38,3},{-21,3}},
                                   color={0,0,127}));
  connect(weather.WindSpeed, southFacingWindows[1].WindSpeedPort) annotation (
      Line(points={{-67,96},{-40,96},{-40,11},{-21,11}},
                                                       color={0,0,127}));
  connect(weather.WindSpeed, southFacingWindows[2].WindSpeedPort) annotation (
      Line(points={{-67,96},{-40,96},{-40,11},{-21,11}},
                                                       color={0,0,127}));
  connect(weather.WindSpeed, southFacingWindows[3].WindSpeedPort) annotation (
      Line(points={{-67,96},{-40,96},{-40,11},{-21,11}},
                                                       color={0,0,127}));
  connect(weather.WindSpeed, southFacingWindows[4].WindSpeedPort) annotation (
      Line(points={{-67,96},{-40,96},{-40,11},{-21,11}},
                                                       color={0,0,127}));
  connect(weather.WindSpeed, southFacingWindows[5].WindSpeedPort) annotation (
      Line(points={{-67,96},{-40,96},{-40,11},{-21,11}},
                                                       color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], SolarRadiation_North5)
    annotation (Line(points={{-90.8,79},{-90.4,79},{-90.4,70},{-70,70}}, color={
          255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[2], SolarRadiation_East)
    annotation (Line(points={{-90.8,79},{-90.8,64},{-90,64},{-90,50},{-70,50}},
        color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[3], SolarRadiation_South)
    annotation (Line(points={{-90.8,79},{-90.8,54},{-90,54},{-90,30},{-70,30}},
        color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[4], SolarRadiation_West)
    annotation (Line(points={{-90.8,79},{-90.8,44},{-90,44},{-90,10},{-70,10}},
        color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[5], SolarRadiation_Hor)
    annotation (Line(points={{-90.8,79},{-90.8,34},{-90,34},{-90,-10},{-70,-10}},
        color={255,128,0}));
  connect(SolarRadiation_North5, southFacingWindows[1].SolarRadiationPort[1])
    annotation (Line(points={{-70,70},{-46,70},{-46,13.2},{-21,13.2}}, color={255,
          128,0}));
  connect(SolarRadiation_North5, southFacingWindows[2].SolarRadiationPort[1])
    annotation (Line(points={{-70,70},{-46,70},{-46,13.2},{-21,13.2}}, color={255,
          128,0}));
  connect(SolarRadiation_North5, southFacingWindows[3].SolarRadiationPort[1])
    annotation (Line(points={{-70,70},{-46,70},{-46,13.2},{-21,13.2}}, color={255,
          128,0}));
  connect(SolarRadiation_North5, southFacingWindows[4].SolarRadiationPort[1])
    annotation (Line(points={{-70,70},{-46,70},{-46,13.2},{-21,13.2}}, color={255,
          128,0}));
  connect(SolarRadiation_North5, southFacingWindows[5].SolarRadiationPort[1])
    annotation (Line(points={{-70,70},{-46,70},{-46,13.2},{-21,13.2}}, color={255,
          128,0}));
  connect(SolarRadiation_Hor, southFacingWindows[1].SolarRadiationPort[5])
    annotation (Line(points={{-70,-10},{-46,-10},{-46,14.8},{-21,14.8}}, color={
          255,128,0}));
  connect(SolarRadiation_Hor, southFacingWindows[2].SolarRadiationPort[5])
    annotation (Line(points={{-70,-10},{-46,-10},{-46,14.8},{-21,14.8}}, color={
          255,128,0}));
  connect(SolarRadiation_Hor, southFacingWindows[3].SolarRadiationPort[5])
    annotation (Line(points={{-70,-10},{-46,-10},{-46,14.8},{-21,14.8}}, color={
          255,128,0}));
  connect(SolarRadiation_Hor, southFacingWindows[4].SolarRadiationPort[5])
    annotation (Line(points={{-70,-10},{-46,-10},{-46,14.8},{-21,14.8}}, color={
          255,128,0}));
  connect(SolarRadiation_Hor, southFacingWindows[5].SolarRadiationPort[5])
    annotation (Line(points={{-70,-10},{-46,-10},{-46,14.8},{-21,14.8}}, color={
          255,128,0}));
  connect(SolarRadiation_West, southFacingWindows[1].SolarRadiationPort[4])
    annotation (Line(points={{-70,10},{-46,10},{-46,14.4},{-21,14.4}}, color={255,
          128,0}));
  connect(SolarRadiation_West, southFacingWindows[2].SolarRadiationPort[4])
    annotation (Line(points={{-70,10},{-46,10},{-46,14.4},{-21,14.4}}, color={255,
          128,0}));
  connect(SolarRadiation_West, southFacingWindows[3].SolarRadiationPort[4])
    annotation (Line(points={{-70,10},{-46,10},{-46,14.4},{-21,14.4}}, color={255,
          128,0}));
  connect(SolarRadiation_West, southFacingWindows[4].SolarRadiationPort[4])
    annotation (Line(points={{-70,10},{-46,10},{-46,14.4},{-21,14.4}}, color={255,
          128,0}));
  connect(SolarRadiation_West, southFacingWindows[5].SolarRadiationPort[4])
    annotation (Line(points={{-70,10},{-46,10},{-46,14.4},{-21,14.4}}, color={255,
          128,0}));
  connect(SolarRadiation_South, southFacingWindows[1].SolarRadiationPort[3])
    annotation (Line(points={{-70,30},{-46,30},{-46,14},{-21,14}}, color={255,128,
          0}));
  connect(SolarRadiation_South, southFacingWindows[2].SolarRadiationPort[3])
    annotation (Line(points={{-70,30},{-46,30},{-46,14},{-21,14}}, color={255,128,
          0}));
  connect(SolarRadiation_South, southFacingWindows[3].SolarRadiationPort[3])
    annotation (Line(points={{-70,30},{-46,30},{-46,14},{-21,14}}, color={255,128,
          0}));
  connect(SolarRadiation_South, southFacingWindows[4].SolarRadiationPort[3])
    annotation (Line(points={{-70,30},{-46,30},{-46,14},{-21,14}}, color={255,128,
          0}));
  connect(SolarRadiation_South, southFacingWindows[5].SolarRadiationPort[3])
    annotation (Line(points={{-70,30},{-46,30},{-46,14},{-21,14}}, color={255,128,
          0}));
  connect(SolarRadiation_East, southFacingWindows[1].SolarRadiationPort[2])
    annotation (Line(points={{-70,50},{-46,50},{-46,13.6},{-21,13.6}}, color={255,
          128,0}));
  connect(SolarRadiation_East, southFacingWindows[2].SolarRadiationPort[2])
    annotation (Line(points={{-70,50},{-46,50},{-46,13.6},{-21,13.6}}, color={255,
          128,0}));
  connect(SolarRadiation_East, southFacingWindows[3].SolarRadiationPort[2])
    annotation (Line(points={{-70,50},{-46,50},{-46,13.6},{-21,13.6}}, color={255,
          128,0}));
  connect(SolarRadiation_East, southFacingWindows[4].SolarRadiationPort[2])
    annotation (Line(points={{-70,50},{-46,50},{-46,13.6},{-21,13.6}}, color={255,
          128,0}));
  connect(SolarRadiation_East, southFacingWindows[5].SolarRadiationPort[2])
    annotation (Line(points={{-70,50},{-46,50},{-46,13.6},{-21,13.6}}, color={255,
          128,0}));
  connect(perRad.port, southFacingWindows[1].thermRoom) annotation (Line(points=
         {{42,-28},{42,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(perRad.port, southFacingWindows[2].thermRoom) annotation (Line(points=
         {{42,-28},{42,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(perRad.port, southFacingWindows[3].thermRoom) annotation (Line(points=
         {{42,-28},{42,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(perRad.port, southFacingWindows[4].thermRoom) annotation (Line(points=
         {{42,-28},{42,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(perRad.port, southFacingWindows[5].thermRoom) annotation (Line(points=
         {{42,-28},{42,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(perCon.port, southFacingWindows[1].thermRoom) annotation (Line(points=
         {{60,-30},{60,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(perCon.port, southFacingWindows[2].thermRoom) annotation (Line(points=
         {{60,-30},{60,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(perCon.port, southFacingWindows[3].thermRoom) annotation (Line(points=
         {{60,-30},{60,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(perCon.port, southFacingWindows[4].thermRoom) annotation (Line(points=
         {{60,-30},{60,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(perCon.port, southFacingWindows[5].thermRoom) annotation (Line(points=
         {{60,-30},{60,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(macConv.port, southFacingWindows[1].thermRoom) annotation (Line(
        points={{78,-30},{78,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(macConv.port, southFacingWindows[2].thermRoom) annotation (Line(
        points={{78,-30},{78,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(macConv.port, southFacingWindows[3].thermRoom) annotation (Line(
        points={{78,-30},{78,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(macConv.port, southFacingWindows[4].thermRoom) annotation (Line(
        points={{78,-30},{78,10.3},{-12.9,10.3}}, color={191,0,0}));
  connect(macConv.port, southFacingWindows[5].thermRoom) annotation (Line(
        points={{78,-30},{78,10.3},{-12.9,10.3}}, color={191,0,0}));
  annotation (experiment(StopTime=4838400, Interval=3600));
end HighOrderModel_MultipleRooms;
