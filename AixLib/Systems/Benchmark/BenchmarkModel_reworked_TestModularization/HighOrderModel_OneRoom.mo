within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrderModel_OneRoom "Single instance of high order room with input paramaters"
   extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-60})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={78,-62})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,
        200; 50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200;
        61200,0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,
        0,0,0; 86400,0,0,0],
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Table with profiles for persons (radiative and convective) and machines
    (convective)"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={78,-92})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={96,-62})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemFloor
    "Prescribed temperature for floor plate outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
    rotation=90,origin={27,-28})));
  Modelica.Blocks.Sources.Constant TSoil(k=283.15)
    "Outdoor surface temperature for floor plate"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
    rotation=90, origin={26,-56})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={78,-32})));
  Modelica.Blocks.Sources.Constant const2(k=0.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-70})));
  ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows southFacingWindows(
    Room_Length=30,
    Room_Height=3,
    Room_Width=30,
    Win_Area=180,
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=10000,
    TOutAirLimit=1273.15,
    solar_absorptance_OW=0.48,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009())
    annotation (Placement(transformation(extent={{2,-4},{22,16}})));
  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather
                             weather(
    Wind_dir=true,
    Wind_speed=true,
    Air_temp=true,
    Rel_hum=false,
    Mass_frac=true,
    Air_press=false,
    Latitude=48.0304,
    Longitude=9.3138,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor(),
    fileName=Modelica.Utilities.Files.loadResource(
        "D:\AixLib\AixLib\Systems\Benchmark\Model\SimYear_Variante3_angepasst.mat"),
    tableName="SimYearVar")
    annotation (Placement(transformation(extent={{-174,14},{-144,34}})));

  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-70,102},{-62,110}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-70,62},{-62,70}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-70,22},{-62,30}})));
  Modelica.Blocks.Math.Product product3
    annotation (Placement(transformation(extent={{-70,-18},{-62,-10}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[0,1; 0.25,1; 0.26,0;
        0.74,0; 0.75,1; 1,1], smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-92,88},{-82,98}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D1(table=[0,1; 0.25,1; 0.5,1;
        0.51,0; 0.99,0; 1,1])
    annotation (Placement(transformation(extent={{-92,48},{-82,58}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D2(table=[0,0; 0.24,0; 0.25,1;
        0.75,1; 0.76,0; 1,0])
    annotation (Placement(transformation(extent={{-92,8},{-82,18}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D3(table=[0,1; 0.01,0; 0.49,0;
        0.5,1; 1,1])
    annotation (Placement(transformation(extent={{-92,-32},{-82,-22}})));
  Modelica.Blocks.Math.Gain gain1(k=0)
    annotation (Placement(transformation(extent={{-86,-60},{-74,-48}})));
  Modelica.Blocks.Math.Gain gain(k=1/360)
    annotation (Placement(transformation(extent={{-128,62},{-118,72}})));
  Model.BusSystems.InternalBus
                         internalBus annotation (Placement(transformation(
          extent={{-108,-106},{-68,-66}}),
                                        iconTransformation(extent={{-88,-86},{
            -68,-66}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_East
    annotation (Placement(transformation(extent={{-38,46},{-18,66}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_South
    annotation (Placement(transformation(extent={{-38,6},{-18,26}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_West
    annotation (Placement(transformation(extent={{-38,-34},{-18,-14}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_Hor
    annotation (Placement(transformation(extent={{-38,-74},{-18,-54}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_North5
    annotation (Placement(transformation(extent={{-38,86},{-18,106}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemRoof
    "Prescribed temperature for roof outdoor surface temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},rotation=-90,
    origin={9,50})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConRoof
    "Outdoor convective heat transfer of roof"
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},rotation=-90,
    origin={7,31})));
  Modelica.Blocks.Sources.Constant Gc(k=25*11.5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={44,30})));
equation
  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{78,-83.2},{60,-83.2},{60,-70}},
    color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{78,-83.2},{78,-72}},          color={0,0,127}));
  connect(intGai.y[3],macConv. Q_flow)
    annotation (Line(points={{78,-83.2},{96,-83.2},{96,-72}},
    color={0,0,127}));
  connect(TSoil.y,preTemFloor. T)
  annotation (Line(points={{26,-51.6},{27,-51.6},{27,-35.2}},
                                                            color={0,0,127}));
  connect(perRad.port,thermalCollector. port_a[1]) annotation (Line(points={{60,-50},
          {60,-42},{78,-42}},               color={191,0,0}));
  connect(perCon.port,thermalCollector. port_a[1])
    annotation (Line(points={{78,-52},{78,-42}}, color={191,0,0}));
  connect(macConv.port,thermalCollector. port_a[2]) annotation (Line(points={{96,-52},
          {96,-42},{78,-42}},               color={191,0,0}));
  connect(const2.y, southFacingWindows.AER)
    annotation (Line(points={{0,-59},{0,1},{1,1}}, color={0,0,127}));
  connect(product.u1,product1. u1) annotation (Line(points={{-70.8,108.4},{-98,
          108.4},{-98,68.4},{-70.8,68.4}},
                                        color={0,0,127}));
  connect(product2.u1,product1. u1) annotation (Line(points={{-70.8,28.4},{-98,
          28.4},{-98,68.4},{-70.8,68.4}},color={0,0,127}));
  connect(product3.u1,product1. u1) annotation (Line(points={{-70.8,-11.6},{-98,
          -11.6},{-98,68.4},{-70.8,68.4}},
                                         color={0,0,127}));
  connect(gain.y,combiTable1D. u[1]) annotation (Line(points={{-117.5,67},{
          -105.75,67},{-105.75,93},{-93,93}},
                                   color={0,0,127}));
  connect(combiTable1D.y[1],product. u2) annotation (Line(points={{-81.5,93},{
          -75.75,93},{-75.75,103.6},{-70.8,103.6}},
                                               color={0,0,127}));
  connect(combiTable1D1.u[1],gain. y) annotation (Line(points={{-93,53},{-106,
          53},{-106,67},{-117.5,67}},
                             color={0,0,127}));
  connect(combiTable1D2.u[1],gain. y) annotation (Line(points={{-93,13},{-106,
          13},{-106,67},{-117.5,67}},
                              color={0,0,127}));
  connect(combiTable1D1.y[1],product1. u2) annotation (Line(points={{-81.5,53},
          {-76,53},{-76,63.6},{-70.8,63.6}},
                                        color={0,0,127}));
  connect(combiTable1D2.y[1],product2. u2) annotation (Line(points={{-81.5,13},
          {-76,13},{-76,23.6},{-70.8,23.6}}, color={0,0,127}));
  connect(combiTable1D3.y[1],product3. u2) annotation (Line(points={{-81.5,-27},
          {-76,-27},{-76,-16.4},{-70.8,-16.4}},
                                             color={0,0,127}));
  connect(gain1.u,product1. u1) annotation (Line(points={{-87.2,-54},{-98,-54},
          {-98,68.4},{-70.8,68.4}},
                                 color={0,0,127}));
  connect(product.y,internalBus. InternalLoads_Wind_Speed_North) annotation (
      Line(points={{-61.6,106},{-52,106},{-52,-85.9},{-87.9,-85.9}},
                                                            color={0,0,127}));
  connect(product1.y,internalBus. InternalLoads_Wind_Speed_East) annotation (
      Line(points={{-61.6,66},{-52,66},{-52,-85.9},{-87.9,-85.9}},
                                                            color={0,0,127}));
  connect(product2.y,internalBus. InternalLoads_Wind_Speed_South) annotation (
      Line(points={{-61.6,26},{-52,26},{-52,-86},{-70,-86},{-70,-85.9},{-87.9,
          -85.9}},                                        color={0,0,127}));
  connect(product3.y,internalBus. InternalLoads_Wind_Speed_West) annotation (
      Line(points={{-61.6,-14},{-52,-14},{-52,-85.9},{-87.9,-85.9}},
                                                              color={0,0,127}));
  connect(gain1.y,internalBus. InternalLoads_Wind_Speed_Hor) annotation (Line(
        points={{-73.4,-54},{-52,-54},{-52,-85.9},{-87.9,-85.9}},
                                                           color={0,0,127}));
  connect(weather.WindSpeed,product1. u1) annotation (Line(points={{-143,30},{
          -98,30},{-98,68.4},{-70.8,68.4}},
                                      color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[2],SolarRadiation_East)
    annotation (Line(points={{-166.8,13},{-166.8,12},{-118,12},{-118,26},{-48,
          26},{-48,56},{-28,56}},
                     color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[1],SolarRadiation_North5)
    annotation (Line(points={{-166.8,13},{-166.8,12},{-118,12},{-118,26},{-48,
          26},{-48,96},{-28,96}},
                     color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[3],SolarRadiation_South)
    annotation (Line(points={{-166.8,13},{-166.8,12},{-118,12},{-118,26},{-48,
          26},{-48,16},{-28,16}},
                           color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[4],SolarRadiation_West)
    annotation (Line(points={{-166.8,13},{-166.8,12},{-118,12},{-118,26},{-48,
          26},{-48,-24},{-28,-24}},
                           color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[5],SolarRadiation_Hor)
    annotation (Line(points={{-166.8,13},{-166.8,12},{-118,12},{-118,26},{-48,
          26},{-48,-64},{-28,-64}},
                           color={255,128,0}));
  connect(weather.WindDirection,gain. u)
    annotation (Line(points={{-143,33},{-138,33},{-138,67},{-129,67}},
                                                             color={0,0,127}));
  connect(gain.y,combiTable1D. u[1]) annotation (Line(points={{-117.5,67},{
          -105.75,67},{-105.75,93},{-93,93}},
                                   color={0,0,127}));
  connect(combiTable1D1.u[1],gain. y) annotation (Line(points={{-93,53},{-106,
          53},{-106,67},{-117.5,67}},
                             color={0,0,127}));
  connect(combiTable1D2.u[1],gain. y) annotation (Line(points={{-93,13},{-106,
          13},{-106,67},{-117.5,67}},
                              color={0,0,127}));
  connect(combiTable1D3.u[1],gain. y) annotation (Line(points={{-93,-27},{-106,
          -27},{-106,67},{-117.5,67}},
                              color={0,0,127}));
  connect(preTemFloor.port, southFacingWindows.Therm_ground) annotation (Line(
        points={{27,-22},{10,-22},{10,-3.6},{8.8,-3.6}}, color={191,0,0}));
  connect(thermalCollector.port_b, southFacingWindows.thermRoom)
    annotation (Line(points={{78,-22},{78,8.3},{9.1,8.3}}, color={191,0,0}));
  connect(weather.WindSpeed, southFacingWindows.WindSpeedPort) annotation (Line(
        points={{-143,30},{-132,30},{-132,8},{-120,8},{-120,9},{1,9}}, color={0,
          0,127}));
  connect(SolarRadiation_North5, southFacingWindows.SolarRadiationPort[1])
    annotation (Line(points={{-28,96},{-14,96},{-14,11.2},{1,11.2}}, color={255,
          128,0}));
  connect(SolarRadiation_East, southFacingWindows.SolarRadiationPort[2])
    annotation (Line(points={{-28,56},{-14,56},{-14,11.6},{1,11.6}}, color={255,
          128,0}));
  connect(SolarRadiation_South, southFacingWindows.SolarRadiationPort[3])
    annotation (Line(points={{-28,16},{-14,16},{-14,12},{1,12}}, color={255,128,
          0}));
  connect(SolarRadiation_West, southFacingWindows.SolarRadiationPort[4])
    annotation (Line(points={{-28,-24},{-14,-24},{-14,12.4},{1,12.4}}, color={
          255,128,0}));
  connect(SolarRadiation_Hor, southFacingWindows.SolarRadiationPort[5])
    annotation (Line(points={{-28,-64},{-14,-64},{-14,12.8},{1,12.8}}, color={
          255,128,0}));
  connect(theConRoof.solid, southFacingWindows.Therm_outside) annotation (Line(
        points={{7,26},{4,26},{4,15.7},{1.5,15.7}}, color={191,0,0}));
  connect(theConRoof.fluid, preTemRoof.port)
    annotation (Line(points={{7,36},{8,36},{8,44},{9,44}}, color={191,0,0}));
  connect(weather.AirTemp, preTemRoof.T) annotation (Line(points={{-143,27},{
          -67.5,27},{-67.5,57.2},{9,57.2}}, color={0,0,127}));
  connect(Gc.y, theConRoof.Gc) annotation (Line(points={{33,30},{24,30},{24,31},
          {12,31}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=15552000, Interval=300));
end HighOrderModel_OneRoom;
