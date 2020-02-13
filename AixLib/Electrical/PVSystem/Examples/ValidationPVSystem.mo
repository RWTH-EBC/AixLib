within AixLib.Electrical.PVSystem.Examples;
model ValidationPVSystem
  extends Modelica.Icons.Example;

  parameter String tableName = "Ground2016"
  "Table name of the weaData file";

  //Modelica.Blocks.Sources.CombiTimeTable weaData(fileName = Modelica.Utilities.Files.loadResource(
   //"modelica://AixLib/Resources/weatherdata/NIST_onemin_Ground_2016.txt"),extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0; 1, 1],
   //columns = columns, tableName = tableName, tableOnFile = tableName <> "NoName")
   //"Weather data input file";

  parameter Integer columns[:] = {5,8,2}
    "Pos 1:T_a - Ambient temperature,
     Pos 2:winVel - Wind velocity,
     Pos 3:radHorBea - Beam(Direct) irradiance on horizontal plane,
     Pos 4:radHorDif - Diffuse irradiance on horizontal plane";
  PVSystem pVSystem(
    redeclare DataBase.SolarElectric.SharpNUU235F2 data,
    redeclare model IVCharacteristics = BaseClasses.PVModule5pAnalytical,
    redeclare model CellTemperature =
        BaseClasses.CellTemperatureMountingCloseToGround,
    n_mod=1152,
    til=0.34906585039887,
    azi=0,
    lat=0.69464104229374,
    lon=-1.3463469849884,
    alt=5,
    timZon=-18000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput DCOutputPower
    "DC output power of the PV array"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  BoundaryConditions.WeatherData.Bus weaBus1
    annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="Ground2016",
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/NIST_onemin_Ground_2016.txt"),
    columns={5,8,2})
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));

equation
  connect(pVSystem.DCOutputPower, DCOutputPower)
    annotation (Line(points={{11,0},{70,0}}, color={0,0,127}));
  connect(pVSystem.weaBus, weaBus1) annotation (Line(
      points={{-11.8,0.6},{-17.9,0.6},{-17.9,0},{-24,0}},
      color={255,204,51},
      thickness=0.5));
  connect(combiTimeTable.y[1], weaBus1.TDryBul)
    annotation (Line(points={{-57,0},{-24,0}}, color={0,0,127}));
  connect(combiTimeTable.y[2], weaBus1.winSpe) annotation (Line(points={{-57,0},
          {-54,0},{-54,-22},{-24,-22},{-24,0}}, color={0,0,127}));
  connect(combiTimeTable.y[3], weaBus1.HGloHor) annotation (Line(points={{-57,0},
          {-57,28},{-24,28},{-24,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ValidationPVSystem;
