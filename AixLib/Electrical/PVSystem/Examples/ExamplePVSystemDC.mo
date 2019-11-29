within AixLib.Electrical.PVSystem.Examples;
model ExamplePVSystemDC
  "Example of a model for determining the DC output Power of a PV array; Modules mounted close to the ground"
  import ModelicaServices;

 extends Modelica.Icons.Example;

 Electrical.PVSystem.PVSystemDC pVSystemDC(
    data=AixLib.DataBase.SolarElectric.QPlusBFRG41285(),
    n_mod=5,
    lat(displayUnit="deg"),
    lon(displayUnit="deg"),
    alt = 10,
    til(displayUnit="deg"),
    azi(displayUnit="deg"),
    redeclare model CellTemperature =
        BaseClasses.CellTemperatureMountingCloseToGround,
    redeclare model IVCharacteristics = BaseClasses.PVModule5pAnalytical)
  "Model for determining the DC output Power of a PV array; Modules mounted close to the ground (adjust to different mounting via cellTemp)"
   annotation (Placement(transformation(extent={{-10,-10},{10,10}})));


  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));


  Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of the PV array"
  annotation (Placement(transformation(extent={{100,-10},{120,10}})));



equation


  connect(pVSystemDC.DCOutputPower, DCOutputPower) annotation (Line(points={{11,0},{
          110,0}},                                                                          color={0,0,127}));

  connect(weaDat.weaBus, pVSystemDC.weaBus) annotation (Line(
      points={{-80,40},{-34,40},{-34,0.6},{-15,0.6}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=31536000, Interval=3600));
end ExamplePVSystemDC;
