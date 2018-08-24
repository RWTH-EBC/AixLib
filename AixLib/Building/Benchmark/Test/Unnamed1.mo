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
        origin={2,2})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-90,-26},{-70,-6}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15)
    annotation (Placement(transformation(extent={{-92,4},{-72,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-56,4},{-36,24}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation=0,    origin={44,2})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{24,-44},{44,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-40,-44},{-20,-24}})));
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
    annotation (Placement(transformation(extent={{-54,60},{-24,80}})));
equation
  connect(realExpression.y, EastWall.WindSpeedPort) annotation (Line(points={{
          -69,-16},{-34,-16},{-34,-15.6},{-2.19999,-15.6}}, color={0,0,127}));
  connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{-71,14},{-58,14}}, color={0,0,127}));
  connect(prescribedTemperature.port, EastWall.port_outside) annotation (Line(
        points={{-36,14},{-20,14},{-20,2},{-2.19999,2}}, color={191,0,0}));
  connect(EastWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
    annotation (Line(points={{6.00002,2},{16,2},{16,2.1},{34.6,2.1}}, color={
          191,0,0}));
  connect(prescribedTemperature1.port, thermStar_Demux.therm) annotation (Line(
        points={{44,-34},{70,-34},{70,7.1},{54.1,7.1}}, color={191,0,0}));
  connect(realExpression2.y, prescribedTemperature1.T)
    annotation (Line(points={{-19,-34},{22,-34}}, color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], EastWall.SolarRadiationPort)
    annotation (Line(points={{-46.8,59},{-46.8,48},{-18,48},{-18,-20},{-3.19999,
          -20}}, color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Unnamed1;
