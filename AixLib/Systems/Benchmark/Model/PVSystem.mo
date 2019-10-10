within AixLib.Systems.Benchmark.Model;
model PVSystem
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
    SOD=DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor(),
    fileName=Modelica.Utilities.Files.loadResource(
        "D:\AixLib\AixLib\Systems\Benchmark\Model\SimYear_Variante3_angepasst.mat"),
    tableName="SimYearVar")
    annotation (Placement(transformation(extent={{-90,44},{-60,64}})));

  Electrical.PVSystem.PVSystem pVSystem(
    NumberOfPanels=50*9,
    data=DataBase.SolarElectric.SymphonyEnergySE6M181(),
    MaxOutputPower=50*9*250)
    annotation (Placement(transformation(extent={{-26,66},{-6,86}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{76,70},{88,82}})));
  BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
           {{-52,-120},{-12,-80}}), iconTransformation(extent={{-10,-110},{10,-90}})));
equation
  connect(pVSystem.PVPowerW,gain2. u)
    annotation (Line(points={{-5,76},{74.8,76}},   color={0,0,127}));
  connect(gain2.y,measureBus. PV_Power) annotation (Line(points={{88.6,76},{96,
          76},{96,-100},{-31.9,-100},{-31.9,-99.9}},
        color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[5],pVSystem. IcTotalRad)
    annotation (Line(points={{-82.8,43},{-82.8,40.5},{-27.8,40.5},{-27.8,75.5}},
        color={255,128,0}));
  connect(weather.AirTemp, pVSystem.TOutside) annotation (Line(points={{-59,57},
          {-44.5,57},{-44.5,83.6},{-28,83.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PVSystem;
