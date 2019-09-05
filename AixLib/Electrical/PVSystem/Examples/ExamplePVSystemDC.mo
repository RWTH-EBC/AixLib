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






// Weather input from TRY

  parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation";

  parameter Real startTime[1] = {0}
    "output = offset for time < startTime (same value for all columns)";

  parameter Integer columns[:] = {5,8,12,13}
    "Pos 1:T_a - Ambient temperature,
     Pos 2:winVel - Wind velocity,
     Pos 3:radHorBea - Beam(Direct) irradiance on horizontal plane,
     Pos 4:radHorDif - Diffuse irradiance on horizontal plane
     
     for TRY:
     Pos 1: Spalte t - Lufttemperatur in 2 m Hoehe ueber Grund,                        
     Pos 2: Spalte WG - Windgeschwindigkeit in 10 m Hoehe ueber Grund,                 
     Pos 3: Spalte B - Direkte Sonnenbestrahlungsstaerke (horiz. Ebene),              
     Pos 4: Spalte D - Diffuse Sonnenbetrahlungsstaerke (horiz. Ebene)";

  parameter String tableName = "wetter"
  "Table name of the weaData file";

  Modelica.Blocks.Sources.CombiTimeTable weaData(fileName = Modelica.Utilities.Files.loadResource(
   "modelica://AixLib/Resources/weatherdata/TRY_Berlin_cold_winter.txt"),
   smoothness=smoothness,extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0; 1, 1],
   columns = columns, tableName = tableName, tableOnFile = tableName <> "NoName")
   "Weather data input file";






  Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of the PV array"
  annotation (Placement(transformation(extent={{100,-10},{120,10}})));


equation

  connect(pVSystemDC.radHorBea, weaData.y[3]);
  connect(pVSystemDC.radHorDif, weaData.y[4]);
  connect(pVSystemDC.T_a, weaData.y[1]);
  connect(pVSystemDC.winVel, weaData.y[2]);

  connect(pVSystemDC.DCOutputPower, DCOutputPower) annotation (Line(points={{7,0},{110,0}}, color={0,0,127}));

  annotation (experiment(StopTime=31536000, Interval=3600));
end ExamplePVSystemDC;
