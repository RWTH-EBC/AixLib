within AixLib.Electrical.PVSystem.Examples;
model ExamplePV
  extends Modelica.Icons.Example;

  Modelica.Blocks.Interfaces.RealOutput Power(
    final quantity="Power",
    final unit="W")
    "Output Power of the PV system including the inverter"
    annotation (Placement(transformation(extent={{72,30},{92,50}})));
  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.Weather Weather(
    Latitude=49.5,
    Longitude=8.5,
    GroundReflection=0.2,
    tableName="wetter",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    Wind_dir=false,
    Air_temp=true,
    Wind_speed=false,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(),

    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt"))
    "Weather data input for simulation of PV power "
    annotation (Placement(transformation(extent={{-93,49},{-68,66}})));
  Electrical.PVSystem.PVSystem PVsystem(
    MaxOutputPower=4000,
    NumberOfPanels=5,
    data=AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181())
    "PV system model including the inverter"
    annotation (Placement(transformation(extent={{-14,30},{6,50}})));

equation
  connect(Weather.SolarRadiation_OrientedSurfaces[6], PVsystem.IcTotalRad)
    annotation (Line(
      points={{-87,48.15},{-87,39.5},{-15.8,39.5}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(Weather.AirTemp, PVsystem.TOutside) annotation (Line(
      points={{-67.1667,60.05},{-56,60.05},{-56,47.6},{-16,47.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PVsystem.PVPowerW, Power)
    annotation (Line(points={{7,40},{82,40}},         color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}})),
    experiment(
      StopTime=3.1536e+007,
      Interval=3600,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simulation to test the <a href=\"AixLib.Fluid.Solar.Electric.PVSystem\">PVsystem</a> model.</p>
</html>",
      revisions="<html>
<ul>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>April 16, 2014 &nbsp;</i> by Ana Constantin:<br/>Formated documentation.</li>
</ul>
</html>"));
end ExamplePV;
