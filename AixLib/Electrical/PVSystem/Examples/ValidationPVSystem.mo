within AixLib.Electrical.PVSystem.Examples;
model ValidationPVSystem
  extends Modelica.Icons.Example;

  parameter String tableName = "Ground2016"
  "Table name of the weaData file";

  //Modelica.Blocks.Sources.CombiTimeTable weaData(fileName = Modelica.Utilities.Files.loadResource(
   //"modelica://AixLib/Resources/weatherdata/NIST_onemin_Ground_2016.txt"),extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0; 1, 1],
   //columns = columns, tableName = tableName, tableOnFile = tableName <> "NoName")
   //"Weather data input file";

  parameter Integer columns[:] = {5,8,3}
    "Pos 1:T_a - Ambient temperature,
     Pos 2:winVel - Wind velocity,
     Pos 3:radHorBea - Beam(Direct) irradiance on horizontal plane,
     Pos 4:radHorDif - Diffuse irradiance on horizontal plane";
  PVSystem pVSystem(
    redeclare DataBase.SolarElectric.SharpNUU235F2 data,
    redeclare model IVCharacteristics = BaseClasses.PVModule5pAnalytical,
    redeclare model CellTemperature = BaseClasses.CellTemperatureOpenRack,
    n_mod=1152,
    til=0.34906585039887,
    azi=0,
    lat=0.68298049756117,
    lon=-1.3476402739642,
    alt=0.67,
    timZon=-18000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput DCOutputPower
    "DC output power of the PV array"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  BoundaryConditions.WeatherData.Bus weaBus1
    annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="Ground2016",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/NIST_onemin_Ground_2016.txt"),
    columns={5,8,3,6},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-58,-2},{-52,4}})));

  Modelica.Blocks.Interfaces.RealOutput DCOutputPower_measured
    "DC output power of the PV array"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Blocks.Math.Gain gain(k=1000)
    annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
equation
  connect(pVSystem.DCOutputPower, DCOutputPower)
    annotation (Line(points={{11,0},{100,0}}, color={0,0,127}));
  connect(pVSystem.weaBus, weaBus1) annotation (Line(
      points={{-11.8,0.6},{-17.9,0.6},{-17.9,0},{-24,0}},
      color={255,204,51},
      thickness=0.5));
  connect(combiTimeTable.y[2], weaBus1.winSpe) annotation (Line(points={{-79,0},
          {-68,0},{-68,-22},{-24,-22},{-24,0}}, color={0,0,127}));
  connect(combiTimeTable.y[3], weaBus1.HGloHor) annotation (Line(points={{-79,0},
          {-68,0},{-68,28},{-24,28},{-24,0}},
                                      color={0,0,127}));
  connect(combiTimeTable.y[1], from_degC.u) annotation (Line(points={{-79,0},{
          -62,0},{-62,1},{-58.6,1}}, color={0,0,127}));
  connect(from_degC.y, weaBus1.TDryBul) annotation (Line(points={{-51.7,1},{
          -31.85,1},{-31.85,0},{-24,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable.y[4], gain.u) annotation (Line(points={{-79,0},{-68,0},
          {-68,-40},{-10,-40}},         color={0,0,127}));
  connect(gain.y, DCOutputPower_measured)
    annotation (Line(points={{13,-40},{100,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=14256000,
      StopTime=14342400,
      Interval=60));
end ValidationPVSystem;
