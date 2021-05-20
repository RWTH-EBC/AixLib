within AixLib.Electrical.PVSystem.Examples;
model ExamplePVSystem
  "Example of a model for determining the DC output Power of a PV array; 
  Modules mounted close to the ground"
  import ModelicaServices;

 extends Modelica.Icons.Example;

  PVSystem pVSystem(
    redeclare DataBase.SolarElectric.QPlusBFRG41285 data,
    n_mod=20,
    lat(displayUnit="deg") = 0.91664692314742,
    lon(displayUnit="deg") = 0.23387411976724,
    alt=10,
    til(displayUnit="deg") = 0.26179938779915,
    azi(displayUnit="deg") = 0,
    redeclare model CellTemperature =
        BaseClasses.CellTemperatureMountingCloseToGround,
    redeclare model IVCharacteristics =
        BaseClasses.IVCharacteristics5pAnalytical,
    timZon(displayUnit="s") = weaDat.timZon)
    "Model for determining the DC output Power of a PV array; Modules mounted close to the ground (adjust to different mounting via cellTemp)"
    annotation (Placement(transformation(extent={{-8,-12},{16,12}})));

  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/Weather_TRY_Berlin_winter.mos"),
      calTSky=AixLib.BoundaryConditions.Types.
      SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of the PV array"
  annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation

  connect(pVSystem.DCOutputPower, DCOutputPower)
    annotation (Line(points={{17.2,0},{110,0}},
                                              color={0,0,127}));

  connect(weaDat.weaBus, pVSystem.weaBus) annotation (Line(
      points={{-80,0},{-34,0},{-34,0.72},{-10.16,0.72}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=31536000, Interval=900), Documentation(info="<html><p>
  Simulation to test the <a href=
  \"AixLib.Electrical.PVSystem.PVSystem\">PVSystem</a> model.
</p>
<p>
  A cold TRY in Berlin is used as an example for the weather data.
</p>
</html>"));
end ExamplePVSystem;
