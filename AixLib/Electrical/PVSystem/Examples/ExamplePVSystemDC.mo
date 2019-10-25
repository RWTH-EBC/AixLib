within AixLib.Electrical.PVSystem.Examples;
model ExamplePVSystemDC
  "Example of a model for determining the DC output Power of a PV array; Modules mounted close to the ground"

 extends Modelica.Icons.Example;

 Electrical.PVSystem.PVSystemDC pVSystemDC(
    data=AixLib.DataBase.SolarElectric.QPlusBFRG41285(),
  n_mod=567,
  lat = 52.52*Modelica.Constants.pi/180,
  lon = 13.41*Modelica.Constants.pi/180,
  alt = 10,
  til = 15*Modelica.Constants.pi/180,
  azi = 0*Modelica.Constants.pi/180,
  groRef = 0.2,
  timZon = 1*3600,
    redeclare model CellTemperature =
        BaseClasses.CellTemperatureMountingCloseToGround,
    redeclare model IVCharacteristics = BaseClasses.PVModule5pAnalytical)
  "Model for determining the DC output Power of a PV array; Modules mounted close to the ground (adjust to different mounting via cellTemp)"
   annotation (Placement(transformation(extent={{-16,-10},{4,10}})));


  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2015_524528132978_Wint_City_Berlin.mos"),
      calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-96,30},{-76,50}})));


  Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of the PV array"
  annotation (Placement(transformation(extent={{100,-10},{120,10}})));



equation


  connect(pVSystemDC.DCOutputPower, DCOutputPower) annotation (Line(points={{5,0},{
          110,0}},                                                                          color={0,0,127}));

  connect(weaDat.weaBus, pVSystemDC.weaBus) annotation (Line(
      points={{-76,40},{-34,40},{-34,0.6},{-21,0.6}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=31536000, Interval=3600));
end ExamplePVSystemDC;
