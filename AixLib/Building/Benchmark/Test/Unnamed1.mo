within AixLib.Building.Benchmark.Test;
model Unnamed1
    replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
      replaceable package Medium_Air = AixLib.Media.Air
    "Medium in the component";
  Components.Walls.Wall EastWall(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=10,
    windowarea=15,
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=180,
        origin={4,-42})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-88,-70},{-68,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-54,-40},{-34,-20}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation=0,    origin={46,-42})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{26,-88},{46,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-38,-88},{-18,-68}})));
  Components.Weather.Weather weather(
    Wind_dir=true,
    Wind_speed=true,
    Air_temp=true,
    Rel_hum=false,
    fileName=
        "D:/aku-bga/AixLib/AixLib/Resources/weatherdata/TRY2010_12_Jahr_Modelica-Library.txt",
    Mass_frac=true,
    Air_press=false,
    Latitude=48.0304,
    Longitude=9.3138,
    SOD=DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor_PV())
    annotation (Placement(transformation(extent={{-94,16},{-64,36}})));
  Components.Walls.Wall EastWall1(
    wall_height=3,
    solar_absorptance=0.48,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=false,
    withDoor=false,
    wall_length=10,
    windowarea=15,
    T0=293.15) annotation (Placement(transformation(
        extent={{3.99999,-24},{-4.00002,24}},
        rotation=180,
        origin={34,56})));
  Modelica.Blocks.Sources.RealExpression realExpression3
    annotation (Placement(transformation(extent={{-58,28},{-38,48}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15)
    annotation (Placement(transformation(extent={{-60,58},{-40,78}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
    annotation (Placement(transformation(extent={{-24,58},{-4,78}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux1
                                                               annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation=0,    origin={76,56})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature3
    annotation (Placement(transformation(extent={{56,10},{76,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=273.15 + 20)
    annotation (Placement(transformation(extent={{14,-16},{34,4}})));
equation
  connect(realExpression.y, EastWall.WindSpeedPort) annotation (Line(points={{-67,-60},
          {-32,-60},{-32,-59.6},{-0.19999,-59.6}},          color={0,0,127}));
  connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{-69,-30},{-56,-30}},
                                                 color={0,0,127}));
  connect(prescribedTemperature.port, EastWall.port_outside) annotation (Line(
        points={{-34,-30},{-18,-30},{-18,-42},{-0.19999,-42}},
                                                         color={191,0,0}));
  connect(EastWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{8.00002,-42},{18,-42},{18,-41.9},{36.6,-41.9}},
                                                                      color={
          191,0,0}));
  connect(prescribedTemperature1.port, thermStar_Demux.therm) annotation (Line(
        points={{46,-78},{72,-78},{72,-36.9},{56.1,-36.9}},
                                                        color={191,0,0}));
  connect(realExpression2.y, prescribedTemperature1.T)
    annotation (Line(points={{-17,-78},{24,-78}}, color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], EastWall.SolarRadiationPort)
    annotation (Line(points={{-86.8,15},{-86.8,4},{-16,4},{-16,-64},{-1.19999,
          -64}}, color={255,128,0}));
  connect(realExpression3.y, EastWall1.WindSpeedPort) annotation (Line(points={
          {-37,38},{-12,38},{-12,38.4},{29.8,38.4}}, color={0,0,127}));
  connect(realExpression4.y, prescribedTemperature2.T)
    annotation (Line(points={{-39,68},{-26,68}}, color={0,0,127}));
  connect(prescribedTemperature2.port, EastWall1.port_outside) annotation (Line(
        points={{-4,68},{2,68},{2,56},{29.8,56}}, color={191,0,0}));
  connect(EastWall1.thermStarComb_inside, thermStar_Demux1.thermStarComb)
    annotation (Line(points={{38,56},{38,56.1},{66.6,56.1}}, color={191,0,0}));
  connect(prescribedTemperature3.port, thermStar_Demux1.therm) annotation (Line(
        points={{76,20},{92,20},{92,61.1},{86.1,61.1}}, color={191,0,0}));
  connect(realExpression5.y,prescribedTemperature3. T)
    annotation (Line(points={{35,-6},{38,-6},{38,6},{50,6},{50,20},{54,20}},
                                                  color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], EastWall1.SolarRadiationPort)
    annotation (Line(points={{-86.8,15},{-86.8,4},{-86,4},{-86,4},{2,4},{2,34},
          {28.8,34}}, color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Unnamed1;
