within AixLib.Electrical.PVSystem.Examples;
model ExamplePVSystemDC
  "Example of a model for determining the DC output Power of a PV array; Modules mounted close to the ground"

 extends Modelica.Icons.Example;



 parameter AixLib.DataBase.SolarElectric.QPlusBFRG41285 data
    "PV module record"
    annotation (Dialog(group="Module type", tab="Array configuration"));


 Electrical.PVSystem.PVSystemDC pVSystemDC(
  data=data,
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
   annotation (Placement(transformation(extent={{-14,-10},{6,10}})));


  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    annotation (Placement(transformation(extent={{-96,30},{-76,50}})));


  Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of the PV array"
  annotation (Placement(transformation(extent={{100,-10},{120,10}})));



equation


  connect(pVSystemDC.DCOutputPower, DCOutputPower) annotation (Line(points={{7,0},{110,0}}, color={0,0,127}));

  connect(weaDat.weaBus, pVSystemDC.weaBus) annotation (Line(
      points={{-76,40},{-34,40},{-34,0.6},{-19,0.6}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=31536000, Interval=3600));
end ExamplePVSystemDC;
