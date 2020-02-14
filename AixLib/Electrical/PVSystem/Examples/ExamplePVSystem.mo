within AixLib.Electrical.PVSystem.Examples;
model ExamplePVSystem
  "Example of a model for determining the DC output Power of a PV array; Modules mounted close to the ground"
  import ModelicaServices;

 extends Modelica.Icons.Example;

  PVSystem pVSystemDC(
    data=AixLib.DataBase.SolarElectric.QPlusBFRG41285(),
    n_mod=567,
    lat(displayUnit="deg") = 0.91664692314742,
    lon(displayUnit="deg") = 0.23387411976724,
    alt=10,
    til(displayUnit="deg") = 0.26179938779915,
    azi(displayUnit="deg") = 0,
    redeclare model CellTemperature = BaseClasses.CellTemperatureOpenRack,
    redeclare model IVCharacteristics = BaseClasses.PVModule5pAnalytical,
    timZon(displayUnit="s") = weaDat.timZon)
    "Model for determining the DC output Power of a PV array; Modules mounted close to the ground (adjust to different mounting via cellTemp)"
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));

  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/Weather_TRY_Berlin_winter.mos"),
      calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of the PV array"
  annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation

  connect(pVSystemDC.DCOutputPower, DCOutputPower) annotation (Line(points={{13,0},{
          110,0}},                                                                          color={0,0,127}));

  connect(weaDat.weaBus, pVSystemDC.weaBus) annotation (Line(
      points={{-80,0},{-34,0},{-34,0.6},{-9.8,0.6}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=31536000, Interval=900));
end ExamplePVSystem;
